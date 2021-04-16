package com.kakao.db;

// BEAN 객체라고 생각하면 될것 같음.


public class KakaoProfile {
	private String id;
	private KakaoAccount kakao_account;

	public class KakaoAccount {
		private Profile profile;
		private String email;
		private boolean has_email;

		public class Profile {
			private String nickname;
			private String profile_image_url;
		}
	}

}
