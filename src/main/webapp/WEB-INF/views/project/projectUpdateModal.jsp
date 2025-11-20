<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.tag-container {
	display: flex;
	flex-wrap: wrap;
	gap: 6px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 8px;
	min-height: 40px;
}

.tag {
	background-color: #eef2ff;
	color: #3730a3;
	padding: 6px 10px;
	border-radius: 12px;
	font-size: 13px;
	display: inline-flex;
	align-items: center;
	gap: 6px;
	white-space: nowrap;
}

.tag.approver {
	background-color: #fdeaea;
	color: #b91c1c !important;
}

.remove-tag {
	cursor: pointer;
	font-weight: bold;
	color: #777;
}

.remove-tag:hover {
	color: #000;
}
</style>
<body>
	<!-- 프로젝트 수정 모달 -->
	<div class="modal fade" id="projectUpdateModal" tabindex="-1"
		aria-labelledby="projectUpdateModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content"
				style="border: none; border-radius: 16px; box-shadow: 0 4px 24px rgba(0, 0, 0, 0.15);">

				<!-- 헤더 -->
				<div class="modal-header"
					style="border: none; padding: 24px 32px 10px;">
					<div>
						<h5 class="modal-title" id="projectUpdateModalLabel"
							style="font-weight: 700; color: #222;">프로젝트 수정</h5>
						<p style="font-size: 13px; color: #777;">프로젝트 정보를 수정합니다.</p>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 본문 -->
				<div class="modal-body" style="padding: 0 32px 32px;">
					<form id="projectUpdateForm" action="/bts/project/update"
						method="post" style="display: flex; gap: 32px; flex-wrap: wrap;">
						<input type="hidden" name="id" id="updateProjectId">
						<!-- 왼쪽 입력 영역 -->
						<div
							style="flex: 1; display: flex; flex-direction: column; gap: 18px; min-width: 320px;">
							<div>
								<label class="form-label fw-semibold">프로젝트 이름</label> <input
									type="text" id="updateProjectName" name="projectName"
									class="form-control" style="font-size: 14px;">
							</div>
							<div>
								<label class="form-label fw-semibold">레포 이름</label> <input
									type="text" id="updateRepoName" name="repoName"
									class="form-control" style="font-size: 14px;">
							</div>
							<div>
								<label class="form-label fw-semibold">레포 소유자 ID</label> <input
									type="text" id="updateOwnerUsername" name="ownerUsername"
									class="form-control" style="font-size: 14px;">
							</div>
							<div>
								<label class="form-label fw-semibold">레포 토큰</label> <input
									type="text" id="updateRepoToken" name="repoToken"
									class="form-control" style="font-size: 14px;">
							</div>
							<div>
								<label class="form-label fw-semibold">프로젝트 멤버</label>
								<div class="tag-container" id="memberTagsUpdate">
									<input type="hidden" id="updateProjectMembers"
										name="memberEmpnos">
								</div>
							</div>
							<div>
								<label class="form-label fw-semibold">운영팀 결재자</label>
								<div class="tag-container" id="approverTagsUpdate">
									<input type="hidden" id="updateApprover" name="approverEmpno">
								</div>
							</div>
						</div>

						<!-- 구분선 -->
						<div
							style="width: 1px; background-color: #e5e7eb; margin: 0 24px;"></div>

						<!-- 오른쪽 인원 검색 영역 -->
						<div
							style="flex: 1; min-width: 400px; max-height: 70vh; overflow-y: auto; padding-right: 8px;">
							<label class="form-label fw-semibold">인원 검색 및 추가</label>
							<div class="input-group mb-3">
								<span class="input-group-text bg-white border-end-0"> <i
									class="bi bi-search text-muted"></i>
								</span> <input type="text" id="searchEnameUpdate"
									class="form-control border-start-0"
									onkeydown="if(event.key=='Enter'){event.preventDefault(); searchEmployeeUpdate();}"
									placeholder="이름 또는 부서로 검색..." style="font-size: 14px;">
							</div>

							<div
								style="background: #fff; border: 1px solid #eee; border-radius: 10px; padding: 10px 15px;">
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
									<tbody id="employeeTableBodyUpdate"></tbody>
								</table>
							</div>
							<nav aria-label="Page navigation" style="margin-top: 15px;">
								<ul id="paginationUpdate"
									class="pagination pagination-sm justify-content-center mb-0"></ul>
							</nav>
						</div>
					</form>
				</div>

				<!-- 하단 버튼 -->
				<div class="modal-footer"
					style="border: none; padding: 16px 32px 28px;">
					<button type="button" class="btn btn-light" data-bs-dismiss="modal"
						style="border: 1px solid #ddd; color: #555; border-radius: 8px; font-size: 14px; padding: 8px 20px;">취소</button>
					<button type="button" class="btn btn-save"
						style="background-color: #4f46e5; color: #fff; border-radius: 8px; font-weight: 500; font-size: 14px; padding: 8px 20px;">
						저장</button>
				</div>
			</div>
		</div>
	</div>

	<script>
	// 모달 열 때
