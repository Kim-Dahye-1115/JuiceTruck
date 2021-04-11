/*
(관리자) 문의글 답변 작성
*/

package com.member.action;

import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.admin.action.GoogleAuthentication;
import com.member.db.MemberBean;
import com.member.db.MemberDAO;


public class MemberFindPwEmailAction implements Action {
	private MemberBean mb = new MemberBean();
	private MemberDAO mdao = new MemberDAO();
	private String email = null;
	private String pass = null;
	private int result = 0;

	@Override
	public ActionForward execute(HttpServletRequest request, final HttpServletResponse response) throws Exception {
		System.out.println("M : AdminQnaWriteAction_execute() 호출");
				
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//num가져와서 re_Ref 같이 맞추고 글 작성
		//MemberBean에 파라미터 저장
		mb = new MemberBean();
		System.out.println("------------------");
		
		email = request.getParameter("email");
		
		mb.setEmail(email);
		mb.setPhone(request.getParameter("phone"));
		pass = mdao.findpass(mb.getEmail(),mb.getPhone());
		
		System.out.println(" mb : "+mb);
		
		//이메일 전송 스레드로
		Thread mailThread = new Thread(new Runnable() {
			@Override
			public void run() {
				//답변 등록 메일로 알림
				System.out.println("받는사람 이메일확인"+mb.getEmail());

				String receiver = email;
				String subject = "[주스트럭]비밀번호 찾기 메일입니다.";
				String content = "비밀번호는 : "+pass+" 입니다.";
				
				
				response.setContentType("text/html);charset=UTF-8");
				
				// smtp 정보	
				try{
					Properties properties = System.getProperties();
					properties.put("mail.smtp.starttls.enable", "true");
					properties.put("mail.smtp.host", "smtp.gmail.com");
					properties.put("mail.smtp.auth", "true");
					properties.put("mail.smtp.port", "587");
						
					Authenticator auth = new GoogleAuthentication();
					Session s = Session.getDefaultInstance(properties,auth);
					Message message = new MimeMessage(s);
						
					Address receiver_address = new InternetAddress(receiver);
						
					//메일 전송에 필요한 값
					message.setHeader("content-type","text/html;charest=UTF-8");
					message.addRecipient(Message.RecipientType.TO, receiver_address);
					message.setSubject(subject);
					message.setContent(content, "text/html;charset=UTF-8");
					message.setSentDate(new java.util.Date());
					Transport.send(message);
					result = 1;
				} catch (Exception e) {
					result = -1;
					pass = "메일 전송 실패";
					e.printStackTrace();
				}
				//메일전송끝
			}
		});
		
		mailThread.start();
		
		if(result != 1){
			request.setAttribute("findpass", pass);
		}
		
		//if (email == null)
		ActionForward forward = new ActionForward();
		forward.setPath("./member/findPwForm.jsp");
		forward.setRedirect(false);
		return forward;
	}	
	
}



