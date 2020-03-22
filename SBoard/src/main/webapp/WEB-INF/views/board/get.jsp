<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/test.css">
<script src="/resources/js/ckeditor.js"></script>
<style>
.uploadResult {
width:100%;
background-color:gray;
}

.uploadResult ul {
display: flex;
flex-flow: row;
justify-content: center;
align-items: center;
}

.uploadResult ul li {
list-style: none;
padding: 10px;
align-content: center;
text-align: center;
}

.uploadResult ul li img {
width: 100px;
}

.uploadResult ul li span {
color:white;
}

.bigPictureWrapper {
position: absolute;
display: none;
justify-content: center;
align-items: center;
top:0%;
width:100%;
height:100%;
background-color:gray;
z-index:100;
background:rgba(255,255,255,0.5);
}

.bigPicture {
position:relative;
display:flex;
justify-content:center;
align-items:center;
}

.bigPicture img {
width:600px;
}
</style>

<p/>
<div class="col-lg-12" style="border-style:solid;border-radius: 15px;border-color:#E9ECEF;margin-top:30px;margin-bottom:30px;">
  <fieldset>
    <legend><spring:message code="read.text" /></legend>
    <div class="form-group">
      <label for="btitle"><spring:message code="title" /></label>
      <input class="form-control" id="btitle" name='btitle' disabled=""  value='<c:out value="${board.btitle}"/>'>
    </div>
    <div class="form-group">
      <label for="bcontent"><spring:message code="content" /></label>
      <textarea class="form-control" id="bcontent" name='bcontent' rows="10" disabled=""><c:out value="${board.bcontent}"/></textarea>
    </div>
    <div class="form-group">
      <label for="bwriter"><spring:message code="writer" /></label>
      <input class="form-control" id="bwriter" name='bwriter' disabled="" value='<c:out value="${board.bwriter}"/>'>
    </div>
    
  </fieldset><p/>	
	
	<!-- 첨부파일  -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">첨부파일</div>
				<div class="panel-body">
					<div class='uploadResult'>
						<ul>
						</ul>
					</div>
				</div> <!-- end panel-body -->
			</div> <!-- end panel -->
		</div> <!-- end col-lg-12 -->
	</div> <!-- end row -->


<sec:authentication property="principal" var="pinfo"/>
	<sec:authorize access="isAuthenticated()">
		<c:if test="${pinfo.username eq board.bwriter}">
			<button data-oper='modify' class="btn btn-outline-primary"><spring:message code="read.modify" /></button>
		</c:if>
	</sec:authorize>
    <button data-oper='list' class="btn btn-primary"><spring:message code="read.list" /></button>
    <p/>
    
    <!-- 추천 -->
   <!-- <i class="far fa-thumbs-up fa-3x"></i> -->
   <div class="fa-4x row justify-content-md-center">
   <span class="fa-layers fa-fw">
   	<i class="fas fa-circle" style="color:#F5F5F5"></i>
    <a class="rec" href="#"><i id="heart" class="far fa-heart faa-pulse animated-hover" data-fa-transform="shrink-6"></i></a>
    <span class="fa-layers-counter" id="recValue" style="background:Tomato"><c:out value="${board.brec}" /></span>
  </span>
  </div>
    <!-- 추천 -->
    <p/>
    
	
	<!-- 사진확대용 div -->
	<div class='bigPictureWrapper'>
	<div class='bigPicture'>
	</div>
	</div>
	
	
	<form id="operForm" action="/board/modify" method="get">
		<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno }"/>'>
		<input type='hidden' name='pageNum' value='<c:out value="${page.pageNum }"/>'>
		<input type='hidden' name='amount' value='<c:out value="${page.amount }"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${page.keyword }"/>'>
		<input type='hidden' name='searchType' value='<c:out value="${page.searchType }"/>'>
	</form>
</div>	
<!-- ------------------------------------------------------------------------------------------------- -->
<!-- Comment -->
<div class="col-lg-12" style="border-style:solid;border-radius: 15px;border-color:#E9ECEF;margin-top:30px;margin-bottom:30px;">
<%@include file="comment.jsp" %>
</div> <!-- comment end -->

<!-- ------------------------------------------------------------------------------------------------ -->
<script type="text/javascript" src="/resources/js/comment.js"></script>



