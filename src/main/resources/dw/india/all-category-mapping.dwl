%dw 2.0
output application/java
var product = payload
var productSubSubCategory = (val) -> vars."SSC-SSSC"[val]
var productSubCategory = (val) -> vars."SC-SSC"[val]
var Category = (val) -> vars."C-CS"[val]
---
payload["productSubSubSubCategory"] map {
productTitle : payload.productTitle,
productOriginalPrice: payload.productOriginalPrice,
productOfferPercentage: payload.productOfferPercentage,
productImage: payload.productImage,
productDiscountPrice: payload.productDiscountPrice,
productCreatedTime: payload.productCreatedTime,
productUploadedTime: payload.productUploadedTime,
productEcommercePlatform: payload.productEcommercePlatform,
productURL: payload.productURL,
productCategory: payload.productCategory,
productScrapSource: payload.productScrapSource,
productDescription: payload.productDescription,
productSubSubSubCategory: ($),
productSubSubCategory: productSubSubCategory($) replace '"' with "'" default "Trending",
productSubCategory: productSubCategory(productSubSubCategory($)) replace '"' with "'" default "Trending",
productCategory: Category(productSubCategory(productSubSubCategory($))) replace '"' with "'" default "Trending"
//productSubSubCategoryTag: payload.productSubSubCategoryTag replace '"' with "'" default "Trending"
}