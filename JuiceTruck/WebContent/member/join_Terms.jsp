<!-- 회원 가입 약관 동의 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주위에서 스피디하게!주스트럭</title><!-- 웹페이지 타이틀에 쓸 문구 의논해요! -->
</head>
	<script>
	
	// 약관 전체 동의-해제
	 function selectAll(selectAll)  {
		  const checkboxes 
		       = document.getElementsByName('check');
		  
		  
		  checkboxes.forEach((checkbox) => {
			  checkbox.checked = selectAll.checked;
		  })
		}  
	
		//약관 체크할 경우 페이지 이동
		
		 function terms_check(){
		 var req = document.form.req.checked;
		 var req2 = document.form.req2.checked;
		 var req3 = document.form.req3.checked;
		 var num = 0;
		 
		 if(req == true && req2 == true && req3 == true){
		  num = 1;
		 }
		 if(num==1){
		  document.form.submit();
		 }else{
		  alert("필수 이용 약관에 모두 동의해 주세요.");
		  return false;
		 }
		} 
		
		
		
		</script>



<body class="joinTerms-page ">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 -->
		<div class="member-join">
		<div class="container">
		<div class="section section-text">
			<div class="row">
				<div class="col-md-9 ml-auto mr-auto">
				<div class="col-md-7 ml-auto mr-auto">
				<h3 class="title">주스 트럭 회원 가입 약관</h3>
				</div>
	<fieldset>
	
	<form action="./Join.me" method="post" id="form" name="form"> 
	
 	<div class=form-check>
 	<label class="form-check-label">
 	<input type='checkbox' class="form-check-input" name='check' value='selectall' onclick='selectAll(this)' />
  	주스트럭 이용약관, 개인정보 수집 및 이용, 위치정보 이용약관(필수)에 모두 동의합니다.
	<span class="form-check-sign">
		<span class="check">
		</span>
	</span>
	</label>
	</div>
		<br>
	 
	 <!-- 이용약관 동의 안내 -->  
	<div class=form-check>
	<label class="form-check-label">
  	 <input type="checkbox" class="form-check-input" name="check" id="req"> 주스트럭 이용약관 동의(필수)
  	 <span class="form-check-sign">
		<span class="check">
		</span>
	</span>
  	 </label>
  	 </div>
	 <!-- 이용약관 동의 내용 -->   
	 
	 <textarea rows="10" cols="20" class="form-control maintext" readonly >
						주스트럭 서비스 이용 약관
제1장 총칙
제1조 (목적)
본 약관은 서비스 이용자가 번개장터 주식회사(이하 “회사”라 합니다)가 제공하는 온라인 서비스 (이하 “서비스”라 합니다)에 회원으로 가입하고 이를 이용함에 있어 회사와 그 이용자의 권리⋅의무 및 책임 사항을 규정함을 목적으로 합니다.

제2조 (정의)
본 약관에서 사용하는 용어의 정의는 다음과 같습니다. 정의되지 않은 본 약관상 용어의 의미는 일반적인 거래 관행에 의합니다.