<!-- 스크립트 시작  -->
<script type="text/javascript">
$(document).ready(function() {
	
	
	ClassicEditor
	.create( document.querySelector( '#bcontent' ), {	
	} )
	.then( editor => {
			editor.isReadOnly = true;
	        console.log( editor );
	} )
	.catch( error => {
	        console.error( error );
	} );
	
	// 시큐리티 csrf 토큰 헤더 설정
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e) {
		operForm.attr("action","/board/modify").submit();
	});
	
	$("button[data-oper='list']").on("click", function(e) {
		operForm.find("#bno").remove();
		operForm.attr("action","/board/list")
		operForm.submit();
	});
	
	
	(function() {
		var bno = '<c:out value="${board.bno}"/>';
		
	$.getJSON("/board/getAttachList", {bno: bno}, function(arr) {
		console.log(arr);
		
		var str = "";
		
		$(arr).each(function(i, attach){
			
			// if image type
			if(attach.fileType){
				var fileCallPath = encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid + "_"+attach.fileName);
				
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"
				+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
			}else {
				
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"
				+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
				str += "<span> "+ attach.fileName+"</span><br/>";
				str += "<img src='/resources/img/attach.png'>";
				str += "</div>";
				str += "</li>";
			
			}
		});
		$(".uploadResult ul").html(str);
		
	}); // end getJSON
		
	})();//end function
	
	
	// 첨부파일 클릭시 이벤트 처리
	$(".uploadResult").on("click","li", function(e) {
		
		console.log("view image");
		var liObj = $(this);
		
		var path = encodeURIComponent(liObj.data("path")+"/" +liObj.data("uuid")+"_" + liObj.data("filename"));
		
		if(liObj.data("type")) {
			showImage(path.replace(new RegExp(/\\/g),"/"));
		}else {
			// 이미지가 아니면 다운로드
			self.location = "/download?fileName="+path
		}
		
	});
	
	// 이미지 보여주기
	function showImage(fileCallPath){

		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"'>")
		.animate({width:'100%', height:'100%'},1000);
	}
	
	// 이미지창 닫기
	$(".bigPictureWrapper").on("click", function(e) {
		$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
		setTimeout(function() {
			$('.bigPictureWrapper').hide();
		}, 1000);
	});
	
	
	// 좋아요 여부 확인
	// 좋아요 여부 확인 변수
	var alreadyLike = "";
	var bno = '<c:out value="${board.bno}"/>';
	var userid = "";
	
	<sec:authorize access="isAnonymous()">	
		userid = "Anonymous";
	</sec:authorize>

	<sec:authorize access="isAuthenticated()">	
		userid = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	console.log("userid : " + userid);
	var likecheckData = {
		"recno" : bno,
		"bno" : bno,
		"userid" : userid
	};
	var likecheckJsonStr = JSON.stringify(likecheckData);
	$.ajax({
		url : '/board/likecheck',
		type : 'POST',
		data : likecheckJsonStr,
		dataType: 'text',
		contentType : "application/json; charset=utf-8",
		beforeSend: function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		success : function(result) {
			alreadyLike = result;
			if(result > 0) {
				$('#heart').removeClass('far fa-heart faa-pulse animated-hover').addClass('fas fa-heart faa-pulse animated-hover');
			}
			
		},
		error : function(error) {
			alert("통신 에러!");
		}
		
	});
	
	
		
	
	
	
	//추천
	$(".rec").on("click", function(e) {
		e.preventDefault();
		if(userid == "Anonymous") {
			 if (confirm("로그인한 사용자만 가능합니다.\n로그인하시겠습니까?") == true){    //확인
				 window.location.href="/customLogin";
			 }else{   //취소
			     return false;
			 }
		} else {
		var cnt = parseInt('<c:out value="${board.brec}" />');
		var data = {
			"recno" : bno,
			"bno" : bno,
			"userid" : userid
		};
		var jsonStr = JSON.stringify(data);
		// ,,,,,,,,,,,,,,,,,,,,,,,
		$.ajax({
			url : '/board/like',
			type : 'POST',
			data : jsonStr,
			contentType : "application/json; charset=utf-8",
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function(result) {
				if(result == 'already'){
					if(alreadyLike == 1){ // 이미 추천했었던 게시물일때
						cnt -= 1;
						$('#heart').removeClass('fas fa-heart faa-pulse animated-hover').addClass('far fa-heart faa-pulse animated-hover');
						$('#recValue').html(cnt);
					} else{ // 페이지 내에서 추천후 취소할 때
					$('#heart').removeClass('fas fa-heart faa-pulse animated-hover').addClass('far fa-heart faa-pulse animated-hover');
					$('#recValue').html(cnt);
					}
				}
				else if(result == 'success'){
					cnt += 1;
					$('#heart').removeClass('far fa-heart faa-pulse animated-hover').addClass('fas fa-heart faa-pulse animated-hover');
					$('#recValue').html(cnt);
				}
				
				},
			error : function(error) {
				alert("error : " + error);
			}
			
		
			
			
		}) // ajax 끝
		} // else 끝
		// ,,,,,,,,,,,,,,,,,,,,,,,

	}); // 함수 끝
	

});
</script>








<%@include file="../includes/footer.jsp" %>