<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>


	<!-- 테이블 시작 -->
  <table class="table table-hover" style="border-style:solid;">
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
  <td><c:out value="${board.btitle}" /></td>
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
	
	function showModal(result) {
		
		if (result == '') {
			return;
		}
		
		if(parseInt(result) > 0 ) {
			$(".modal-body").html("게시글" + parseInt(result) + " 번이 등록되었습니다."); 
		}
		
		$("#myModal").modal("show");
	}
	
	
	
	
	
}); /* 도큐먼트 레디 괄호 */
</script>	
	

<%@include file="../includes/footer.jsp" %>