/*
(관리자) 문의글 답변 작성
*/

package com.admin.action;

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

import com.admin.db.QnaBean;
import com.admin.db.QnaDAO;


public class AdminQnaWriteAction implements Action {
	private QnaBean qb = new QnaBean();
	private QnaDAO qdao = new QnaDAO();
	private String email = null;

	@Override
	public ActionForward execute(HttpServletRequest request, final HttpServletResponse response) throws Exception {
		System.out.println("M : AdminQnaWriteAction_execute() 호출");
		
		//로그인제어(관리자만 가능)
		HttpSession session = request.getSession();
		email = (String) session.getAttribute("email");
				
		ActionForward forward = new ActionForward();
		if(email == null || !email.equals("admin@itwill.com")){
			forward.setPath("./qnaList.qa");
			forward.setRedirect(true);
			return forward;
		}
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//num가져와서 re_Ref 같이 맞추고 글 작성
		//qnaBean에 파라미터 저장
		qb = new QnaBean();
		qb.setQ_num(Integer.parseInt(request.getParameter("num")));
		qb.setEmail(email); 
		qb.setQ_category(request.getParameter("category"));
		qb.setQ_content(request.getParameter("content"));
		qb.setQ_subject(request.getParameter("subject"));
		
		//문의 답변 등록
		qdao = new QnaDAO();
		qdao.adminReplyInsertQna(qb);
		
		//이메일 전송 스레드로
		Thread mailThread = new Thread(new Runnable() {
			@Override
			public void run() {
				//문의글 작성 회원 이메일 확인
				qb = qdao.getQnaContent(qb.getQ_num());
				
				//답변 등록 메일로 알림
				System.out.println("받는사람 이메일확인"+qb.getEmail());

				String receiver = qb.getEmail();
				String subject = "[주스트럭]문의에 대한 답변이 등록되었습니다";
				String content = "문의주셔서 감사합니다. 답변을 확인해 주세요";
						
				response.setContentType("text/html);charset=UTF-8");
					
				try{
					Properties properties = System.getProperties();
					properties.put("mail.smtp.starttls.enable", "true");
					properties.put("mail.smtp.host", "smtp.gmail.com");
					properties.put("mail.smtp.auth", "true");
					properties.put("mail.smtp.port", "587"); //gmail 포트
						
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
					System.out.println("메일 전송 완료");
				} catch (Exception e) {
					System.out.println("메일 전송 실패");
					e.printStackTrace();
				}
				//메일전송끝
			}
		});
		
		mailThread.start();
		
		//페이지이동
		forward.setPath("./qnaList.qa");
		forward.setRedirect(true);
		
		return forward;
	}
	
}



