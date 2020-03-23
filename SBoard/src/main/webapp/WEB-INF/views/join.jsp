<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="./includes/header.jsp" %>

<!-- <script src="/resources/js/login.js"></script> -->

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
                                    <input type="text" class="form-control form-control-lg rounded-0" name="userid" id="userid" required="">

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
                            </form>
                        </div>
                    </div>
                    <!-- /form card register end -->
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