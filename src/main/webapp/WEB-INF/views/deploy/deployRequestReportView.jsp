<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<!-- 헤드부분 고정 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/css/compareModal3.css">

<style>
/* ===== 공통 ===== */
body {
	background-color:#f7f7fb;
}

/* 모달 공통 */
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

/* sun-editor 길이 문제  */
#approvalModal .sun-editor {
	width: 100% !important;
	max-width: 100% !important;
}

/* ===== 메인 레이아웃 ===== */
.report-main-card {
	background-color:#fff;
	border-radius:16px;
	box-shadow:0 4px 18px rgba(15,23,42,0.06);
	padding:30px 30px 26px 30px;
	width:100%;
}

/* 상단 헤더 */
.report-title {
	font-weight:700;
	color:#222;
	margin-bottom:4px;
}
.report-subtitle {
	color:#777;
	font-size:0.9rem;
	margin:0;
}
.report-top-btn {
	background-color:#4a5eff;
	border:none;
	border-radius:8px;
	font-weight:500;
	color:#fff;
	padding:8px 18px;
	font-size:0.9rem;
}
.report-top-btn:hover {
	filter:brightness(0.97);
}

/* ===== 결재 진행 상황 카드 ===== */
.card-approval {
	border:none;
	border-radius:14px;
	box-shadow:0 8px 24px rgba(15,23,42,0.05);
	background-color:#ffffff; /* ✅ 배경 흰색으로 통일 */
}
.card-approval .card-header {
	border-bottom:none;
	background-color:transparent;
	padding:1rem 1.25rem 0.5rem 1.25rem;
}
.section-title {
	font-weight:600;
	color:#333;
	font-size:1rem;
}
.section-subtitle {
	font-size:0.8rem;
	color:#9ca3af;
	margin-bottom:0;
}

/* 진행 상태 뱃지 */
.approval-badges span.badge {
	font-size:0.72rem;
	padding:0.35rem 0.6rem;
	border-radius:999px;
}

/* ===== 세련된 타임라인 스타일 ===== */
.approval-timeline {
	position:relative;
	margin-top:1rem;
	margin-bottom:0.5rem;
	padding:16px 22px;
	border-radius:12px;
	background-color:#f9fafc;
	overflow:hidden;
}

