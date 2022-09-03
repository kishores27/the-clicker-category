%dw 2.0
import * from dw::core::URL
output application/java
---
(flatten(payload) map ($ 
	
	update {
	case date at .productCreatedTime -> (date as DateTime as Number)
	case url at .productURL -> flatten(decodeURI(url) scan  (/\?url=(.*)/))[1]
	})) default null