<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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
align-content: center;
text-align: center;
}

.uploadResult ul li img{
width:100px;
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
z-index: 100;
background:rgba(255,255,255,0.5);
}

.bigPicture {
position: relative;
display: flex;
justify-content: center;
align-items: center;
}

.bigPicture img {
width:600px;
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
 	<div class='bigPictureWrapper'>
 		<div class='bigPicture'>
 		</div>
 	</div>
 	
 	
 	
    <div class="form-group">
      <label for="bwriter"><spring:message code="writer" /></label>
      <%-- <input class="form-control" id="bwriter" name='bwriter' value='<sec:authentication property="principal.username"/>' readonly="readonly"></input> --%>
    </div>   
    <button type="submit" class="btn btn-primary"><spring:message code="write.button" /></button>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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

					
	// 원본 이미지 보여주기			
function showImage(fileCallPath) {
	
		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+encodeURI(fileCallPath)+"'>")
		.animate({width:'100%',height:'100%'}, 1000);
}

// 등록버튼
$(document).ready(function(e){

	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e) {
		
		e.preventDefault();
		var str = "";
		
		$(".uploadResult ul li").each(function(i, obj) {
			
			var jobj = $(obj);			
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
		});
		formObj.append(str).submit();
		
	});
	
	
	// 파일 리스트 보여주기
	var uploadResult = $(".uploadResult ul");
	
	function showUploadedFile(uploadResultArr) {
		var str = "";
		$(uploadResultArr).each(
				function(i, obj) {
				if(!obj.image) {
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
					
					var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					
					/* str += "<li><a href='/download?fileName="+fileCallPath+"'>"+"<img src='/resources/img/attach.png'>" + obj.fileName + "</a></li>"; */
					str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+"<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+"<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>"+"</div></li>"
				}else {
					var fileCallPath = encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
					var originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g),"/");
					
					str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
					"<img src='/display?fileName="+fileCallPath+"'></a>"+
					"<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>"+"</li>"
					/* str += "<li><img src='/display?fileName="+fileCallPath+"'></li>"; */
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
	
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	
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
		beforeSend: function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		data:formData,
		type : 'POST',
		dataType:'json',
		success: function(result){
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
				str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";
				str += " ><div>";
				str += "<span> "+obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' "
				str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
				}else{
					
				var fileCallPath = encodeURIComponent( obj.uploadPath+"/"+obj.uuid +"_"+obj.fileName);
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li ";
				str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>"
				str += "<span> "+obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'></a>";
				str += "</div>";
				str += "</li>";
				
				}
		});
		uploadUL.append(str);
	}
	
	// X 버튼 클릭시 이미지 삭제
	$(".uploadResult").on("click", "button", function(e) {
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type:type},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType:'text',
			type: 'POST',
				success: function(result) {
					targetLi.remove();
				}
		}); // $.ajax
		
	});
	

	// 원본이미지 보여주기 끄기
	$(".bigPictureWrapper").on("click", function(e) {
		$(".bigPicture").animate({width:'0%',height:'0%'}, 1000);
		setTimeout(function() {
			$('.bigPictureWrapper').hide();
		},1000);
	});
	

	
	
	})
</script>

<%@include file="../includes/footer.jsp" %>