회원: 본 약관에 동의하고 회사와 서비스 이용계약을 체결한 자를 말합니다.
판매자: 물품을 판매하기 위해 회사의 판매자 등록 절차를 완료한 회원을 말합니다. 물품의 판매를 업(業)으로 하는 판매자(이하 “업자인 판매자”, 개인인지 법인인지 여부를 불문)인 경우와 그렇지 아니한 판매자 (이하 “업자 아닌 판매자”)인 경우 판매자 등록 절차에 차이가 있을 수 있습니다.
구매자: 판매자가 판매하는 물품을 구매하고자 하는 회원을 말합니다.
번개페이: 구매자가 물품 구매를 위해 회사에 물품 대금을 결제할 수 있는 결제 시스템을 말합니다.
번개톡: 서비스 내에서 회원들 간에 메시지 송수신할 수 있는 기능을 말합니다.
번개페이거래: 회원이 다른 회원이 판매하는 물품을 구매하기 위하여 회사에 구매 청약의 접수를 하고 판매자와 구매 계약을 체결한 후 번개페이를 통해 물품 대금을 지급하는 거래 형태를 말합니다.
번개톡거래: 회원이 회사를 통하지 않고 회원간 번개톡을 통해 메시지를 주고 받아 물품을 거래하는 형태를 말합니다.
번개포인트: 회원의 누적 물품 구매 액수 또는 회사가 진행하는 이벤트 당첨 결과 등에 따라 회사가 회원에게 부여하고 회원이 적립하여 배송비 결제 등 회사가 지정하는 용도에 사용할 수 있는 혜택을 말합니다.
제3조 (약관의 게시와 개정)
회사는 본 약관의 내용을 회원이 쉽게 확인할 수 있도록 기술적 조치를 취합니다.
회사는 콘텐츠산업진흥법, 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제에 관한 법률, 소비자기본법 등 관련 법령을 위반하지 않는 범위 내에서 본 약관을 개정할 수 있습니다.
회사가 약관을 개정할 경우 기존 약관과 개정 약관 및 개정 약관 적용 일자와 개정 사유를 명시하고 기존 약관과 함께 개정 약관 적용 일자 7일 전부터 적용 일자 이후 상당한 기간 동안, 개정 약관의 내용이 회원에게 불리한 경우 개정 약관 적용 일자 30일 전부터 적용 일 이후 상당한 기간 동안, 이를 서비스 웹페이지 및 어플리케이션 화면에 게시하거나 기타 방법으로 회원에게 통지합니다.
회사가 ‘전항에 따라 회원에게 통지한 후 개정 약관 고지일로부터 개정 약관 시행일 이후 7일이 지나는 날까지 회원이 거부 의사를 표시하지 아니할 경우 회원이 개정 약관에 동의한 것으로 본다는 뜻’을 고지하였음에도 회원의 거부 의사표시가 없는 경우 개정 약관에 동의한 것으로 간주합니다. 회원이 개정 약관에 동의하지 않을 경우 해당 회원은 서비스 이용 계약을 해지할 수 있습니다.
회원은 회사가 제공하는 서비스를 이용함에 있어서 전자상거래 등에서의 소비자보호에 관한 법률, 전자금융거래법, 소비자기본법, 표시∙광고의 공정화에 관한 법률, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관련 법령을 준수하여야 하며, 본 약관의 규정을 들어 관련법령 위반에 대한 면책을 주장할 수 없습니다.
제2장 서비스의 내용 및 회원 가입
제4조 (서비스 이용 계약)
회사가 제공하는 서비스를 이용하기 위한 이용 계약은 회사의 서비스를 이용하고자 하는 자의 회원가입 신청에 대하여 회사가 승낙함으로써 성립합니다.
전항의 회원가입 신청을 하기 위해서는 회사가 정한 온라인 회원가입 신청서에 필수 기재사항을 입력하고 본인인증 절차를 완료하여야 합니다.
회원가입 신청을 위해 필수적으로 기재한 항목이 변경된 경우(폐업 등의 사유 발생 포함) 해당 회원은 위 변경 사실을 직접 수정하거나 회사에 1:1문의 또는 전화를 통해 통지하여야 하며, 통지하지 않음으로 인하여 발생한 회원의 불이익에 관하여는 회원이 책임을 집니다.
회사가 정한 필수 기재사항을 입력하지 않거나 허위의 정보를 입력하거나 회원가입 신청을 하려는 자가 만 14세 미만일 경우 회원가입 신청이 제한될 수 있습니다.
회사는 회원에게 유익한 정보를 제공하기 위해 위 필수 기재사항 이외에도 회원가입을 신청하는 자에게 취미, 관심사 등 정보 제공을 요청할 수 있으나 회원가입을 신청하는 자는 위 정보의 제공을 거절할 수 있습니다.
회사는 회사의 서비스를 이용하기 위해 회원가입 신청을 한 자가 본조 제2.항에서 정한 필수 기재사항을 정확하게 입력하고 본 약관에 동의한 경우 원칙적으로 서비스의 이용을 승낙합니다. 다만, 회사는 다음과 같은 사유가 있는 경우 회원가입 신청의 승낙을 거절 또는 보류할 수 있고, 이 경우 회사는 승낙 거절 또는 보류의 사유와 승낙에 필요한 추가 요청 정보 등 관련 사항을 통지합니다.
회사의 설비에 여유가 없는 경우
회사의 서비스 제공에 기술적인 문제가 있는 경우
회원가입 신청자가 본 약관에 따라 회원 자격을 상실하거나 이용 계약이 해지된 적이 있는 경우 (단, 회사의 회원 재가입 승낙을 얻은 경우는 예외)
타인의 명의를 도용한 경우
허위의 정보를 기재한 경우
기타 회사의 합리적인 판단 하에 필요하다고 인정하는 경우
제5조 (판매자 등록)
제4조에 따라 회사로부터 회원가입 신청을 승낙 받아 이용 계약이 성립된 회원이 회사의 서비스를 이용하여 다른 회원에게 물품을 판매하고자 할 경우 판매자 등록 절차를 거쳐야 합니다.
판매자 등록을 하기 위해서는 회사가 정한 온라인 등록 신청서에 다음의 필수 기재사항을 입력하여야 하며, 업자인 판매자의 다음 각 호의 정보는 회원에게 공개됩니다.
이름(법인인 경우 상호 및 대표자 이름)
주소
전화번호
이메일주소
(통신판매업자인 경우) 통신판매업신고 번호
업자가 아닌 판매자가 서비스 이용을 위해 입력하여 제공한 신원정보는 판매자의 물품에 대한 구매 청약을 한 구매자의 요청에 따라 해당 구매자에게 제공될 수 있습니다.
제6조 (서비스의 제공)
서비스의 종류
거래중개서비스
회사가 제공하는 웹사이트 또는 어플리케이션을 통하여 회원 상호간에 물품 거래가 이루어질 수 있는 사이버 거래 장소의 제공
유료서비스
광고 서비스: 회원이 회사에 광고 수수료를 지급하고 자신이 운영하는 사이버 몰 또는 판매하는 물품 등을 다른 회원에게 광고할 수 있는 서비스
번개페이 서비스: 회원 상호간 물품 거래가 번개페이거래로 이루어질 경우 구매자의 청약, 계약 체결 및 물품 대금 정산을 위해 필요한 부수적인 서비스 일체
배송 서비스: 회사가 제3자와 업무 제휴를 통해 제공하는 통합 택배 서비스
기타 부가서비스
번개톡 서비스: 회원 상호간 메시지를 주고 받을 수 있는 번개톡 메신저 서비스
거래 활성화를 위한 부수적인 서비스: 거래 후기 작성, 찜 기능 등 회원의 서비스 이용을 돕는 부수적인 서비스
번개포인트: 회사가 회원의 누적 물품 구매 액수 또는 회사가 진행하는 이벤트 당첨 결과 등에 따라 회원에게 서비스 내에서 사용할 수 있는 포인트를 부여하여 회원이 포인트를 회사가 지정하는 용도로 현금 대신 사용할 수 있는 서비스
회사는 연중무휴, 24시간 서비스를 제공함을 원칙으로 하되, 컴퓨터 등 정보통신설비의 보수, 점검, 교체, 고장 등 운영상 상당한 이유가 있는 경우 회원에게 통지한 후 서비스의 제공을 일시적으로 중단할 수 있습니다. 다만, 회사가 사전에 서비스의 중단을 통지할 수 없었던 부득이한 사유가 있는 경우 사후에 통지할 수 있습니다.
회사는 서비스의 제공을 위한 별도의 계약 종료, 신규 서비스 개시, 기존 서비스 개정 등의 사유로 서비스의 내용을 변경할 수 있습니다.
회사는 서비스의 내용에 변경이 있는 경우 변경된 서비스가 적용되기 30일 이전부터 적용 일자 이후 상당한 기간까지 웹사이트 및 어플리케이션 공지사항을 통해 회원들에게 변경된 서비스의 내용을 사전 공지합니다. 다만 회원의 거래와 관련하여 중대한 영향을 미치는 변경 사항이 있는 경우 회원에게 별도로 통지합니다.
제7조 (이용 계약의 종료 및 회원 자격 상실)
회원은 언제든지 회사에 해지의 의사를 통지함으로써 이용 계약을 해지할 수 있습니다. 다만 회원은 회사의 해지 의사를 통지하기 전에 구매 또는 판매 진행 중인 절차를 모두 완료, 철회, 취소하여야 하며, 철회 또는 취소로 인한 불이익은 해당 회원이 부담합니다.
회사는 원칙적으로 전항의 이용 계약 해지의 의사 표시를 확인한 후 해당 회원의 게시글과 해당 계정을 삭제하여 해지 절차를 완료해야 합니다. 다만, 다음 각 호의 사유가 있는 경우 이용 계약 해지 절차를 보류할 수 있습니다.
이용 계약 해지의 의사표시를 한 자가 회원 당사자인지 여부를 확인할 수 없는 경우
이용 계약 해지의 의사표시를 한 회원의 구매 또는 판매 진행 중인 거래 절차가 모두 완료되지 않은 경우
구매자에 대한 환불 등으로 인하여 회원이 서비스 이용에 관하여 회사에 변제할 채무가 남아있는 경우
이용 계약 해지의 의사표시를 한 회원에 관한 거래 사기 및 분쟁 문제가 남아 있는 경우
회사는 본 약관 또는 운영정책에 따라 특정한 사유가 발생한 경우 회원의 자격을 박탈하고 이용계약을 해지할 수 있습니다.
제3장 개인정보보호
제8조 (개인정보보호 및 개인정보 제공 동의 등)
회사는 개인정보처리방침에 따라 회원가입 및 판매자 등록시 회원으로부터 제공 받은 정보를 수집 및 보관합니다.
회사는 관련 법령 및 회사의 운영정책에 따라 특정 물품을 판매하고자 하는 판매자의 경우 추가적인 정보 및 관련 자료를 요청하여 수집 및 보관할 수 있습니다.
회사는 회원의 회원가입 신청 및 판매자 등록을 위해 제공 받은 정보를 다음의 예외적인 경우가 아닌 한 원활한 서비스 제공 이외의 목적으로 사용하거나 이용자의 동의 없이 제3자에게 제공하지 않습니다.
관련 법령에 근거하여 회원 정보의 이용 및 제3자에 대한 정보 제공을 허용하는 경우
회사의 약관 및 운영 정책 등에 따라 회원의 동의를 얻은 경우
특정 물품을 구매하고자 하는 회원이 해당 물품을 판매하는 업자 아닌 판매자의 정보를 회사에 요청하는 경우
회사는 회원의 개인정보를 보호하기 위하여 개인정보처리방침을 수립하여 이를 따르고, 개인정보보호책임자를 지정합니다.
제9조 (거래 기록 보관)
제회사는 번개페이거래를 통해 거래된 구매 내역에 관한 물품명, 결제 일시, 결제 금액, 결제 방법, 결제 고유번호, (신용카드 또는 체크카드 결제인 경우) 카드 승인번호, 금융사명(카드사 또는 은행), 배송지 정보, 운송장 정보 등 정보를 거래 이후 5년간 보관합니다.
회사는 번개톡거래를 통해 거래된 구매 내역의 당사자, 물품, 가격 등 정보를 거래 이후 5년간 보관합니다.
회사는 본조 제 1, 2항의 거래 정보의 보안을 유지하고 위 거래 정보를 거래 당사자인 회원이 보관 기간 동안 열람할 수 있도록 기술적 조치를 취합니다.
거래 기록 등 보관에 관한 구체적인 사항은 관련 법령 및 개인정보처리방침을 따릅니다.
제10조 (전자적 대금지급 사실의 통지)
번개페이거래를 통해 물품 구매 청약을 한 회원이 번개페이 서비스를 통해 물품 대금을 결제한 경우 회사는 위 회원에게 결제 사실을 신속하게 통지합니다. 다만, 회사는 위 통지를 하지 않고 물품 대금을 결제한 회원에게 대금을 결제한 물품의 정보, 결제 금액과 결제 조건 등의 중요 정보를 열람하는 방법을 제공할 수 있습니다.

