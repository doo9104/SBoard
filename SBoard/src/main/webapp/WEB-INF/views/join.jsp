<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="./includes/header.jsp" %>

<!-- <script src="/resources/js/login.js"></script> -->
<script src="/resources/js/textchange.js"></script>
<script type="text/javascript" src="/resources/js/jquery.oLoader.min.js"></script>



 <div class="row">
        <div class="col-md-12">
		<div class="col-md-12 text-center mb-5">
			</div>
            <div class="row">
                <div class="col-md-6 mx-auto">			
					<!-- form join -->
                    <div class="card rounded-0" id="register-form">
                        <div class="card-header">
                            <h3 class="mb-0">New Account</h3>
                        </div>
                        <div class="card-body">
                            <form class="registerform" role="form" autocomplete="off" id="formLogin" novalidate="" method="POST">
                                <div class="form-group">
                                    <label for="userid">ID</label>
                                    <input type="text" class="form-control form-control-lg rounded-0" oninput="checkId()" name="userid" id="userid" maxlength="10" required="">
                                    <div class="valid-feedback">사용 가능한 아이디입니다!</div>
                                    <div id="invalid" class="invalid-feedback">이미 사용중인 아이디입니다.</div>

                                </div>
								<div class="form-group">
                                    <label for="username">UserName</label>
                                    <input type="text" class="form-control form-control-lg rounded-0" name="username" id="username" maxlength="8" required="">
									<div class="valid-feedback">사용 가능한 닉네임입니다!</div>
                                    <div id="invalid1" class="invalid-feedback">이미 사용중인 닉네임입니다.</div>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control form-control-lg rounded-0" name="password" id="password" required="" autocomplete="new-password">
  
                                </div>
								<div class="form-group">
                                    <label for="passwordConfirm">Password Confirm</label>
                                    <input type="password" class="form-control form-control-lg rounded-0" name="passwordConfirm" id="passwordConfirm" required="" autocomplete="new-password">
    
                                </div>
								<div class="form-group">
                                    <label for="email">E-mail:</label>
                                    <input type="email" class="form-control form-control-lg rounded-0" name="email" id="email" required="" autocomplete="new-password">
               						<div class="valid-feedback">사용 가능한 이메일입니다!</div>
                                    <div id="invalid2" class="invalid-feedback">이미 사용중인 이메일입니다.</div>
                                </div>
                                <div>
                                    <label class="custom-control custom-checkbox">
                                     I have an account. <a href="/customLogin" class="login-form-link">Login.</a>
                                    </label>
                                </div>
                                <button type="submit" class="btn btn-success btn-lg float-right" id="btnRegister">Register</button>
                            	
                            </form>
                        </div>
                    </div>
                    <!-- /form card register end -->
                </div>
            </div>
        </div>
    </div>

<!-- 알림 -->



<script type="text/javascript">
$(document).ready(function() {
	
var emailC = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

var csrfHeaderName = "${_csrf.headerName}",
	csrfTokenValue = "${_csrf.token}";
	
	useridCheck = false;
	usernameCheck = false;
	passwordCheck = false;
	emailCheck = false;



	// 가입버튼
$("#btnRegister").on("click", function(e) { 
	e.preventDefault();
	if($("#userid").val() == ""){ bootbox.alert("아이디를 입력하세요."); $("#userid").focus(); return false; }
	if($("#username").val() == ""){ bootbox.alert("닉네임을 입력하세요."); $("#username").focus(); return false; }
	if($("#password").val() != $("#passwordConfirm").val()){ bootbox.alert("비밀번호가 다릅니다."); $("#password").val(""); $("#passwordConfirm").val(""); $("#password").focus(); return false; }
	if($("#email").val() == ""){ bootbox.alert("이메일을 입력해주세요"); $("#email").focus(); return false; }
	/* if(!getMail.test($("#email").val())){ alert("이메일형식에 맞게 입력해주세요") $("#email").val(""); $("#email").focus(); return false; } */
	
	if(useridCheck == true && usernameCheck == true && passwordCheck == true && emailCheck == true) {
		//로그인 성공 ajax 보내기
		var input = { 
			"userid" : $("#userid").val(),
			"username" : $("#username").val(),
			"userpw" : $("#password").val(),
			"email" : $("#email").val()
			};

		var JsonStr = JSON.stringify(input);

		$.ajax({
			url : '/join',
			type : 'POST',
			data : JsonStr,
			dataType: 'text',
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				$('body').loading();
			},
			contentType : "application/json; charset=utf-8",
			success : function(result) {
				bootbox.alert("회원가입 완료를 위한 이메일을 발송하였습니다.");
			},
			error : function(error) {
				bootbox.alert("통신 에러!");
			},complete:function(){
				$('body').loading('stop');
			}
		}); // ajax 끝
			
		//성공 ajax 보내기
	} else {
		bootbox.alert("입력 정보를 확인하세요.");
	}
	
	
});


$("#password,#passwordConfirm").on("textchange", function() {
	var pwd1 = $("#password").val(),
		pwd2 = $("#passwordConfirm").val();
	if(pwd1 != "" || pwd2 != ""){
	if(pwd1 == pwd2) {
		// 비밀번호 = 비밀번호 확인 일치할때
		$('#password,#passwordConfirm').attr("class", "form-control form-control-lg rounded-0 is-valid");
		passwordCheck = true;
	} else {
		// 비밀번호 != 비밀번호 확인 불일치할때
		$('#password,#passwordConfirm').attr("class", "form-control form-control-lg rounded-0 is-invalid");
		passwordCheck = false;
		}
	} 
	if(pwd1.length == 0 || pwd2.length == 0) { // 하나가 빈칸이면 검증 해제
		$('#password,#passwordConfirm').attr("class", "form-control form-control-lg rounded-0");
		passwordCheck = false;
	}
});


//이메일 정규식 확인
$('#email').on("blur", function() {
	if (emailC.test($('#email').val())) {
		$('#email').attr("class", "form-control form-control-lg rounded-0 is-valid");
		/////// ajax
		var input = { 
			"email" : $("#email").val()
		};

		var JsonStr = JSON.stringify(input);

	
		$.ajax({
			url : '/emailCheck',
			type : 'POST',
			data : JsonStr,
			dataType: 'text',
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			contentType : "application/json; charset=utf-8",
			success : function(result) {
				if(result == '0') {
					emailCheck = true;
					$('#email').attr("class", "form-control form-control-lg rounded-0 is-valid");
					inputText = $("#email").val();
					if(inputText.length == 0) {
						emailCheck = false;
						$('#email').attr("class", "form-control form-control-lg rounded-0");
					}
				} else if(result == '1') {
					emailCheck = false;
					$("#invalid2").html("이미 사용중인 이메일입니다.");
					$('#email').attr("class", "form-control form-control-lg rounded-0 is-invalid");
					inputText = $("#email").val();
					if(inputText.length == 0) {
						emailCheck = false;
						$('#email').attr("class", "form-control form-control-lg rounded-0");
					}
				}
			},
			error : function(error) {
				alert("통신 에러!");
			}
		}); // ajax 끝
		/////// ajax
	} else {
		emailCheck = false;
		$('#email').attr("class", "form-control form-control-lg rounded-0 is-invalid");
		$("#invalid2").html("유효하지 않은 이메일주소입니다.");
	} // else 끝
	if ($("#email").val().length == 0) {
		$('#email').attr("class", "form-control form-control-lg rounded-0");
	}
	
}) // 함수 끝







}); /* 도큐먼트 레디 괄호 */


