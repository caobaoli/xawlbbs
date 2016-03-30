package xyz.springabc.web.helper;

import java.util.regex.Pattern;

public class Validator {
	
	public static boolean isEmail(String email){
		 String check = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";  
		 Pattern regex = Pattern.compile(check);  
		 java.util.regex.Matcher matcher = regex.matcher(email);
		 return matcher.matches();
	}
	
}
