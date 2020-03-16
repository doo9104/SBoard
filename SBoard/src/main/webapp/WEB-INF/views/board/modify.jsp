<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%@include file="../includes/header.jsp" %>
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
<form role="form" action="/board/modify" method="post">
		<input type='hidden' name='pageNum' value='<c:out value="${page.pageNum }"/>'>
		<input type='hidden' name='amount' value='<c:out value="${page.amount}"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${page.keyword }"/>'>
		<input type='hidden' name='searchType' value='<c:out value="${page.searchType }"/>'>

  <fieldset>
    <legend><spring:message code="modify.text" /></legend>
    
    <div class="form-group">
      <label for="btitle"><spring:message code="title" /></label>
      <input class="form-control" id="btitle" name='btitle'  value='<c:out value="${board.btitle}"/>'>
    </div>
    <div class="form-group">
      <label for="bcontent"><spring:message code="content" /></label>
      <textarea class="form-control" id="bcontent" name='bcontent' rows="10"><c:out value="${board.bcontent}"/></textarea>
    </div>
    <div class="form-group">
      <label for="bwriter"><spring:message code="writer" /></label>
      <input class="form-control" id="bwriter" name='bwriter' readonly=""  value='<c:out value="${board.bwriter}"/>'>
    </div>
    <!-- 수집용 -->
    <div class="form-group" style="display:none;">
      <input type="hidden" class="form-control" id="bregdate" name='bregdate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.bregdate}"/>'>
    </div>
    <div class="form-group" style="display:none;">
      <input type="hidden" class="form-control" id="bupdateregdate" name='bupdateregdate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.bupdateregdate}"/>'>
    </div>
     <div class="form-group" style="display:none;">
      <input class="form-control" id="bno" name='bno'  value='<c:out value="${board.bno}"/>'>
    </div>
    
     <div class="form-group uploadDiv">
      <label for="exampleInputFile"><spring:message code="write.file1" /></label>
      <input type="file" class="form-control-file" name='uploadFile' id="exampleInputFile" multiple aria-describedby="fileHelp"></input>
      <small id="fileHelp" class="form-text text-muted"><spring:message code="write.file3" /></small>
    </div>
    <!-- 첨부파일 -->
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
    
    
    <button data-oper='modify' type="submit" class="btn btn-outline-primary"><spring:message code="modify.modifybutton" /></button>
    <button data-oper='remove' type="submit" class="btn btn-danger"><spring:message code="modify.removebutton" /></button>
    <button data-oper='list' type="submit" class="btn btn-primary"><spring:message code="modify.listbutton" /></button>
    
  </fieldset>
</form>





<!-- 사진확대용 div -->
<div class='bigPictureWrapper'>
<div class='bigPicture'>
</div>
</div>





	<p/>


<!-- 스크립트 시작  -->
<script type="text/javascript">
$(document).ready(function() {
	
	(function() {
		var bno = '<c:out value="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList", {bno:bno}, function(arr) {
			console.log(arr);
			var str = "";
			
			$(arr).each(function(i, attach) {
				// 이미지타입일때
				if(attach.fileType){
					var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
					str += "<li style='cursor:pointer' data-path='"+attach.uploadPath+"'";
					str += " data-uuid='"+attach.uuid+"' data-fileName='"+attach.fileName+"'data-type='"+attach.fileType+"'>";
					str += "<span> " + attach.fileName + " </span>";
					str += " <button type='button' data-file='"+fileCallPath+"' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button>"
					str += " <div>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str += "</li>";
				}else {
					var fileCallPath = encodeURIComponent( attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li style='cursor:pointer' data-path='"+attach.uploadPath+"'";
					str += " data-uuid='"+attach.uuid+"' data-fileName='"+attach.fileName+"'data-type='"+attach.fileType+"'>";
					str += "<span> " + attach.fileName + " </span>";
					str += " <button type='button' data-file='"+fileCallPath+"' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button>"
					str += " <div>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str += "</li>";
				}
			});
			$(".uploadResult ul").html(str);
		}); // end getJSON
		
	})(); // end function
	
	
	
	
	
	
	
	var formObj = $("form");
	
	$('button').on("click", function(e) {
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		if(operation === 'remove') {
			formObj.attr("action", "/board/remove");
		}else if(operation === 'list') {
			formObj.attr("action","/board/list").attr("method","get");
			
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var searchTypeTag = $("input[name='searchType']").clone();
			
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(searchTypeTag);
			}else if(operation === 'modify'){
				
				var str = "";
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
				});
				formObj.append(str).submit();
			}
		formObj.submit();
	});
	

	ClassicEditor
	.create( document.querySelector( '#bcontent' ), {	
		
		toolbar: [ 'heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'TodoList', '|', 'code', 'codeBlock', '|', 'fontFamily', 'fontColor', 'fontSize', 'fontBackgroundColor', 'underline', 'highlight', '|', 'blockQuote', 'insertTable', 'mediaEmbed', 'undo', 'redo' ], 
		
		heading: { options: [ 
			{ model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
			{ model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' }, 
			{ model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
			{ model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' }
		] }

		
		
	} )
	.then( editor => {
	        console.log( editor );
	} )
	.catch( error => {
	        console.error( error );
	} );
	
	
	

	
	// 이미지 삭제버튼 클릭
	$(".uploadResult").on("click", "button", function(e) {
		console.log("delete file");
	
	if(confirm("이 파일을 제거하겠습니까? ")){
		var targetLi = $(this).closest("li");
		targetLi.remove();
	}
	});
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; // 5MB
	
	// 파일 확장자나 크기 제한 검사
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("5MB 이상 파일은 업로드 할 수 없습니다.");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 확장자의 파일은 업로드 할 수 없습니다.\n[업로드 불가능한 확장자 : exe,sh,zip,alz]");
			return false;
		}
		return true;
	}
	
	
	
	
	$("input[type='file']").change(function(e){
		
		var formData = new FormData(); // 폼 태그에 대응
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		for(var i = 0; i < files.length; i++){
			if(!checkExtension(files[i].name, files[i].size) ){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
	
	$.ajax({
		url : '/uploadAjaxAction',
		processData : false,
		contentType : false,
		data:formData,
		type : 'POST',
		dataType:'json',
		success: function(result){
			console.log(result);
			/* showUploadedFile(result) */
			showUploadResult(result);
			
		}
	}); // $.ajax
	});
	
	function showUploadResult(uploadResultArr) {
		if(!uploadResultArr || uploadResultArr.length == 0) { return; }
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			if(obj.image){
				
				var fileCallPath = encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"'";
		        str += " data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'data-type='"+obj.image+"'";
		        str += " ><div>";
		        str += "<span> " + obj.fileName + " </span>";
		        str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
		        str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
		        str += "<img src='/display?fileName=" + fileCallPath + "'>";
		        str += "</div>";
		        str += "</li>";
				}else{
					
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
			    var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
			    str += "<li data-path='"+obj.uploadPath+"'";
			    str += " data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'data-type='"+obj.image+"'";
			    str += " ><div>";
			    str += "<span> " + obj.fileName + " </span>";
			    str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
			    str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			    str += "<img src='/resources/img/attachment.png'></a>";
			    str += "</div>";
			    str += "</li>";
				}
		});
		uploadUL.append(str);
	}
	
	
	
	
});





</script>







<%@include file="../includes/footer.jsp" %>