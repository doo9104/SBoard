<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<!--  PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" -->
<html>
<head>
	<link href="/resources/css/all.css" rel="stylesheet"> <!-- 폰트어썸 -->
	 <script defer src="/resources/js/bootbox.js"></script>
	 <script defer src="/resources/js/bootbox.locales.js"></script>
	<script
	  src="https://code.jquery.com/jquery-3.4.1.min.js"
	  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	  crossorigin="anonymous">
	<script defer src="/resources/js/all.js"></script>
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title><spring:message code="site.title" text="SBoard" /></title>
</head>


<body>
<h1>잘못된 접근</h1>

<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/></h2>
<h2><c:out value="${msg}"/></h2>


<script type="text/javascript">

alert("잘못된 접근입니다.");
history.back();
</script>


</body>
</html>

