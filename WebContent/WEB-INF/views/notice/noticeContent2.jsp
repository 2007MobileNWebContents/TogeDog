<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<title>공지사항 & QnA게시판</title>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
   integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
   crossorigin="anonymous">
<style>
<style>
div {
	font-family: 맑은고딕;
}

#wrapper {
	width: 1890px;
	margin: 0 auto;
	padding: 0 auto;
}

#contents {
	width: 1200px;
	height: 700px;
	margin: 0 auto;
	position: relative;
	bottom: 35px;
}

#legendtitle {
	text-align: left;
	font-size: 24px;
	font-weight: bold;
}

#textP {
	text-align: left;
	position: relative;
	left: 190px;
	font-weight: 1000;
	font-size: 20px;
}

#textA {
	text-align: left;
	position: relative;
	left: 190px;
	font-size: 12px;
}

#buttonM, #buttonD {
	width: 90px;
	height: 30px;
	background-color: black;
	color: white;
	font-size: 13px;
	font-weight: 1000;
	border-top-left-radius: 8px;
	border-top-right-radius: 8px;
	border-bottom-right-radius: 8px;
	border-bottom-left-radius: 8px;
	float: left;
	margin: 5px;
}

#buttonL {
	width: 130px;
	height: 30px;
	font-size: 13px;
	background-color: darkgray;
	color: black;
	border-top-left-radius: 8px;
	border-top-right-radius: 8px;
	border-bottom-right-radius: 8px;
	border-bottom-left-radius: 8px;
	float: left;
	margin: 5px;
}

#comments {
	text-align: center;
	left: 15%;
	position: relative;
}
</style>
</head>
<body>
	<div id="wrapper">
		<div id="header"></div>
		<div id="nav"></div>
		<div id="contents">
<p style="text-align: right; font-size: 13px;">홈 > Q&A > 게시글</p>
			<div id="div1" style="text-align: center;">
				<legend id="legendtitle">Q & A</legend>
				<br>
				<hr>
				<br>
         <c:if test="${sessionScope.member.userId eq 'munji' || content.userId eq sessionScope.member.userId }">

  
            
            <p id="textP">제목 : ${content.subject }</p>
            <p id="textA">글번호 : ${content.noticeNo } / 글쓴이 :${content.userId }  / 작성일 :${content.regDate }  / 조회수 : ${content.readcount }</p>
               </c:if>
              	
	
           <form action="/notice/commentinsert" method="post">
           <c:if test="${sessionScope.member.userId eq 'munji' || content.userId eq sessionScope.member.userId }">
            <textarea rows="20" cols="110" name="content">${content.contents }</textarea>
            <br>
           
           
       <div style="position: relative; left: 662px">
               <a
                  href="/notice/modifyform?noticeNo=${content.noticeNo }"><input
                  type="button" value="수정하기" id="buttonM"></a>
                  
                  <a href="/notice/delete?noticeNo=${content.noticeNo }"
                  onclick="return deleteConfirm();"> 
                  
                  <input type="button" value="삭제하기" id="buttonD"></a> 
                  <a href="/notice/list"><input type="button" value="목록으로 돌아가기" id="buttonL"
                  onclick="javascript:history.back();"></a>
            </div>
            </c:if>
          
                  <script>
      function deleteConfirm() {
            return confirm ("게시글을 정말로 삭제하시겠습니까?");
            location.href="";
      }   
      
   </script>
            </form>
            
  
<br><br><br><br>

<div id="comments">

  
<c:if test="${sessionScope.member.userId eq 'munji' || content.userId eq sessionScope.member.userId }">
<table>
    <tr>
        <th colspan="2">댓글 목록</th>
      
    </tr>  
   
</table>
<a>작성자 : ${sessionScope.member.userId} | 답변 내용 :  ${comment.contents } | 작성일 :  ${comment.regDate }</a>
   <form action="/notice/commentinsert" method="post">
   	<textarea rows="1" cols="100" name="contents"></textarea><br>
   	<input type="hidden" name="userId" value="${content.userId }">
    <input type="hidden" name="noticeNo" value="${content.noticeNo }">
	<input type="submit" value="답글달기" onclick="reload()" id="buttonM">

	</form>

<script>
		function reload(){
			var noticeNo = '${content.noticeNo }'
			alert("답글을 등록하시겠습니까?");
		}
	</script>

 
<c:forEach var="i" begin = "1" end ="${totalCount }" step="1">
    <a href="BoardServlet?command=board_view&num=${param.num }&page=${i}"></a>

</c:forEach>
</c:if>


<br><br>
 
   </div>


</div>


	<br><br>

		<hr>
		<div id="footer"></div>

		<script type="text/javascript">
			/* include */
			$(document).ready(function() {
				$("#header").load("/include/headerWeb.jsp")
				$("#nav").load("/include/navWeb.jsp")
				$("#footer").load("/include/footerWeb.html")
			});
		</script>
	</div>
</body>
</html>