제4장 거래중개서비스를 통한 물품거래
제11조 (물품거래서비스의 성질과 목적)
회사는 서비스 내에서 회원간 물품 거래가 이루어질 수 있도록 온라인 거래 장소와 서비스를 제공합니다. 서비스 내에서 판매되는 물품 중 판매자가 직접 판매하나 위 판매자로부터 회사가 판매 중개를 의뢰 받은 물품에 관하여 회사는 거래의 당사자가 아니며 해당 물품의 거래에 대하여 원칙적으로 책임을 부담하지 않습니다.

제12조 (구매 신청)
서비스를 이용하여 물품을 구매하고자 하는 회원은 번개페이거래 또는 번개톡거래의 두 가지 방법으로 물품의 구매를 위한 청약을 할 수 있습니다.
회원이 번개페이거래를 통해 물품을 구매하고자 할 경우 위 회원은 택배거래 또는 직거래 방식 중 한 가지를 선택할 수 있으며 번개페이 서비스를 통해 판매자가 입력한 물품 대금을 결제합니다(택배거래의 경우 배송 정보 입력).
회원이 번개톡거래를 통해 물품을 구매하고자 할 경우 위 회원은 번개톡 서비스를 통해 판매자와 거래 조건 및 방안을 개별적으로 정하여 청약, 청약의 승낙, 계약 체결, 결제, 환불 등의 거래 절차를 진행합니다. 회사는 구매자와 판매자간 직접 거래 절차를 진행하는 위와 같은 거래에 관하여 원칙적으로 책임을 부담하지 않습니다.
제13조 (번개페이거래에서의 수신 확인, 계약의 성립 통지 및 구매 신청 변경 및 취소)
본조는 번개페이거래를 통한 물품 거래에만 적용됩니다.
구매자로부터 번개페이거래를 통해 구매의 신청을 받은 회사는 구매의 신청을 받았다는 사실을 구매자에게 통지하여야 합니다.
번개페이를 통해 물품 대금이 결제된 물품을 판매하는 판매자는 위 물품을 판매할 수 없는 사유가 발생한 경우 해당 사실을 즉시 물품 대금을 결제한 구매자에게 통지하여야 합니다.
회사는 물품 구매를 위한 계약이 성립되었다는 사실과 계약 물품의 상세 내용, 계약의 조건, 판매자 정보 등을 구매자에게 통지합니다.
구매자는 회사로부터 계약의 성립에 관한 통지를 받기 전까지 배송지 정보 등 일부 구매 신청 정보를 변경할 수 있고 구매 신청을 취소할 수 있습니다.
제14조 (번개페이거래에서의 환급)
본조는 번개페이거래를 통한 물품 거래에만 적용됩니다.
판매자 회원이 물품을 발송하기 전(직거래의 경우 물품을 전달하기 전) 물품 대금을 결제한 구매자가 물품 구매를 취소한 경우 회사는 3영업일 내 결제된 물품 대금을 결제 방법과 동일한 방법으로 구매자에게 환급합니다.
회사는 물품 대금을 결제한 구매자가 물품 구매를 취소한 때에 판매자 회원이 물품을 발송하였는지 여부(직거래의 경우 물품을 전달하였는지 여부)가 확인되지 않은 경우 환급 절차를 일시적으로 보류할 수 있습니다.
번개페이거래에 따라 계약이 성립된 후 판매자가 물품을 배송하지 않거나 전달하지 않은 상태로 2주 이상 경과될 경우 해당 계약은 자동으로 해지되고 물품 대금이 구매자에게 환급될 수 있습니다.
판매자가 물품을 배송하거나 전달하지 않아 번개페이거래가 취소되는 경우 회사는 해당 판매자에게 판매 거부로 인한 불이익을 줄 수 있습니다.
제15조 (번개페이거래에서의 물품 대금 정산)
본조는 번개페이거래를 통한 물품 거래에만 적용됩니다.
판매자가 번개페이로 물품 대금을 결제한 구매자에게 택배거래 또는 직거래의 방식으로 물품을 전달하면 회사는 번개페이 수수료를 제외하고 정산한 물품 대금을 판매자에게 지급합니다.
회사는 판매자의 귀책사유로 인해 발생한 비용을 판매대금 정산시 정산 금액에서 공제한 후 나머지 금액에 한하여 판매자에게 지급할 수 있습니다.
판매자가 물품을 발송하였으나 배송 추적이 불가능한 사유 등으로 배송 완료 여부를 확인할 수 없는 경우 물품 발송일 기준으로 45일째되는 날 판매자에게 물품 대금의 정산을 할 수 있습니다.
판매자 또는 회사가 서비스 이용 계약을 해지한 경우, 회사는 판매자의 해지 전 최종 3개월 동안 월 평균 판매액의 30%에 해당하는 금액을 계약 해지일로부터 3개월 동안 예치하여 구매자에 대한 환불 등 절차에 사용하고 위 기간이 지난 후 잔여 금액을 판매자에게 지급 할 수 있습니다.
회사는 장기간 구매자의 물품 수령이 지연되고 있는 건의 물품 대금 정산을 향후 구매자의 환불 요청에 대비하여 일정 기간 유보할 수 있습니다.
판매자의 채권자가 제기한 신청에 의한 물품 대금의 가압류, 압류 및 추심명령 등 법원의 결정이 있을 경우, 회사는 판매자와 채권자 간의 합의 또는 채무액 변제 등으로 위 결정이 해제될 때까지 물품 대금의 정산을 보류하거나 제3채무자로서 정당하게 판매자의 채무를 변제할 수 있습니다.
회사는 아래의 사유가 발생하는 경우 물품 대금의 정산을 보류할 수 있습니다.
구매자가 신용카드로 결제한 경우, 회사는 정당한 이유가 있다면 여신전문금융업상 규정에 따른 신용카드 부정사용을 통한 허위거래 여부를 판단하기 위해 최고 60일까지 판매자에 대한 정산 대금의 지급을 보류할 수 있습니다. 이 경우, 회사는 거래 사실 확인을 위한 증빙을 판매자에게 요구할 수 있으며, 회사는 사실 여부 확인 후 판매자에게 물품 대금을 지급할 수 있습니다.
회사는 판매자가 매매 부적합 상품의 판매자로 적발되거나, 구매자의 불만이 다수 접수되는 등의 사유로 추가적인 환불, 교환 등 요청이 염려되는 경우 3개월간 정산을 보류할 수 있습니다.
관련 법령의 규정에 의하거나 기타 합리적인 사유가 있는 경우에는 회사는 판매자에게 사전 통지하고 물품 대금의 전부 또는 일부에 대한 정산을 일정 기간 보류할 수 있습니다.
제16조 (번개페이거래에서의 청약 철회)
번개페이거래를 통해 물품을 구매하는 구매자는 제13조에 따른 계약의 성립 통지를 받은 후 판매자로부터 물품을 수령한 날로부터 7일 이내에 물품 구매 청약을 철회할 수 있습니다. 다만, 판매자로부터 수령한 물품이 계약의 내용과 일치하지 않을 경우에는 물품을 수령한 날로부터 3개월 이내에, 일치하지 않는다는 사실을 안 날 또는 알 수 있었던 날로부터 30일 이내에 구매 청약을 철회할 수 있습니다.
다음의 경우에는 구매자의 전항에 따른 청약의 철회가 제한됩니다.
구매자의 책임 있는 사유로 물품이 멸실 또는 훼손된 경우
구매자의 사용 또는 일부 소비로 물품의 가치가 현저히 감소한 경우
재판매가 곤란할 정도로 물품의 가치가 현저히 감소한 경우
복제가 가능한 물품의 포장을 훼손한 경우
기타 관련 법령에 따라 청약의 철회가 제한되는 경우
제17조 (번개페이거래에서 청약 철회 등의 효과)
본조는 번개페이거래를 통한 물품 거래에만 적용됩니다.
구매자가 전조에 따라 청약을 철회한 경우 구매자는 물품을 수령한 방법으로 해당 물품을 판매자에게 반환하여야 하고, 판매자는 구매자가 수령한 물품을 반환할 수 있도록 성실하게 협조하여야 합니다.
전항에 따라 구매자로부터 청약을 철회한 물품을 반환 받은 판매자는 반환 받은 사실을 회사에 알리고, 만약 물품 대금을 회사로부터 이미 지급 받았다면, 정산 받은 물품 대금을 즉시 구매자에게 반환하여야 합니다(판매자가 물품 대금을 회사로부터 지급 받기 전이라면 회사가 구매자에게 직접 물품 대금을 반환합니다).
회사는 본조에 따라 판매자로부터 청약을 철회한 물품을 반환 받은 사실을 통지 받은 후 3영업일 이내에 구매자가 결제한 물품 대금을 구매자에게 환급하여야 합니다.
제5장 회사와 회원의 책임과 의무
제18조 (회사의 의무)
회사는 원활한 서비스의 제공 및 정보의 보안을 위하여 이에 필요한 인력과 설비를 적절하게 유지하고 점검 또는 복구 조치 등을 성실하게 이행합니다.
회사는 회원의 동의 없이 회원의 정보를 수집 또는 활용하거나 제3자에게 제공하지 않습니다.
제19조 (회원의 의무)
회원은 본 약관, 운영정책, 이용안내 사항과 관련 법령을 준수하여야 하며 기타 회사 업무에 방해되는 행위를 하여서는 안됩니다.
회사는 회원이 본 약관 및 운영정책에서 제한 또는 금지하는 행위를 한 경우 해당 회원이 회사로부터 부수적으로 제공 받은 포인트 등 혜택의 전부 또는 일부를 회수하거나 계정 접속을 제한 또는 회원 자격을 박탈할 수 있고, 해당 회원의 게시글을 임시 삭제 또는 영구 삭제 할 수 있습니다. 이에 따라 회원 자격을 박탈 당한 자의 재가입은 제한될 수 있습니다.
회사가 전항에 따른 조치를 취할 경우 원칙적으로 사전에 해당 회원에게 통지하나 긴급을 요하는 등 부득이한 사유가 있는 경우 선 조치 후 사후 통지할 수 있습니다.
조치의 대상인 회원이 제2항에 따른 회사의 조치에 대하여 이의가 있는 경우 회사에 이의를 신청할 수 있습니다.
제20조 (판매자의 의무)
판매자는 다음 각 호에 따른 의무를 이행하여야 합니다.
구매자의 요청이 있을 경우 판매하는 물품의 구매 청약을 한 구매자에게 이름, 생년월일(업자 아닌 판매자의 경우만 해당), 주소, 전화번호, 이메일 등 신원정보를 제공하여야 합니다.
구매자로부터 번개톡거래를 통한 구매 청약을 받거나 구매자가 번개페이거래를 통해 구매 청약을 한 사실을 알게 되었을 경우 청약을 받은 사실을 즉시 구매자에게 알려야 합니다. 만약 청약을 받은 물품을 판매할 수 없는 사정이 있다면 지체 없이 그 사정을 구매자에게 알리고 구매 청약을 취소할 것을 요청하여야 합니다.
청약의 철회와 계약의 해제에 관한 기한, 행사 방법, 효과에 관하여 미리 다른 회원이 알 수 있도록 고지하여야 합니다.
구매자가 물품 대금을 결제하거나 판매자에게 지급한 후 판매자에게 물품 배송 또는 직거래에 관한 진행 상황을 문의한 경우 이에 성실하게 응하여야 합니다.
구매자가 번개페이를 통해 물품 대금을 결제하거나 판매자가 구매자로부터 물품 대금을 직접 지급 받은 후 판매자에게 물품을 판매하지 못한 사정이 생긴 경우 판매자는 즉시 이를 구매자에게 알리고 번개페이를 통해 결제된 물품 대금의 환급 절차 진행을 위해 해당 사실을 회사에 알리거나 직접 지급 받은 물품 대금을 즉시 구매자에게 환급하여야 합니다.
물품을 발송하였거나 직접 전달하였다는 점을 증명할 책임이 있고, 회사가 물품 대금 정산 등 목적으로 판매자에게 물품의 발송 또는 전달이 완료되었다는 증빙을 요청할 수 있으며 판매자는 회사의 위와 같은 요청에 성실하게 응하여야 합니다. 판매자가 위 요청에 성실하게 응하지 아니하여 발생한 회사의 손해 및 제반 문제에 대한 일체의 책임은 판매자가 부담합니다.
업자인 판매자는 다음 각 호에 따른 의무를 추가적으로 이행하여야 합니다.
전자상거래법에 따라 통신판매업자로 신고하여야 합니다.
구매자가 구매 청약을 한 날로부터 7일 이내에 물품 전달을 위한 조치를 취하여야 하고 번개페이거래의 경우 구매자가 번개페이를 통해 물품 대금 결제를 한 날로부터 3영업일 이내에 물품의 택배 배송을 위한 조치를 하여야 합니다(직거래의 경우 3영업일 이내에 직거래를 위한 거래 일정을 정하여야 합니다). 다만, 판매자가 구매자와 별도로 달리 협의한 경우에는 위 의무가 적용되지 않을 수 있습니다.
구매자가 물품을 수령한 후 7일 이내에 단순 변심 등의 사유에 따라 청약을 철회할 의사를 표시한 경우 구매자가 수령한 방법으로 물품을 판매자에게 반환할 수 있도록 협조하여야 하고, 구매자로부터 물품을 반환 받은 후 즉시 구매자로부터 직접 받은 물품 대금을 구매자에게 반환하거나 회사로부터 정산 받은 물품 대금을 회사에 반환하여야 합니다.
판매자가 판매한 물품이 기존의 판매 게시글에 기재된 정보와 다르거나 다르게 이행되었다면 구매자가 물품을 수령한 후 3개월 이내에, 위 다르거나 다르게 이행된 사실을 구매자가 안 날 또는 알 수 있었던 날로부터 30일 이내에 청약을 철회할 의사를 표시한 경우 구매자가 수령한 방법으로 물품을 판매자에게 반환할 수 있도록 협조하여야 하고, 구매자로부터 물품을 반환 받은 후 즉시 구매자로부터 직접 받은 물품 대금을 구매자에게 반환하거나 회사로부터 정산 받은 물품 대금을 회사에 반환하여야 합니다.
구매자의 책임 있는 사유로 물품이 이미 멸실 또는 훼손되거나 구매자의 사용 또는 소비로 물품의 가치가 현저하게 감소하였거나 재판매하기 곤란한 정도로 물품의 가치가 현저히 감소한 경우에는 본조에 따라 구매자가 청약을 철회할 의사를 표시하였다고 하더라도 이를 거부할 수 있습니다.
제21조 (회원에 대한 통지)
회사가 회원에 대한 통지를 하는 경우 본 약관에 별도의 규정이 없는 한 서비스 제공을 위한 웹사이트 또는 어플리케이션 내 알림으로 통지하거나 회원이 회원가입 신청시(또는 이후 회사에 변경 통지한) 입력한 이메일 주소로 이메일 발송, 휴대전화번호로 SMS 또는 카카오톡 메시지 발송을 통해 통지할 수 있습니다.
회사는 회원 전체에 대한 통지가 필요한 경우 7일 이상의 웹사이트 및 어플리케이션 공지사항 화면에 통지의 내용을 게시함으로써 전항의 통지를 갈음할 수 있습니다
제6장 분쟁의 해결
제22조 (분쟁조정센터)
회사는 서비스 이용에 관한 회원의 불만이나 회원간 분쟁의 접수 및 해결을 위한 인력 및 설비를 갖춘 분쟁조정센터를 운영하고, 분쟁조정의 절차에 관한 상세 내용을 정하는 분쟁조정기준을 제정합니다.

