<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
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
	

<%@include file="../includes/footer.jsp" %>