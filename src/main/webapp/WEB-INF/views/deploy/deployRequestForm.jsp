<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<!-- 헤드부분 고정 -->
<style>
.modal-almost-fullscreen {
	width: calc(100% - 60px); /* 좌우 30px 여백 */
	max-width: none;
	height: calc(100% - 60px); /* 상하 30px 여백 */
	margin: 30px auto;
}

.modal-almost-fullscreen .modal-content {
	height: 100%;
}

.modal-almost-fullscreen .modal-body {
	overflow-y: auto;
}
</style>


<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">



</head>

<body>
	<%@ include file="/WEB-INF/views/jspf/header.jspf"%>
	<!-- 헤더 네비부분 고정 -->



	<div class="content-wrapper">
		<div class="container-xxl felx-grow-1 container-p-y">
			<div class="row">
				<div class="col-md-12">

					<div class="d-flex justify-content-between align-item-center mt-4">
						<h3 class="mb-0">배포신청</h3>
						<div>
							<button id="prevBtn" type="button" class="btn btn-primary" style="display: none;" onclick="prevDeployForm()">이전</button>
							<button id="nextBtn" type="button" class="btn btn-primary" onclick="nextDeployForm()">다음</button>
						</div>
					</div>
					<hr>

					<form id="deployRequestForm" method="post" name="deployRequestForm"
						action="/bts/deployForm/sumbmitDeployRequestForm">

						<div id="prevDeployForm" style="display: block;">
							<div class="card mb-4">
								<div class="card-body">
									<div>
										<h5 class="mb-2">프로젝트명</h5>
										<select id="rquestTBdevRepoId" name="devRepoId"
											class="form-select form-select-lg">
											<c:forEach var="devrepoList" items="${devRepoByUserIdList}">
												<option value="${devrepoList.id }">${devrepoList.projectName }</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>

							<div class="card mb-4">
								<div>
									<div class="card-body">
										<div class="mb-4">
											<h5 class="mb-2">보고서 제목</h5>
											<input type="text" id="rquestTBtitle" name="title"
												class="form-control">
										</div>
										<div class="mb-3">
											<h5 class="mb-2">보고서 내용</h5>
											<textarea class="form-control" id="rquestTBcontent" name="content"
												rows="14"></textarea>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 프로젝트명, 제목, 내용 -->

						<div id="nextDeployForm" style="display: none;">
							<div class="card mb-4">
								<div class="card-body">
									<div class="row">
										<!-- 커밋목록 -->
										<div class="col-md-6">
											<h5 class="mb-3">커밋목록</h5>
											<div id="commit-list-group" class="list-group"
												style="max-height: 300px; overflow-y: auto;">
												<c:forEach var="commitList" items="${commitList}">
													<a href="#"
														class="list-group-item list-group-item-action commit-item"
														data-sha="${commitList.sha}">
														<div class="fw-bold">${commitList.commitMessage}</div>
														<small class="text-muted">${fn:substring(commitList.sha, 0, 7)} ·
															<c:choose>
																<c:when test="${!empty commitList.userName}">${commitList.userName}</c:when>
																<c:otherwise>알 수 없음</c:otherwise>
															</c:choose> (${commitList.authorName}) · ${commitList.authorDate}
														</small>
													</a>
												</c:forEach>
											</div>
										</div>

										<!-- 파일 목록 -->
										<div class="col-md-6">
											<h5 class="mb-3">파일목록</h5>
											<div class="list-group file-item"
												style="max-height: 300px; overflow-y: auto;"></div>
										</div>

									</div>
								</div>
							</div>


							<div class="card mb-4">
								<div class="card-body">
									<h5 class="mb-3">선택된 배포 항목</h5>
									<div class="table-responsive">
										<table class="table table-bordered align-middle">
											<thead>
												<tr>
													<th style="display: none;">파일 해시</th>
													<th>커밋 해시</th>
													<th>파일명</th>
													<th>동작</th>
												</tr>
											</thead>
											<tbody>

											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- 커밋/배포할 파일 선택 -->

					</form>


				</div>
			</div>
		</div>
	</div>



	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->


	<%@ include
		file="/WEB-INF/views/deploy/deployRequestCompareModal2.jspf"%>
	
	<script>
		function prevDeployForm(){
			$("#prevDeployForm").show();
			$("#nextDeployForm").css("display", "none"); // .show();
			
			$("#prevBtn").hide(); // display:none;
			$("#nextBtn").text("다음");
			$("#nextBtn").attr("onclick", "nextDeployForm()");
		}	

		function nextDeployForm(){
			$("#prevDeployForm").hide();
			$("#nextDeployForm").css("display", "block"); // .show();
			
			$("#prevBtn").show(); // display:none;
			$("#nextBtn").text("제출");
			$("#nextBtn").attr("onclick", "submmitDeployForm()");
			
			$("#commit-list-group").empty();
			// 레포지토리커밋목록 가져오기 
			$.ajax({
				url:"/bts/deployRequest",
				method: "GET",
				data: {
					ownerName: "rwanda95do",
					repoName: "vote-and-voice",
					token: "",
				},
				dataType: "json", 
				success: function(commitList){
					console.log(commitList);
					
					for(var i=0; i < commitList.length; i++ ){
						console.log(commitList[i].sha);
						
						$("#commit-list-group").append(`
								<a href="#" class="list-group-item list-group-item-action commit-item" data-sha="\${commitList[i].sha}">
									<div class="fw-bold">\${commitList[i].commitMessage}</div> 
									<small class="text-muted"> \${commitList[i].sha.substring(0,7)}· 
									\${commitList[i].userName? commitList[i].userName : "알 수 없음"}
									(\${commitList[i].authorName}) · 
									\${commitList[i].authorDate}</small>
								</a>
						`);
					}
				},
				error: function(){
					alert("커밋목록 불러오기 실패")
				}
			});
			
			
			
			
		}	
		
		function submmitDeployForm(){
			$("#deployRequestForm").submit();
		}
		
		
	</script>