제23조 (분쟁의 해결을 위한 신원정보 제공)
거래 관련 분쟁에 관한 관계기관의 회사에 대한 요청에 따라 회사는 관계기관에 회원의 신원 정보를 제공할 수 있습니다. 번개페이거래로 이루어진 회원간의 거래에 관한 분쟁이 발생한 경우 회사는 분쟁의 해결을 위해 위 거래의 당사자인 회원의 요청에 따라 번개페이를 통해 결제된 물품 대금 지급에 관한 정보를 제공할 수 있습니다.
제7장 기타
제24조 (운영정책)
회사는 회원에게 건전하고 안전한 서비스를 원활하게 제공하기 위해 운영정책을 수립하고 운영합니다.

제25조 (저작권 등 콘텐츠에 대한 권리의 귀속)
서비스의 저작권 및 지적재산권을 전적으로 회사에 귀속됩니다. 다만, 제휴 계약에 따라 제공된 저작물은 그렇지 아니합니다.
회사가 제공하는 서비스의 디자인, 회사가 만든 텍스트, 스크립트(script), 그래픽, 회원 상호간 메시지 전송 기능 등 회사가 제공하는 서비스에 관한 모든 상표, 서비스 마크, 로고 등 관련 저작권 기타 지적재산권은 대한민국 및 외국의 관련 법령에 근거하여 회사가 보유하고 있거나 회사에게 소유권 또는 사용권이 있습니다.
회원은 본 약관으로 인하여 서비스를 소유하거나 서비스에 관한 저작권을 보유하게 되는 것이 아니라, 회사로부터 서비스의 이용을 허락 받게 되는 것입니다.
회원은 회사에 의해 명시적으로 허락된 내용을 제외하고는 서비스를 통해 얻어지는 회원 상태 정보를 영리 목적으로 사용, 복사, 유통할 수 없고, 회사가 만든 텍스트, 스크립트, 그래픽의 회원 상호간 메시지 전송 기능 등을 복사하거나 유통할 수 없습니다.
회사는 서비스와 관련하여 회원에게 회사가 정한 이용 조건에 따라 계정, 아이디, 콘텐츠 등을 이용할 수 있는 이용 권한을 부여하며, 회원은 이를 양도, 판매, 담보제공 등의 처분행위를 할 수 없습니다.
회사는 서비스를 통해 얻어지는 회원의 게시물(판매자, 구매자 정보 및 기타 거래 관련 정보) 관련 정보를 영리 목적으로 회원의 허락 없이 사용할 수 있습니다.
회원이 서비스를 이용하면서 발생 및 생성된 정보에 대한 저작권 및 지적재산권은 모두 회사에 귀속됩니다. 다만, 회원이 단독으로 생성한 콘텐츠에 대해서는 회사와 해당 회원에게 공동 소유권 또는 사용권이 있습니다.
제26조 (재판권 및 준거법)
본 약관과 회사와 회원간의 서비스 이용 계약, 회원 상호간의 물품 거래에 관하여는 대한민국 법령이 적용되며, 이에 관하여 발생한 분쟁을 해결하기 위한 소송이나 절차는 회사의 본점 소재지를 관할하는 법원에 따르는 것으로 합니다.

