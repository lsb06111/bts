<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<!-- 헤드부분 고정 -->
<style>
.dropdown-menu {
	min-width: 110px !important;
}

.dropdown-menu {
	right: auto !important;
	left: 0 !important;
}
</style>
</head>
<body data-ctx="<%=request.getContextPath()%>"
	style="background-color: #f7f7fb;">
	<%@ include file="/WEB-INF/views/jspf/header.jspf"%>
	<!-- 헤더 네비부분 고정 -->
	<div style="display: flex; min-height: 100vh;">

		<!-- 메인 콘텐츠 -->
		<div style="flex: 1; padding: 50px;">

			<!-- 제목 -->
			<div
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
				<h4 style="font-weight: 700; color: #222;">사원 목록</h4>
				<div class="d-flex align-items-center gap-2">

					<!-- ✅ 이용자 필터 -->
					<div class="dropdown" style="position: relative;"
						data-bs-display="static">
						<button class="btn btn-light dropdown-toggle" type="button"
							id="userFilterDropdown" data-bs-toggle="dropdown"
							aria-expanded="false"
							style="font-size: 13px; border: 1px solid #ddd; border-radius: 8px; color: #555;">
							이용자: 전체</button>
						<ul
							class="dropdown-menu dropdown-menu-custom dropdown-menu-start shadow-sm"
							aria-labelledby="userFilterDropdown" style="font-size: 13px;">
							<li><a class="dropdown-item user-filter-item" href="#"
								data-value="ALL">전체</a></li>
							<li><a class="dropdown-item user-filter-item" href="#"
								data-value="BTS">BTS</a></li>
						</ul>
					</div>

					<!-- ✅ 부서(직위) 필터 -->
					<div class="dropdown" style="position: relative;"
						data-bs-display="static">
						<button class="btn btn-light dropdown-toggle" type="button"
							id="deptFilterDropdown" data-bs-toggle="dropdown"
							aria-expanded="false"
							style="font-size: 13px; border: 1px solid #ddd; border-radius: 8px; color: #555;">
							부서: 전체</button>
						<ul
							class="dropdown-menu dropdown-menu-custom dropdown-menu-start shadow-sm"
							aria-labelledby="deptFilterDropdown" style="font-size: 13px;">
							<li><a class="dropdown-item dept-filter-item" href="#"
								data-value="">전체</a></li>
							<li><a class="dropdown-item dept-filter-item" href="#"
								data-value="개발팀">개발팀</a></li>
							<li><a class="dropdown-item dept-filter-item" href="#"
								data-value="운영팀">운영팀</a></li>
							<li><a class="dropdown-item dept-filter-item" href="#"
								data-value="인사팀">인사팀</a></li>
						</ul>
					</div>

					<div class="input-group" style="width: 240px;">
					<form action="${pageContext.request.contextPath}/emp/list2" method="get" class="input-group" style="width: 240px;">
						<input type="text" name="ename" value="${ename}" class="form-control" placeholder="사원명 검색..."
							style="font-size: 13px; border-right: 0; background-color: #fafafa;">
						<button class="btn btn-outline-light" type="button"
							style="border-left: 0; border-color: #ddd; background-color: #fff;">
							<i class="bi bi-search" style="color: #777;"></i>
						</button>
						</form>
					</div>
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
							<th style="width: 10%;">사원번호</th>
							<th style="width: 8%;">내선번호</th>
							<th style="width: 13%;">휴대전화</th>
							<th style="width: 10%;">이름</th>
							<th style="width: 15%;">부서</th>
							<th style="width: 10%;">직위</th>
							<th style="width: 8%;">상태</th>
						</tr>
					</thead>
					<tbody style="text-align: center; color: #333;">
						<c:forEach var="emp" items="${users}">
							<tr>
								<td>${emp.empno}</td>
								<td>${emp.ephone}</td>
								<td>${emp.phone}</td>
								<td>${emp.ename}</td>
								<td>${emp.dept.dname}</td>
								<td>${emp.job.jname}</td>
								<td><span
									class="badge rounded-pill ${emp.estate=='재직중'?'bg-success':'bg-danger'}"
									style="padding: 6px 10px; font-weight: 500;">${emp.estate}</span></td>
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

			<p>총 데이터 수: ${offset}</p>
			<!-- 하단 버튼 -->
			<div
				style="display: flex; justify-content: flex-end; margin-top: 25px;">
				<c:if test="${loginUser.dept.deptno == 3}">
					<button type="button" class="btn"
						style="background-color: #4f46e5; color: #fff; font-weight: 500; padding: 10px 24px; border-radius: 8px; font-size: 14px;"
						data-bs-toggle="modal" data-bs-target="#employeeAddModal2">
						사원 추가</button>
				</c:if>
			</div>
		</div>
	</div>

	<!-- head.jspf 아래쪽이나 body 끝부분에 추가 -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>




	<%@ include file="/WEB-INF/views/jspf/employee/employeeAddModal2.jspf"%>
	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->
	<script>
		document
				.addEventListener(
						"DOMContentLoaded",
						function() {
							// 이용자 필터 클릭 이벤트
							var userFilterItems = document
									.querySelectorAll('.user-filter-item');
							for (var i = 0; i < userFilterItems.length; i++) {
								userFilterItems[i]
										.addEventListener(
												'click',
												function(e) {
													e.preventDefault();
													var value = this
															.getAttribute('data-value')
															|| '전체';
													document
															.getElementById('userFilterDropdown').innerText = '이용자: '
															+ (value || '전체');
													console.log('이용자 필터 선택:',
															value);
													// TODO: Ajax 호출 or 테이블 필터링
												});
							}

							// 부서(직위) 필터 클릭 이벤트
							var deptFilterItems = document
									.querySelectorAll('.dept-filter-item');
							for (var i = 0; i < deptFilterItems.length; i++) {
								deptFilterItems[i]
										.addEventListener(
												'click',
												function(e) {
													e.preventDefault();
													var value = this
															.getAttribute('data-value')
															|| '전체';
													document
															.getElementById('deptFilterDropdown').innerText = '부서: '
															+ (value || '전체');
													console.log('부서 필터 선택:',
															value);
													// TODO: Ajax 호출 or 테이블 필터링
												});
							}
						});
	</script>

</body>
</html>