var alreadyClick = false;



	$(".rec").on("click", function(e) {
		e.preventDefault();
		if(!alreadyClick) {
		var cnt = '<c:out value="${board.brec}" />';
		
		console.log("cnt : " + cnt);
		cnt = parseInt(cnt)+1;
		console.log("cnt : " + cnt);
		alert("추천하였습니다.");
		alreadyClick = true;
		}else {
			alert("이미 추천하였습니다.");
			return;
		}
		
	});
	