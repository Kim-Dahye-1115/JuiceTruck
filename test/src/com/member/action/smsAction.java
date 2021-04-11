package com.member.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.member.db.MemberDAO;

public class smsAction implements ActionIdCheck {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String phone = request.getParameter("phone");
		//System.out.println(phone);
		
		 	String api_key = "NCSJFBVFK4LUACPB";
	        String api_secret = "9US9MRLDMVYQDKUEHY52ODKCRH0GU5MH";
	        Coolsms coolsms = new Coolsms(api_key, api_secret);
	        
	        
	        Random rand  = new Random();
	        String numStr = "";
	        for(int i=0; i<6; i++) {
	            String ran = Integer.toString(rand.nextInt(10));
	            numStr+=ran;
	        }
	        
	        System.out.println("인증번호 "+numStr);

			
			HashMap<String, String> set = new HashMap<String, String>();
			set.put("to", phone); // 수신번호

			
			set.put("from", "01045979602"); // 발신번호
			set.put("text", "[주스트럭] 본인 확인 인증번호는 ["+numStr+"] 입니다."); // 문자내용
			set.put("type", "sms"); // 문자 타입

			PrintWriter out = response.getWriter();

			// 주석 풀어야 됨
			JSONObject result = coolsms.send(set); // 보내기&전송결과받기
			MemberDAO mdao = new MemberDAO();
			int result1 = mdao.pnum_check(phone);
		
			
			JSONArray List = new JSONArray();
			JSONObject nb = new JSONObject();
			
			if(result1 == 0){
				nb.put("pnum_check", 0);
				nb.put("numStr", numStr);
				nb.put("phone", phone);
				List.add(nb);
				
				
				System.out.println("발송");
				if ((Boolean) result.get("status") == true) {
					
		     		
		     		
				} else {
					// 메시지 보내기 실패
					System.out.println("실패");
					System.out.println(result.get("code")); // REST API 에러코드
					System.out.println(result.get("message")); // 에러메시지
				}
			}else{
				nb.put("pnum_check", -1);
				System.out.println("중복");
				List.add(nb);
			}
			out.println(List);
		
	}	
}

