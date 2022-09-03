%dw 2.0
output application/java
import * from dw::core::URL

---
(payload map ($ update {
	case date at .productCreatedTime -> (date as DateTime as Number)
})) default null