이 약관은 2020년 11월 18일부터 시행합니다.
	 </textarea>
	 <br> <br>
	 <!-- 이용약관 동의 내용 -->   
  <!--    </li> -->
    <!--  </div> -->
     
          <!-- 이용약관 동의 안내 -->  
          
           <!-- 개인정보 수집 및 이용에 대한 안내 -->

	<div class=form-check>
	<label class="form-check-label">
   <input type="checkbox" class="form-check-input" name="check" id="req2"> 개인정보 수집 및 이용 동의(필수)
     <span class="form-check-sign">
		<span class="check">
		</span>
	</span>
	</label>
     </div> 
       <!-- 개인정보 수집 및 이용 약관 -->
       <textarea rows="10" cols="20" class="form-control maintext" readonly >
 개인정보보호법에 따라 네이버에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.

1. 수집하는 개인정보
이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 네이버 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 네이버는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.

회원가입 시점에 네이버가 이용자로부터 수집하는 개인정보는 아래와 같습니다.
- 회원 가입 시에 ‘아이디, 비밀번호, 이름, 생년월일, 성별, 휴대전화번호’를 필수항목으로 수집합니다. 만약 이용자가 입력하는 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다. 그리고 선택항목으로 이메일 주소, 프로필 정보를 수집합니다.
- 단체아이디로 회원가입 시 단체아이디, 비밀번호, 단체이름, 이메일주소, 휴대전화번호를 필수항목으로 수집합니다. 그리고 단체 대표자명을 선택항목으로 수집합니다.
서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.
NAVER 내의 개별 서비스 이용, 이벤트 응모 및 경품 신청 과정에서 해당 서비스의 이용자에 한해 추가 개인정보 수집이 발생할 수 있습니다. 추가로 개인정보를 수집할 경우에는 해당 개인정보 수집 시점에서 이용자에게 ‘수집하는 개인정보 항목, 개인정보의 수집 및 이용목적, 개인정보의 보관기간’에 대해 안내 드리고 동의를 받습니다.

