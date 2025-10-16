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
</head>

<body
	style="background-color: #f7f7fb; font-family: 'Noto Sans KR', sans-serif;">
	<%@ include file="/WEB-INF/views/jspf/header.jspf"%>
	<!-- 헤더 네비부분 고정 -->

	<%-- <%@ include file="/WEB-INF/views/jspf/main/mainContent.jspf" %>  --%>
	<div class="content-wrapper">
		<div class="container-xxl flex-grow-1 container-p-y">
			<div class="row">

				<div class="col-md-12">
				
					<div class="d-flex justify-content-between align-item-center mt-4">
						<h3 class="mb-0">배포신청</h3>
						<div>
							<button type="button" class="btn btn-outline-secondary me-2">임시
								저장</button>
							<button type="button" class="btn btn-primary">다음</button>
						</div>
					</div>
					<hr>

					<div class="card mb-4">
						<div class="card-body">
							<div class="row">
								<!-- 커밋목록 -->
								<div class="col-md-6">
									<h5 class="mb-3">커밋목록</h5>
									<div class="list-group"
										style="max-height: 300px; overflow-y: auto;">
										<c:forEach var="commitList" items="${commitList}">
											<a href="#" class="list-group-item list-group-item-action commit-item" data-sha="${commitList.sha}">
												<div class="fw-bold">${commitList.commitMessage}</div> 
												<small class="text-muted">${fn:substring(commitList.sha, 0, 7)} · 
												<c:choose>
													<c:when test="${!empty commitList.userName}">${commitList.userName}</c:when>
													<c:otherwise>알 수 없음</c:otherwise>
												</c:choose> (${commitList.authorName}) · 
												${commitList.authorDate}</small>
											</a>
										</c:forEach>
									</div>
								</div>

								<!-- 파일 목록 -->
								<div class="col-md-6">
									<h5 class="mb-3">파일목록</h5>
									<div class="list-group file-item"
										style="max-height: 300px; overflow-y: auto;">
										<!-- 
										<div
											class="d-flex justify-content-between align-items-center list-group-item">
											<span class="text-truncate" style="max-width: 80%;">src/main/java/com/.../AdminUsersController.java</span>
											<button class="btn btn-sm btn-primary">추가</button>
										</div>
										 -->
									</div>
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
											<th>커밋 해시</th>
											<th>파일 경로</th>
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

			</div>
		</div>
	</div>






	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->
	
	<%@ include file="/WEB-INF/views/deploy/deployRequestCompareModal2.jspf"%>
	<script>
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
						const fileSha = file.sha;
						console.log(fileName);
						console.log(fileSha);
						
						$(".file-item").append(
							`<div class="d-flex justify-content-between align-items-center list-group-item">
					          <span class="text-truncate" style="max-width: 80%;">\${fileName}</span>
					          <button id="\${fileSha}" class="btn btn-sm btn-primary file-item-btn" data-filename="\${fileName}">추가</button>
					        </div>`
						);
					};
					
				},
				error: function(){
					alert("요청 실패!");
				}
			});
			
		});
	
	
	
	
	/*（파일 항목 -> 선택된 배포 항목) 파일 추가 */
		$(".file-item").on("click", ".file-item-btn" ,function(){
			const fileSha = $(this).attr("id");
			const fileShaShort = $(this).attr("id").slice(0,7);
			const fileName = $(this).data("filename");

			$("tbody").append(`
					<tr>
						<td>\${fileShaShort}</td>
						<td>\${fileName}</td>
						<td>
							<button class="btn btn-sm btn-outline-secondary file-comapare-btn"
								data-sha="\${fileSha}" data-filename="\${fileName}"
								data-bs-toggle="modal" data-bs-target="#deployRequestCompareModal">비교</button>
						</td>
					</tr>
					`);
		});		
	
	
	
	
	
	});


	</script>

</body>
</html>
