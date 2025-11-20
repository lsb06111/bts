<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<!-- 헤드부분 고정 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/compareModal3.css">

<style>
/* ===== 모달 공통 ===== */
.modal-almost-fullscreen {
	width: calc(100% - 60px);
	max-width: none;
	height: calc(100% - 60px);
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

/* ===== 페이지 공통 레이아웃 ===== */
body {
	background-color:#f7f7fb;
}

/* 메인 카드 */
.deploy-main-card {
	background-color:#fff;
	border-radius:16px;
	box-shadow:0 4px 18px rgba(15,23,42,0.06);
	padding:30px 30px 26px 30px;
	width:100%;
}

/* 제목/설명 */
.deploy-title {
	font-weight:700;
	color:#222;
	margin-bottom:4px;
}
.deploy-subtitle {
	color:#777;
	font-size:0.9rem;
	margin:0;
}

/* 상단 버튼 */
.deploy-top-btn {
	background-color:#4a5eff;
	border:none;
	border-radius:8px;
	font-weight:500;
	color:#fff;
	padding:8px 18px;
	font-size:0.9rem;
}
.deploy-top-btn:disabled,
.deploy-top-btn[disabled] {
	opacity:0.6;
}
.deploy-top-btn:hover {
	filter:brightness(0.97);
}

/* 섹션 카드 */
.card-form {
	border:none;
	border-radius:12px;
	box-shadow:0 2px 10px rgba(15,23,42,0.04);
}
.card-form + .card-form {
	margin-top:18px;
}
.section-title {
	font-weight:600;
	color:#333;
	font-size:1rem;
}
.section-subtitle {
	font-size:0.85rem;
	color:#9a9fb5;
	margin-bottom:0.4rem;
}

/* 프로젝트 셀렉트 */
#rquestTBdevRepoId {
	border-radius:10px;
	border:1px solid #dde1ee;
	font-size:0.95rem;
}
#rquestTBdevRepoId:focus {
	box-shadow:0 0 0 0.15rem rgba(74,94,255,0.15);
	border-color:#4a5eff;
}

/* 제목/본문 */
#rquestTBtitle {
	border-radius:10px;
	border:1px solid #dde1ee;
	font-size:0.95rem;
}
#rquestTBtitle::placeholder {
	color:#b6b9c7;
}
#rquestTBtitle:focus {
	box-shadow:0 0 0 0.15rem rgba(74,94,255,0.15);
	border-color:#4a5eff;
}

/* SunEditor 래퍼 */
#editor {
	border-radius:10px;
	overflow:hidden;
}

/* 커밋/파일 영역 */
#commit-list-group,
.file-item {
	border:1px solid #eef0f7;
	border-radius:10px;
	background-color:#fafbff;
}

/* 리스트 아이템 공통 */
#commit-list-group .list-group-item,
.file-item .list-group-item {
	border:none;
	border-bottom:1px solid #edf0f6;
	font-size:0.9rem;
}
#commit-list-group .list-group-item:last-child,
.file-item .list-group-item:last-child {
	border-bottom:none;
}
#commit-list-group .list-group-item {
	cursor:pointer;
}
#commit-list-group .list-group-item.active,
#commit-list-group .list-group-item:hover {
	background-color:#eef2ff;
	color:#222;
}

/* 파일 검색 */
#fileSearch {
	border-radius:8px;
	border:1px solid #dde1ee;
	font-size:0.85rem;
}
#fileSearch::placeholder {
	color:#b6b9c7;
}
#fileSearch:focus {
	box-shadow:0 0 0 0.15rem rgba(74,94,255,0.15);
	border-color:#4a5eff;
}

/* 파일 추가 버튼 */
.file-item-btn {
	border-radius:999px;
	font-size:0.8rem;
	padding:4px 12px;
	background-color:#4a5eff;
	border:none;
}
.file-item-btn[disabled] {
	background-color:#c4c8f7;
	border:none;
}

/* 선택된 파일 테이블 */
.table-selected {
	font-size:0.9rem;
}
.table-selected thead {
	background-color:#f8f9fc;
}
.table-selected th {
	font-weight:600;
	color:#555;
}
.table-selected td {
	vertical-align:middle;
}
.table-selected input.form-control-plaintext {
	padding:0;
	font-size:0.86rem;
}

/* 비교/삭제 버튼 */
.file-comapare-btn {
	font-size:0.8rem;
	border-radius:999px;
	padding:4px 10px;
}

