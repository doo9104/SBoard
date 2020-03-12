<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<script src="/resources/js/ckeditor.js"></script>


<p/>
<form role="form" action="/board/register" method="post">
  <fieldset>
    <legend>글 작성</legend>
    <div class="form-group">
      <label for="btitle">제목</label>
      <input class="form-control" id="btitle" name='btitle'/>
    </div>
    <div class="form-group">
      <label for="bcontent">내용</label>
      <textarea class="form-control" id="bcontent" name='bcontent' rows="10"></textarea>
    </div>
    <div class="form-group uploadDiv">
      <label for="exampleInputFile">첨부파일 등록</label>
      <input type="file" class="form-control-file" name='uploadFile' id="exampleInputFile" multiple aria-describedby="fileHelp"></input>
      <small id="fileHelp" class="form-text text-muted">첨부할 파일을 선택해주세요.</small>
    </div>
    <!-- 첨부된 파일의 결과를 처리하는 DIV-->
    <div class='uploadResult'>
    <ul>
    </ul>
    </div>
    <!-- 첨부된 파일의 결과를 처리하는 DIV-->
 
    <div class="form-group">
      <label for="bwriter">작성자</label>
      <input class="form-control" id="bwriter" name='bwriter'></input>
    </div>   
    <button type="submit" class="btn btn-primary">글작성</button>
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
	
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; // 5MB
	
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("5MB 이상 파일은 업로드 할 수 없습니다.");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 확장자의 파일은 업로드 할 수 없습니다.\n[업로드 불가능한 확장자 : exe,sh,zip,alz]");
			return false;
		}
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
		contentType : false,data:
			formData,type : 'POST',
			dataType:'json',
			success: function(result){
				console.log(result);
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
				str += "<img src='/resources/img/attach.png'></a>";
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