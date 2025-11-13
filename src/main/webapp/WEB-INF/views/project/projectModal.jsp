<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.page-link { transition: none !important; }
.tag-container {
	display:flex; flex-wrap:wrap; align-items:center; gap:6px;
	background:#fff; border:1px solid #ddd; border-radius:8px; padding:8px;
	max-height:120px; overflow-y:auto; min-height:30px;
}
.tag-container input {
	border:none; outline:none; font-size:13px; flex:1 1 120px; min-width:100px;
}
.tag {
	background-color:#eef2ff; color:#3730a3; padding:6px 10px;
	border-radius:12px; font-size:13px; display:flex; align-items:center; gap:6px;
}
.tag.approver { background:#fdeaea; color:#b91c1c; }
.tag .remove-tag { cursor:pointer; font-weight:bold; color:#666; }
</style>
<!-- ✅ 통합 프로젝트 모달 -->
<div class="modal fade" id="projectModal" tabindex="-1"
	aria-labelledby="projectModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-xl" style="max-width:1400px; width:90%;">
		<div class="modal-content"
			style="border:none; border-radius:16px; box-shadow:0 4px 24px rgba(0,0,0,0.15);">

			<!-- 헤더 -->
			<div class="modal-header" style="border:none; padding:24px 32px 10px;">
				<div>
					<h5 id="modalTitle" style="font-weight:700; color:#222;"></h5>
					<p id="modalSubtitle" style="font-size:13px; color:#777;"></p>
				</div>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>

			<!-- 본문 -->
			<div class="modal-body" style="padding:0 32px 32px; min-height:650px; max-height:70vh; overflow-y:auto;">
				<form id="projectForm" method="post" style="display:flex; gap:32px; flex-wrap:wrap;">
					
					<!-- 왼쪽 입력 영역 -->
					<div style="flex:1; display:flex; flex-direction:column; gap:18px; min-width:320px;">
						<input type="hidden" name="projectId">

						<div>
							<label class="form-label fw-semibold">프로젝트 이름</label>
							<input type="text" name="projectName" class="form-control" style="font-size:14px;">
						</div>

						<div>
							<label class="form-label fw-semibold">레포 이름</label>
							<input type="text" name="repoName" class="form-control" style="font-size:14px;">
						</div>

						<div>
							<label class="form-label fw-semibold">레포 소유자 ID</label>
							<input type="text" name="ownerUsername" class="form-control" style="font-size:14px;">
						</div>

						<div>
							<label class="form-label fw-semibold">레포 토큰</label>
							<input type="text" name="repoToken" class="form-control" style="font-size:14px;">
						</div>

						<!-- ✅ 수정모드 전용 -->
						<div id="statusField" style="display:none;">
							<label class="form-label fw-semibold">프로젝트 상태</label>
							<select name="projectStatus" class="form-select" style="font-size:14px;">
								<option value="진행중">진행중</option>
								<option value="완료">완료</option>
								<option value="보류">보류</option>
							</select>
						</div>

						<div>
							<label class="form-label fw-semibold">프로젝트 멤버</label>
							<div class="tag-container" id="memberTags">
								<input type="hidden" name="members">
							</div>
						</div>

						<div>
							<label class="form-label fw-semibold">운영팀 결재자</label>
							<div class="tag-container" id="approverTags">
								<input type="hidden" name="approver">
							</div>
						</div>
					</div>

					<!-- 구분선 -->
					<div style="width:1px; background-color:#e5e7eb; margin:0 24px;"></div>

					<!-- 오른쪽 영역 -->
					<div style="flex:1; min-width:400px; max-height:70vh; overflow-y:auto; padding-right:8px;">
						<label class="form-label fw-semibold">인원 검색 및 추가</label>
						<div class="input-group mb-3">
							<span class="input-group-text bg-white border-end-0">
								<i class="bi bi-search text-muted"></i>
							</span>
							<input type="text" id="searchEname" class="form-control border-start-0"
								onkeydown="if(event.key=='Enter'){event.preventDefault(); searchEmployee();}"
								placeholder="이름 또는 부서로 검색..." style="font-size:14px;">
						</div>

						<div style="background:#fff; border:1px solid #eee; border-radius:10px; padding:10px 15px;">
							<table class="table table-hover align-middle text-center mb-0" style="font-size:14px;">
								<thead style="background-color:#f9fafc; color:#555; font-weight:600;">
									<tr>
										<th>사원번호</th><th>이름</th><th>부서</th><th>직급</th><th>상태</th>
									</tr>
								</thead>
								<tbody id="employeeTableBody"></tbody>
							</table>
						</div>

						<nav aria-label="Page navigation" style="margin-top:15px;">
							<ul id="pagination" class="pagination pagination-sm justify-content-center mb-0"></ul>
						</nav>
					</div>
				</form>
			</div>

			<!-- 하단 버튼 -->
			<div class="modal-footer" style="border:none; padding:16px 32px 28px;">
				<button type="button" class="btn btn-light" data-bs-dismiss="modal"
					style="border:1px solid #ddd; color:#555; border-radius:8px; font-size:14px; padding:8px 20px;">취소</button>
				<button type="submit" form="projectForm" id="modalSubmitBtn" class="btn"
					style="background-color:#4f46e5; color:#fff; border-radius:8px; font-weight:500; font-size:14px; padding:8px 20px;"></button>
			</div>
		</div>
	</div>
</div>

<script>
/* ==================== 모달 제어 ==================== */
function openProjectModal(mode, projectData = null) {
  $("#projectForm")[0].reset();
  $("#memberTags, #approverTags").find(".tag").remove();

  if (mode === "add") {
    $("#projectForm").attr("action", "/bts/project/add");
    $("#modalTitle").text("프로젝트 추가");
    $("#modalSubtitle").text("새 프로젝트를 등록합니다.");
    $("#modalSubmitBtn").text("완료");
    $("#statusField").hide();
  } else {
    $("#projectForm").attr("action", "/bts/project/update");
    $("#modalTitle").text("프로젝트 수정");
    $("#modalSubtitle").text("프로젝트 정보를 수정합니다.");
    $("#modalSubmitBtn").text("저장");
    $("#statusField").show();

    if (projectData) {
      $("input[name='projectId']").val(projectData.id);
      $("input[name='projectName']").val(projectData.projectName);
      $("input[name='repoName']").val(projectData.repoName);
      $("input[name='ownerUsername']").val(projectData.ownerUsername);
      $("select[name='projectStatus']").val(projectData.projectStatus);
    }
  }

  $("#projectModal").modal("show");
  loadEmployeePage(1);
}

/* ==================== 직원 목록 + 검색 ==================== */
function loadEmployeePage(pageNum, ename = "") {
  $.ajax({
    url: "/bts/project/employee",
    type: "GET",
    data: { page: pageNum, ename: ename },
    dataType: "json",
    success: function(data) {
      const tbody = $("#employeeTableBody");
      tbody.empty();

      if (!data.list || data.list.length === 0) {
        tbody.append("<tr><td colspan='5'>검색 결과가 없습니다.</td></tr>");
      } else {
        $.each(data.list, function(i, emp) {
          let addBtn = "";
          if (emp.dept && emp.dept.dname == "개발팀" && emp.job && emp.job.jname == "사원") {
            addBtn = "<button type='button' class='btn btn-outline-primary btn-sm memberBtn' style='border-radius:6px;font-size:13px;'>멤버추가</button>";
          } else if (emp.dept && emp.dept.dname == "운영팀") {
            addBtn = "<button type='button' class='btn btn-outline-danger btn-sm approveBtn' style='border-radius:6px;font-size:13px;'>결재자추가</button>";
          }

          tbody.append("<tr>" +
            "<td>"+emp.empno+"</td><td>"+emp.ename+"</td><td>"+(emp.dept?emp.dept.dname:"-")+"</td><td>"+(emp.job?emp.job.jname:"-")+"</td><td>"+addBtn+"</td></tr>");
        });
      }

      const pagination = $("#pagination");
      pagination.empty();
      const totalPage = data.totalPage || 1;
      const page = data.page || 1;

      pagination.append(`<li class='page-item ${page<=1?"disabled":""}'><a class='page-link' href='#' onclick='loadEmployeePage(${page-1}, "${ename}")'>&lt;</a></li>`);
      for (let i=1;i<=totalPage;i++){
        pagination.append(`<li class='page-item ${i==page?"active":""}'><a class='page-link' href='#' onclick='loadEmployeePage(${i},"${ename}")'>${i}</a></li>`);
      }
      pagination.append(`<li class='page-item ${page>=totalPage?"disabled":""}'><a class='page-link' href='#' onclick='loadEmployeePage(${page+1}, "${ename}")'>&gt;</a></li>`);
    },
    error: function(){ alert("사원 목록 불러오기 실패"); }
  });
}

function searchEmployee(pageNum=1){
  const ename = $("#searchEname").val().trim();
  loadEmployeePage(pageNum, ename);
}

/* ==================== 멤버 / 결재자 태그 ==================== */
$(document).on("click", ".memberBtn", function() {
  const tr = $(this).closest("tr");
  const empno = tr.find("td:eq(0)").text();
  const empName = tr.find("td:eq(1)").text();
  const deptName = tr.find("td:eq(2)").text();
  if ($("#memberTags .tag[data-empno='"+empno+"']").length>0) return;
  $("#memberTags input").before(`<div class='tag' data-empno='${empno}'>${empName} (${deptName}) <span class='remove-tag'>&times;</span></div>`);
});

$(document).on("click", ".approveBtn", function() {
  const tr = $(this).closest("tr");
  const empno = tr.find("td:eq(0)").text();
  const empName = tr.find("td:eq(1)").text();
  const deptName = tr.find("td:eq(2)").text();
  $("#approverTags").html(`<div class='tag approver' data-empno='${empno}'>${empName} (${deptName}) <span class='remove-tag'>&times;</span></div>`);
});

$(document).on("click", ".remove-tag", function(){ $(this).parent().remove(); });
</script>
</body>
</html>