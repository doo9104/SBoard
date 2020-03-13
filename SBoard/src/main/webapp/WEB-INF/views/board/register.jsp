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
display:flex;
flex-flow: row;
justify-content:center;
align-items:center;
}

.uploadResult ul li {
list-style:none;
padding:10px;
}

.uploadResult ul li img{
width:200px;
}


</style>

<p/>
<form role="form" action="/board/register" method="post">
  <fieldset>
    <legend><spring:message code="write.text" /></legend>
    <div class="form-group">
      <label for="btitle"><spring:message code="title" /></label>
      <input class="form-control" id="btitle" name='btitle'/>
    </div>
    <div class="form-group">
      <label for="bcontent"><spring:message code="content" /></label>
      <textarea class="form-control" id="bcontent" name='bcontent' rows="10"></textarea>
    </div>
    <div class="form-group uploadDiv">
      <label for="exampleInputFile"><spring:message code="write.file1" /></label>
      <input type="file" class="form-control-file" name='uploadFile' id="exampleInputFile" multiple aria-describedby="fileHelp"></input>
      <small id="fileHelp" class="form-text text-muted"><spring:message code="write.file3" /></small>
    </div>
    <!-- 첨부된 파일의 결과를 처리하는 DIV-->
    <div class='uploadResult'>
    <ul>
    </ul>
    </div>
    <!-- 첨부된 파일의 결과를 처리하는 DIV-->
 
    <div class="form-group">
      <label for="bwriter"><spring:message code="writer" /></label>
      <input class="form-control" id="bwriter" name='bwriter'></input>
    </div>   
    <button type="submit" class="btn btn-primary"><spring:message code="write.button" /></button>
  </fieldset>
</form>










<script type="text/javascript">
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
					
					
$(document).ready(function(e){

	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e) {
		
		e.preventDefault();
		console.log("submit clicked");
		
	});
	
	
	// 파일 리스트 보여주기
	var uploadResult = $(".uploadResult ul");
	
	function showUploadedFile(uploadResultArr) {
		var str = "";
		$(uploadResultArr).each(
				function(i, obj) {
				if(!obj.image) {
					str += "<li><img src='/resources/img/attach.png'>" + obj.fileName + "</li>";
				}else {
					//str += "<li>" + obj.fileName + "</li>";
					var fileCallPath = encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
					console.log("obj.uploadPath : " + obj.uploadPath);
					str += "<li><img src='/display?fileName="+fileCallPath+"'></li>";
				}
		});
		uploadResult.append(str);
	}
	
	
	
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
		
		var formData = new FormData();
		
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
			showUploadedFile(result)
			/* showUploadResult(result); */
			
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
				str += "<li><div>";
				str += "<span> "+obj.fileName+"</span>";
				str += "<button type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
				}else{
					
				var fileCallPath = encodeURIComponent( obj.uploadPath+"/"+obj.uuid +"_"+obj.fileName);
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li><div>";
				str += "<span> "+obj.fileName+"</span>";
				str += "<button type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<a><img src='/resources/img/attach.png'></a>";
				str += "</div>";
				str += "</li>";
				
				}
		});
		uploadUL.append(str);
	}
	
	$(".uploadResult").on("click", "button", function(e) {
		console.log("delete file");
	});
	

	})
</script>

<%@include file="../includes/footer.jsp" %>