function openUpdateModal(project) {
	console.log("전달 데이터 :"+project);
	console.log("프로젝트이름 :"+project.projectName);
	console.log("프로젝트 멤버들 :"+project.memberNames);
	console.log("프로젝트 멤버들 empnos :"+project.memberEmpnos);
	console.log("결재자 :"+project.approverName);
	
    $("#updateProjectId").val(project.id);
    $("#updateProjectName").val(project.projectName); 
    $("#updateRepoName").val(project.repoName);
    $("#updateOwnerUsername").val(project.ownerUsername);
    $("#updateRepoToken").val(project.repoToken);    
    $('#memberTagsUpdate').find('.tag').remove();
    $('#approverTagsUpdate').empty();
    
    // 멤버들 출력 (LISTAGG 결과를 쉼표로 split)
    if (project.memberNames) {
  const members = project.memberNames.split(',').map(n => n.trim());
  
  const empnos = typeof project.memberEmpnos == 'number' ? [project.memberEmpnos] : project.memberEmpnos.split(',').map(n => n.trim());
  const deptnos = project.memberDeptnos.split(',').map(n => n.trim());
  console.log(deptnos);
  let index = 0;
  members.forEach(name => {
    const $tag = $('<div>').addClass('tag').attr('data-empno', empnos[index]).text(name+" ("+deptnos[index]+")");
    const $remove = $('<span>').addClass('remove-tag').html('&times;');
    $tag.append(' ').append($remove);
    $('#memberTagsUpdate').append($tag);
    index++;
    
  });
}

if (project.approverName) {
  const $tag = $('<div>').addClass('tag approver').text(project.approverName);
  const $remove = $('<span>').addClass('remove-tag').html('&times;');
  $tag.append(' ').append($remove);
  $('#approverTagsUpdate').append($tag);
}
    $("#projectUpdateModal").modal("show");
}

$(document).ready(function() {
    console.log("업데이트 모달 초기 로딩 실행됨");
    loadEmployeePageUpdate(1);
});

$('#projectUpdateModal').on('shown.bs.modal', function () {
    console.log("업데이트 모달 열림, 사원 목록 갱신 실행됨");
    loadEmployeePageUpdate(1);
});

function loadEmployeePageUpdate(pageNum) {
    $.ajax({
        url: "/bts/project/employee",
        type: "GET",
        data: { page: pageNum },
        dataType: "json",
        success: function(data) {
        	 console.log("loadEmployeePageUpdate 응답 도착", data);
            const tbody = $("#employeeTableBodyUpdate");
            tbody.empty();

            $.each(data.list, function(i, emp) {
                let addBtn = "";
                if (emp.dept && emp.dept.dname == "개발팀" && emp.job && emp.job.jname == "팀원") {
                    addBtn = "<button type='button' class='btn btn-outline-primary btn-sm memberBtnUpdate'>멤버추가</button>";
                } else if (emp.dept && emp.dept.dname == "운영팀") {
                    addBtn = "<button type='button' class='btn btn-outline-danger btn-sm approveBtnUpdate'>결재자추가</button>";
                }
                tbody.append(
                    "<tr><td>"+emp.empno+"</td><td>"+emp.ename+"</td><td>"+(emp.dept?emp.dept.dname:"-")+"</td><td>"+(emp.job?emp.job.jname:"-")+"</td><td>"+addBtn+"</td></tr>"
                );
            });

            // 페이지네이션
            const pagination = $("#paginationUpdate");
            pagination.empty();
            const page = data.page || 1;
            const totalPage = data.totalPage || 1;

            pagination.append(`<li class='page-item \${page<=1?"disabled":""}'><a class='page-link' href='#' onclick='loadEmployeePageUpdate(\${page-1})'>&lt;</a></li>`);
            for(let i=1;i<=totalPage;i++){
                pagination.append(`<li class='page-item \${i==page?"active":""}'><a class='page-link' href='#' onclick='loadEmployeePageUpdate(\${i})'>\${i}</a></li>`);
            }
            pagination.append(`<li class='page-item \${page>=totalPage?"disabled":""}'><a class='page-link' href='#' onclick='loadEmployeePageUpdate(\${page+1})'>&gt;</a></li>`);
        }
    });
}