////////////////////////////////
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

function checkId() { // 아이디체크
	var inputID = { 
			"userid" : $("#userid").val()
	};
	console.log(inputID);
	var JsonStr = JSON.stringify(inputID);
	var inputText = $("#userid").val();
	
	if(inputText.length >= 5) {
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
				useridCheck = true;
				$('#userid').attr("class", "form-control form-control-lg rounded-0 is-valid");
				inputText = $("#userid").val();
				if(inputText.length == 0) {
					useridCheck = false;
					$('#userid').attr("class", "form-control form-control-lg rounded-0");
				}
			}else if(result == '1') {
				console.log("이미 사용중인 아이디입니다.");
				useridCheck = false;
				$("#invalid").html("이미 사용중인 아이디입니다.");
				$('#userid').attr("class", "form-control form-control-lg rounded-0 is-invalid");
				inputText = $("#userid").val();
				if(inputText.length == 0) {
					useridCheck = false;
					$('#userid').attr("class", "form-control form-control-lg rounded-0");
				}
			}
		},
		error : function(error) {
			bootbox.alert("통신 에러!");
		}
	}); // ajax 끝
	} else if (inputText.length < 5){
		useridCheck = false;
		$('#userid').attr("class", "form-control form-control-lg rounded-0 is-invalid");
		$("#invalid").html("5글자 이상 입력해주세요.");
		inputText = $("#userid").val();
		if(inputText.length == 0) {
			$('#userid').attr("class", "form-control form-control-lg rounded-0");
		}
	} else if(inputText.length == 10) {
		// 10글자 채웠을때 계속 ajax전송 방지
	} // if문 끝 
} // 함수 끝




$('#username').on("blur", function() {   // 유저 닉네임칸 포커스를 잃으면 검사 
	var inputID = { 
			"username" : $("#username").val()
	};
	var JsonStr = JSON.stringify(inputID);
	var inputText = $("#username").val();
	if(inputText.length >= 2) {
	$.ajax({
		url : '/nameCheck',
		type : 'POST',
		data : JsonStr,
		dataType: 'text',
		beforeSend: function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		contentType : "application/json; charset=utf-8",
		success : function(result) {
			if(result == '0') { // 사용가능
				console.log("사용가능합니다.");
				usernameCheck = true;
				$('#username').attr("class", "form-control form-control-lg rounded-0 is-valid");
				inputText = $("#username").val();
				if(inputText.length == 0) {
					$('#username').attr("class", "form-control form-control-lg rounded-0");
					usernameCheck = false;
				}
			}else if(result == '1') { // 이미 사용중
				console.log("이미 사용중인 닉네임입니다.");
				usernameCheck = false;
				$("#invalid1").html("이미 사용중인 닉네임입니다.");
				$('#username').attr("class", "form-control form-control-lg rounded-0 is-invalid");
				inputText = $("#username").val();
				if(inputText.length == 0) {
					$('#username').attr("class", "form-control form-control-lg rounded-0");
				}
			}
		},
		error : function(error) {
			bootbox.alert("통신 에러!");
		}
	}); // ajax 끝
	} else if (inputText.length < 2){
		$('#username').attr("class", "form-control form-control-lg rounded-0 is-invalid");
		$("#invalid1").html("2글자 이상 입력해주세요.");
		usernameCheck = false;
		inputText = $("#username").val();
		if(inputText.length == 0) {
			$('#username').attr("class", "form-control form-control-lg rounded-0");
		}
	} 

}); // 함수 끝












</script>


<%@include file="./includes/footer.jsp" %>