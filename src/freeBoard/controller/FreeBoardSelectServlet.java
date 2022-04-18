package freeBoard.controller;



import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import freeBoard.model.service.FreeBoardService;
import freeBoard.model.vo.FreeBoard;

/**
 * Servlet implementation class NoticeSelectServlet
 */
@WebServlet("/freeboard/select")
public class FreeBoardSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FreeBoardSelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한개의 Notice를 DB에서 가져오면 됨
		// 1. 인코딩 처리
		// 2. 웹페이지에서 보내주는 데이터 변수에 저장
		int freeNoticeNo = Integer.parseInt(request.getParameter("freeNoticeNo"));

		Cookie viewCookie=null;
		Cookie[] cookies=request.getCookies();

		System.out.println("cookie : "+cookies);
		
		// SELECT * FROM NOTICE WHERE NOTICENO=12;
		
		// SELECT * FROM NOTICE WHERE NOTICENO = 12;
		FreeBoard freeboard = new FreeBoardService().selectFreeBoard(freeNoticeNo);
		
		if(cookies !=null) {

			for (int i = 0; i < cookies.length; i++) {
				
                
                //만들어진 쿠키들을 확인하며, 만약 들어온 적 있다면 생성되었을 쿠키가 있는지 확인
				if(cookies[i].getName().equals("|"+freeNoticeNo+"|")) {
					
				
                //찾은 쿠키를 변수에 저장
					viewCookie=cookies[i];
				}
			}
			
		}else {
			System.out.println("cookies 확인 로직 : 쿠키가 없습니다.");
		}


		//만들어진 쿠키가 없음을 확인
		if(viewCookie==null) {
        
          	System.out.println("viewCookie 확인 로직 : 쿠키 없당");
			
            try {
            
            	//이 페이지에 왔다는 증거용(?) 쿠키 생성
				Cookie newCookie=new Cookie("|"+freeNoticeNo+"|","readCount");
				response.addCookie(newCookie);
                
                //쿠키가 없으니 증가 로직 진행
				new FreeBoardService().updateReadCount(freeNoticeNo);
                
			} catch (Exception e) {
				System.out.println("쿠키 넣을때 오류 나나? : "+e.getMessage());
				e.getStackTrace();

			}
		
        //만들어진 쿠키가 있으면 증가로직 진행하지 않음
		}else {
			System.out.println("viewCookie 확인 로직 : 쿠키 있당");
			String value=viewCookie.getValue();
			System.out.println("viewCookie 확인 로직 : 쿠키 value : "+value);
		}
		
		if (freeboard != null ) {
			request.setAttribute("content", freeboard);
			RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/freeboard/freeboardContent.jsp");
			view.forward(request, response);
		}else {
			request.getRequestDispatcher("/WEB-INF/views/freeboard/freeboardError.html").forward(request, response);
		}
	}	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
