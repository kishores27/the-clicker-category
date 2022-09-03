%dw 2.0
output application/java
---
payload ++ {
	productUploadedTime : (now() >> "Asia/Kolkata") as String {format : 'yyyy-MM-dd HH:mm:ss'}
}