%dw 2.0
output application/java
---
(((flatten(payload..payload) default flatten(payload)) filter !isEmpty($) and lower($.productOfferPercentage) != "ad") orderBy -($.productCreatedTime)) map ($ update {
	case date at .productCreatedTime -> (date as DateTime >> "Asia/Kolkata") as String {
		format : 'yyyy-MM-dd HH:mm:ss'
	}
			case dp at .productDiscountPrice -> if ( !isEmpty(dp) ) ((dp scan /[\d., ]+/)[-1][0] replace /,|^[.]| / with "") else null
			case op at .productOriginalPrice -> if ( !isEmpty(op) ) ((op scan /[\d., ]+/)[-1][0] replace /,|^[.]| / with "") else null
			case purl at .productURL -> if ( !isEmpty(purl) ) (purl splitBy "?")[0] else null
// case purl at .productURL -> if ( (purl contains "amazon.in") or (purl contains "https://amzn.to") ) ((purl splitBy "?")[0] ++ p('india.amazon.tagId')) else if ( !isEmpty(purl) ) (p('india.cluelink.cidlink') ++ ((purl splitBy "?")[0])) else purl
}) map (if ( isEmpty($.productOfferPercentage) ) ($ ++ {
	"productOfferPercentage": if ( !isEmpty($.productOriginalPrice) and !isEmpty($.productDiscountPrice) ) upper(floor((($.productOriginalPrice - $.productDiscountPrice)/$.productOriginalPrice)*100) ++ "% OFF")
else "BEST OFFER"
}) else ($)) filter ($ != null) distinctBy ($.productURL) 