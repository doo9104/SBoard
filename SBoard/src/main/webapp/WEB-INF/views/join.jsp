<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="./includes/header.jsp" %>

<!-- <script src="/resources/js/login.js"></script> -->
<script src="/resources/js/test.js"></script>
 <div class="row">
        <div class="col-md-12">
		<div class="col-md-12 text-center mb-5">
			</div>
            <div class="row">
                <div class="col-md-6 mx-auto">			
					    <!-- form card register -->
                    <div class="card rounded-0" id="register-form">
                        <div class="card-header">
                            <h3 class="mb-0">New Account</h3>
                        </div>
                        <div class="card-body">
                            <form class="registerform" role="form" autocomplete="off" id="formLogin" novalidate="" method="POST">
                                <div class="form-group">
                                    <label for="r_username">ID</label>
                                    <input type="text" class="form-control form-control-lg rounded-0" oninput="checkId()" name="userid" id="userid" required="">
                                    <div class="valid-feedback">사용 가능한 아이디입니다!</div>
                                    <div class="invalid-feedback">이미 사용중인 아이디입니다.</div>

                                </div>
								<div class="form-group">
                                    <label for="r_name">UserName</label>
                                    <input type="text" class="form-control form-control-lg rounded-0" name="username" id="username" required="">

                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input type="password" class="form-control form-control-lg rounded-0" name="password" id="password" required="" autocomplete="new-password">
  
                                </div>
								<div class="form-group">
                                    <label>Password Confirm</label>
                                    <input type="password" class="form-control form-control-lg rounded-0" name="passwordConfirm" id="passwordConfirm" required="" autocomplete="new-password">
    
                                </div>
								<div class="form-group">
                                    <label>E-mail:</label>
                                    <input type="email" class="form-control form-control-lg rounded-0" name="email" id="email" required="" autocomplete="new-password">
               
                                </div>
                                <div>
                                    <label class="custom-control custom-checkbox">
                                     I have an account. <a href="/customLogin" class="login-form-link">Login.</a>
                                    </label>
                                </div>
                                <button type="submit" class="btn btn-success btn-lg float-right" id="btnRegister">Register</button>
                            	<button type="submit" class="btn btn-success btn-lg float-right" id="test">test</button>
                            	
                            </form>
                        </div>
                    </div>
                    <!-- /form card register end -->
                </div>
            </div>
        </div>
    </div>


<script type="text/javascript">
function checkId() {
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	var inputID = { 
			"userid" : $("#userid").val()
	};
	console.log(inputID);
	var JsonStr = JSON.stringify(inputID);
	$.ajax({
		url : '/idCheck',
		type : 'POST',
		data : JsonStr,
		dataType: 'text',
		beforeSend: function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		contentType : "application/json; charset=utf-8",
		success : function(result) {
			if(result == '0') {
				console.log("사용가능합니다.");
				$('#userid').attr("class", "form-control form-control-lg rounded-0 is-valid");
				var inputText = $("#userid").val();
				if(inputText.length == 0) {
					$('#userid').attr("class", "form-control form-control-lg rounded-0");
				}
			}else if(result == '1') {
				console.log("이미 사용중인 아이디입니다.");
				$('#userid').attr("class", "form-control form-control-lg rounded-0 is-invalid");
				var inputText = $("#userid").val();
				if(inputText.length == 0) {
					$('#userid').attr("class", "form-control form-control-lg rounded-0");
				}
			}
		},
		error : function(error) {
			alert("통신 에러!");
		}
	});
}

</script>

<script type="text/javascript">
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
/* var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); */

$("#test").on("click", function(e) {
	e.preventDefault();
	var Data = {
			"userid" : 'admin9'
		};
		var JsonStr = JSON.stringify(Data);
		$.ajax({
			url : '/idCheck',
			type : 'POST',
			data : JsonStr,
			dataType: 'text',
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			contentType : "application/json; charset=utf-8",
			success : function(result) {
				alert("성공! : " + result);
				
			},
			error : function(error) {
				alert("통신 에러!");
			}
			
		});
	
	
	
});



$("#btnRegister").on("click", function(e) {
	e.preventDefault();
	if($("#userid").val() == ""){ alert("아이디를 입력하세요."); $("#userid").focus(); return false; }
	if($("#username").val() == ""){ alert("닉네임을 입력하세요."); $("#username").focus(); return false; }
	if($("#password").val() != $("#passwordConfirm").val()){ alert("비밀번호가 다릅니다."); $("#password").val(""); $("#passwordConfirm").val(""); $("#password").focus(); return false; }
	if($("#email").val() == ""){ alert("이메일을 입력해주세요"); $("#email").focus(); return false; }
	/* if(!getMail.test($("#email").val())){ alert("이메일형식에 맞게 입력해주세요") $("#email").val(""); $("#email").focus(); return false; } */


	alert("클릭");
});


$("#password,#passwordConfirm").on("textchange", function() {
	var pwd1 = $("#password").val();
	var pwd2 = $("#passwordConfirm").val();
	if(pwd1 != "" || pwd2 != ""){
	if(pwd1 == pwd2) {
		// 비밀번호 = 비밀번호 확인 일치할때
		$('#password,#passwordConfirm').attr("class", "form-control form-control-lg rounded-0 is-valid");
	} else {
		// 비밀번호 != 비밀번호 확인 불일치할때
		$('#password,#passwordConfirm').attr("class", "form-control form-control-lg rounded-0 is-invalid");
	}
	} 
	if(pwd1.length == 0 || pwd2.length == 0) { // 하나가 빈칸이면 검증 해제
		$('#password,#passwordConfirm').attr("class", "form-control form-control-lg rounded-0");
	}
});



</script>


<%@include file="./includes/footer.jsp" %>