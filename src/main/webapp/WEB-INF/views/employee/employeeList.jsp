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
<body data-ctx="<%=request.getContextPath()%>"
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
						<ul class="dropdown-menu dropdown-menu-start shadow-sm"
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
				<table id="empTable" class="table table-hover align-middle"
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
								<td>${emp.dept.dname}</td>
								<td>${emp.job.jname}</td>
								<td><span
									class="badge rounded-pill ${emp.estate == '재직중' ? 'bg-success' : 'bg-danger'}"
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
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<%@ include file="/WEB-INF/views/jspf/employee/employeeAddModal.jspf"%>
	<%@ include
		file="/WEB-INF/views/jspf/employee/employeeUpdateModal.jspf"%>
	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<script>
	document.addEventListener("DOMContentLoaded", function() {

	    var ctx = document.body.getAttribute("data-ctx");
	    var tbody = document.querySelector("table tbody");
	    var userBtn = document.getElementById("userFilterDropdown");
	    var deptBtn = document.getElementById("deptFilterDropdown");
	    var userItems = document.querySelectorAll(".user-filter-item");
	    var deptItems = document.querySelectorAll(".dept-filter-item");
	    var currentType = "ALL";
	    var currentDept = 0;

	    // 페이지네이션
	    function initPagination() {
	        var rowsPerPage = 10;
	        var table = document.querySelector("table tbody");
	        var rows = Array.from(table.querySelectorAll("tr"));
	        var pagination = document.getElementById("pagination-container");
	        var totalPages = Math.ceil(rows.length / rowsPerPage);
	        var currentPage = 1;

	        if (rows.length <= rowsPerPage) {
	            pagination.innerHTML = "";
	            return;
	        }

	        function displayPage(page) {
	            var start = (page - 1) * rowsPerPage;
	            var end = start + rowsPerPage;
	            rows.forEach(function(row, i) {
	                row.style.display = (i >= start && i < end) ? "" : "none";
	            });
	        }

	        function renderPagination() {
	            pagination.innerHTML = "";

	            function createPageLi(label, disabled, callback) {
	                var li = document.createElement("li");
	                li.className = "page-item" + (disabled ? " disabled" : "");
	                li.innerHTML = '<a class="page-link" href="#">' + label + '</a>';
	                if (!disabled) li.addEventListener("click", callback);
	                pagination.appendChild(li);
	            }

	            createPageLi("«", currentPage == 1, function() {
	                if (currentPage > 1) {
	                    currentPage--;
	                    displayPage(currentPage);
	                    renderPagination();
	                }
	            });

	            for (var i = 1; i <= totalPages; i++) {
	                (function(page) {
	                    var li = document.createElement("li");
	                    li.className = "page-item" + (page == currentPage ? " active" : "");
	                    li.innerHTML = '<a class="page-link" href="#">' + page + '</a>';
	                    li.addEventListener("click", function() {
	                        currentPage = page;
	                        displayPage(currentPage);
	                        renderPagination();
	                    });
	                    pagination.appendChild(li);
	                })(i);
	            }

	            createPageLi("»", currentPage == totalPages, function() {
	                if (currentPage < totalPages) {
	                    currentPage++;
	                    displayPage(currentPage);
	                    renderPagination();
	                }
	            });
	        }

	        displayPage(currentPage);
	        renderPagination();
	    }

	    // 행 클릭 이벤트 바인딩
	    function bindRowClick() {
	        var table = document.getElementById("empTable");
	        var rows = table.getElementsByTagName("tr");

	        for (var i = 0; i < rows.length; i++) {
	            rows[i].style.cursor = "pointer";
	            rows[i].addEventListener("mouseover", function() {
	                this.style.backgroundColor = "#f1f4ff";
	            });
	            rows[i].addEventListener("mouseout", function() {
	                this.style.backgroundColor = "";
	            });
	            rows[i].addEventListener("click", function() {
	                var empno = this.cells[0].innerText.trim();
	                if (empno === "" || empno === "-") return;

	                var xhr = new XMLHttpRequest();
	                xhr.open("GET", ctx + "/emp/find?empno=" + empno, true);
	                xhr.onreadystatechange = function() {
	                	if (xhr.readyState === 4 && xhr.status === 200) {
	                        var emp = JSON.parse(xhr.responseText);

	                        // ✅ 모달 input 채우기
	                        document.getElementById("editEmpno").value = emp.empno || "";
	                        document.getElementById("editEmail").value = emp.email || "";
	                        document.getElementById("editPassword").value = emp.birthdate || "";
	                        document.getElementById("editEphone").value = emp.ephone || "";
	                        document.getElementById("editPhone").value = emp.phone || "";
	                        document.getElementById("editEname").value = emp.ename || "";
	                        document.getElementById("editEstate").value = emp.estate || "";

	                        // ✅ 부서/직위 selectbox는 번호로 선택
	                        if (emp.dept && emp.dept.deptno)
	                            document.getElementById("editDept").value = emp.dept.deptno;
	                        if (emp.job && emp.job.jobno)
	                            document.getElementById("editJob").value = emp.job.jobno;

	                        // ✅ 수정 모달 열기
	                        var modal = new bootstrap.Modal(document.getElementById("employeeUpdateModal"));
	                        modal.show();
	                    }
	                };
	                xhr.send();
	            });
	        }
	    }

	    // 필터 기반 데이터 로드
	    function loadEmpData(type, deptno) {
	        fetch(ctx + "/emp/filterDept?type=" + type + "&deptno=" + deptno)
	            .then(function(res) {
	                if (!res.ok) throw new Error("서버 오류: " + res.status);
	                return res.json();
	            })
	            .then(function(data) {
	                tbody.innerHTML = "";
	                if (!data || data.length === 0) {
	                    tbody.innerHTML = "<tr><td colspan='7' class='text-center'>데이터가 없습니다</td></tr>";
	                    return;
	                }
	                for (var i = 0; i < data.length; i++) {
	                    var row = data[i];
	                    var deptName = (row.dept && row.dept.dname) ? row.dept.dname : "-";
	                    var jobName = (row.job && row.job.jname) ? row.job.jname : "-";
	                    var badgeClass = (row.estate === "재직중") ? "bg-success" : "bg-danger";

	                    var tr = "<tr>" +
	                        "<td>" + (row.empno || "-") + "</td>" +
	                        "<td>" + (row.ephone || "-") + "</td>" +
	                        "<td>" + (row.phone || "-") + "</td>" +
	                        "<td>" + (row.ename || "-") + "</td>" +
	                        "<td>" + deptName + "</td>" +
	                        "<td>" + jobName + "</td>" +
	                        "<td><span class='badge rounded-pill " + badgeClass + "'>" +
	                        (row.estate || "-") + "</span></td>" +
	                        "</tr>";
	                    tbody.innerHTML += tr;
	                }
	                initPagination();
	                bindRowClick(); // 필터 후 새 행에도 이벤트 다시 연결
	            })
	            .catch(function(err) {
	                console.error("조회 실패:", err);
	            });
	    }

	    // 초기 로드
	    userBtn.innerText = "이용자: 전체";
	    deptBtn.innerText = "부서: 전체";
	    loadEmpData(currentType, currentDept);
	    bindRowClick();

	    // 이용자 필터 이벤트
	    for (var i = 0; i < userItems.length; i++) {
	        userItems[i].addEventListener("click", function(e) {
	            e.preventDefault();
	            currentType = this.getAttribute("data-value") || "ALL";
	            userBtn.innerText = "이용자: " + (currentType === "ALL" ? "전체" : currentType);
	            loadEmpData(currentType, currentDept);
	        });
	    }

	    // 부서 필터 이벤트
	    for (var j = 0; j < deptItems.length; j++) {
	        deptItems[j].addEventListener("click", function(e) {
	            e.preventDefault();
	            var deptName = this.getAttribute("data-value");
	            var deptno = 0;
	            if (deptName === "개발팀") deptno = 1;
	            else if (deptName === "운영팀") deptno = 2;
	            else if (deptName === "인사팀") deptno = 3;
	            currentDept = deptno;
	            deptBtn.innerText = "부서: " + (deptName || "전체");
	            loadEmpData(currentType, currentDept);
	        });
	    }
	    
	 // ✅ 사원정보 수정 버튼 클릭 이벤트
	    $(document).on('click', '#updateEmpBtn', function () {
	        if (!confirm('해당 사원 정보를 수정하시겠습니까?')) return;

	        const empData = {
	            empno: $('#editEmpno').val().trim(),
	            email: $('#editEmail').val().trim(),
	            ename: $('#editEname').val().trim(),
	            ephone: $('#editEphone').val().trim(),
	            phone: $('#editPhone').val().trim(),
	            estate: $('#editEstate').val(),
	            deptno: $('#editDept').val(),
	            jobno: $('#editJob').val()
	        };

	        $.ajax({
	            url: ctx + '/emp/update',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(empData),
	            success: function (response) {
	                if (response === 'success') {
	                    alert('사원 정보가 성공적으로 수정되었습니다.');
	                    $('#employeeUpdateModal').modal('hide');
	                    $('.modal-backdrop').remove();
	                    $('body').removeClass('modal-open');
	                    $('body').css('overflow', 'auto');
	                    loadEmpData(currentType, currentDept); // ✅ 테이블 새로고침
	                } else {
	                    alert('수정 중 오류가 발생했습니다.');
	                }
	            },
	            error: function () {
	                alert('서버 통신 오류가 발생했습니다.');
	            }
	        });
	    });
	});
	</script>
</body>
</html>