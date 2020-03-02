<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>


	<!-- 테이블 시작 style="border-style:solid;" -->
  <table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">글번호</th>
      <th scope="col">제목</th>
      <th scope="col">작성자</th>
      <th scope="col">조회수</th>
      <th scope="col">추천</th>
      <th scope="col">작성일</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${list}" var="board">
  <tr>
  <td><c:out value="${board.bno}" /></td>
  <td><a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.btitle}" /></a></td>
  <td><c:out value="${board.bwriter}" /></td>
  <td><c:out value="${board.bhit}" /></td>
  <td><c:out value="${board.brec_up}" /></td>
  <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.bregdate }"/></td>
  </tr>
  </c:forEach>
 </tbody>
</table> 
	<!-- 테이블 끝 -->
	<button type="button" onclick="location.href='register'" class="btn btn-primary">글작성</button>
	<!-- 글작성 버튼  끝-->
	<p/>
	
	<!-- 페이지네이션 시작-->
			<div>
		  <ul class="pagination">
		  
		  <c:if test="${pageMaker.prev}">
		    <li class="page-item">
		      <a class="page-link" href="${pageMaker.startPage -1}">&laquo;</a>
		    </li>
		  </c:if>
		  
		  <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
		   <li class="page-item ${pageMaker.page.pageNum == num ? "active":""} ">
		      <a class="page-link" href="${num}">${num}</a>
		    </li>
		  </c:forEach>
		  
		   <c:if test="${pageMaker.next}">
		    <li class="page-item">
		      <a class="page-link" href="${pageMaker.endPage +1}">&raquo;</a>
		    </li>
		  </c:if>
	
		  </ul>
		</div>
	<!-- 페이지네이션 끝 -->
	
	<form id='actionForm' action="/board/list" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.page.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.page.amount}'>
	</form>
	
	
	<!-- 모달창 시작-->
	<div class="modal" id="myModal">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">처리 안내</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">처리가 완료되었습니다.</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달창 끝 -->


<!-- 스크립트 시작  -->
<script type="text/javascript">
$(document).ready(function() {
	
	var result = '<c:out value="${result}"/>';
	
	showModal(result);
	
	history.replaceState({},null,null);
	// 리스트에서 등록 후 모달창이 뜨고 뒤로가기 후에 다시 리스트 오면 모달창이 또 뜨는 문제를 방지하기 위해
 	// window의 history객체를 이용해서 현재 페이지는 모달창을 띄울 필요가 없다는것을 설정

	
	function showModal(result) {
		
		if (result == '' || history.state) {
			return;
		}
		
		if(parseInt(result) > 0 ) {
			$(".modal-body").html("게시글" + parseInt(result) + " 번이 등록되었습니다."); 
		}
		
		$("#myModal").modal("show");
	}
	
	var actionForm = $("#actionForm");
	$(".page-item a").on("click", function(e) {
		
		e.preventDefault();
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	
	$(".move").on("click",function(e) {
		
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action","/board/get");
		actionForm.submit();
	});
	
	
}); /* 도큐먼트 레디 괄호 */



</script>	
	

<%@include file="../includes/footer.jsp" %>