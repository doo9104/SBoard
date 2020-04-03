<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="./includes/header.jsp" %>
<sec:authentication property="principal" var="pinfo"/>

<script src="/resources/js/textchange.js"></script>
<script type="text/javascript" src="/resources/js/jquery.oLoader.min.js"></script>
	
<div id="pwCheckForm" class="row">
	<div class="col-sm justify-content-center">
		<h2><c:out value="${userinfo.username}"/>님, 보안을 위해 비밀번호를 한번더 입력해주세요.</h2>
		<input type="password" class="form-control form-control-sm rounded-0"  name="password" id="password" required="">
		<button type="button" id="pwdCheck" class="btn btn-outline-primary">확인</button>
	</div>
</div>

<!-- style="display:none;" -->
<div id="myPageForm" class="container" style="display:none;">
<div class="form-group row justify-content-md-center">
<h2>계정 정보 수정 </h2>
</div>
<div class="form-group row justify-content-md-center">
	<label for="userid" class="col-sm-2 col-form-label">아이디</label>
    <div class="col-sm-10">
      <input type="text" readonly class="form-control form-control rounded-0" id="userid" value="<c:out value="${userinfo.userid}"/>">
    </div>
    
    <label for="username" class="col-sm-2 col-form-label">닉네임</label>
    <div class="col-sm-10">
      <input type="text" class="form-control form-control rounded-0" name="username" id="username" value="<c:out value="${userinfo.username}"/>">
      <div class="valid-feedback">사용 가능한 닉네임입니다!</div>
      <div id="invalid1" class="invalid-feedback">이미 사용중인 닉네임입니다.</div>
    </div>
    
     <label for="userpw" class="col-sm-2 col-form-label">비밀번호</label>
    <div class="col-sm-10">
      <input type="password" class="form-control form-control rounded-0" name="userpw" id="userpw" >
    </div>
    
     <label for="passwordConfirm" class="col-sm-2 col-form-label">비밀번호 확인</label>
    <div class="col-sm-10">
      <input type="password" class="form-control form-control rounded-0" name="passwordConfirm" id="passwordConfirm" >
    </div>
    
     <label for="email" class="col-sm-2 col-form-label">이메일</label>
    <div class="col-sm-10">
      <input type="email" class="form-control form-control rounded-0" id="email" value="<c:out value="${userinfo.email}"/>">
      <div class="valid-feedback">사용 가능한 이메일입니다!</div>
      <div id="invalid2" class="invalid-feedback">이미 사용중인 이메일입니다.</div>
    </div>
</div>


<div class="form-group row justify-content-md-center">
	<button data-oper='modify' type="button" class="btn btn-primary">수정</button>
	<button data-oper='drop' type="button" class="btn btn-danger">회원탈퇴</button>
</div>



<form id="logoutForm" action="/customLogout" method='post'>
	<input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>


</div> <!-- 컨테이너 div 끝 -->


<script type="text/javascript">
$(document).ready(function() {
	
/* 시큐리티 csrf 토큰 헤더 설정 */
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

var oldUsername = $("#username").val();
var oldEmail = $("#email").val();


usernameCheck = true;
passwordCheck = false;
emailCheck = true;


var emailC = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;


$("#pwdCheck").on("click", function(e) { 
	var input = { 
			"userid" : "<c:out value="${pinfo.username}"/>",
			"userpw" : $("#password").val()
	}, JsonStr = JSON.stringify(input);

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
			if(result == 1) {
				$("#myPageForm").show(500);
			} else { bootbox.alert("비밀번호가 맞지 않습니다."); }
		},
		error : function(error) {
			alert("통신 에러!");
		}
	}); // ajax 끝
});//함수끝


$("button[data-oper='drop']").on("click", function(e) {
	bootbox.confirm({
	    title: "회원 탈퇴", message: "정말 탈퇴하시겠습니까? 한번 탈퇴하면 복구할 수 없습니다!",
	    buttons: {
	        cancel: { label: '<i class="fa fa-times"></i> 취소' },
	        confirm: { className: 'btn-danger', label: '<i class="fa fa-check"></i> 탈퇴' }
	    },
	    callback: function (result) {
	    	dropUser();
	        console.log('This was logged in the callback: ' + result);
	    }
	});
});

$("button[data-oper='modify']").on("click", function(e) {
	if($("#userid").val() == ""){ bootbox.alert("아이디를 입력하세요."); $("#userid").focus(); return false; }
	if($("#username").val() == ""){ bootbox.alert("닉네임을 입력하세요."); $("#username").focus(); return false; }
	if($("#userpw").val() != $("#passwordConfirm").val()){ bootbox.alert("비밀번호가 다릅니다."); $("#userpw").val(""); $("#passwordConfirm").val(""); $("#userpw").focus(); return false; }
	if($("#email").val() == ""){ bootbox.alert("이메일을 입력해주세요"); $("#email").focus(); return false; }
	
	if(usernameCheck == true && passwordCheck == true && emailCheck == true) {
	updateUserinfo();
	} else { bootbox.alert("입력 정보를 확인하세요."); }
});