/* 페이지네이션 */
.pagination .page-link {
	font-size:0.85rem;
}
.pagination .page-link i {
	font-size:1rem;
}

/* 스피너 */
.demo-inline-spacing {
	display:flex;
	align-items:center;
	gap:8px;
}
</style>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>

<body>
	<%@ include file="/WEB-INF/views/jspf/header.jspf"%>
	<!-- 헤더 네비부분 고정 -->

	<div class="container my-3">

		<!-- 메인 카드 (틀 유지) -->
		<div class="deploy-main-card">

			<!-- 상단 헤더 -->
			<div class="d-flex justify-content-between align-items-center mb-4">
				<div>
					<h3 class="deploy-title">배포 신청</h3>
					<p class="deploy-subtitle">
						프로젝트를 선택하고 배포 보고서를 작성한 뒤, 커밋과 파일을 선택해 요청을 제출하세요.
					</p>
				</div>
				<div class="d-flex gap-2">
					<button id="prevBtn" type="button"
					        class="btn deploy-top-btn"
					        style="display:none;"
					        onclick="prevDeployForm()">
						이전
					</button>
					<button id="nextBtn" type="button"
					        class="btn deploy-top-btn"
					        onclick="nextDeployForm()">
						다음
					</button>
				</div>
			</div>

			<!-- 구분선 -->
			<hr style="border:none; border-top:2px solid #4a5eff; opacity:0.9; margin-bottom:24px;">

			<!-- 폼 전체 -->
			<form id="deployRequestForm" method="post" name="deployRequestForm"
				action="/bts/deployForm/sumbmitDeployRequestForm">

				<!-- STEP 1: 프로젝트 / 제목 / 내용 -->
				<div id="prevDeployForm" style="display:block;">

					<!-- 프로젝트 선택 -->
					<div class="card mb-4 card-form">
						<div class="card-body">
							<h5 class="section-title mb-1">프로젝트명</h5>
							<p class="section-subtitle">배포를 신청할 프로젝트를 선택하세요.</p>
							<select id="rquestTBdevRepoId" name="devRepoId"
								class="form-select form-select-lg mt-3">
								<c:forEach var="devrepoList" items="${devRepoByUserIdList}">
									<option value="${devrepoList.id}">${devrepoList.projectName}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<!-- 보고서 작성 -->
					<div class="card card-form">
						<div class="card-body">
							<div class="mb-4">
								<h5 class="section-title mb-1">보고서 제목</h5>
								<p class="section-subtitle">예: 10월 2주차 서비스 배포, 긴급 패치 배포 등</p>
								<input type="text" id="rquestTBtitle" name="title"
									class="form-control mt-2"
									placeholder="배포 보고서 제목을 입력하세요.">
							</div>
							<div class="mb-0">
								<h5 class="section-title mb-1">보고서 내용</h5>
								<p class="section-subtitle">
									주요 변경 사항, 영향 범위, 검증 내용, 롤백 계획 등을 자세히 작성해주세요.
								</p>
								<textarea id="editor_content" name="content" style="display:none"></textarea>
								<textarea id="editor"></textarea>
							</div>
						</div>
					</div>
				</div>
				<!-- // STEP 1 -->

				<!-- STEP 2: 커밋 / 파일 선택 -->
				<div id="nextDeployForm" style="display:none;">

					<!-- 커밋 / 파일 선택 -->
					<div class="card mb-4 card-form">
						<div class="card-body">
							<div class="row">

								<!-- 커밋 목록 -->
								<div class="col-md-6 mb-3">
									<div class="d-flex justify-content-between align-items-center">
										<div>
											<h5 class="section-title mb-1">커밋 목록</h5>
											<p class="section-subtitle">배포에 포함할 커밋을 선택하세요.</p>
										</div>
										<nav aria-label="Page navigation" class="ms-2">
											<ul id="commitPagination" class="pagination pagination-sm mb-0">
												<li class="page-item prev">
													<a class="page-link" href="javascript:void(0);">
														<i class="tf-icon bx bx-chevrons-left"></i>
													</a>
												</li>
												<!-- 페이지 번호 동적 생성 -->
												<li class="page-item next">
													<a class="page-link" href="javascript:void(0);">
														<i class="tf-icon bx bx-chevrons-right"></i>
													</a>
												</li>
											</ul>
										</nav>
									</div>

									<div id="commit-list-group" class="list-group mt-2"
										style="max-height:300px; overflow-y:auto;">
									</div>

									<!-- 스피너 -->
									<div class="demo-inline-spacing mt-3">
										<div class="spinner-border spinner-border-sm text-primary" role="status">
											<span class="visually-hidden">Loading...</span>
										</div>
										<small class="text-muted" style="font-size:0.8rem;">커밋 정보를 불러오는 중입니다.</small>
									</div>
								</div>

								<!-- 파일 목록 -->
								<div class="col-md-6 mb-3">
									<div class="d-flex justify-content-between align-items-center">
										<div>
											<h5 class="section-title mb-1">파일 목록</h5>
											<p class="section-subtitle">선택한 커밋의 파일을 추가하세요.</p>
										</div>
										<input type="text" id="fileSearch" class="form-control form-control-sm"
										       style="width:260px;"
										       placeholder="파일명 검색..">
									</div>
									<div class="list-group file-item mt-2"
										style="max-height:300px; overflow-y:auto;"></div>
								</div>

							</div>
						</div>
					</div>

					<!-- 선택된 배포 항목 -->
					<div class="card mb-0 card-form">
						<div class="card-body">
							<h5 class="section-title mb-2">선택된 배포 항목</h5>
							<p class="section-subtitle mb-3">
								배포에 포함될 커밋/파일 목록입니다. 필요시 비교하거나 목록에서 제거할 수 있습니다.
							</p>
							<div class="table-responsive">
								<table class="table table-bordered align-middle mb-0 table-selected">
									<thead>
										<tr>
											<th style="display:none;">파일 해시</th>
											<th>커밋 해시</th>
											<th>파일명</th>
											<th>동작</th>
										</tr>
									</thead>
									<tbody>
										<!-- 동적으로 추가 -->
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
				<!-- // STEP 2 -->

			</form>
		</div><!-- // 메인 카드 끝 -->

	</div><!-- // container 끝 -->

	<script src="https://cdn.jsdelivr.net/npm/suneditor@latest/dist/suneditor.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/suneditor@latest/src/lang/ko.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/deploy/deployPagination.js"></script>

	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->

	<%@ include file="/WEB-INF/views/deploy/deployRequestCompareModal4.jspf"%>  <!-- 수정 2 또는 3 -->

	<script>
		let editor;
		$(function(){
			editor = SUNEDITOR.create('editor', {
				lang: SUNEDITOR_LANG.ko,
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
			});
		});

		function prevDeployForm(){
			$("#prevDeployForm").show();
			$("#nextDeployForm").css("display", "none");

			$("#prevBtn").hide();
			$("#nextBtn").text("다음");
			$("#nextBtn").attr("onclick", "nextDeployForm()");
		}

		function nextDeployForm(){
			$("#prevDeployForm").hide();
			$("#nextDeployForm").css("display", "block");

			$("#prevBtn").show();
			$("#nextBtn").text("제출");
			$("#nextBtn").attr("onclick", "submmitDeployForm()");

			$("#commit-list-group").empty();

			loadCommit(1);
		}

		function submmitDeployForm(){
			const titleVal = $("#rquestTBtitle").val();
			const contentVal = editor.getContents();
			const selectedFileLength = $("tbody").children().length;

			if(titleVal === "" || contentVal === "" || selectedFileLength === 0){
				alert("필수항목을 채워주세요");
			}else {
				document.querySelector('#editor_content').value = contentVal;
				$("#deployRequestForm").submit();
			}
		}
	</script>

	<script>
	/* 전역 : 파일의 patch값을 저장해서 모달까지 넘기기 위해서 */
	const patchMap = new Map(); 

	// 파일 중복 추가 확인을 위한 set
	const addFileSet = new Set();

	$(document).ready(function(){				

		/* 커밋목록 선택 후, 해당 커밋으로 조회 */
		$(".list-group").on("click", ".commit-item", function(e){
			$(".file-item").empty();

			const sha = $(this).data("sha");
			const repoId = $("#rquestTBdevRepoId").val();

			$.ajax({
				url: "/bts/deployRequest/commits/sha",
				method: "GET",
				data: {
					"sha": sha,
					"repoId": repoId
				},
				dataType: "json",
				success: function(res){
					$('#fileSearch').val("");

					for(let file of res){
						const fileName = file.fileName;
						const fileSha = file.fileSha;
						const commitSha = file.commitSha;
						patchMap.set(fileSha, file.patch);

						if(!addFileSet.has(fileSha)){
							$(".file-item").append(
									`<div class="d-flex justify-content-between align-items-center list-group-item">
								      <span class="text-truncate" style="max-width:80%;" title="\${fileName}">
								        \${fileName}
								      </span>

								      <!-- 버튼 2개 묶어서 오른쪽 끝으로 -->
								      <div class="d-flex gap-2 btn-wrapper" style="margin-left:auto;">
								        <button id="\${fileSha}" class="btn btn-sm btn-primary file-item-btn"
								            data-filename="\${fileName}" data-commitsha="\${commitSha}">
								            추가
								        </button>

								        <button type="button" id="compareFileItemBtn"
								            class="btn btn-sm btn-outline-primary file-comapare-btn"
								            data-sha="\${fileSha}" data-filename="\${fileName}"
								            data-commitsha="\${commitSha}" data-repoId="\${repoId}"
								            data-bs-toggle="modal" data-bs-target="#deployRequestCompareModal">
								            비교
								        </button>
								      </div>
								</div>`
							);
						} else {
							$(".file-item").append(
								`<div class="d-flex justify-content-between align-items-center list-group-item">
									<span class="text-truncate" style="max-width:80%;">\${fileName}</span>
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

		/* (파일 항목 -> 선택된 배포 항목) 파일 추가 */
		$(".file-item").on("click", ".file-item-btn" ,function(e){
			e.preventDefault();

			const repoId = $("#rquestTBdevRepoId").val();

			const fileSha = $(this).attr("id");
			const fileName = $(this).data("filename");
			const commitSha = $(this).data("commitsha");

			// 파일 중복 추가 X
			$(this).prop("disabled", true);
			addFileSet.add(fileSha);

			$("tbody").append(`
				<tr>
					<td style="display:none;">
						<input id="fileSha" name="" type="text" class="form-control-plaintext" value="\${fileSha}"/>
					</td>
					<td>
						<input id="sha" name="" type="text" class="form-control-plaintext" value="\${commitSha}" />
					</td>
					<td>
						<input id="fileName" name="" type="text" class="form-control-plaintext" value="\${fileName}" />
					</td>
					<td>
						<button id="compareFileItemBtn" class="btn btn-sm btn-outline-primary file-comapare-btn"
							data-sha="\${fileSha}" data-filename="\${fileName}" data-commitsha="\${commitSha}"
							data-repoId="\${repoId}"
							data-bs-toggle="modal" data-bs-target="#deployRequestCompareModal">비교</button>
						<button id="removeFileItemBtn" class="btn btn-sm btn-outline-secondary file-comapare-btn"
							data-sha="\${fileSha}" data-filename="\${fileName}" data-commitsha="\${commitSha}">
							<i class="tf-icons bi bi-trash3-fill"></i>
						</button>
					</td>
				</tr>
			`);

			reindexSelectedFiles();
		});

		/* 긴 파일명 보이게 하기 */
		$(".file-item").on("mouseenter", "div", function(){
			$(this).find("span").removeClass("text-truncate");
		});
		$(".file-item").on("mouseleave", "div", function(){
			$(this).find("span").addClass("text-truncate");
		});

		/* 파일 검색 */
		$('#fileSearch').on("keyup", function(){
			const searchTerm = $(this).val().toLowerCase().trim();

			$(".file-item > div").each(function(){
				const fileName = $(this).find("span").text().toLowerCase();
				const visible = searchTerm.length === 0 || fileName.indexOf(searchTerm) > -1;
				$(this).toggleClass('d-none', !visible);
			});
		});
	});

	/* 비교 버튼 눌렀을 때 */
	$("tbody").on("click", "#compareFileItemBtn", function(e){
		e.preventDefault();
		// 비교 모달은 JSPF에서 처리
	});

	/* 제거 버튼 눌렀을 때 비교 항목 목록에서 제거 */
	$("tbody").on("click", "#removeFileItemBtn", function(e){
		e.preventDefault();
		$(this).closest("tr").remove();

		const fileSha = $(this).data("sha");
		addFileSet.delete(fileSha);
		$(`button#\${fileSha}`).prop("disabled", false);

		reindexSelectedFiles();
	});

	/* 선택 항목 name 인덱스 정렬 */
	function reindexSelectedFiles(){
		$("tbody tr").each(function(index){
			$(this).find("input#fileSha").attr("name", `selectedFiles[\${Number(index)}].fileSha`);
			$(this).find("input#sha").attr("name", `selectedFiles[\${Number(index)}].sha`);
			$(this).find("input#fileName").attr("name", `selectedFiles[\${Number(index)}].fileName`);
		});
	}
	</script>
</body>
</html>