<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<!-- 헤드부분 고정 -->
</head>
<body data-ctx="<%=request.getContextPath()%>" style="background-color:#f7f7fb;">
	<%@ include file="/WEB-INF/views/jspf/header.jspf"%>
	<!-- 헤더 네비부분 고정 -->

	<div class="container my-3">

		<!-- 👇 history 페이지와 동일한 흰색 메인 박스 -->
		<div style="
			background-color:#fff;
			border-radius:16px;
			box-shadow:0 4px 18px rgba(0,0,0,0.08);
			padding:30px 30px;
			width:100%;
		">

			<!-- 상단 타이틀 -->
			<div class="d-flex justify-content-between align-items-center mb-4">
				<div>
					<h3 style="font-weight:700; color:#222;">사원 목록</h3>
					<p style="color:#777; font-size:0.9rem; margin:0;">
						사원 정보와 근무 상태를 확인하세요.
					</p>
				</div>
			</div>

			<!-- 파란 구분선 -->
			<hr style="border:none; border-top:2px solid #4a5eff; opacity:0.9; margin-bottom:30px;">

			<!-- 🔵 필터 + 검색 라인 (history와 동일 구조) -->
			<div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">

				<!-- 왼쪽: 부서 필터 드롭다운 -->
				<div class="d-flex align-items-center gap-2">
					<select class="form-select form-select-sm"
					        name="deptSelect"
					        style="width:auto; border-radius:8px; height:38px;">
						<option value="">부서</option>
						<option value="개발팀"
							<c:if test="${param.dept == '개발팀'}">selected</c:if>>
							개발팀
						</option>
						<option value="운영팀"
							<c:if test="${param.dept == '운영팀'}">selected</c:if>>
							운영팀
						</option>
						<option value="인사팀"
							<c:if test="${param.dept == '인사팀'}">selected</c:if>>
							인사팀
						</option>
					</select>
				</div>

				<!-- 오른쪽: 검색 폼 (history 스타일) -->
				<form action="${pageContext.request.contextPath}/emp/list2"
					  method="get"
					  class="d-flex align-items-center" style="margin:0;">

					<!-- 부서 필터 값 동기화용 hidden -->
					<input type="hidden" name="dept" id="deptHidden" value="${param.dept}"/>

					<div style="position:relative; width:220px;">
						<input type="text"
						       name="ename"
						       value="${param.ename}"
						       class="form-control form-control-sm"
						       placeholder="사원명 검색..."
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
							<th style="width:10%;">사원번호</th>
							<th style="width:10%;">내선번호</th>
							<th style="width:15%;">휴대전화</th>
							<th style="width:10%;">이름</th>
							<th style="width:20%;">부서</th>
							<th style="width:10%;">직위</th>
							<th style="width:10%;">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="emp" items="${users}">
							<tr class="emp-row"
								data-empno="${emp.emp.empno}"
								data-ename="${emp.emp.ename}"
								data-email="${emp.emp.email}"
								data-phone="${emp.emp.phone}"
								data-ephone="${emp.emp.ephone}"
								data-deptno="${emp.emp.dept.deptno}"
								data-jobno="${emp.emp.job.jobno}"
								data-estate="${emp.emp.estate}"
								data-company="${emp.emp.company}"
								style="border-bottom:1px solid #f1f1f1;">
								<td style="color:#666;">${emp.emp.empno}</td>
								<td style="color:#555;">${emp.emp.ephone}</td>
								<td style="color:#555;">${emp.emp.phone}</td>
								<td style="color:#222; font-weight:500;">${emp.emp.ename}</td>
								<td style="color:#555;">${emp.emp.dept.dname}</td>
								<td style="color:#555;">${emp.emp.job.jname}</td>
								<td>
									<span class="badge rounded-pill ${emp.emp.estate=='재직중' ? 'bg-success' : 'bg-danger'}"
									      style="padding:6px 10px; font-weight:500; font-size:0.8rem;">
										${emp.emp.estate}
									</span>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty users}">
							<tr>
								<td colspan="7" style="padding:40px 0; color:#aaa;">등록된 사원 정보가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>

			<!-- 페이지네이션 (history 스타일) -->
			<nav aria-label="Page navigation" class="mt-4">
				<ul class="pagination justify-content-center mb-0">
					<!-- 이전 -->
					<li class="page-item ${page <= 1 ? 'disabled' : ''}">
						<a class="page-link"
						   href="?page=${page-1}&ename=${param.ename}&dept=${param.dept}"
						   style="color:#4a5eff;">
							&lt;
						</a>
					</li>

					<!-- 페이지 번호 -->
					<c:forEach var="i" begin="1" end="${totalPage}">
						<li class="page-item ${i == page ? 'active' : ''}">
							<a class="page-link"
							   href="?page=${i}&ename=${param.ename}&dept=${param.dept}"
							   style="${i == page ? 'background-color:#4a5eff; border:none;' : 'color:#4a5eff;'}">
								${i}
							</a>
						</li>
					</c:forEach>

					<!-- 다음 -->
					<li class="page-item ${page >= totalPage || totalPage == 0 ? 'disabled' : ''}">
						<a class="page-link"
						   href="?page=${page+1}&ename=${param.ename}&dept=${param.dept}"
						   style="color:#4a5eff;">
							&gt;
						</a>
					</li>
				</ul>
			</nav>

			

			<!-- 하단 버튼 -->
			<div class="d-flex justify-content-end mt-4">
				<c:if test="${loginUser.dept.deptno == 3}">
					<button type="button" class="btn"
						style="background-color:#4a5eff; color:#fff; font-weight:500; padding:10px 24px; border-radius:8px; font-size:0.9rem; border:none;"
						data-bs-toggle="modal" data-bs-target="#employeeAddModal2">
						<i class="bi bi-plus-lg me-1"></i>사원 추가
					</button>
				</c:if>
			</div>

		</div><!-- // 흰 메인 박스 끝 -->

	</div><!-- // container 끝 -->

	<%@ include file="/WEB-INF/views/jspf/employee/employeeAddModal2.jspf"%>
	<%@ include file="/WEB-INF/views/jspf/employee/employeeUpdateModal2.jspf"%>
	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->

	<script>
		$(document).ready(function() {
			const loginDeptno = "${loginUser.dept.deptno}";
			console.log("현재 로그인한 부서번호:", loginDeptno);

			// 부서 셀렉트와 hidden 값 동기화
			const deptSelect = document.querySelector('select[name="deptSelect"]');
			const deptHidden = document.getElementById('deptHidden');
			if (deptSelect && deptHidden) {
				deptSelect.addEventListener('change', function() {
					deptHidden.value = this.value;
				});
			}

			// 사원 목록 클릭 (인사팀만 수정 가능)
			$(document).on("click", ".emp-row", function() {
				const empDeptno = String($(this).data("deptno"));
				const loginDeptnoStr = String(loginDeptno);
				console.log("로그인 부서: ", loginDeptnoStr, " / 클릭한 사원 부서:", empDeptno);

				if (loginDeptnoStr !== "3") {
					console.log("인사팀 아님 — 수정 불가");
					return;
				}
				console.log("인사팀 접속. 수정 가능");

				$("#employeeUpdateModal2 #updateEmailInput").val($(this).data("email"));
				$("#employeeUpdateModal2 #updateNameInput").val($(this).data("ename"));
				$("#employeeUpdateModal2 #updatePhoneInput").val($(this).data("phone"));
				$("#employeeUpdateModal2 #updateEphoneInput").val($(this).data("ephone"));
				$("#employeeUpdateModal2 #updateDeptInput").val($(this).data("deptno"));
				$("#employeeUpdateModal2 #updateJobInput").val($(this).data("jobno"));
				$("#employeeUpdateModal2 #updateEstateInput").val($(this).data("estate"));
				$("#employeeUpdateModal2 #updateCompanyInput").val($(this).data("company"));

				if (!$("#employeeUpdateModal2 #updateEmpnoHidden").length) {
					$("#employeeUpdateModal2 #empUpdateForm").append('<input type="hidden" id="updateEmpnoHidden" name="empno">');
				}
				$("#employeeUpdateModal2 #updateEmpnoHidden").val($(this).data("empno"));

				$("#employeeUpdateModal2").modal("show");
			});

			// 수정 버튼 클릭시
			$("#updateEmpBtn").on("click", function() {
				const formData = $("#empUpdateForm").serialize();
				$.ajax({
					url: "${pageContext.request.contextPath}/emp/update",
					type: "POST",
					data: formData,
					success: function() {
						alert("수정이 완료되었습니다.");
						location.reload();
					},
					error: function() {
						alert("수정 중 오류가 발생했습니다.");
					}
				});
			});

			// (기존 필터 관련 JS는 남겨둠 — 필요시 재활용 가능)
			$(".user-filter-item").on("click", function(e) {
				e.preventDefault();
				const value = $(this).data("value") || "전체";
				$("#userFilterDropdown").text("이용자: " + value);
				console.log("이용자 필터 선택:", value);
			});

			$(".dept-filter-item").on("click", function(e) {
				e.preventDefault();
				const value = $(this).data("value") || "전체";
				$("#deptFilterDropdown").text("부서: " + value);
				console.log("부서 필터 선택:", value);
			});
		});
	</script>
</body>
</html>