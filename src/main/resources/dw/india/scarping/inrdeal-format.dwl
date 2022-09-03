%dw 2.0
output application/java
import * from dw::core::URL
//var queryParams = (prod) -> (parseURI(prod)["query"])
//var start =(prod) -> (queryParams(prod) find "url=")[0]+4
//var end = (prod) -> ((queryParams(prod)[start(prod) to -1] find "?")[0])+start(prod)-1
//var host = (prod) -> (parseURI(decodeURI(prod))["host"])
---
//flatten(payload.payload) filter $.productDiscountPrice != "Free"
(flatten(payload.payload)[?($.productDiscountPrice != "Free")] map ($ update {
	case date at .productCreatedTime -> (date as DateTime as Number)
	case url at .productURL -> (decodeURI(url) scan(/\&url=(.*)&/))[0][1]
})) default null
//((flatten(payload.payload)[?($.productDiscountPrice != "Free" and not isEmpty($.productURL)) ])
//map
//($ update {
//	case prod at .productURL -> if(prod contains "amazon") queryParams(prod)[start(prod) to end(prod)] else queryParams(prod)[start(prod) to -1]
//}))
