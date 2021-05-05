//검색 action 페이지
//usersList(상점검색결과),goodsList(상품검색결과) 영역객체에 저장
package com.market.action;

import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.market.db.SearchDAO;

public class SearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("M : SearchAction_execute() 호출");
		//검색어 저장
		String search = request.getParameter("search");
		System.out.println("검색어 : "+search);
		
		//검색 결과조회
		SearchDAO sdao = new SearchDAO();
		Vector searchResult = sdao.search(search);
		System.out.println("검색결과 : "+searchResult);
		
		List goodsList = (List) searchResult.get(1);
		
		request.setAttribute("goodsList", goodsList);
		
		//페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./mainGoods/goods_list.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