서비스 이용 과정에서 IP 주소, 쿠키, 서비스 이용 기록, 기기정보, 위치정보가 생성되어 수집될 수 있습니다. 또한 이미지 및 음성을 이용한 검색 서비스 등에서 이미지나 음성이 수집될 수 있습니다.
구체적으로 1) 서비스 이용 과정에서 이용자에 관한 정보를 자동화된 방법으로 생성하여 이를 저장(수집)하거나,
2) 이용자 기기의 고유한 정보를 원래의 값을 확인하지 못 하도록 안전하게 변환하여 수집합니다. 서비스 이용 과정에서 위치정보가 수집될 수 있으며,
네이버에서 제공하는 위치기반 서비스에 대해서는 '네이버 위치정보 이용약관'에서 자세하게 규정하고 있습니다.
이와 같이 수집된 정보는 개인정보와의 연계 여부 등에 따라 개인정보에 해당할 수 있고, 개인정보에 해당하지 않을 수도 있습니다.

2. 수집한 개인정보의 이용
네이버 및 네이버 관련 제반 서비스(모바일 웹/앱 포함)의 회원관리, 서비스 개발・제공 및 향상, 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.

- 회원 가입 의사의 확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.
- 콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성, 지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다.
- 법령 및 네이버 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.
- 유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 상품 및 서비스의 배송을 위하여 개인정보를 이용합니다.
- 이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.
- 서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.
- 보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.
3. 개인정보의 보관기간
회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.
단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.

이용자에게 개인정보 보관기간에 대해 회원가입 시 또는 서비스 가입 시 동의를 얻은 경우는 아래와 같습니다.
- 부정 가입 및 이용 방지
가입인증 휴대전화번호 또는DI (만14세 미만의 경우 법정대리인DI) : 수집시점으로부터6개월 보관
탈퇴한 이용자의 휴대전화번호(복호화가 불가능한 일방향 암호화(해시처리)) : 탈퇴일로부터6개월 보관
- QR코드 복구 요청 대응
QR코드 등록 정보:삭제 시점으로부터6개월 보관
- 스마트플레이스 분쟁 조정 및 고객문의 대응
휴대전화번호:등록/수정/삭제 요청 시로부터 최대1년
- 네이버 플러스 멤버십 서비스 혜택 중복 제공 방지
암호화처리(해시처리)한DI :혜택 제공 종료일로부터6개월 보관
전자상거래 등에서의 소비자 보호에 관한 법률, 전자금융거래법, 통신비밀보호법 등 법령에서 일정기간 정보의 보관을 규정하는 경우는 아래와 같습니다. 네이버는 이 기간 동안 법령의 규정에 따라 개인정보를 보관하며, 본 정보를 다른 목적으로는 절대 이용하지 않습니다.
- 전자상거래 등에서 소비자 보호에 관한 법률
계약 또는 청약철회 등에 관한 기록: 5년 보관
대금결제 및 재화 등의 공급에 관한 기록: 5년 보관
소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관
- 전자금융거래법
전자금융에 관한 기록: 5년 보관
- 통신비밀보호법
로그인 기록: 3개월

