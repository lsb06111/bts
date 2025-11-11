<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<!-- 헤드부분 고정 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/compareModal3.css">
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
.custom-tooltip .tooltip-inner {
	background-color: #e4d4fc !important;
	color: #333333; 
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
						<h3 class="mb-0">배포수정</h3>
						<div>
							<button id="prevBtn" type="button" class="btn btn-primary" style="display: none;" onclick="prevDeployForm()">이전</button>
							<button id="nextBtn" type="button" class="btn btn-primary" onclick="nextDeployForm()">다음</button>
						</div>
					</div>
					<hr>

					<form id="modifyRequestForm" method="post" name="modifyRequestForm"
						action="/bts/deployForm/sumbmitmodifyRequestForm">

						<div id="prevDeployForm" style="display: block;">
							<div class="card mb-4">
								<div class="card-body">
									<input type="hidden" name="reqId"  value="${requestsDTO.id}">
									<div>
										<h5 class="mb-2">프로젝트명</h5>
										<select id="rquestTBdevRepoId" name="devRepoId"
											class="form-select form-select-lg">
											<c:forEach var="devrepoList" items="${devRepoByUserIdList}">
												<option value="${devrepoList.id }"
													<c:if test="${ devrepoList.id == requestsDTO.devRepoId}">selected</c:if>>
												${devrepoList.projectName }</option>
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
												class="form-control" value="${requestsDTO.title}">
										</div>
										<div class="mb-3">
											<h5 class="mb-2">보고서 내용</h5>
											<textarea id="editor_content" name="content" style="display:none" >${fn:escapeXml(requestsDTO.content)}</textarea>
											 <textarea id="editor" ></textarea>
											
											<!-- <textarea class="form-control" id="rquestTBcontent" name="content"
												rows="14"></textarea> -->
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
										<div class="col-md-6 mb-3">
											<div class="d-flex justify-content-between">
												<h5 class="mb-3">커밋목록</h5>
												<nav aria-label="Page navigation" class="ml-1">
						                          <ul id="commitPagination" class="pagination pagination-sm">
						                            <li class="page-item prev">
						                              <a class="page-link" href="javascript:void(0);"
						                                ><i class="tf-icon bx bx-chevrons-left"></i
						                              ></a>
						                            </li>
						                            <!-- 
						                            <li class="page-item page-num">
						                              <a class="page-link" href="javascript:void(0);">1</a>
						                            </li>						                            
						                             -->
						                            <li class="page-item next">
						                              <a class="page-link" href="javascript:void(0);"
						                                ><i class="tf-icon bx bx-chevrons-right"></i
						                              ></a>
						                            </li>
						                          </ul>
						                        </nav>
					                        </div>
											<div id="commit-list-group" class="list-group"
												style="max-height: 300px; overflow-y: auto;">
											</div>
											<!-- 스피너 -->
											<div class="demo-inline-spacing">
						                        <div class="spinner-border spinner-border-lg text-primary" role="status">
						                          <span class="visually-hidden">Loading...</span>
						                        </div>
					                        </div>
										</div>

										<!-- 파일 목록 -->
										<div class="col-md-6">
											<div class="d-flex justify-content-between align-items-center ">
												<h5 class="mb-3">파일목록</h5>
												<input type="text" id="fileSearch" class="form-control mb-2" style="width:300px;" placeholder="파일명 검색..">
											</div>
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
												<c:if test="${not empty commitFilesList}">
													<c:forEach var="commitFile" items="${commitFilesList }">
														<tr>
															<td style="display:none;"><input id="fileSha" name="" type="text" class="form-control-plaintext" value="${commitFile.fileSha}"/></td>
															<td><input id="sha" name="" type="text" class="form-control-plaintext" value="${commitFile.sha}" /></td>
															<td><input id="fileName" name="" tyep="text" class="form-control-plaintext" value="${commitFile.fileName}" /></td>
															<td>
																<button id="compareFileItemBtn" class="btn btn-sm btn-outline-primary file-comapare-btn"
																	data-sha="${commitFile.fileSha}" data-filename="${commitFile.fileName}" data-commitsha="${commitFile.sha}"
																	data-bs-toggle="modal" data-bs-target="#deployRequestCompareModal">비교</button>
																<button id="removeFileItemBtn" class="btn btn-sm btn-outline-secondary file-comapare-btn"
																	data-sha="${commitFile.fileSha}" data-filename="${commitFile.fileName}" data-commitsha="${commitFile.sha}">
																	<i class="tf-icons bi bi-trash3-fill"></i></button>
															</td>
														</tr>
													</c:forEach>
												</c:if>
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


<script src="https://cdn.jsdelivr.net/npm/suneditor@latest/dist/suneditor.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/suneditor@latest/src/lang/ko.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/deploy/deployPagination.js"></script>
	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->
s

	<%@ include
		file="/WEB-INF/views/deploy/deployRequestCompareModal4.jspf"%>  <!-- 수정 2 또는 3 -->
	
	<script>
	let editor;
	$(function(){
		editor = SUNEDITOR.create('editor', {
			  lang: SUNEDITOR_LANG.ko,    // 한국어 UI
			  height: '300px',
			  width:'100%',
			  minHeight: '200px',
			  buttonList: [
			    ['undo', 'redo'],
			    ['formatBlock'],
			    ['bold', 'underline', 'italic', 'strike'],
			    ['fontColor', 'hiliteColor'],
			    ['align', 'list', 'lineHeight'],
			    ['link', 'image', 'video'],
			    ['removeFormat', 'showBlocks', 'codeView', 'fullScreen']
			  ],
			  // 이미지 업로드를 직접 처리하려면 다음 옵션 활용 (예시 비활성화) - 컨트롤러 구현 예정 - 11/04
			  // callBackSave: (contents, isChanged) => { ... }
			  // imageUploadUrl: '/your/upload/url', // 서버 업로드 엔드포인트
			});

	    // JSP에서 넘어온 content 불러오기
	    const content = $("#editor_content").val();

	    // SunEditor에 내용 세팅
	    editor.setContents(content);	
	});
	
	
	
	
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
			
			loadCommit(1);
			
			/*
			// 레포지토리커밋목록 가져오기
			const repoId = $("#rquestTBdevRepoId").val();
			console.log(repoId);
			$.ajax({
				url:"/bts/deployRequest",
				method: "GET",
				data: {
					repoId: repoId
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
			
			
			*/
			
		}	
		
		function submmitDeployForm(){
			/* 값 확인해서 통과시키기 */
			const titleVal = $("#requestTBtitle").val();
			const contentVal = editor.getContents();
			
			const selectedFileLength = $("tbody").children().length;
			
			console.log(titleVal);
			console.log(contentVal);
			console.log(selectedFileLength);
			
			if(titleVal == "" || contentVal=="" || selectedFileLength==0){
				alert("필수항목을 채워주세요");
			}else {
				document.querySelector('#editor_content').value = contentVal;
				$("#modifyRequestForm").submit();			
			}
		}
		
		
	</script>