$('#email').on("blur", function() {
	
if(oldEmail == $("#email").val()) {
	$('#email').attr("class", "form-control form-control rounded-0");
	emailCheck = true;
	return;
} else {	
	if (emailC.test($('#email').val())) {
		$('#email').attr("class", "form-control form-control rounded-0 is-valid");
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
					$('#email').attr("class", "form-control form-control rounded-0 is-valid");
					inputText = $("#email").val();
					if(inputText.length == 0) {
						emailCheck = false;
						$('#email').attr("class", "form-control form-control rounded-0");
					}
				} else if(result == '1') {
					emailCheck = false;
					$("#invalid2").html("이미 사용중인 이메일입니다.");
					$('#email').attr("class", "form-control form-control rounded-0 is-invalid");
					inputText = $("#email").val();
					if(inputText.length == 0) {
						emailCheck = false;
						$('#email').attr("class", "form-control form-control rounded-0");
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
		$('#email').attr("class", "form-control form-control rounded-0 is-invalid");
		$("#invalid2").html("유효하지 않은 이메일주소입니다.");
	} // else 끝
	if ($("#email").val().length == 0) {
		$('#email').attr("class", "form-control form-control rounded-0");
	}
} // 처음 이메일비교 else 끝	
}) // 함수 끝


$("#userpw,#passwordConfirm").on("textchange", function() {
	var pwd1 = $("#userpw").val(),
		pwd2 = $("#passwordConfirm").val();
	if(pwd1 != "" || pwd2 != ""){
	if(pwd1 == pwd2) {
		// 비밀번호 = 비밀번호 확인 일치할때
		$('#userpw,#passwordConfirm').attr("class", "form-control form-control rounded-0 is-valid");
		passwordCheck = true;
	} else {
		// 비밀번호 != 비밀번호 확인 불일치할때
		$('#userpw,#passwordConfirm').attr("class", "form-control form-control rounded-0 is-invalid");
		passwordCheck = false;
		}
	} 
	if(pwd1.length == 0 || pwd2.length == 0) { // 하나가 빈칸이면 검증 해제
		$('#userpw,#passwordConfirm').attr("class", "form-control form-control rounded-0");
		passwordCheck = false;
	}
});



$('#username').on("blur", function() {   // 유저 닉네임칸 포커스를 잃으면 검사 
if(oldUsername == $("#username").val()) {
	usernameCheck = true;
	$('#username').attr("class", "form-control form-control rounded-0");
	return;
} else {
	
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
				$('#username').attr("class", "form-control form-control rounded-0 is-valid");
				inputText = $("#username").val();
				if(inputText.length == 0) {
					$('#username').attr("class", "form-control form-control rounded-0");
					usernameCheck = false;
				}
			}else if(result == '1') { // 이미 사용중
				usernameCheck = false;
				$("#invalid1").html("이미 사용중인 닉네임입니다.");
				$('#username').attr("class", "form-control form-control rounded-0 is-invalid");
				inputText = $("#username").val();
				if(inputText.length == 0) {
					$('#username').attr("class", "form-control form-control rounded-0");
				}
			}
		},
		error : function(error) {
			bootbox.alert("통신 에러!");
		}
	}); // ajax 끝
	} else if (inputText.length < 2){
		$('#username').attr("class", "form-control form-control rounded-0 is-invalid");
		$("#invalid1").html("2글자 이상 입력해주세요.");
		usernameCheck = false;
		inputText = $("#username").val();
		if(inputText.length == 0) {
			$('#username').attr("class", "form-control form-control rounded-0");
		}
	} 
}
}); // 함수 끝


















/////////////////////////////////////////////////////////////////////
//                              함수                                                                       //
/////////////////////////////////////////////////////////////////////

function updateUserinfo() {
	var input = { 
			"userid" : "<c:out value="${pinfo.username}"/>",
			"username" : $("#username").val(),
			"userpw" : $("#userpw").val(),
			"email" : $("#email").val()
	};
	var JsonStr = JSON.stringify(input);

	$.ajax({
		url : '/updateUserInfo',
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
}

function dropUser() { // 회원탈퇴
	var input = { 
			"userid" : "<c:out value="${pinfo.username}"/>",
			"email" : $("#email").val()
	};
	var JsonStr = JSON.stringify(input);

	$.ajax({
		url : '/dropUser',
		type : 'POST',
		data : JsonStr,
		dataType: 'text',
		beforeSend: function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		contentType : "application/json; charset=utf-8",
		success : function(result) {
			bootbox.alert({
			    message: "탈퇴되었습니다.",
			    size: 'small',
			    callback: function () {
			    	var logoutForm = $("#logoutForm");
					logoutForm.submit();
			    }
			});
		},
		error : function(error) {
			alert("통신 에러!");
		}
	}); // ajax 끝
}













});//도큐먼트 끝
</script>




<%@include file="./includes/footer.jsp" %>