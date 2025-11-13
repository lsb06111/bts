<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/jspf/header.jspf"%>
	<!-- 헤더 네비부분 고정 -->
	<div class="container my-3">

		<!-- 메인 콘텐츠 (history 페이지와 동일 스타일) -->
		<div style="
        background-color:#fff;
        border-radius:16px;
        box-shadow:0 4px 18px rgba(0,0,0,0.08);
        padding:30px 30px;
        width:100%;
    ">

			<!-- 헤더 영역 (타이틀) -->
			<div class="d-flex justify-content-between align-items-center mb-4">
				<div>
					<h3 style="font-weight:700; color:#222;">프로젝트 관리</h3>
					<p style="color:#777; font-size:0.9rem; margin:0;">
						프로젝트와 저장소 정보를 관리하세요.
					</p>
				</div>
			</div>

			<!-- 구분선 (history 동일) -->
			<hr style="border:none; border-top:2px solid #4a5eff; opacity:0.9; margin-bottom:30px;">

			<!-- 🔵 필터 + 검색 (history와 동일한 라인 구조) -->
			<div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">

				<!-- 왼쪽: 프로젝트 상태 드롭다운 -->
				<div class="d-flex align-items-center gap-2">
					<select class="form-select form-select-sm"
					        name="projectStatusSelect"
					        style="width:auto; border-radius:8px; height:38px;">
						<option value="">프로젝트 상태</option>
						<option value="진행중"
							<c:if test="${param.projectStatus == '진행중'}">selected</c:if>>
							진행중
						</option>
						<option value="완료"
							<c:if test="${param.projectStatus == '완료'}">selected</c:if>>
							완료
						</option>
						<option value="중단"
							<c:if test="${param.projectStatus == '중단'}">selected</c:if>>
							중단
						</option>
					</select>
				</div>

				<!-- 오른쪽: 검색창 (history 스타일) -->
				<form action="/bts/project/list" method="get"
				      class="d-flex align-items-center" style="margin:0;">
					<!-- 상태값도 함께 넘기기 위해 hidden -->
					<input type="hidden" name="projectStatus" id="projectStatusHidden"
					       value="${param.projectStatus}"/>

					<div style="position:relative; width:220px;">
						<input type="text"
						       class="form-control form-control-sm"
						       name="projectName"
						       value="${param.projectName}"
						       placeholder="검색..."
						       style="border-radius:8px; font-size:0.9rem; padding-left:35px; height:38px;">
						<button type="submit"
						        style="position:absolute; left:8px; top:50%; transform:translateY(-50%); border:none; background:transparent; padding:0;">
							<i class="bi bi-search" style="color:#999;"></i>
						</button>
					</div>
				</form>
			</div>

			<!-- 테이블 -->
			<div class="table-responsive">
				<table class="table align-middle text-center mb-0" style="font-size:0.95rem;">
					<thead style="background-color:#f8f9fc;">
						<tr style="color:#555; font-weight:600;">
							<th style="width: 15%;">프로젝트명</th>
							<th style="width: 15%;">레포이름</th>
							<th style="width: 20%;">레포 소유자 ID</th>
							<th style="width: 25%;">프로젝트 팀원</th>
							<th style="width: 15%;">프로젝트 상태</th>
							<th style="width: 10%;">삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="project" items="${projects}">
							<tr class="project-row"
							    data-id="${project.id}"
							    data-name="${project.projectName}"
							    data-repo="${project.repoName}"
							    data-owner="${project.ownerUsername}"
							    data-token="${project.repoToken}"
							    data-members="${project.memberNames}"
							    data-approver="${project.approverName}"
							    data-empnos="${project.memberEmpnos}"
							    data-deptnos="${project.memberDeptnos }"
							    style="border-bottom:1px solid #f1f1f1;">
								<td style="color:#222; font-weight:500;">${project.projectName}</td>
								<td style="color:#555;">${project.repoName}</td>
								<td style="color:#555;">${project.ownerUsername}</td>
								<td style="color:#555;">${project.memberNames}</td>
								<td style="color:#4a5eff; font-weight:600;">${project.currentStage}</td>
								<td>
									<button class="btn btn-sm btn-outline-secondary"
									        style="border-radius:6px; font-size:0.85rem; padding:4px 8px; background-color:#fff;">
										<i class="bi bi-trash" style="font-size:1rem; color:#808080;"></i>
									</button>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty projects}">
							<tr>
								<td colspan="6" style="padding:40px 0; color:#aaa;">등록된 프로젝트가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>

			<!-- 페이지네이션 -->
			<nav aria-label="Page navigation" class="mt-4">
				<ul class="pagination justify-content-center mb-0">
					<!-- 이전 -->
					<li class="page-item ${page <= 1 ? 'disabled' : ''}">
						<a class="page-link"
						   href="?page=${page-1}&projectName=${param.projectName}&projectStatus=${param.projectStatus}"
						   style="color:#4a5eff;">
							&lt;
						</a>
					</li>

					<!-- 페이지 번호 -->
					<c:forEach var="i" begin="1" end="${totalPage}">
						<li class="page-item ${i == page ? 'active' : ''}">
							<a class="page-link"
							   href="?page=${i}&projectName=${param.projectName}&projectStatus=${param.projectStatus}"
							   style="${i == page ? 'background-color:#4a5eff; border:none;' : 'color:#4a5eff;'}">
								${i}
							</a>
						</li>
					</c:forEach>

					<!-- 다음 -->
					<li class="page-item ${page >= totalPage || totalPage == 0 ? 'disabled' : ''}">
						<a class="page-link"
						   href="?page=${page+1}&projectName=${param.projectName}&projectStatus=${param.projectStatus}"
						   style="color:#4a5eff;">
							&gt;
						</a>
					</li>
				</ul>
			</nav>

			<!-- 프로젝트 추가 버튼 -->
			<div class="d-flex justify-content-end mt-4">
				<c:if test="${loginUser.job.jobno == 3 && loginUser.dept.deptno == 1}">
					<button type="button" class="btn"
						style="background-color:#4a5eff; color:#fff; font-weight:500; padding:10px 24px; border-radius:8px; font-size:0.9rem; border:none;"
						data-bs-toggle="modal" data-bs-target="#projectAddModal">
						<i class="bi bi-plus-lg me-1"></i>프로젝트 추가
					</button>
				</c:if>
			</div>

		</div>
	</div>

	<%@ include file="/WEB-INF/views/project/projectAddModal.jsp"%>
	<%@ include file="/WEB-INF/views/project/projectUpdateModal.jsp"%>
	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>

	<script>
		$(document).ready(function() {

			const loginDeptno = "${loginUser.dept.deptno}";
			const loginJobno = "${loginUser.job.jobno}";

			// 상태 셀렉트 변경 시 hidden에 값 반영
			const statusSelect = document.querySelector('select[name="projectStatusSelect"]');
			const statusHidden = document.getElementById('projectStatusHidden');
			if (statusSelect && statusHidden) {
				statusSelect.addEventListener('change', function() {
					statusHidden.value = this.value;
				});
			}

			// 프로젝트 행 클릭 시 수정 모달
			$(document).on("click", ".project-row", function() {
				if (loginDeptno !== "1" || loginJobno !== "3") {
					console.log("권한 없음 , 수정 모달 비활성화");
					return;
				}

				const project = {
					id : $(this).data("id"),
					projectName : $(this).data("name"),
					repoName : $(this).data("repo"),
					ownerUsername : $(this).data("owner"),
					repoToken : $(this).data("token"),
					memberNames : $(this).data("members"),
					approverName : $(this).data("approver"),
					memberEmpnos : $(this).data("empnos"),
					memberDeptnos : $(this).data("deptnos")
				};

				console.log("선택된 프로젝트:", project);
				openUpdateModal(project);
			});
		});
	</script>
</body>
</html>