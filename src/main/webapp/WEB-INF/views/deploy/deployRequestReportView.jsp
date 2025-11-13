<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<!-- 헤드부분 고정 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/css/compareModal3.css">
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

/* sun-editor 길이 문제  */
#approvalModal .sun-editor {
	width: 100% !important;
	max-width: 100% !important;
}
</style>

</head>

<body>
	<%@ include file="/WEB-INF/views/jspf/header.jspf"%>
	<!-- 헤더 네비부분 고정 -->



	<!--  -->
	<div class="content-wrapper">
		<div class="container-xxl felx-grow-1 container-p-y">
			<div class="row">
				<div class="col-md-12">
					<div class="d-flex justify-content-between align-item-center mt-4">
						<h3 class="mb-0">보고서 확인</h3>
						<div>
							<c:choose>
								<c:when test="${isMine}">
									<!-- true : 작성자이면 -->
									<c:if test="${latests eq '반려'}">
										<button id="modifyBtn" type="button" class="btn btn-primary me-2">수정하기</button>
									</c:if>
								</c:when>

								<c:otherwise>
									<!-- 작성자가 아니라면 -->
									<c:if
										test="${jobNo!= 1 and (latests eq '승인요망' or latests eq '반려')}">
										<button type="button" class="btn btn-primary me-2"
											data-bs-toggle="modal" data-bs-target="#approvalModal">결재하기</button>
									</c:if>
								</c:otherwise>
							</c:choose>


							<!-- approvalModal -->
							<div id="approvalModal" class="modal fade" tabindex="-1"
								aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered modal-lg"
									role="document">
									<form id="approvalForm" method="post"
										action="${pageContext.request.contextPath}/deploy/approval/submit">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title">결재처리</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" arai-label="Close"></button>
											</div>
											<div class="modal-body">
												<label for="content" class="form-label fw-bold">결재
													사유 (반려 시 필수)</label>
												<div class="w-100 overflow-hidden">
													<textarea id="editor_content" name="content"
														style="display: none"></textarea>
													<textarea id="editor"></textarea>
												</div>
												<!-- <textarea id="content" name="content" class="form-control"
												 rows="10" cols="50"></textarea>  -->

												<input type="hidden" name="reportId"
													value="${requestsDTO.id}"> 
												<input type="hidden"
													name="actionType" value="">
												<%-- <input type="text" name="userId" value="${userid} }"> --%>
											</div>
											<div class="modal-footer">
												<input type="button" id="rejectBtn"
													class="btn btn-outline-danger" value="반려"></input> <input
													type="button" id="approveBtn"
													class="btn btn-outline-primary" value="승인"></input>
											</div>
										</div>
									</form>
								</div>
							</div>
							<!--  -->
						</div>
					</div>
					<hr>

					<div class="card mb-4">
						<div class="card-header">
							<div class="d-flex align-items-center justify-content-between">
								<h5 class="fw-bold mb-3">결재 진행 상황</h5>
								<div class="demo-inline-spacing">
									<p class="d-inline-block mb-0"><span class="badge badge-center rounded-pill bg-label-success">완 료</span></p>
									<p class="d-inline-block mb-0"><span class="badge badge-center rounded-pill bg-label-warning">진 행</span></p>
									<p class="d-inline-block mb-0"><span class="badge badge-center rounded-pill bg-label-secondary">대 기</span></p>
								</div>
							</div>
							<div class="container">
								<div
									class="row text-center align-items-center position-relative">

									<!-- 진행선 배경 (은은하게만 표시) -->
									<div class="position-absolute top-50 start-0 w-100 translate-middle-y rounded-pill"
									     style="height: 4px; background-color: #dee2e6; z-index: 0;"></div>
									<!-- 팀원 -->
									<div class="col position-relative" style="z-index: 1;">
										<div
											class="rounded-circle text-white fw-bold d-flex justify-content-center align-items-center mx-auto mb-2
     										${result == 0 ? 'bg-warning' : (result > 0 ? 'bg-success opacity-75' : 'bg-secondary')}"
											style="width: 60px; height: 60px;">1</div>
										<div class="fw-semibold">${requestsDTO.ename}</div>
										<%-- <div class="text-muted small">${fn:substring(requestsDTO.createdAt,0,10)}</div> --%>
									</div>

									<!-- 팀장 -->
									<div class="col position-relative" style="z-index: 1;">
										<div
											class="rounded-circle text-white fw-bold d-flex justify-content-center align-items-center mx-auto mb-2
     										${result == 1 ? 'bg-warning' : (result > 1 ? 'bg-success opacity-75' : 'bg-secondary')}"
											style="width: 60px; height: 60px;">2</div>
										<div class="fw-semibold">${approvlaLines[0]}</div>
									</div>

									<!-- 운영 -->
									<div class="col position-relative" style="z-index: 1;">
										<div
											class="rounded-circle text-white fw-bold d-flex justify-content-center align-items-center mx-auto mb-2
      										${result == 2 ? 'bg-warning' : (result > 2 ? 'bg-success opacity-75' : 'bg-secondary')}"
											style="width: 60px; height: 60px;">3</div>
										<div class="fw-semibold">${approvlaLines[1]}</div>
									</div>
								</div>
							</div>
						</div>

						<hr>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered text-center align-middle">
									<tr>
										<td style="width: 20%;">문서번호</td>
										<td style="width: 30%;">${requestsDTO.id}</td>
										<td style="width: 20%;">기안자</td>
										<td style="width: 30%;">${requestsDTO.ename }</td>
									</tr>
									<tr>
										<td>기안 일시</td>
										<td><c:set var="createdAt"
												value="${fn:substring(requestsDTO.createdAt,0, 16) }" />
											${createdAt }</td>
										<td>완료 일시</td>
										<td>
										<c:if test="${approvalHistory[0].dname eq '운영팀'  and approvalHistory[0].description eq '승인' }">
											${fn:substring(approvalHistory[0].createdAt, 0, 16) }
										</c:if>
										</td>
									</tr>

									<tr>
										<td>제목</td>
										<td colspan="3" class="text-start">${requestsDTO.title }
										</td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="text-start mb-5">${requestsDTO.content}</div>
											<div>
												<h5>커밋 파일 목록</h5>
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
														<c:forEach items="${commitFilesList}" var="commitFiles">
															<tr>
																<td style="display: none;">${commitFiles.fileSha}</td>
																<td>${commitFiles.sha}</td>
																<td>${commitFiles.fileName}</td>
																<td>
																	<button id="compareFileItemBtn"
																		class="btn btn-sm btn-outline-primary file-comapare-btn"
																		data-sha="${commitFiles.fileSha}"
																		data-filename="${commitFiles.fileName}"
																		data-commitsha="${commitFiles.sha}"
																		data-repoId="${requestsDTO.devRepoId }"
																		data-bs-toggle="modal"
																		data-bs-target="#deployRequestCompareModal">비교</button>

																</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
										</td>
									</tr>

								</table>
							</div>
						</div>

					</div>


					<!-- 승인 반려 코멘트 -->
					<div class="card mb-4">
						<div class="card-header">
							<h5>승인/반려 사유</h5>
						</div>
						<div class="card-body">
							<c:forEach var="approvalHistory" items="${approvalHistory}">
								<c:if test="${approvalHistory.statusId ne 1 }">
									<div class="mb-3 p-3 border rounded-3 bg-light">
										<div
											class="d-flex justify-content-between align-item-center mb-2">
											<p>
												<span class="fw-bold">(${approvalHistory.dname})</span>
												${approvalHistory.ename} ${approvalHistory.jname}
											</p>
											<p
												style="color: ${approvalHistory.statusId==3?'red':'blue'};">
												${approvalHistory.description}
												<c:set var="ahCreatedAt"
													value="${fn:substring(approvalHistory.createdAt, 0, 16) }" />
												<small>(${ahCreatedAt})</small>
											</p>
										</div>
										<div>${approvalHistory.content }</div>
									</div>
								</c:if>
							</c:forEach>

							<!-- 사유가 없을 경우 -->
							<c:if test="${empty approvalHistory }">
								<div class="text-muted">등록된 승인/반려 사유가 없습니다.</div>
							</c:if>
						</div>
					</div>
					<!--  -->

				</div>
			</div>
		</div>
	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/suneditor@latest/dist/suneditor.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/suneditor@latest/src/lang/ko.js"></script>
	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->

	<!-- deployRequestCompareModal -->
	<%@ include
		file="/WEB-INF/views/deploy/deployRequestCompareModal4.jspf"%>

	<script>
		let editor;
		$(function() {
			editor = SUNEDITOR.create('editor', {
				lang : SUNEDITOR_LANG.ko, // 한국어 UI
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
						[ 'removeFormat', 'showBlocks', 'codeView',
								'fullScreen' ] ],
			// 이미지 업로드를 직접 처리하려면 다음 옵션 활용 (예시 비활성화) - 컨트롤러 구현 예정 - 11/04
			// callBackSave: (contents, isChanged) => { ... }
			// imageUploadUrl: '/your/upload/url', // 서버 업로드 엔드포인트
			});

		})

		// 수정버튼 클릭 
		$("#modifyBtn").on("click", function(){
			var requestId = ${requestsDTO.id};
			
			window.location.href = "${pageContext.request.contextPath}/deploy/approval/modify?requestId=" + requestId ;
			
		});
		
		// 반려버튼 클릭
		$("#approvalModal").on("click", "#rejectBtn", function() {
			const content = editor.getContents();//$("#approvalModal #content").val(); // trim()공백제거
			console.log(content);
			if (!editor.getText()) {
				alert("반려 사유를 입력해주세요");
				return;
			}
			$("#approvalModal #editor_content").val(content);
			
			$("#approvalModal input[name='actionType']").val("반려");
			$("#approvalForm").submit();

		});

		// 승인버튼 클릭
		$("#approvalModal").on(
				"click",
				"#approveBtn",
				function() {
					$("#approvalModal input[name='actionType']").val("승인");
					document.querySelector('#editor_content').value = editor
							.getContents();
					$("#approvalForm").submit();
				});
	</script>


</body>
</html>
