/*
이메일전송에 필요한 클래스
*/
package com.admin.action;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	//이메일 정보
	PasswordAuthentication passAuth;
	
	public GoogleAuthentication(){
		passAuth = new PasswordAuthentication("juicetruck.ad", "mksflgoweezxeiqu");
	}
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		
		return passAuth;
	}

}
