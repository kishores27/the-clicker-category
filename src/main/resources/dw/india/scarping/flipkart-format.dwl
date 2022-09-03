%dw 2.0
output application/java
---
flatten(payload..payload) map ( (data,index) -> data update {
	//case dprice at .productDiscountPrice -> dprice[ 1 to -1]
	//case oprice at .productOriginalPrice -> oprice[ 1 to -1]
	case date at .productUploadedTime -> (date as DateTime as Number)
	case ptitle at .producTitle -> if(isEmpty(ptitle)) (((data.productURL splitBy  "?")[0] splitBy  "/")[3] splitBy  "-") joinBy  " " else ptitle
	
}) default null