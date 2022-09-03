%dw 2.0
import * from dw::core::URL
output application/java
---
flatten(payload.payload)  map ($ update {
	case url at .productURL -> if(url contains "www.amazon.in") (url splitBy  "/source=offertag.in") joinBy  "" else url
	case date at .productCreatedTime -> (date as DateTime as Number)
})