output application/json
import * from dw::core::URL
---
(flatten(payload.payload) map ($ 
	
	update {
	case date at .productCreatedTime -> (date as DateTime as Number)
	case url at .productURL -> flatten(decodeURI(url) scan(/\?(.*)/))[1]
 	//case dprice at .productDiscountPrice -> (dprice[ 2 to -1])[2 to -1]
	//case oprice at .productOriginalPrice -> if(oprice contains  "worth") (oprice splitBy  " ") [-1] else (oprice splitBy " ")[1]
	case oprice at .productOriginalPrice -> if(oprice contains  "worth") (oprice splitBy  " ") [-1] else oprice
	})) default null
	//map ($ ++ { "productOfferPercentage" : if($.productOriginalPrice != null and $.productDiscountPrice !=null ) floor((($.productOriginalPrice - $.productDiscountPrice)/$.productOriginalPrice)*100) ++ "% OFF"
//else "BEST OFFER"})) 

	