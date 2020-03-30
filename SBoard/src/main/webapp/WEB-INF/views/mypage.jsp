<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="./includes/header.jsp" %>

<div class="row">
	<div class="col-sm justify-content-center" style="border-style: solid;">
		<h2>비밀번호를 한번더 입력해주세요.</h2>
		<input type="text" class="form-control form-control-sm rounded-0"  name="password" id="password" required="">
		<button type="button" id="pwdCheck" class="btn btn-outline-primary">확인</button>
	</div>
</div>




<script>
//시큐리티 csrf 토큰 헤더 설정
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";


$("#pwdCheck").on("click", function(e) { 
	var input = { 
			"userpw" : $("#password").val()
	};
	console.log(input);
	var JsonStr = JSON.stringify(input);

	$.ajax({
		url : '/mypage/passwordConfirm',
		type : 'POST',
		data : JsonStr,
		dataType: 'text',
		beforeSend: function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		contentType : "application/json; charset=utf-8",
		success : function(result) {
			alert("통신 성공!");
		},
		error : function(error) {
			alert("통신 에러!");
		}
	}); // ajax 끝
});

</script>




<%@include file="./includes/footer.jsp" %>