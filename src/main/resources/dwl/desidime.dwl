%dw 2.0
output application/json
import * from dw::core::URL
import java!india::desidime
//(attributes.queryParams.page as String) else "1"
---
//(desidime::getDesidime("https://www.desidime.com/new"))[?($.productDiscountPrice != "" and $.productURL !="")] ++

(desidime::getDesidime(p('india.desidime')))[?($.productDiscountPrice != "" and $.productURL !="")]  map ($ update {
	case url at .productURL -> flatten(decodeURI(url) scan(/\&url=(.*)/))[1]
})