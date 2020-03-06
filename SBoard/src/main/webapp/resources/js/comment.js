console.log("Comment Module");
var CommentService = (function() {

	function add(ccontent, callback, error) {
		console.log("add comment...");
	
	$.ajax({
		type : 'post',
		url : '/comments/new',
		data : JSON.stringify(ccontent),
		contentType : "application/json; charset=utf-8",
		success : function(result, status, xhr) {
			if (callback) {
				callback(result);
			}
		},
		error : function(xhr, status, er) {
			if (error) {
				error(er);
			}
		}	
	});
	}
	
	
	function getList(param, callback, error) {
	
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/comments/pages/" + bno + "/" + page + ".json",
				function(data) {
					if (callback) {
						callback(data);
					}
		}).fail(function(xhr, status, err) {
		if (error) {
			error();
			}
		});
	}
	
	
	function remove(cno, callback, error) {
		
		$.ajax({
			type : 'delete',
			url : '/comments/' + cno,
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}	
		});
		}
	
	
	
	
	return {
		add : add,
		getList : getList,
		remove : remove
	};
})();

