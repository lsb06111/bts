/**
 * 
 */

let currentPage = 1;

// 페이지 만들어줘야함.. +-2
function updatePagination(res){
	const pagination = $("#commitPagination");
	// 숫자 초기화?
	pagination.find("li.page-num").remove();
	
	const totalPage = res.totalPage;
	const current = res.currentPage;  // 그냥.. currentPage해도 되지 않나..?
	const startPage = Math.max(1, current-2);
	const endPage = Math.min(totalPage, currentPage+2);
	console.log(startPage);
	console.log(endPage);
	// 번호 생성...
	for(let i=startPage; i<=endPage; i++){
		const activeClass = (i===currentPage) ? "active" : "";
		$("<li>", {class: `page-item page-num ${activeClass}`})
			.append($("<a>", {class: "page-link", href:"javascript:void(0);", text: i}))
			.insertBefore(pagination.find(".next"));
	}
	
	// <<, >> 보여주고 안보여주고 
	pagination.find(".prev a").off("click").on("click", function(){
		if(current > 1) loadCommit(1);
	});
	pagination.find(".next a").off("click").on("click", function(){
		if(current < totalPage) loadCommit(totalPage);
	});
}

// 커밋목록 보여줘야함... => 전에 했던거
function loadCommit(page){
	const repoId = $("#rquestTBdevRepoId").val();

	$.ajax({
		url:"/bts/deployRequest",
		method:"GET",
		data:{
			repoId: repoId,
			page: page	// 페이지 없으면 1?
		},
		dataType: "json",
		beforeSend: function(){
			$("#commit-list-group").empty();
			// 스피너 보여주기
			$(".demo-inline-spacing").show();
			$(".file-item").empty();
		},
		success: function(res){
			$("#commit-list-group").empty();
			
			for(var i=0; i<res.commitList.length; i++){
				$("#commit-list-group").append(`
					<a href="#" class="list-group-item list-group-item-action commit-item" data-sha="${res.commitList[i].sha}">
						<div class="fw-bold">${res.commitList[i].commitMessage}</div> 
						<small class="text-muted"> ${res.commitList[i].sha.substring(0,7)}· 
						${res.commitList[i].userName? res.commitList[i].userName : "알 수 없음"}
						(${res.commitList[i].authorName}) · 
						${res.commitList[i].authorDate}</small>
					</a>
				`);
			}
			currentPage= res.currentPage;
			updatePagination(res);
		},
		error: function(){
			alert("커밋목록을 불러오지 못했습니다....")
		},
		complete: function(){
			// 스피너 없애기
			$(".demo-inline-spacing").hide();
		}
	});
}

// 숫자 페이지 눌렸을 때
$(document).on("click", "#commitPagination .page-num a", function(){
	const page = parseInt($(this).text());
	loadCommit(page);
	
	
});
