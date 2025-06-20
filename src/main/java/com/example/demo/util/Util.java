package com.example.demo.util;

public class Util {
	public static String jsReplace(String msg, String uri) {
		
		if (msg == null) {
			msg = "";
		}
		
		if (uri == null || uri.length() == 0) {
			uri = "/usr/home/main";
		}
		
		return String.format("""
					<script>
						const msg = '%s'.trim();
						
						if (msg.length > 0) {
							requestAnimationFrame(() => {
								alert(msg);
							})
						}
						
						setTimeout(() => {
							location.replace('%s');
						}, 100);
					</script>
				""", msg, uri);
	}

	public static String jsBack(String msg) {
	    return "<script>alert('" + msg + "'); history.back();</script>";
	}
}