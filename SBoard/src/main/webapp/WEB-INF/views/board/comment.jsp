<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>




<link href="/resources/css/commentStyles.css" rel="stylesheet" type="text/css">
<p/>

<form id="commentForm">
<div class="col-lg-12" style="border-style:solid;border-radius: 15px;border-color:#black;margin-top:30px;margin-bottom:30px;">
<p/>
<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1"><spring:message code="writer" /></span>
  </div>
  <input type="text" class="form-control" id="cwriter" name="cwriter">
  <input type="hidden" name="cregdate">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</div>


<div class="input-group mb-3">
  <textarea class="form-control" rows="3" id="ccontent" name="ccontent"></textarea>
  <div class="input-group-append">
  <sec:authorize access="isAuthenticated()">
    <button data-oper='register' class="btn btn-outline-secondary" type="button" id="register"><spring:message code="comment.button" /></button>
  </sec:authorize>
  </div>
</div>

</div>
<p/>
</form>

<!-- 댓글 리스트 -->
<div class="container" id="comment">
		 <!-- <div class="media comment-box" data-cno='11'>
            <div class="media-left">
                <a href="#">
                    <img class="img-responsive user-photo" src="/resources/img/avatar.png">
                </a>
            </div>
            <div class="media-body">
            	<small class="pull-right text-muted">2020-03-07 01:18</small>
                <h4 class="media-heading">김승환</h4>
                <p>첫번째 댓글</p>
              
            </div>
        </div>   -->
</div>
<button type="button" id="moreCmt" class="btn btn-primary btn-lg"><spring:message code="comment.more" /></button>
<!-- 댓글 페이징 -->
<div class="panel-footer">

</div>
<!-- 댓글 페이징 끝 -->


<script type="text/javascript" src="/resources/js/comment.js"></script>


<script>
$(document).ready(function() {
	

	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $("#comment");
	var scrollCount = 1;
	var str = "";
	var a = 1;
	
	var commentWriter = null;
	
	/* 시큐리티 값 변수에넣기 */
	<sec:authorize access="isAuthenticated()">
	commentWriter = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	console.log("commentWriter : " +commentWriter);
	
	//댓글 입력창에 유저 닉네임 넣기
	if(commentWriter != null) {
	document.getElementById('cwriter').value = commentWriter;
	} else {
		document.getElementById('cwriter').value = '없지롱';
	}
		
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue)
	});
	
	
	showList(1);
	console.log("scrollCount : " + scrollCount);
	
	function showList(page) {
		console.log("page : " + page);
		
		CommentService.getList({bno:bnoValue,page: page|| 1},
			function(commentCount, list) {
			console.log("commentCount : " + commentCount);
			console.log("list : " + list);
			console.log(list);
			
			/* a = 총 페이지수 */
			a = Math.ceil(commentCount/10);
			console.log("a : " + a);
			
			if(page == -1){
				replyUL.html("");
				str = "";
				for(i = 1; i <= a ; i++){
					console.log("i : " + i);
					showList(i);		
				}
				scrollCount = a;
				return;
			}
			
			
			
			/* var str = ""; */
			
			if(list == null || list.length == 0){
				/* replyUL.html(""); */
				return;
			}
			
			for(var i = 0, len = list.length || 0; i< len; i++) {
				str += "<div class='media comment-box' data-cno='"+list[i].cno+"'><div class='media-left'><a href='#'><img class='img-responsive user-photo' src='/resources/img/avatar.png'></a></div>";
				str += "<div class='media-body'><small class='pull-right text-muted'>"+CommentService.displayTime(list[i].cregdate)+"</small><h4 class='media-heading'>"+list[i].cwriter+"</h4>";
				str += "<p>"+list[i].ccontent+"</p></div></div>";
			}
			
			replyUL.html(str);
			
		});
	} /* showList 끝 */
	
	
	
	
	
	
	
	
	/* 댓글 등록 시작 */
	$("button[data-oper='register']").on("click", function(e) {
		/* e.preventDefault(); */
		var comment = {
				ccontent : $("#ccontent").val(),
				cwriter : $("#cwriter").val(),
				bno : bnoValue
		};
		
		
		/* if(scrollCount > 1){
			for(i = scrollCount; i <= a ; i++){
				console.log("i : " + i);
				showList(i);
			}
		} */
		
		
		  CommentService.add(comment, function(result) {
			$("#ccontent").val("");
			$("#cwriter").val("");
			alert("등록되었습니다.");
			showList(-1);
		});  
		
	});
	
	
	
	$("#comment").on("click", "#test", function(e) {
		var cno = $(this).data("cno");
		console.log(cno);
	});
	
	
	
	$('#moreCmt').click(function(){
		scrollCount++;
		console.log("더 보기 클릭 scrollCount : " + scrollCount);
		loadCmt();
	});
 
	
 
	function loadCmt() {
		CommentService.getList({bno:bnoValue,page: scrollCount},
			function(commentCount, list) {
				if(scrollCount > (Math.ceil(commentCount/10))){
					alert("마지막 댓글입니다.");
					scrollCount--;
					console.log("scrollCount가 줄어들었음 : " + scrollCount);
					return;
				} else {
					console.log("더보기함수 scrollCount : " + scrollCount)
				for(var i = 0, len = list.length || 0; i< len; i++) {
					str += "<div class='media comment-box' data-cno='"+list[i].cno+"'><div class='media-left'><a href='#'><img class='img-responsive user-photo' src='/resources/img/avatar.png'></a></div>";
					str += "<div class='media-body'><small class='pull-right text-muted'>"+CommentService.displayTime(list[i].cregdate)+"</small><h4 class='media-heading'>"+list[i].cwriter+"</h4>";
					str += "<p>"+list[i].ccontent+"</p></div></div>";
				}
				}
			replyUL.html(str);
		});
		
	}
 
		
});
</script>