/* ✅ 가로 라인을 정확히 가운데로 정렬 */
.approval-timeline-line {
	position:absolute;
	top:50%;
	left:50%;
	transform:translate(-50%, -50%);
	width:76%;             /* 적당한 길이 */
	height:3px;
	border-radius:999px;
	background:linear-gradient(90deg,#e5e7eb,#e5e7eb);
	z-index:0;
}

/* 각 스텝 */
.approval-step {
	position:relative;
	z-index:1;
}

/* 스텝 원 공통 */
.approval-step-circle {
	width:52px;
	height:52px;
	border-radius:50%;
	display:flex;
	justify-content:center;
	align-items:center;
	font-weight:700;
	margin:0 auto 6px auto;
	font-size:0.95rem;
	color:#6b7280;
	background-color:#ffffff;
	border:2px solid rgba(148,163,184,0.55);
	box-shadow:0 2px 6px rgba(15,23,42,0.08);
	transition:all 0.2s ease;
}

/* 진행 중/완료 상태 하이라이트 */
.approval-step-circle.bg-warning {
	background-color:#fbbf24 !important;
	border-color:#fbbf24;
	color:#fff;
	box-shadow:0 0 0 4px rgba(251,191,36,0.25);
}
.approval-step-circle.bg-success {
	background-color:#22c55e !important;
	border-color:#22c55e;
	color:#fff;
	box-shadow:0 0 0 4px rgba(34,197,94,0.25);
}
.approval-step-circle.bg-secondary {
	background-color:#e5e7eb !important;
	border-color:#d1d5db;
	color:#6b7280;
	box-shadow:none;
	opacity:0.8;
}
.approval-step-circle.bg-success.opacity-75 {
	opacity:0.9;
}

/* 라벨 */
.approval-step-label {
	font-weight:500;
	color:#374151;
	font-size:0.85rem;
	white-space:nowrap;
}

/* ===== 문서 정보 & 내용 ===== */
.card-report-detail {
	border:none;
	border-radius:12px;
	box-shadow:0 2px 10px rgba(15,23,42,0.04);
}

.report-meta-table {
	font-size:0.9rem;
	margin-bottom:0;
}
.report-meta-table td {
	vertical-align:middle;
}
.report-meta-table td:first-child,
.report-meta-table td:nth-child(3) {
	background-color:#f9fafb;
	font-weight:600;
	color:#4b5563;
}

/* 제목/내용 */
.report-content-title {
	font-weight:600;
	font-size:0.95rem;
	color:#111827;
}
.report-content-body {
	padding-top:1rem;
	padding-bottom:1.5rem;
	font-size:0.92rem;
	color:#374151;
	border-bottom:1px dashed #e5e7eb;
}

/* 커밋 파일 목록 테이블 */
.commit-files-title {
	font-weight:600;
	margin-bottom:0.75rem;
	color:#111827;
}
.commit-files-table {
	font-size:0.88rem;
	margin-bottom:0;
}
.commit-files-table thead {
	background-color:#f8f9fc;
}
.commit-files-table th {
	font-weight:600;
	color:#4b5563;
}
.commit-files-table td {
	vertical-align:middle;
}
.file-comapare-btn {
	font-size:0.8rem;
	border-radius:999px;
	padding:4px 10px;
}

/* ===== 승인/반려 코멘트 카드 ===== */
.card-approval-history {
	border:none;
	border-radius:12px;
	box-shadow:0 2px 10px rgba(15,23,42,0.04);
}
.card-approval-history .card-header {
	border-bottom:none;
	background-color:transparent;
}
.approval-comment-block {
	border-radius:12px;
	border:1px solid #e5e7eb;
	background-color:#f9fafb;
}
.approval-comment-header {
	font-size:0.9rem;
	color:#111827;
}
.approval-comment-status {
	font-size:0.9rem;
}
.approval-comment-status small {
	font-size:0.75rem;
	color:#6b7280;
}
.approval-comment-body {
	font-size:0.9rem;
	color:#374151;
}

/* 결재 모달 버튼 */
#approvalModal .btn-outline-primary,
#approvalModal .btn-outline-danger {
	border-radius:999px;
	font-size:0.85rem;
	padding:6px 18px;
}
</style>

</head>

