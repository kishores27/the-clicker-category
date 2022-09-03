%dw 2.0
output application/java
import * from dw::core::URL
---
payload ++ {
	newProduct : isEmpty(vars.result),
	id: vars.result[0].product_id,
	productPriceUpdated: if(!isEmpty(payload.productDiscountPrice) and (!isEmpty(vars.result))) payload.productDiscountPrice < vars.result[0].product_discount_price else false,
	productEcommercePlatform : parseURI(payload.productURL)["host"] default null,
	productDescription: if(!isEmpty(payload.productDescription)) payload.productDescription as String else payload.productTitle as String,
	productOriginalPrice: payload.productOriginalPrice default null
	//productCreatedTime : now() as String {format : 'yyyy-MM-dd hh:mm:ss'},
	//productUploadedTime : now() as String {format : 'yyyy-MM-dd hh:mm:ss'}
}