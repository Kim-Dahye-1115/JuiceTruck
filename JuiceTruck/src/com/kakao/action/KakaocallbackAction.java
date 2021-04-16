package com.kakao.action;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kakao.db.KakaoProfile;
import com.kakao.db.OAuthToken;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

public class KakaocallbackAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 카카오 테스트
		String code = request.getParameter("code");

		//System.out.println("code :"+code);
		//Post요청, x-www-form-urlencoded
		
		String endpoint="https://kauth.kakao.com/oauth/token";
		URL url =new URL(endpoint);
		
		String bodyData="grant_type=authorization_code&";
		bodyData += "client_id=c9cffd9530ad8456ac8cc3f58d0088b3&"; //자기 REST API키 입력
		bodyData += "redirect_uri=http://itwillbs10.cafe24.com/Juice/GoodsList.ag"; // redirect_uri 접속경로
		//bodyData += "code="+code;
	
		//Stream 연결
		HttpsURLConnection conn=(HttpsURLConnection)url.openConnection();
		//http header 값 넣기
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		conn.setDoOutput(true);
		//request 하기
		BufferedWriter bw=new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(),"UTF-8"));
		bw.write(bodyData);
		bw.flush();
		System.out.println("######"+bw.toString());
		
		BufferedReader br = new BufferedReader(
				new InputStreamReader(conn.getInputStream(), "UTF-8")
				);
		String input="";
		StringBuilder sb=new StringBuilder();
		while((input=br.readLine())!=null){
			sb.append(input);
		}
		
		System.out.println("!!!!!!!!"+sb.toString()); // 값을 보기위해 넣었습니다. 
		
		//JsonParser jsonParser = new JsonParser();
		
		//JsonArray jsonArray = (JsonArray) jsonParser.parse(n);
				
		//Gson으로 파싱
		Gson gson=new Gson();
		
		OAuthToken oAuthToken=gson.fromJson(sb.toString(), OAuthToken.class);
		
		

		//profile 받기(Resource Server)
		String endpoint2="https://kapi.kakao.com/v2/user/me";
		URL url2 =new URL(endpoint2);
		
		HttpsURLConnection conn2=(HttpsURLConnection)url2.openConnection();
		
		//header 값 넣기
		conn2.setRequestProperty("Authorization", "Bearer "+oAuthToken.getAccess_token());
		conn2.setDoOutput(true);
		
		//request 하기
		BufferedReader br2=new BufferedReader(new InputStreamReader(conn2.getInputStream(),"UTF-8"));
		String input2="";
		StringBuilder sb2=new StringBuilder();
		while((input2=br2.readLine())!=null) {
			sb2.append(input2);
		}
		
		System.out.println("sb2.toString() : "+sb2.toString());
		
		Gson gson2=new Gson();
		KakaoProfile kakaoProfile=gson2.fromJson(sb2.toString(), KakaoProfile.class);
	
		System.out.println(kakaoProfile);
		
		
	
		return null;
	}

}
