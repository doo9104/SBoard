<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title><spring:message code="site.title" text="SBoard" /></title>

<!-- <link href="/resources/css/bootstrap-min.css" rel="stylesheet" type="text/css"> -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">

</head>
<body>

<!-- 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <a class="navbar-brand" href="/board/list">SBoard</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarColor01">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Features</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Pricing</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">About</a>
      </li>
    </ul>
    <!-- 오른쪽 메뉴 -->
    <nav class="navbar navbar-expand-sm navbar-dark bg-primary justify-content-center">
  		<ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="#">로그인</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">회원가입</a>
      </li>
    </ul>
	</nav>
	<!-- 오른쪽 메뉴 끝 -->
    <a href="" id="korean"><img src="/resources/img/kr.png"></a>
    <a href="" id="english"><img src="/resources/img/us.png"></a>
    <a href="" id="japanese"><img src="/resources/img/jp.png"></a>
  <!--   <div class="btn-group" role="group" aria-label="Basic example">
  <button type="button" id="korean" class="btn btn-secondary">한국어</button>
  <button type="button" id="english" class="btn btn-secondary">English</button>
  <button type="button" id="japanese"class="btn btn-secondary">日本語</button>
</div> -->
    <!-- <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form> -->
  </div>
</nav>
<!-- 네비게이션 바 끝 -->  
            
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous">
</script> 

<script type="text/javascript">
$(document).ready(function() {

$("#korean").on("click", function(e) {	
	e.preventDefault();
	location.href='/board/list?lang=ko';
});
$("#english").on("click", function(e) {	
	e.preventDefault();
	location.href='/board/list?lang=en';
});
$("#japanese").on("click", function(e) {	
	e.preventDefault();
	location.href='/board/list?lang=jp';
});

}); /* 도큐먼트 레디 괄호 */
</script>

            
<!-- 메인 컨텐츠 시작 -->
<div class="container"> <!-- 가-1 -->