<!--  -->


	<script>
	/* 전역 : 파일의 patch값을 저장해서 모달까지 넘기기 위해서  */
	const patchMap = new Map(); 
	
	// 파일 중복 추가 확인을 위한 set
	const addFileSet = new Set();
	
	$(document).ready(function(){				
	/* 커밋목록 선택후, 해당 커밋으로 조회 */
		$(".list-group").on("click", ".commit-item", function(e){  // 무한스크롤-이벤트위임
			//alert($(this).data("sha"));   //alert(e.currentTarget.dataset.sha);
			$(".file-item").empty();
			
			const sha = $(this).data("sha");
			
			
			$.ajax({
				url: "/bts/deployRequest/commits/sha",
				method: "GET",
				data: {"sha": sha},
				dataType: "json",  
				success: function(res){
					for(let file of res){
						const fileName = file.fileName;
						const fileSha = file.fileSha;
						const commitSha = file.commitSha;
						patchMap.set(fileSha, file.patch);
						//console.log(patchMap.get("patch"));
						//console.log(fileName);
						//console.log(fileSha);
						
						
						if(!addFileSet.has(fileSha)){
							$(".file-item").append(
								`<div class="d-flex justify-content-between align-items-center list-group-item">
						          <span class="text-truncate" style="max-width: 80%;">\${fileName}</span>
						          <button id="\${fileSha}" class="btn btn-sm btn-primary file-item-btn" 
						          	data-filename="\${fileName}" data-commitsha="\${commitSha}">추가</button>
						        </div>`
							);
						} else {
							$(".file-item").append(
								`<div class="d-flex justify-content-between align-items-center list-group-item">
						          <span class="text-truncate" style="max-width: 80%;">\${fileName}</span>
						          <button id="\${fileSha}" class="btn btn-sm btn-primary file-item-btn" 
						          	data-filename="\${fileName}" data-commitsha="\${commitSha}" disabled>추가</button>
						        </div>`
							);							
						}
						
					};
					
				},
				error: function(){
					alert("요청 실패!");
				}
			});
			
		});
	
	
	
	/*（파일 항목 -> 선택된 배포 항목) 파일 추가 */
		$(".file-item").on("click", ".file-item-btn" ,function(e){
			e.preventDefault();
			
			const fileSha = $(this).attr("id");
			//const fileShaShort = $(this).attr("id").slice(0,7);
			const fileName = $(this).data("filename");
			const commitSha = $(this).data("commitsha");
			const commitShaShort = commitSha.slice(0,7);
			
			// 파일 중복 추가 X
			$(this).prop("disabled", "true");
			addFileSet.add(fileSha);
			console.log(addFileSet);
			
			$("tbody").append(`
					<tr>
						<td style="display:none;"><input id="fileSha" name="" type="text" class="form-control-plaintext" value="\${fileSha}"/></td>
						<td><input id="sha" name="" type="text" class="form-control-plaintext" value="\${commitSha}" /></td>
						<td><input id="fileName" name="" tyep="text" class="form-control-plaintext" value="\${fileName}" /></td>
						<td>
							<button id="compareFileItemBtn" class="btn btn-sm btn-outline-primary file-comapare-btn"
								data-sha="\${fileSha}" data-filename="\${fileName}" data-commitsha="\${commitSha}"
								data-bs-toggle="modal" data-bs-target="#deployRequestCompareModal">비교</button>
							<button id="removeFileItemBtn" class="btn btn-sm btn-outline-secondary file-comapare-btn"
								data-sha="\${fileSha}" data-filename="\${fileName}" data-commitsha="\${commitSha}">
								<i class="tf-icons bi bi-trash3-fill"></i></button>
						</td>
					</tr>
					`);
			
			reindexSelectedFiles();
		});

	});

/* 비교 버튼 눌렀을 때 */
	$("tbody").on("click", "#compareFileItemBtn", function(e){
		e.preventDefault();
	});
 
/* 제거버튼 눌렀을 때 비교 항목 목록에서 제거  */	
	$("tbody").on("click", "#removeFileItemBtn", function(e){
		e.preventDefault();
		$(this).closest("tr").remove();
		
		const fileSha = $(this).data("sha");
		addFileSet.delete(fileSha);
//		$(`.file-item-btn#\${fileSha}`).prop("disabled", false);
		$(`button#\${fileSha}`).prop("disabled", false);
		reindexSelectedFiles();
	});
	
/* 선택항목의 데어터를 넘겨주기 위해서 name값의 인덱스 만들기(정렬) : innerClass DTO  */
	function reindexSelectedFiles(){
		 $("tbody tr").each(function(index){
			 console.log(Number(index));
			 $(this).find("input#fileSha").attr("name", `selectedFiles[\${Number(index)}].fileSha`);
			 $(this).find("input#sha").attr("name", `selectedFiles[\${Number(index)}].sha`);
			 $(this).find("input#fileName").attr("name", `selectedFiles[\${Number(index)}].fileName`);
		 });
	}


	</script>
</body>
</html>
