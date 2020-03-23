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
					    <!-- form card forgot -->
                    <div class="card rounded-0" id="forgot-form">
                        <div class="card-header">
                            <h3 class="mb-0">Reset Password</h3>
                        </div>
                        <div class="card-body">
                            <form class="forgotform" role="form" autocomplete="off" id="formLogin" novalidate="" method="POST">
                                <div class="form-group">
                                    <label>E-mail</label>
                                    <input type="email" class="form-control form-control-lg rounded-0" id="pwd1" required="" autocomplete="new-password">
               
                                </div>
								<div>
								<label class="custom-control custom-checkbox">
                                     <a href="javascript:void('register-form-link');" class="register-form-link">Register</a>
                                    </label>
									<label class="custom-control custom-checkbox">
                                     <a href="javascript:void('login-form-link');" class="login-form-link">Login</a>
                                    </label>
								</div>
                                <button type="submit" class="btn btn-success btn-lg float-right" id="btnReset">Reset Password</button>
                            </form>
                        </div>
                    </div>
                    <!-- /form card forgot end -->
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