function searchEmployeeUpdate(pageNum = 1) {
    const ename = $("#searchEnameUpdate").val().trim();
    if (ename == "") {
        loadEmployeePageUpdate(1);
        return;
    }

    $.ajax({
        url: "/bts/project/employee",
        type: "GET",
        data: { page: pageNum, ename: ename },
        dataType: "json",
        success: function(data) {
            const tbody = $("#employeeTableBodyUpdate");
            tbody.empty();

            if (!data.list || data.list.length == 0) {
                tbody.append("<tr><td colspan='5'>검색 결과가 없습니다.</td></tr>");
            } else {
                $.each(data.list, function(i, emp) {
                    let addBtn = "";
                    if (emp.dept && emp.dept.dname == "개발팀" && emp.job && emp.job.jname == "팀원") {
                        addBtn = "<button type='button' class='btn btn-outline-primary btn-sm memberBtnUpdate'>멤버추가</button>";
                    } else if (emp.dept && emp.dept.dname == "운영팀") {
                        addBtn = "<button type='button' class='btn btn-outline-danger btn-sm approveBtnUpdate'>결재자추가</button>";
                    }
                    tbody.append("<tr><td>"+emp.empno+"</td><td>"+emp.ename+"</td><td>"+(emp.dept?emp.dept.dname:"-")+"</td><td>"+(emp.job?emp.job.jname:"-")+"</td><td>"+addBtn+"</td></tr>");
                });
            }const pagination = $("#paginationUpdate");
            pagination.empty();
            const page = data.page || 1;
            const totalPage = data.totalPage || 1;

            pagination.append(`<li class='page-item \${page<=1?"disabled":""}'><a class='page-link' href='#' onclick='loadEmployeePageUpdate(\${page-1})'>&lt;</a></li>`);
            for(let i=1;i<=totalPage;i++){
                pagination.append(`<li class='page-item \${i==page?"active":""}'><a class='page-link' href='#' onclick='loadEmployeePageUpdate(\${i})'>\${i}</a></li>`);
            }
            pagination.append(`<li class='page-item \${page>=totalPage?"disabled":""}'><a class='page-link' href='#' onclick='loadEmployeePageUpdate(\${page+1})'>&gt;</a></li>`);
        }
    });
}

$(document).on("click", ".memberBtnUpdate", function() {
	console.log("clcickckckckdkckdckdkckkd")
    const tr = $(this).closest("tr");
    const empno = tr.find("td:eq(0)").text();
    const empName = tr.find("td:eq(1)").text();
    const deptName = tr.find("td:eq(2)").text();
    if ($("#memberTagsUpdate .tag[data-empno='"+empno+"']").length > 0) return;

    console.log(empno, empName, deptName);
    const tag = "<div class='tag' data-empno='"+empno+"'>"+empName+" ("+deptName+") <span class='remove-tag'>&times;</span></div>";
    $("#memberTagsUpdate input").before(tag);
});

$(document).on("click", ".approveBtnUpdate", function() {
    const tr = $(this).closest("tr");
    const empno = tr.find("td:eq(0)").text();
    const empName = tr.find("td:eq(1)").text();
    const deptName = tr.find("td:eq(2)").text();

    const tag = "<div class='tag approver' data-empno='"+empno+"'>"+empName+" ("+deptName+") <span class='remove-tag'>&times;</span></div>";
    $("#approverTagsUpdate").html(tag);
});

$(document).on("click", ".remove-tag", function() {
    $(this).parent().remove();
});

$('#projectUpdateModal').on('shown.bs.modal', function () {
    loadEmployeePageUpdate(1);
});

//저장 버튼 클릭 이벤트
$(document).on("click", "#projectUpdateModal .btn-save", function() {
    const modal = $("#projectUpdateModal");
    const formData = {
        id: $("#updateProjectId").val(),
        projectName: modal.find("input[name='projectName']").val().trim(),
        repoName: modal.find("input[name='repoName']").val().trim(),
        ownerUsername: modal.find("input[name='ownerUsername']").val().trim(),
        repoToken: modal.find("input[name='repoToken']").val().trim(),
        currentStage: "진행중"
    };

    const memberEmpnos = modal.find("#memberTagsUpdate .tag").map(function() {
        return $(this).data("empno");
    }).get();

    const approverEmpno = modal.find("#approverTagsUpdate .approver").data("empno") || null;

    console.log("formData:", formData);
    console.log("memberEmpnos:", memberEmpnos, "approverEmpno:", approverEmpno);

    $.ajax({
        url: "/bts/project/update",
        type: "POST",
        traditional: true,
        data: {
            id: formData.id,
            projectName: formData.projectName,
            repoName: formData.repoName,
            ownerUsername: formData.ownerUsername,
            repoToken: formData.repoToken,
            memberEmpnos: memberEmpnos,
            approverEmpno: approverEmpno
        },
        success: function() {
            alert("프로젝트가 성공적으로 수정되었습니다!");
            $("#projectUpdateModal").modal("hide");
            location.reload();
        },
        error: function() {
            alert("프로젝트 수정 중 오류가 발생했습니다.");
        }
    });
});
</script>
</body>
</html>