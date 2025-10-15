<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<!-- 헤드부분 고정 -->
</head>
<style>
.dropdown-menu {
	min-width: 110px !important;
}

.dropdown-menu {
	right: auto !important;
	left: 0 !important;
}
</style>
<body
	style="background-color: #f7f7fb; font-family: 'Noto Sans KR', sans-serif;">
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
						<ul class="dropdown-menu dropdown-menu-start shadow-sm"
							aria-labelledby="userFilterDropdown" style="font-size: 13px;">
							<li><a class="dropdown-item user-filter-item" href="#"
								data-value="">전체</a></li>
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
						<ul class="dropdown-menu dropdown-menu-start shadow-sm"
							aria-labelledby="deptFilterDropdown" style="font-size: 13px;">
							<li><a class="dropdown-item dept-filter-item" href="#"
								data-value="">전체</a></li>
							<li><a class="dropdown-item dept-filter-item" href="#"
								data-value="1">사원</a></li>
							<li><a class="dropdown-item dept-filter-item" href="#"
								data-value="2">대리</a></li>
							<li><a class="dropdown-item dept-filter-item" href="#"
								data-value="3">팀장</a></li>
							<li><a class="dropdown-item dept-filter-item" href="#"
								data-value="4">과장</a></li>
							<li><a class="dropdown-item dept-filter-item" href="#"
								data-value="5">차장</a></li>
							<li><a class="dropdown-item dept-filter-item" href="#"
								data-value="6">부장</a></li>
						</ul>
					</div>

					<div class="input-group" style="width: 240px;">
						<input type="text" class="form-control" placeholder="검색..."
							style="font-size: 13px; border-right: 0; background-color: #fafafa;">
						<button class="btn btn-outline-light" type="button"
							style="border-left: 0; border-color: #ddd; background-color: #fff;">
							<i class="bi bi-search" style="color: #777;"></i>
						</button>
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
						<c:forEach var="emp" items="${empList}">
							<tr>
								<td>${emp.empno}</td>
								<td>${emp.ephone}</td>
								<td>${emp.phone}</td>
								<td>${emp.ename}</td>
								<td>${emp.deptno}</td>
								<td>${emp.jobno}</td>
								<td><span
									class="badge rounded-pill ${emp.estate eq '재직중' ? 'bg-success' : 'bg-danger'}"
									style="padding: 6px 10px; font-weight: 500;">
										${emp.estate} </span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- 페이지네이션 -->
			<nav aria-label="Page navigation" class="mt-3">
				<ul id="pagination-container"
					class="pagination pagination-sm justify-content-center mb-0"></ul>
			</nav>

			<p style="color: red;">[DEBUG] role = ${loginUser}</p>
			<!-- 하단 버튼 -->
			<div
				style="display: flex; justify-content: flex-end; margin-top: 25px;">
				<c:if test="${loginUser.dept.deptno == 3}">
					<button type="button" class="btn"
						style="background-color: #4f46e5; color: #fff; font-weight: 500; padding: 10px 24px; border-radius: 8px; font-size: 14px;"
						data-bs-toggle="modal" data-bs-target="#employeeAddModal">
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




	<%@ include file="/WEB-INF/views/employee/employeeAddModal.jsp"%>
	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->
	<script>
	// 이용자 필터 클릭 시
	document.querySelectorAll('.user-filter-item').forEach(item => {
	    item.addEventListener('click', e => {
	        e.preventDefault();
	        const userType = item.dataset.value; // 전체 / BTS
	        const deptValue = document.querySelector('#deptFilterDropdown').dataset.value || '';
	        loadTable(userType, deptValue);
	    });
	});

	// 부서 필터 클릭 시
	document.querySelectorAll('.dept-filter-item').forEach(item => {
  		item.addEventListener('click', e => {
    	e.preventDefault();
    	const deptValue = item.getAttribute('data-value');

    // 드롭다운 표시 변경
    document.getElementById('deptFilterDropdown').innerText = '부서: ' + (deptValue || '전체');

    // 빈값이면 전체 조회로 돌림
    if (!deptValue) {
      	loadTable('/bts/emp/list'); // 전체 사원 불러오기
      	return;
    }

    // 부서별 조회 요청
    loadTable(`/bts/emp/listByDept?dept=${deptValue}`);
  });
});

	// ✅ Ajax로 데이터 새로 로딩
	const contextPath = '${pageContext.request.contextPath}';
	function loadTable(url) {
		  fetch(contextPath + url)
		    .then(res => {
		      if (!res.ok) throw new Error("서버 응답 오류");
		      return res.text();
		    })
		    .then(html => {
		      const tbody = document.querySelector('tbody');
		      const newTbody = new DOMParser().parseFromString(html, 'text/html').querySelector('tbody');
		      tbody.innerHTML = newTbody.innerHTML;
		      applyPagination();
		    })
		    .catch(err => console.error("❌ loadTable 실패:", err));
		}
	
	
	// ✅ 페이지네이션 함수
	function applyPagination() {
	  const rowsPerPage = 10;
	  const table = document.querySelector("table tbody");
	  const rows = Array.from(table.querySelectorAll("tr"));
	  const pagination = document.getElementById("pagination-container");
	  const totalPages = Math.ceil(rows.length / rowsPerPage);
	  let currentPage = 1;

	  console.log("총 행:", rows.length, "총 페이지:", totalPages);

	  if (rows.length <= rowsPerPage) {
	    pagination.innerHTML = "";
	    return;
	  }

	  const displayPage = (page) => {
	    const start = (page - 1) * rowsPerPage;
	    const end = start + rowsPerPage;
	    rows.forEach((row, i) => {
	      row.style.display = (i >= start && i < end) ? "" : "none";
	    });
	  };

	  const renderPagination = () => {
	    pagination.innerHTML = "";

	    const prevLi = document.createElement("li");
	    prevLi.className = "page-item" + (currentPage === 1 ? " disabled" : "");
	    prevLi.innerHTML = `<a class="page-link" href="#">«</a>`;
	    prevLi.addEventListener("click", (e) => {
	      e.preventDefault();
	      if (currentPage > 1) {
	        currentPage--;
	        displayPage(currentPage);
	        renderPagination();
	      }
	    });
	    pagination.appendChild(prevLi);

	    for (let i = 1; i <= totalPages; i++) {
	      const li = document.createElement("li");
	      li.className = "page-item" + (i === currentPage ? " active" : "");
	      li.innerHTML = `<a class="page-link" href="#">${i}</a>`;
	      li.addEventListener("click", (e) => {
	        e.preventDefault();
	        currentPage = i;
	        displayPage(currentPage);
	        renderPagination();
	      });
	      pagination.appendChild(li);
	    }

	    const nextLi = document.createElement("li");
	    nextLi.className = "page-item" + (currentPage === totalPages ? " disabled" : "");
	    nextLi.innerHTML = `<a class="page-link" href="#">»</a>`;
	    nextLi.addEventListener("click", (e) => {
	      e.preventDefault();
	      if (currentPage < totalPages) {
	        currentPage++;
	        displayPage(currentPage);
	        renderPagination();
	      }
	    });
	    pagination.appendChild(nextLi);
	  };

	  displayPage(currentPage);
	  renderPagination();
	}

	// ✅ 페이지 로드 시 최초 실행
	document.addEventListener("DOMContentLoaded", () => {
	  applyPagination();
	});
	</script>
</body>
</html>