<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="./includes/header.jsp" %>

<script src="/resources/js/login.js"></script>

 <div class="row">
        <div class="col-md-12">
		<div class="col-md-12 text-center mb-5">
			</div>
            <div class="row">
                <div class="col-md-6 mx-auto">
                    <!-- form card login -->
                    <div class="card rounded-0" id="login-form">
                        <div class="card-header">
                            <h3 class="mb-0">Login</h3>
                            <h2><c:out value="${error}" /></h2>
                            <h2><c:out value="${logout}" /></h2>
                        </div>
                        <div class="card-body">
                            <form class="loginForm" role="form" autocomplete="off" id="formLogin" novalidate="" method='POST' action="/login">
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control form-control-lg rounded-0"  name="username" id="username" required="">
     
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control form-control-lg rounded-0" name="password" id="password" required="">
                                </div>
                                <div class="checkbox">
                                <label><input name="remember-me" type="checkbox">Remember Me</label>
                                </div>
                                <hr/>
                                <div>
                                    <label class="custom-control custom-checkbox">
                                     <a href="/join" class="register-form-link">Register</a>
                                    </label>
									<label class="custom-control custom-checkbox">
                                     <a href="/findpassword" class="forgot-form-link">Forgot Password</a>
                                    </label>
                                </div>
                                <button type="submit" class="btn btn-success btn-lg float-right" id="btnLogin">Login</button>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            </form>
                        </div>
                    </div>
                    <!-- /form card login end-->
					
					
                </div>
            </div>
        </div>
    </div>




<script>
$("#btnLogin").on("click", function(e) {
	e.preventDefault();
	$(".loginForm").submit();
});

</script>


<%@include file="./includes/footer.jsp" %>