<body>
	<%@ include file="/WEB-INF/views/jspf/header.jspf"%>
	<!-- 헤더 네비부분 고정 -->

	<div class="container my-3">
		<div class="report-main-card">

			<!-- 상단 헤더 -->
			<div class="d-flex justify-content-between align-items-center mb-4">
				<div>
					<h3 class="report-title">보고서 확인</h3>
					<p class="report-subtitle">
						배포 보고서와 결재 진행 상황, 승인/반려 사유를 한눈에 확인하세요.
					</p>
				</div>
				<div>
					<c:choose>
						<c:when test="${isMine}">
							<c:if test="${latests eq '반려'}">
								<button id="modifyBtn" type="button"
									class="btn report-top-btn me-1">
									수정하기
								</button>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${jobNo!= 1 and (latests eq '승인요망' or latests eq '반려')}">
								<button type="button"
									class="btn report-top-btn me-1"
									data-bs-toggle="modal" data-bs-target="#approvalModal">
									결재하기
								</button>
							</c:if>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<!-- 상단 구분선 -->
			<hr style="border:none; border-top:2px solid #4a5eff; opacity:0.9; margin-bottom:24px;">

			<!-- ===== 결재 모달 ===== -->
			<div id="approvalModal" class="modal fade" tabindex="-1"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
					<form id="approvalForm" method="post"
						action="${pageContext.request.contextPath}/deploy/approval/submit">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">결재처리</h5>
								<button type="button" class="btn-close"
									data-bs-dismiss="modal" arai-label="Close"></button>
							</div>
							<div class="modal-body">
								<label for="content" class="form-label fw-bold">결재 사유 (반려 시 필수)</label>
								<div class="w-100 overflow-hidden">
									<textarea id="editor_content" name="content"
										style="display:none"></textarea>
									<textarea id="editor"></textarea>
								</div>

								<input type="hidden" name="reportId" value="${requestsDTO.id}">
								<input type="hidden" name="actionType" value="">
							</div>
							<div class="modal-footer">
								<input type="button" id="rejectBtn"
									class="btn btn-outline-danger" value="반려"/>
								<input type="button" id="approveBtn"
									class="btn btn-outline-primary" value="승인"/>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- ===== // 결재 모달 ===== -->

			<!-- ===== 결재 진행 상황 카드 (HTML은 그대로) ===== -->
			<div class="card mb-4 card-approval">
				<div class="card-header pb-0">
					<div class="d-flex align-items-center justify-content-between">
						<div>
							<h5 class="section-title mb-1">결재 진행 상황</h5>
							<p class="section-subtitle">각 단계별 진행 상태를 확인하세요.</p>
						</div>
						<div class="approval-badges">
							<p class="d-inline-block mb-0 me-1">
								<span class="badge bg-label-success">완료</span>
							</p>
							<p class="d-inline-block mb-0 me-1">
								<span class="badge bg-label-warning">진행</span>
							</p>
							<p class="d-inline-block mb-0">
								<span class="badge bg-label-secondary">대기</span>
							</p>
						</div>
					</div>
				</div>

				<div class="card-body pt-3">
					<div class="container">
						<div class="row text-center align-items-center approval-timeline">

							<!-- 라인 -->
							<div class="approval-timeline-line"></div>

							<!-- 팀원 -->
							<div class="col approval-step">
								<div
									class="approval-step-circle
									${result == 0 ? 'bg-warning' : (result > 0 ? 'bg-success opacity-75' : 'bg-secondary')}">
									1
								</div>
								<div class="approval-step-label">${requestsDTO.ename}</div>
							</div>

							<!-- 팀장 -->
							<div class="col approval-step">
								<div
									class="approval-step-circle
									${result == 1 ? 'bg-warning' : (result > 1 ? 'bg-success opacity-75' : 'bg-secondary')}">
									2
								</div>
								<div class="approval-step-label">${approvlaLines[0]}</div>
							</div>

							<!-- 운영 -->
							<div class="col approval-step">
								<div
									class="approval-step-circle
									${result == 2 ? 'bg-warning' : (result > 2 ? 'bg-success opacity-75' : 'bg-secondary')}">
									3
								</div>
								<div class="approval-step-label">${approvlaLines[1]}</div>
							</div>

						</div>
					</div>
				</div>
			</div>


			<!-- ===== 보고서 상세 / 커밋 파일 ===== -->
			<div class="card mb-4 card-report-detail">
				<div class="card-body">
					<div class="table-responsive mb-3">
						<table class="table table-bordered text-center align-middle report-meta-table">
							<tr>
								<td style="width:20%;">문서번호</td>
								<td style="width:30%;">${requestsDTO.id}</td>
								<td style="width:20%;">기안자</td>
								<td style="width:30%;">${requestsDTO.ename}</td>
							</tr>
							<tr>
								<td>기안 일시</td>
								<td>
									<c:set var="createdAt"
										value="${fn:substring(requestsDTO.createdAt,0, 16)}" />
									${createdAt}
								</td>
								<td>완료 일시</td>
								<td>
									<c:if test="${approvalHistory[0].dname eq '운영팀'  and approvalHistory[0].description eq '승인'}">
										${fn:substring(approvalHistory[0].createdAt, 0, 16)}
									</c:if>
								</td>
							</tr>
							<tr>
								<td>제목</td>
								<td colspan="3" class="text-start report-content-title">
									${requestsDTO.title}
								</td>
							</tr>
							<tr>
								<td colspan="4" class="text-start">

									<!-- 보고서 본문 -->
									<div class="report-content-body">
										${requestsDTO.content}
									</div>

									<!-- 커밋 파일 목록 -->
									<div class="mt-3">
										<h5 class="commit-files-title">커밋 파일 목록</h5>
										<div class="table-responsive">
											<table class="table table-bordered align-middle commit-files-table">
												<thead>
													<tr>
														<th style="display:none;">파일 해시</th>
														<th style="width:25%;">커밋 해시</th>
														<th>파일명</th>
														<th style="width:12%;">동작</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${commitFilesList}" var="commitFiles">
														<tr>
															<td style="display:none;">${commitFiles.fileSha}</td>
															<td>${commitFiles.sha}</td>
															<td>${commitFiles.fileName}</td>
															<td>
																<button id="compareFileItemBtn"
																	class="btn btn-sm btn-outline-primary file-comapare-btn"
																	data-sha="${commitFiles.fileSha}"
																	data-filename="${commitFiles.fileName}"
																	data-commitsha="${commitFiles.sha}"
																	data-repoId="${requestsDTO.devRepoId}"
																	data-bs-toggle="modal"
																	data-bs-target="#deployRequestCompareModal">
																	비교
																</button>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>

								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>

			<!-- ===== 승인 / 반려 코멘트 카드 ===== -->
			<div class="card mb-0 card-approval-history">
				<div class="card-header pb-0">
					<h5 class="section-title mb-1">승인 / 반려 사유</h5>
					
				</div>
				<div class="card-body pt-3">
					<c:forEach var="approvalHistory" items="${approvalHistory}">
						<c:if test="${approvalHistory.statusId ne 1}">
							<div class="mb-3 p-3 approval-comment-block">
								<div class="d-flex justify-content-between align-items-center mb-2 approval-comment-header">
									<p class="mb-0">
										<span class="fw-bold">(${approvalHistory.dname})</span>
										${approvalHistory.ename} ${approvalHistory.jname}
									</p>
									<p class="mb-0 approval-comment-status"
										style="color: ${approvalHistory.statusId==3 ? 'red' : 'blue'};">
										${approvalHistory.description}
										<c:set var="ahCreatedAt"
											value="${fn:substring(approvalHistory.createdAt, 0, 16)}" />
										<small>(${ahCreatedAt})</small>
									</p>
								</div>
								<div class="approval-comment-body">
									${approvalHistory.content}
								</div>
							</div>
						</c:if>
					</c:forEach>

					<c:if test="${empty approvalHistory}">
						<div class="text-muted" style="font-size:0.9rem;">
							등록된 승인/반려 사유가 없습니다.
						</div>
					</c:if>
				</div>
			</div>

		</div><!-- // report-main-card -->
	</div><!-- // container -->

	<script src="https://cdn.jsdelivr.net/npm/suneditor@latest/dist/suneditor.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/suneditor@latest/src/lang/ko.js"></script>
	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->

	<!-- deployRequestCompareModal -->
	<%@ include file="/WEB-INF/views/deploy/deployRequestCompareModal4.jspf"%>

	<script>
		let editor;
		$(function() {
			editor = SUNEDITOR.create('editor', {
				lang : SUNEDITOR_LANG.ko,
				height : '300px',
				width : '100%',
				minHeight : '200px',
				buttonList : [
					[ 'undo', 'redo' ],
					[ 'formatBlock' ],
					[ 'bold', 'underline', 'italic', 'strike' ],
					[ 'fontColor', 'hiliteColor' ],
					[ 'align', 'list', 'lineHeight' ],
					[ 'link', 'image', 'video' ],
					[ 'removeFormat', 'showBlocks', 'codeView', 'fullScreen' ]
				],
			});
		});

		// 수정버튼 클릭 
		$("#modifyBtn").on("click", function(){
			var requestId = ${requestsDTO.id};
			window.location.href = "${pageContext.request.contextPath}/deploy/approval/modify?requestId=" + requestId;
		});

		// 반려버튼 클릭
		$("#approvalModal").on("click", "#rejectBtn", function() {
			const content = editor.getContents();
			if (!editor.getText()) {
				alert("반려 사유를 입력해주세요");
				return;
			}
			$("#approvalModal #editor_content").val(content);
			$("#approvalModal input[name='actionType']").val("반려");
			$("#approvalForm").submit();
		});

		// 승인버튼 클릭
		$("#approvalModal").on("click", "#approveBtn", function() {
			$("#approvalModal input[name='actionType']").val("승인");
			document.querySelector('#editor_content').value = editor.getContents();
			$("#approvalForm").submit();
		});
	</script>

</body>
</html>