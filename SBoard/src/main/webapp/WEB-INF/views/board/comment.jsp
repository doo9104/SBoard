<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<link href="/resources/css/commentStyles.css" rel="stylesheet" type="text/css">
<p/>

<form id="commentForm">
<div class="col-lg-12" style="border-style:solid;border-radius: 15px;border-color:#black;margin-top:30px;margin-bottom:30px;">
<p/>
<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">작성자</span>
  </div>
  <input type="text" class="form-control" id="cwriter" name="cwriter">
  <input type="hidden" name="cregdate">
</div>


<div class="input-group mb-3">
  <textarea class="form-control" rows="3" id="ccontent" name="ccontent"></textarea>
  <div class="input-group-append">
    <button data-oper='register' class="btn btn-outline-secondary" type="button" id="register">등록</button>
  </div>
</div>

</div>
<p/>
</form>

<!-- 댓글 리스트 -->
<div class="container" id="comment">
		 <div class="media comment-box" data-cno='11'>
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
        </div>  
</div>



<script type="text/javascript" src="/resources/js/comment.js"></script>


<script>
$(document).ready(function() {
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $("#comment");
		
	showList(1);
	
	function showList(page) {
		
		CommentService.getList({bno:bnoValue,page: page|| 1},function(list) {
			var str = "";
			if(list == null || list.length == 0){
				replyUL.html("");
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
		CommentService.add(comment, function(result) {
			$("#ccontent").val("");
			$("#cwriter").val("");
			showList(1);
			alert(result);
		});
	});
	
	
	
});
</script>







