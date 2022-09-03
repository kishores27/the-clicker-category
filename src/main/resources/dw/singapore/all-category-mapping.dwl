%dw 2.0
output application/java
var category = vars.category
var time = (now() >> "Asia/Kolkata") as String {format : 'yyyy-MM-dd HH:mm:ss'}
---
payload ++ {
	productSubSubSubCategory: category.productSubSubSubCategory,
	productSubSubCategory: category.productSubSubCategory,
	productSubCategory: category.productSubCategory,
	productCategory: category.productCategory,
	productUploadedTime: time
}