참고로 네이버는 ‘개인정보 유효기간제’에 따라 1년간 서비스를 이용하지 않은 회원의 개인정보를 별도로 분리 보관하여 관리하고 있습니다.

4. 개인정보 수집 및 이용 동의를 거부할 권리
이용자는 개인정보의 수집 및 이용 동의를 거부할 권리가 있습니다. 회원가입 시 수집하는 최소한의 개인정보, 즉, 필수 항목에 대한 수집 및 이용 동의를 거부하실 경우, 회원가입이 어려울 수 있습니다.
       </textarea>
       <br><br>
       <!-- 개인정보 수집 및 이용 약관 -->

      <!-- 개인정보 수집 및 이용에 대한 안내 -->
      
      <!-- 위치정보 이용약관 동의 내용 안내 -->
      <div class=form-check>
      <label class="form-check-label">
		 <input type="checkbox" class="form-check-input" name="check" id="req3"> 위치정보 이용약관 동의(필수)
       <span class="form-check-sign">
		<span class="check">
		</span>
	</span>
	</label>
        </div> 
          <!-- 위치정보 이용약관 동의 내용 -->
          
          <textarea rows="10" cols="20" class="form-control maintext" readonly >
위치정보 이용약관에 동의하시면, 위치를 활용한 광고 정보 수신 등을 포함하는 네이버 위치기반 서비스를 이용할 수 있습니다.


제 1 조 (목적)
이 약관은 네이버 주식회사 (이하 “회사”)가 제공하는 위치정보사업 또는 위치기반서비스사업과 관련하여 회사와 개인위치정보주체와의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.

제 2 조 (약관 외 준칙)
이 약관에 명시되지 않은 사항은 위치정보의 보호 및 이용 등에 관한 법률, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신기본법, 전기통신사업법 등 관계법령과 회사의 이용약관 및 개인정보처리방침, 회사가 별도로 정한 지침 등에 의합니다.

제 3 조 (서비스 내용 및 요금)
①회사는 직접 위치정보를 수집하거나 위치정보사업자인 이동통신사로부터 위치정보를 전달받아 아래와 같은 위치기반서비스를 제공합니다.
1.Geo Tagging 서비스: 게시물에 포함된 개인위치정보주체 또는 이동성 있는 기기의 위치정보가 게시물과 함께 저장됩니다.
2.위치정보를 활용한 검색결과 제공 서비스: 정보 검색을 요청하거나 개인위치정보주체 또는 이동성 있는 기기의 위치정보를 제공 시 본 위치정보를 이용한 검색결과 및 주변결과(맛집, 주변업체, 교통수단 등)를 제시합니다.
3.위치정보를 활용한 친구찾기 및 친구맺기: 현재 위치를 활용하여 친구를 찾아주거나 친구를 추천하여 줍니다.
4.연락처 교환하기: 위치정보를 활용하여 친구와 연락처를 교환할 수 있습니다.
5.이용자 위치를 활용한 광고정보 제공: 검색결과 또는 기타 서비스 이용 과정에서 개인위치정보주체 또는 이동성 있는 기기의 위치를 이용하여 광고소재를 제시합니다.
6. 이용자 보호 및 부정 이용 방지: 개인위치정보주체 또는 이동성 있는 기기의 위치를 이용하여 권한없는 자의 비정상적인 서비스 이용 시도 등을 차단합니다.
7. 위치정보 공유: 개인위치정보주체 또는 이동성 있는 기기의 위치정보를 안심귀가 등을 목적으로 지인 또는 개인위치정보주체가 지정한 제3자에게 공유합니다.
8. 길 안내 등 생활편의 서비스 제공: 교통정보와 길 안내 등 최적의 경로를 지도로 제공하며, 주변 시설물 찾기, 뉴스/날씨 등 생활정보, 긴급구조 서비스 등 다양한 운전 및 생활 편의 서비스를 제공합니다.
②제1항 위치기반서비스의 이용요금은 무료입니다.
제 4 조 (개인위치정보주체의 권리)
①개인위치정보주체는 개인위치정보 수집 범위 및 이용약관의 내용 중 일부 또는 개인위치정보의 이용ㆍ제공 목적, 제공받는 자의 범위 및 위치기반서비스의 일부에 대하여 동의를 유보할 수 있습니다.
②개인위치정보주체는 개인위치정보의 수집ㆍ이용ㆍ제공에 대한 동의의 전부 또는 일부를 철회할 수 있습니다.
③개인위치정보주체는 언제든지 개인위치정보의 수집ㆍ이용ㆍ제공의 일시적인 중지를 요구할 수 있습니다. 이 경우 회사는 요구를 거절하지 아니하며, 이를 위한 기술적 수단을 갖추고 있습니다.
④개인위치정보주체는 회사에 대하여 아래 자료의 열람 또는 고지를 요구할 수 있고, 당해 자료에 오류가 있는 경우에는 그 정정을 요구할 수 있습니다. 이 경우 회사는 정당한 이유 없이 요구를 거절하지 아니합니다.
1.개인위치정보주체에 대한 위치정보 수집ㆍ이용ㆍ제공사실 확인자료
2.개인위치정보주체의 개인위치정보가 위치정보의 보호 및 이용 등에 관한 법률 또는 다른 법령의 규정에 의하여 제3자에게 제공된 이유 및 내용
⑤회사는 개인위치정보주체가 동의의 전부 또는 일부를 철회한 경우에는 지체 없이 수집된 개인위치정보 및 위치정보 수집ㆍ이용ㆍ제공사실 확인자료를 파기합니다. 단, 동의의 일부를 철회하는 경우에는 철회하는 부분의 개인위치정보 및 위치정보 수집ㆍ이용ㆍ제공사실 확인자료에 한합니다.
⑥개인위치정보주체는 제1항 내지 제4항 의 권리행사를 위하여 이 약관 제13조의 연락처를 이용하여 회사에 요구할 수 있습니다.
제 5 조 (법정대리인의 권리)
①회사는 만14세 미만 아동으로부터 개인위치정보를 수집ㆍ이용 또는 제공하고자 하는 경우에는 만14세 미만 아동과 그 법정대리인의 동의를 받아야 합니다.
②법정대리인은 만14세 미만 아동의 개인위치정보를 수집ㆍ이용ㆍ제공에 동의하는 경우 동의유보권, 동의철회권 및 일시중지권, 열람ㆍ고지요구권을 행사할 수 있습니다.
제 6 조 (위치정보 이용ㆍ제공사실 확인자료 보유근거 및 보유기간)
회사는 위치정보의 보호 및 이용 등에 관한 법률 제16조 제2항에 근거하여 개인위치정보주체에 대한 위치정보 수집ㆍ이용ㆍ제공사실 확인자료를 위치정보시스템에 자동으로 기록하며, 6개월 이상 보관합니다.

