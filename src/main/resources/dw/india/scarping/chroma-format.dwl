%dw 2.0
output application/java
---
flatten(payload..payload) map ( (data,index) -> data update {
	case date at .productUploadedTime -> (date as DateTime as Number)
	case dprice at .productDiscountPrice -> (dprice splitBy ".")[0]
	case oprice at .productOriginalPrice -> (oprice splitBy ".")[0]
	
}) default null