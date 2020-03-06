<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/resources/css/commentStyles.css" rel="stylesheet" type="text/css">

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
	}
	
	
});
</script>







