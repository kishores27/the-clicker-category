%dw 2.0
output application/json
import words from dw::core::Strings

var regex = (val) -> lower((((" " ++ val ++ " | " ++ val ++ "\$" ++"|^" ++ val ) replace "(" with "") replace ")" with "") replace '"' with "'")

fun setSSC(ptitle) = [(((keysOf(vars."SSSC-SSSCT") map {
	key: $,
	value: flatten(lower(ptitle) scan regex($))[0]
}) filter $.value != null)),
(((keysOf(vars."SSSC-SSSCT") map {
	key: vars."SSSC-SSSCT"[$],
	value: flatten(lower(ptitle) scan  regex($))[0]
}) filter $.value != null))]

//tags
//fun setSSCTag(ptitle) = [(((keysOf(vars."SSC-SSCT") map {
//	key: $,
//	value: flatten(lower(regex(ptitle)) scan  regex($))[0]
//}) filter $.value != null)),
//(((keysOf(vars."SSC-SSCT") map {
//	key: vars."SSC-SSCT"[$],
//	value: flatten(regex(lower(ptitle)) scan  regex($))[0]
//}) filter $.value != null))]


//get category, sub category, sub sub category values
var SSSCValue = ([setSSC(payload.productTitle)[1].key[-1]] default ["Trending"]) distinctBy ($)
//var SSSCKey = setSSC(payload.productTitle)[0].key 

//var SSCTKey = setSSCTag(payload.productTitle)[1].key
//var SSCTValue = (setSSCTag(payload.productTitle)[0].key default ["Trending"]) distinctBy ($)
---
(payload ++ {
	productUploadedTime: (now() >> "Asia/Kolkata") as String {
		format : 'yyyy-MM-dd HH:mm:ss'
	},
	//productSubSubCategory: SSCValue,
	productSubSubSubCategory: SSSCValue  , //array [ "cutlery","Dining Table"],
	//productSubSubCategory: SSCTValue
}) -- ['newProduct']