<!--  -->


	<script>
	/* 전역 : 파일의 patch값을 저장해서 모달까지 넘기기 위해서  */
	const patchMap = new Map(); 
	
	// 파일 중복 추가 확인을 위한 set
	const addFileSet = new Set();
	
	$(document).ready(function(){	
		reindexSelectedFiles();
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
					$('#fileSearch').val("");
					
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
						          <span class="text-truncate" style="max-width: 80%;" title="\${fileName}">\${fileName}</span>
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

	/* 긴 파일명 보이게하기 */
		$(".file-item").on("mouseenter", "div", function(){
			//console.log($(this).index());
			$(this).find("span").removeClass("text-truncate");
		});
		$(".file-item").on("mouseleave", "div", function(){
			//console.log($(this).index());
			$(this).find("span").addClass("text-truncate");
		});
		
	/* 파일 검색  */
		$('#fileSearch').on("keyup", function(){
			const searchTerm = $(this).val().toLowerCase().trim();
			
			$(".file-item > div").each(function(){
				const fileName = $(this).find("span").text().toLowerCase();
				//console.log(fileName.indexOf(searchTerm));
				const visible = searchTerm.length === 0 || fileName.indexOf(searchTerm) > -1	
				$(this).toggleClass('d-none', !visible);
			});		
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

	<script>
	// 수정할때 사용하는 것. 
	</script>
</body>
</html>
