<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.page-link {
	transition: none !important;
}

.tag-container {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 6px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 8px;
	max-height: 120px; /* 높이 제한 */
	overflow-y: auto; /* 넘치면 스크롤 */
	min-height: 30px;   /* 기본 높이 */
}

.tag-container input {
	border: none;
	outline: none;
	font-size: 13px;
	flex: 1 1 120px; /* 입력창이 한 줄에서 자연스럽게 이어지도록 */
	min-width: 100px;
	box-shadow: none;
}

.tag {
	background-color: #eef2ff;
	color: #3730a3;   
	padding: 6px 10px;
	border-radius: 12px;
	font-size: 13px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.tag.approver {
	background-color: #fdeaea;
	color: #b91c1c;
}

.tag .remove-tag {
	cursor: pointer;
	font-weight: bold;
	color: #666;
}
</style>
<body>
	<!-- 프로젝트 추가 모달 -->
	<div class="modal fade" id="projectAddModal" tabindex="-1"
		aria-labelledby="projectAddModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-xl"
			style="max-width: 1400px; width: 90%">
			<div class="modal-content"
				style="border: none; border-radius: 16px; box-shadow: 0 4px 24px rgba(0, 0, 0, 0.15);">

				<!-- 헤더 -->
				<div class="modal-header"
					style="border: none; padding: 24px 32px 10px;">
					<h5 class="modal-title" id="projectAddModalLabel"
						style="font-weight: 700; color: #222;">프로젝트 추가</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 본문 -->
				<!-- <div class="modal-body" style="padding: 0 32px 32px; max-height: 75vh; overflow-y: hidden;"> -->
				<div class="modal-body" style="padding: 0 32px 32px;">

					<!-- form 유지하면서 flex 적용 -->
					<form id="projectAddForm" action="/bts/project/add" method="post"
						style="display: flex; gap: 32px; flex-wrap: wrap;">

						<!-- 왼쪽 입력 영역 -->
						<div
							style="flex: 1; display: flex; flex-direction: column; gap: 18px; min-width: 320px;">
							<div>
								<label class="form-label fw-semibold">프로젝트 이름</label> <input
									type="text" name="projectName" class="form-control"
									placeholder="예: 고용24 통합 로그인 시스템 개선" style="font-size: 14px;">
							</div>

							<div>
								<label class="form-label fw-semibold">레포 이름</label> <input
									type="text" name="repoName" class="form-control"
									placeholder="예: employ24-login-enhancement"
									style="font-size: 14px;">
							</div>

							<div>
								<label class="form-label fw-semibold">레포 소유자 ID</label> <input
									type="text" name="repoOwner" class="form-control"
									placeholder="예: github_user_kim" style="font-size: 14px;">
							</div>

							<div>
								<label class="form-label fw-semibold">레포 토큰</label> <input
									type="text" name="repoToken" class="form-control"
									placeholder="예: ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
									style="font-size: 14px;">
							</div>

							<div>
								<label class="form-label fw-semibold">프로젝트 멤버</label>
								<div class="tag-container" id="memberTags">
									<input type="hidden" name="members" class="form-control"
										placeholder="예: 김지아 (공공사업1 Div), 박지수 (전략사업2 Div)"
										style="font-size: 14px;">
								</div>
							</div>

							<div>
								<label class="form-label fw-semibold">운영팀 결재자</label>
								<div class="tag-container" id="approverTags">
									<input type="hidden" name="approver" class="form-control"
										placeholder="예: 이준호 (운영팀2)" style="font-size: 14px;">
								</div>
							</div>
						</div>


						<!-- 세로 구분선 -->
						<div
							style="width: 1px; background-color: #e5e7eb; margin: 0 24px;"></div>

						<!-- 오른쪽 인원 검색 영역 with scroll-bar-->
						<div
							style="flex: 1; min-width: 400px; max-height: 70vh; overflow-y: auto; padding-right: 8px;">
							<label class="form-label fw-semibold">인원 검색 및 추가</label>

							<div class="input-group mb-3">
								<span class="input-group-text bg-white border-end-0"> <i
									class="bi bi-search text-muted"></i>
								</span> <input type="text" class="form-control border-start-0"
									placeholder="이름 또는 부서로 검색..." style="font-size: 14px;">
							</div>

							<div
								style="background-color: #fff; border: 1px solid #eee; border-radius: 10px; padding: 10px 15px;">
								<table class="table table-hover align-middle text-center mb-0"
									style="font-size: 14px;">
									<thead
										style="background-color: #f9fafc; color: #555; font-weight: 600;">
										<tr>
											<th>사원번호</th>
											<th>이름</th>
											<th>부서</th>
											<th>직급</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody id="employeeTableBody">
									</tbody>
								</table>
							</div>
							<!-- 페이지네이션 -->
							<nav aria-label="Page navigation" style="margin-top: 15px;">
								<ul id="pagination"
									class="pagination pagination-sm justify-content-center mb-0">
									<li class="page-item disabled"><a class="page-link"
										href="#" tabindex="-1" aria-disabled="true">&lt;</a></li>
									<li class="page-item active"><a class="page-link" href="#">1</a>
									</li>
									<li class="page-item"><a class="page-link" href="#">2</a></li>
									<li class="page-item"><a class="page-link" href="#">3</a></li>
									<li class="page-item"><a class="page-link" href="#">&gt;</a>
									</li>
								</ul>
							</nav>
						</div>
					</form>
				</div>

				<!-- 하단 버튼 -->
				<div class="modal-footer"
					style="border: none; padding: 16px 32px 28px;">
					<button type="button" class="btn btn-light" data-bs-dismiss="modal"
						style="border: 1px solid #ddd; color: #555; border-radius: 8px; font-size: 14px; padding: 8px 20px;">
						취소</button>
					<button type="submit" form="projectAddForm" class="btn"
						style="background-color: #4f46e5; color: #fff; border-radius: 8px; font-weight: 500; font-size: 14px; padding: 8px 20px;">
						완료</button>
				</div>

			</div>
		</div>
	</div>
	<script>
	function loadEmployeePage(pageNum) {
	    $.ajax({
	        url: "/bts/project/employee",
	        type: "GET",
	        data: { page: pageNum },
	        dataType: "json",
	        success: function(data) {
	            var tbody = $("#employeeTableBody");
	            tbody.empty();

	            // 직원 목록 출력
	            $.each(data.list, function(i, emp) {
	                var addBtn = "";

	                if (emp.dept && emp.dept.dname == "개발팀" && emp.job && emp.job.jname == "사원") {
	                    addBtn = "<button type='button' class='btn btn-outline-primary btn-sm memberBtn' style='border-radius:6px;font-size:13px;'>멤버추가</button>";
	                } else if (emp.dept && emp.dept.dname == "운영팀") {
	                    addBtn = "<button type='button' class='btn btn-outline-danger btn-sm approveBtn' style='border-radius:6px;font-size:13px;'>결재자추가</button>";
	                }

	                var row = "<tr>" +
	                            "<td>" + emp.empno + "</td>" +
	                            "<td>" + emp.ename + "</td>" +
	                            "<td>" + (emp.dept ? emp.dept.dname : "-") + "</td>" +
	                            "<td>" + (emp.job ? emp.job.jname : "-") + "</td>" +
	                            "<td>" + addBtn + "</td>" +
	                          "</tr>";

	                tbody.append(row);
	            });

	            // 페이지네이션
	            var pagination = $("#pagination");
	            pagination.empty();

	            // 이전 버튼
	            if (data.page > 1) {
	                pagination.append("<li class='page-item'><a class='page-link' href='#' onclick='loadEmployeePage(" + (data.page - 1) + ")'>&lt;</a></li>");
	            } else {
	                pagination.append("<li class='page-item disabled'><a class='page-link' href='#'>&lt;</a></li>");
	            }

	            // 페이지 번호
	            for (var i = 1; i <= data.totalPage; i++) {
	                var active = (i == data.page) ? "active" : "";
	                pagination.append("<li class='page-item " + active + "'><a class='page-link' href='#' onclick='loadEmployeePage(" + i + ")'>" + i + "</a></li>");
	            }

	            // 다음 버튼
	            if (data.page < data.totalPage) {
	                pagination.append("<li class='page-item'><a class='page-link' href='#' onclick='loadEmployeePage(" + (data.page + 1) + ")'>&gt;</a></li>");
	            } else {
	                pagination.append("<li class='page-item disabled'><a class='page-link' href='#'>&gt;</a></li>");
	            }
	        },
	        error: function() {
	            alert("사원 목록을 불러오지 못했습니다.");
	        }
	    });
	}

	// 멤버추가 버튼
	$(document).on("click", ".memberBtn", function() {
	    var tr = $(this).closest("tr");
	    var empno = tr.find("td:eq(0)").text();
	    var empName = tr.find("td:eq(1)").text();
	    var deptName = tr.find("td:eq(2)").text();

	    // 중복 방지
	    if ($("#memberTags .tag[data-empno='" + empno + "']").length > 0) return;

	    var tagHtml = "<div class='tag' data-empno='" + empno + "'>" +
	                    empName + " (" + deptName + ")" +
	                    " <span class='remove-tag'>&times;</span></div>";

	    $("#memberTags input").before(tagHtml);
	});

	// 결재자추가 버튼
	$(document).on("click", ".approveBtn", function() {
	    var tr = $(this).closest("tr");
	    var empno = tr.find("td:eq(0)").text();
	    var empName = tr.find("td:eq(1)").text();
	    var deptName = tr.find("td:eq(2)").text();

	    var tagHtml = "<div class='tag approver' data-empno='" + empno + "'>" +
	                    empName + " (" + deptName + ")" +
	                    " <span class='remove-tag'>&times;</span></div>";

	    $("#approverTags").html(tagHtml); // 한 명만 유지
	});

	// 태그 삭제
	$(document).on("click", ".remove-tag", function() {
	    $(this).parent().remove();
	});

	// 폼 제출 시 hidden input 추가
	$(document).on("submit", "#projectAddForm", function() {
	    var form = $(this);

	    // 이전 hidden 제거
	    form.find("input[name='memberEmpnos'], input[name='approverEmpno']").remove();

	    // 멤버 리스트 추가
	    $("#memberTags .tag").each(function() {
	        var empno = $(this).attr("data-empno");
	        form.append("<input type='hidden' name='memberEmpnos' value='" + empno + "'>");
	    });

	    // 결재자 추가
	    var approver = $("#approverTags .tag").attr("data-empno");
	    if (approver) {
	        form.append("<input type='hidden' name='approverEmpno' value='" + approver + "'>");
	    }
	});

	// 페이지 로드 시 첫 페이지
	$(document).ready(function() {
	    loadEmployeePage(1);
	});
	</script>
</body>
</html>