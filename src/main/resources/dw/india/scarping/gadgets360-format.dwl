%dw 2.0
output application/java
---
((flatten(payload) filter !isEmpty($)) map ( $ update {
		case date at .productCreatedTime -> (date as DateTime as Number)
		case price at .productDiscountPrice -> (price splitBy "(")[0]
		case url at .productURL -> if(!isEmpty(url)) flatten(url scan(/URL=(.*)=/))[1] else null
})) map ($ ++ {
productImage: $.productImage1 default $.productImage2 default $.productImage3 default null
})