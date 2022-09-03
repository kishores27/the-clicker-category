%dw 2.0
import * from dw::core::URL
output application/java
---
(flatten(payload) map ($ update {
	case dp at .productDiscountPrice -> (dp splitBy  "(")[0]
	case date at .productCreatedTime -> (date as DateTime as Number)
})) default null