제 7 조 (서비스의 변경 및 중지)
①회사는 위치정보사업자의 정책변경 등과 같이 회사의 제반 사정 또는 법률상의 장애 등으로 서비스를 유지할 수 없는 경우, 서비스의 전부 또는 일부를 제한, 변경하거나 중지할 수 있습니다.
②제1항에 의한 서비스 중단의 경우에는 회사는 사전에 인터넷 등에 공지하거나 개인위치정보주체에게 통지합니다.
제 8 조 (개인위치정보 제3자 제공시 즉시 통보)
①회사는 개인위치정보주체의 동의 없이 당해 개인위치정보주체의 개인위치정보를 제3자에게 제공하지 아니하며, 제3자 제공 서비스를 제공하는 경우에는 제공 받는 자 및 제공목적을 사전에 개인위치정보주체에게 고지하고 동의를 받습니다.
②회사는 개인위치정보를 개인위치정보주체가 지정하는 제3자에게 제공하는 경우에는 개인위치정보를 수집한 당해 통신단말장치로 매회 개인위치정보주체에게 제공받는 자, 제공일시 및 제공목적을 즉시 통보합니다.
③다만, 아래에 해당하는 경우에는 개인위치정보주체가 미리 특정하여 지정한 통신단말장치 또는 전자우편주소 등으로 통보합니다.
1.개인위치정보를 수집한 당해 통신단말장치가 문자, 음성 또는 영상의 수신기능을 갖추지 아니한 경우
2.개인위치정보주체가 개인위치정보를 수집한 당해 통신단말장치 외의 통신단말장치 또는 전자우편주소 등으로 통보할 것을 미리 요청한 경우
제 9 조 (8세 이하의 아동 등의 보호의무자의 권리)
①회사는 아래의 경우에 해당하는 자(이하 “8세 이하의 아동”등이라 한다)의 보호의무자가 8세 이하의 아동 등의 생명 또는 신체보호를 위하여 개인위치정보의 이용 또는 제공에 동의하는 경우에는 본인의 동의가 있는 것으로 봅니다.
1. 8세 이하의 아동
2. 금치산자
3. 장애인복지법제2조제2항제2호의 규정에 의한 정신적 장애를 가진 자로서 장애인고용촉진및직업재활법 제2조제2호의 규정에 의한 중증장애인에 해당하는 자(장애인복지법 제29조의 규정에 의하여 장애인등록을 한 자에 한한다)
② 8세 이하의 아동 등의 생명 또는 신체의 보호를 위하여 개인위치정보의 이용 또는 제공에 동의를 하고자 하는 보호의무자는 서면동의서에 보호의무자임을 증명하는 서면을 첨부하여 회사에 제출하여야 합니다.
③보호의무자는 8세 이하의 아동 등의 개인위치정보 이용 또는 제공에 동의하는 경우 개인위치정보주체 권리의 전부를 행사할 수 있습니다.
제 10 조 (손해배상)
개인위치정보주체는 회사의 위치정보의 보호 및 이용 등에 관한 법률 제15조 내지 26조의 규정을 위반한 행위로 손해를 입은 경우에 회사에 대하여 손해배상을 청구할 수 있습니다. 이 경우 회사는 고의 또는 과실이 없음을 입증하지 아니하면 책임을 면할 수 없습니다.

제 11 조 (분쟁의 조정)
① 회사는 위치정보와 관련된 분쟁에 대하여 개인위치정보주체와 협의가 이루어지지 아니하거나 협의를 할 수 없는 경우에는 방송통신위원회에 재정을 신청할 수 있습니다.
② 회사 또는 개인정보위치 주체는 위치정보와 관련된 분쟁에 대해 당사자간 협의가 이루어지지 아니하거나 협의를 할 수 없는 경우에는 개인정보보호법에 따라 개인정보분쟁조정위원회에 조정을 신청할 수 있습니다.
제 12 조 (사업자 정보)
회사의 상호, 주소, 전화번호 그 밖의 연락처는 다음과 같습니다.

상호: 네이버 주식회사
주소: 경기도 성남시 분당구 불정로 6 네이버 그린팩토리 (463-867)
전화번호: 1588-3820
이메일 주소: navercc@naver.com
부칙
제1조 시행일
2015년 6월 2일부터 시행되던 종전의 약관은 본 약관으로 대체하며, 본 약관은 2015년 11월 26일부터 적용됩니다.

제2조 위치정보관리 책임자 정보
회사는 다음과 같이 위치정보 관리책임자를 지정하여 이용자들이 서비스 이용과정에서 발생한 민원사항 처리를 비롯하여 개인위치정보 주체의 권리 보호를 위해 힘쓰고 있습니다.

위치정보 관리책임자 : (개인)정보보호 담당 부서 임원(개인정보 보호책임자 겸직)
전화번호 : 1588-3820
이메일 주소 : privacy@naver.com
          </textarea><br><br>
         
          
          
          <!-- 위치정보 이용약관 동의 내용 -->

     <!-- 위치정보 이용약관 동의 내용 안내 -->
     

     <!-- 이용약관 동의 안내 -->  
     
   <!--  <input type="submit" value="확인" id="terms_check" > -->
   <div class="col-md-5 ml-auto mr-auto fileadd6">
    <input type="button" class="btn btn-primary" value="동의" onclick="terms_check()"/>
    <input type="button" class="btn btn-primary" value="취소" onclick="history.back();">
	</div>

  
 	<!-- 약관동의 -->     
 	
 	
 	</form>
 	
     </fieldset> 
     
     </div>
		</div>
		</div>
		</div>
		</div> 
<!-- 푸터 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 -->
</body>
</html>