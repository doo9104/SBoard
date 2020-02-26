<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>


	<!-- 테이블 시작 -->
  <table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">글번호</th>
      <th scope="col">제목</th>
      <th scope="col">작성자</th>
      <th scope="col">조회수</th>
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
  <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.bregdate }"/></td>
  </tr>
  </c:forEach>
 </tbody>
</table> 
	<!-- 테이블 끝 -->

<%@include file="../includes/footer.jsp" %>