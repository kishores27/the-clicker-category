import * from dw::core::URL
---
(payload map ($ 
	
	update {
	case date at .productCreatedTime -> (date as DateTime as Number)
	case url at .productURL -> flatten(decodeURI(url) scan(/\&link=(.*)/))[1]
 	//case dprice at .productDiscountPrice -> ((dprice splitBy  " ")[0])[1 to -1]
	//case oprice at .productOriginalPrice -> ((oprice splitBy  " ")[0])[1 to -1]
	})) //map ($ ++ { "productOfferPercentage" : floor((($.productOriginalPrice - $.productDiscountPrice)/$.productOriginalPrice)*100) ++ "% OFF"
//}) 
default null
	
	