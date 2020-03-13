<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%@include file="../includes/header.jsp" %>
	<!-- 테이블 시작 style="border-style:solid;" -->
  <table class="table table-hover">
  <thead>
    <tr>
      <th scope="col"><spring:message code="board.no" /></th>
      <th scope="col"><spring:message code="title" /></th>
      <th scope="col"><spring:message code="writer" /></th>
      <th scope="col"><spring:message code="board.hit" /></th>
      <th scope="col"><spring:message code="board.rec" /></th>
      <th scope="col"><spring:message code="board.regdate" /></th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${list}" var="board">
  <tr>
  <td><c:out value="${board.bno}" /></td>
  <td><a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.btitle}" /></a><small> [<c:out value="${board.commentCnt}"/>]</small></td>
  <td><c:out value="${board.bwriter}" /></td>
  <td><c:out value="${board.bhit}" /></td>
  <td><c:out value="${board.brec_up}" /></td>
  <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.bregdate }"/></td>
  </tr>
  </c:forEach>
 </tbody>
</table> 
	<!-- 테이블 끝 -->

	
<div class="container">
  <div class="row">  <!-- 가1 -->
    <div class="col"> <!-- 가2 -->
      <button type="button" onclick="location.href='register'" class="btn btn-primary"><spring:message code="board.write" /></button>
    </div> <!-- 가2 -->
    <div class="col-md-auto"> <!-- 가3 -->    
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
		<!-- 페이지네이션 끝-->
    </div> <!-- 가3 -->
  </div> <!-- 가1 -->
 
	<div class="row"> <!-- 나1 -->
	  <!-- 검색창  시작-->
	  <form id='actionForm' action="/board/list" method='get'>
	<div class="input-group"> <!-- 검색창 div -->
	  <div class="input-group-prepend">
		<span class="input-group-text">
	         <span class="fa fa-search"></span>
	    </span>
	  </div>
	  <input name='keyword' type="text" class="form-control" placeholder='<spring:message code="search.text" />' value='<c:out value="${pageMaker.page.keyword}"/>'/>
	  <select name='searchType' class="custom-select" style="max-width: 20%;">
	    <option value="T" <c:out value="${pageMaker.page.searchType eq 'T'?'selected':'' }"/>><spring:message code="search.T" /></option>
	    <option value="C" <c:out value="${pageMaker.page.searchType eq 'C'?'selected':'' }"/>><spring:message code="search.C" /></option>
	    <option value="TC" <c:out value="${pageMaker.page.searchType eq 'TC'?'selected':'' }"/>><spring:message code="search.TC" /></option>
	    <option value="W" <c:out value="${pageMaker.page.searchType eq 'W'?'selected':'' }"/>><spring:message code="search.W" /></option>
	  </select>
	  <div class="input-group-append">
	    <button class="btn btn-outline-secondary"><spring:message code="search.button" /></button>
	    <input type='hidden' name='pageNum' value='${pageMaker.page.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.page.amount}'>
	  </div>
	</div> <!-- 검색창 div -->
	</form>
	<!-- 검색창 끝 -->
	</div> <!-- 나1 -->
</div> <!-- 전체컨테이너 -->
	
	
	
	

	
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
	/*	
		리스트에서 등록 후 모달창이 뜨고 뒤로가기 후에 다시 리스트 오면 모달창이 또 뜨는 문제를 방지하기 위해
		window의 history객체를 이용해서 현재 페이지는 모달창을 띄울 필요가 없다는것을 설정
	*/
	
	function showModal(result) {
		
		if (result == '' || history.state) {
			return;
		}
		
		if(parseInt(result) > 0 ) {
			$(".modal-body").html("게시글" + parseInt(result) + " 번이 등록되었습니다."); 
		}
		
		$("#myModal").modal("show");
	}
	
	/* 페이지 이동 스크립트 */
	var actionForm = $("#actionForm");
	$(".page-item a").on("click", function(e) {
		
		e.preventDefault();
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	/* 페이지 이동 스크립트 */
	$(".move").on("click",function(e) {
		
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action","/board/get");
		actionForm.submit();
	});
	
	/* 검색 버튼 스크립트*/
	$("#actionForm button").on("click", function() {
		
		if(!actionForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요.");
			return false;
		}
		
		
		actionForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		actionForm.submit();
	});
	
	
}); /* 도큐먼트 레디 괄호 */



</script>	
	

<%@include file="../includes/footer.jsp" %>