<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body style="background-color: #f7f7fb;">
	<%@ include file="/WEB-INF/views/jspf/header.jspf"%>
	<!-- 헤더 네비부분 고정 -->
	<div style="display: flex; min-height: 100vh;">

		<!-- 메인 콘텐츠 -->
		<div style="flex: 1; padding: 50px;">

			<!-- 제목 -->
			<div
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
				<h4 style="font-weight: 700; color: #222;">프로젝트 관리</h4>
				<div class="input-group" style="width: 240px;">
					<form action="/bts/project/list" method="get" class="input-group"
						style="width: 240px;">
						<input type="text" class="form-control" name="projectName"
							value="${projectName}" placeholder="검색..."
							style="font-size: 13px; border-right: 0; background-color: #fafafa;">
						<button class="btn btn-outline-light" type="button"
							style="border-left: 0; border-color: #ddd; background-color: #fff;">
							<i class="bi bi-search" style="color: #777;"></i>
						</button>
					</form>
				</div>
			</div>

			<!-- 테이블 카드 -->
			<!-- 600px 넘어가면 스크롤 생성 -->
			<div
				style="background-color: #fff; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05); padding: 20px; max-height: 600px; overflow-y: auto;">
				<table class="table table-hover align-middle"
					style="margin-bottom: 0; font-size: 14px;">
					<thead
						style="background-color: #f9fafc; color: #555; font-weight: 600; text-align: center;">
						<tr>
							<th style="width: 10%;">프로젝트명</th>
							<th style="width: 8%;">레포이름</th>
							<th style="width: 13%;">레포 소유자 ID</th>
							<th style="width: 10%;">프로젝트 팀원</th>
							<th style="width: 15%;">프로젝트 상태</th>
							<th style="width: 10%;">삭제</th>
						</tr>
					</thead>
					<tbody style="text-align: center; color: #333;">
						<c:forEach var="project" items="${projects}">
							<tr class="project-row">
								<td>${project.projectName}</td>
								<td>${project.repoName}</td>
								<td>${project.ownerUsername}</td>
								<td>${project.memberNames}</td>
								<td>${project.currentStage}</td>
								<td><button class="btn btn-light"
										style="border: none; background: transparent; padding: 4px 8px;">
										<i class="bi bi-trash"
											style="color: #808080; font-size: 16px;"></i>
									</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>
			<!-- 페이지네이션 -->
			<nav aria-label="Page navigation" class="mt-3">
				<ul class="pagination pagination-sm justify-content-center mb-0">
					<!-- 이전버튼 -->
					<c:choose>
						<c:when test="${page > 1}">
							<li class="page-item"><a class="page-link"
								href="?page=${page-1}">&lt;</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled"><a class="page-link" href="#"
								tabindex="-1" aria-disabled="true">&lt;</a></li>
						</c:otherwise>
					</c:choose>

					<!-- 페이지 번호 -->
					<c:forEach var="i" begin="1" end="${totalPage}">
						<li class="page-item ${i == page ? 'active' : ''}"><a
							class="page-link" href="?page=${i}">${i}</a></li>
					</c:forEach>

					<!-- 다음버튼 -->
					<c:choose>
						<c:when test="${page < totalPage}">
							<li class="page-item"><a class="page-link"
								href="?page=${page+1}">&gt;</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled"><a class="page-link" href="#"
								tabindex="-1" aria-disabled="true">&gt;</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>

			<!-- 하단 버튼 -->
				<div
					style="display: flex; justify-content: flex-end; margin-top: 25px;">
			<c:if test="${loginUser.job.jobno == 3 && loginUser.dept.deptno == 1}">
					<button type="button" class="btn"
						style="background-color: #4f46e5; color: #fff; font-weight: 500; padding: 10px 24px; border-radius: 8px; font-size: 14px;"
						data-bs-toggle="modal" data-bs-target="#projectAddModal">
						프로젝트 추가</button>
			</c:if>
				</div>
		</div>
	</div>


	<%@ include file="/WEB-INF/views/project/projectAddModal.jsp"%>
	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->
	<script>
	const loginDeptno = "${loginUser.dept.deptno}"
	const loginJobno = "${loginUser.job.jobno}"
	console.log('loginDeptno = ' + loginDeptno);
	console.log('loginJobno = ' + loginJobno);
	</script>
</body>
</html>