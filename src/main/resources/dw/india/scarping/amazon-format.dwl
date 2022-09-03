%dw 2.0
output application/json
import * from dw::core::URL
---
if(!isEmpty(vars.hasError))
null
else
(flatten(payload.payload) default payload map ($ update {
    case date at .productCreatedTime -> (date as DateTime as Number)
    case url at .productURL -> if(url contains "&url") "https://www.amazon.in" ++ (
    	(((parseURI(url)["query"]) splitBy "&") [2][4 to -1]) splitBy "/ref")[0] as String else (url splitBy "/ref")[0]
	case dprice at .productDiscountPrice -> (dprice splitBy ".")[0]
	case oprice at .productOriginalPrice -> (oprice splitBy ".")[0]
    case rating at .productRating -> (rating splitBy  " ")[0]
}))