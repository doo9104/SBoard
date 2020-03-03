<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<p/>
<form role="form" action="/board/modify" method="post">
		<input type='hidden' name='pageNum' value='<c:out value="${page.pageNum }"/>'>
		<input type='hidden' name='amount' value='<c:out value="${page.amount}"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${page.keyword }"/>'>
		<input type='hidden' name='searchType' value='<c:out value="${page.searchType }"/>'>

  <fieldset>
    <legend>글 수정</legend>
    
    <div class="form-group">
      <label for="btitle">제목</label>
      <input class="form-control" id="btitle" name='btitle'  value='<c:out value="${board.btitle}"/>'>
    </div>
    <div class="form-group">
      <label for="bcontent">내용</label>
      <textarea class="form-control" id="bcontent" name='bcontent' rows="10"><c:out value="${board.bcontent}"/></textarea>
    </div>
    <div class="form-group">
      <label for="bwriter">작성자</label>
      <input class="form-control" id="bwriter" name='bwriter' readonly=""  value='<c:out value="${board.bwriter}"/>'>
    </div>
    <!-- 수집용 -->
    <div class="form-group" style="display:none;">
      <input type="hidden" class="form-control" id="bregdate" name='bregdate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.bregdate}"/>'>
    </div>
    <div class="form-group" style="display:none;">
      <input type="hidden" class="form-control" id="bupdateregdate" name='bupdateregdate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.bupdateregdate}"/>'>
    </div>
     <div class="form-group" style="display:none;">
      <input class="form-control" id="bno" name='bno'  value='<c:out value="${board.bno}"/>'>
    </div>
    
    <button data-oper='modify' type="submit" class="btn btn-outline-primary">수정</button>
    <button data-oper='remove' type="submit" class="btn btn-danger">삭제</button>
    <button data-oper='list' type="submit" class="btn btn-primary">목록</button>
    
  </fieldset>
</form>
	<p/>



<!-- 스크립트 시작  -->
<script type="text/javascript">
$(document).ready(function() {
	
	var formObj = $("form");
	
	$('button').on("click", function(e) {
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		if(operation === 'remove') {
			formObj.attr("action", "/board/remove");
		}else if(operation === 'list') {
			formObj.attr("action","/board/list").attr("method","get");
			
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var searchTypeTag = $("input[name='searchType']").clone();
			
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(searchTypeTag);
			}
		formObj.submit();
	});
	
	
});


</script>







<%@include file="../includes/footer.jsp" %>