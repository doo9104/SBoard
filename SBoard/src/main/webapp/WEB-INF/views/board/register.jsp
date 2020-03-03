<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<script src="/resources/js/ckeditor.js"></script>


<p/>
<form role="form" action="/board/register" method="post">
  <fieldset>
    <legend>글 작성</legend>
    <div class="form-group">
      <label for="btitle">제목</label>
      <input class="form-control" id="btitle" name='btitle'>
    </div>
    <div class="form-group">
      <label for="bcontent">내용</label>
      <textarea class="form-control" id="bcontent" name='bcontent' rows="10"></textarea>
    </div>
    <div class="form-group">
      <label for="bwriter">작성자</label>
      <input class="form-control" id="bwriter" name='bwriter'>
    </div>   
    <button type="submit" class="btn btn-primary">글작성</button>
  </fieldset>
</form>

						<script>
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
						        console.log( editor );
						} )
						.catch( error => {
						        console.error( error );
						} );
		                </script>

<%@include file="../includes/footer.jsp" %>