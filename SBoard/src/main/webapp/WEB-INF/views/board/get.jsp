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
	
	toolbar: [ 'heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'TodoList', '|', 'code', 'codeBlock', '|', 'fontFamily', 'fontColor', 'fontSize', 'fontBackgroundColor', 'underline', 'highlight', '|', 'blockQuote', 'insertTable', 'mediaEmbed', 'undo', 'redo' ], 
	
	heading: { options: [ 
		{ model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
		{ model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' }, 
		{ model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
		{ model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' }
	] }

	
	
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