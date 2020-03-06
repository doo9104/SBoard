<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

<script src="/resources/js/ckeditor.js"></script>


<p/>

  <fieldset>
    <legend>글 조회</legend>
    <div class="form-group">
      <label for="btitle">제목</label>
      <input class="form-control" id="btitle" name='btitle' disabled=""  value='<c:out value="${board.btitle}"/>'>
    </div>
    <div class="form-group">
      <label for="bcontent">내용</label>
      <textarea class="form-control" id="bcontent" name='bcontent' rows="10" disabled=""><c:out value="${board.bcontent}"/></textarea>
    </div>
    <div class="form-group">
      <label for="bwriter">작성자</label>
      <input class="form-control" id="bwriter" name='bwriter' disabled="" value='<c:out value="${board.bwriter}"/>'>
    </div>
    <button data-oper='modify' class="btn btn-outline-primary">글 수정</button>
    <button data-oper='list' class="btn btn-primary">목록</button>
  </fieldset>
	
	
	
	<form id="operForm" action="/board/modify" method="get">
		<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno }"/>'>
		<input type='hidden' name='pageNum' value='<c:out value="${page.pageNum }"/>'>
		<input type='hidden' name='amount' value='<c:out value="${page.amount }"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${page.keyword }"/>'>
		<input type='hidden' name='searchType' value='<c:out value="${page.searchType }"/>'>
	</form>
				



<script type="text/javascript" src="/resources/js/comment.js"></script>


<script>
console.log("=========");
console.log("JS TEST");

var bnoValue = '<c:out value="${board.bno}"/>'

// 댓글 등록
/* CommentService.add(
		{ccontent:"JS TEST", cwriter:"noob", bno:bnoValue}
		,
		function(result) {
			alert("RESULT : " + result);
		}
); */

// 댓글 가져오기
/* CommentService.getList({bno:bnoValue, page:1}, function(list) {
	
	for(var i=0, len=list.length||0; i<len;i++){
		console.log(list[i]);
	}
}); */

CommentService.remove(12, function(count) {
	
	console.log(count);
	
	if(count === "success") {
		alert("REMOVED");
	}
}, function(err) {
	alert("ERROR");
});



</script>



<!-- 스크립트 시작  -->
<script type="text/javascript">
$(document).ready(function() {
	
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e) {
		operForm.attr("action","/board/modify").submit();
	});
	
	$("button[data-oper='list']").on("click", function(e) {
		operForm.find("#bno").remove();
		operForm.attr("action","/board/list")
		operForm.submit();
	});
	
	
});




ClassicEditor
.create( document.querySelector( '#bcontent' ), {	
	
	

	
	
} )
.then( editor => {
		editor.isReadOnly = true;
        console.log( editor );
} )
.catch( error => {
        console.error( error );
} );

</script>








<%@include file="../includes/footer.jsp" %>