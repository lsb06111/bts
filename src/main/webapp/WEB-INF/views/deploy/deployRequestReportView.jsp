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
.custom-tooltip .tooltip-inner {
	background-color: #e4d4fc !important;
	color: #333333; 
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
							<button type="button" class="btn btn-primary me-2"
								data-bs-toggle="modal" data-bs-target="#approvalModal">결재하기</button>
							<!-- <input type="button" class="btn btn-outline-primary" onclick="" value="승인"></input> -->
							
							<!-- approvalModal -->
							<div id="approvalModal" class="modal fade" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<form id="approvalForm" method="post" action="/deploy/approval/submit">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title">결재처리</h5>
												<button type="button" class="btn-close" data-bs-dismiss="modal" arai-label="Close"></button>
											</div>
											<div class="modal-body">
												<label for="content" class="form-label fw-bold">결재 사유 (반려 시 필수)</label>
												<textarea id="content" name="content" class="form-control"
												 rows="10" cols="50"></textarea>
												<input type="text" name="reportId">
												<input type="text" name="actionType" value="">
											</div>
											<div class="modal-footer">
												<input type="button" id="rejectBtn" class="btn btn-outline-danger" value="반려"></input>
												<input type="button" id="approveBtn" class="btn btn-outline-primary" value="승인"></input>
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
							<table class="table table-bordered text-center align-middle">
								<tr class="fw-bold">
									<td scope="col" rowspan="2">결재</td>
									<td scope="col">팀원</td>
									<td scope="col">팀장</td>
									<td scope="col">운영</td>
								</tr>
								<tr>
									<td>
										<div class="d-flex flex-column align-items-center py-2">
											<img src="/bts/resources/assets/img/rain.gif" alt="승인"
												style="width: 50px; height: 50px;">
											<div class="text-muted mt-2">2025-11-03</div>
											<div>일이삼</div>
										</div>
									</td>
									<td>
										<div class="d-flex flex-column align-items-center py-2">
											<img src="/bts/resources/assets/img/rain.gif" alt="승인"
												style="width: 50px; height: 50px;">
											<div class="text-muted mt-2">2025-11-03</div>
											<div>일이삼</div>
										</div>
									</td>
									<td>
										<div class="d-flex flex-column align-items-center py-2">
											<img src="/bts/resources/assets/img/rain.gif" alt="승인"
												style="width: 50px; height: 50px;">
											<div class="text-muted mt-2">2025-11-03</div>
											<div>일이삼</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
						
						<div class="card-body">
							<div class="table-responsive">
							<table  class="table table-bordered text-center align-middle">
								<tr>
									<td style="width: 20%;">문서번호</td>
									<td style="width: 30%;">DR-20251103</td>
									<td style="width: 20%;">기안자</td>
									<td style="width: 30%;">일이삼</td>
								</tr>
								<tr>
									<td>기안 일시</td>
									<td>
										<c:set var="createdAt" value="${fn:substring(requestsDTO.createdAt,0, 16) }"></c:set>
										${createdAt }
									</td>
									<td>완료 일시</td>
									<td>????-??-??</td>
								</tr>
								
								<tr>
									<td>제목</td>
									<td colspan="3" class="text-start">${requestsDTO.title }</td>
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
													<button id="compareFileItemBtn" class="btn btn-sm btn-outline-primary file-comapare-btn"
														data-sha="${commitFiles.fileSha}" data-filename="${commitFiles.fileName}" data-commitsha="${commitFiles.sha}"
														data-bs-toggle="modal" data-bs-target="#deployRequestCompareModal">비교</button>
													
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
				</div>
			</div>
		</div>
	</div>




	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->
	
	<!-- deployRequestCompareModal -->
	<%@ include file="/WEB-INF/views/deploy/deployRequestCompareModal4.jspf"%>
	
	<script>
	$("#approvalModal").on("click", "#rejectBtn",  function(){
		const content = $("#approvalModal #content").val().trim();  // trim()공백제거
		if(!content){
			alert("반려 사유를 입력해주세요");	
			return;
		}
		$("#approvalModal input[name='actionType']").val("반려");
		$("#approvalForm").submit();
		
	});
	$("#approvalModal").on("click", "#approveBtn",  function(){
		$("#approvalModal input[name='actionType']").val("승인");
		$("#approvalForm").submit();
	});
	
	</script>
	
	
</body>
</html>
