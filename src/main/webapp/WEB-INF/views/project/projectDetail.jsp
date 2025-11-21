<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="modal fade" id="projectDetailModal" tabindex="-1" 
     aria-labelledby="projectDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl" 
         style="max-width: 1400px; width: 90%;">
        <div class="modal-content" 
             style="border: none; border-radius: 16px; box-shadow: 0 4px 24px rgba(0,0,0,0.15);">

            <!-- 헤더 -->
            <div class="modal-header"
                 style="border: none; padding: 24px 32px 10px;">
                <div>
                    <h5 class="modal-title" id="projectDetailModalLabel" 
                        style="font-weight: 700; color: #222;">프로젝트 상세 정보</h5>
                    <p style="font-size: 13px; color: #777;">해당 프로젝트의 전체 정보를 확인할 수 있습니다.</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- 본문 -->
            <div class="modal-body" style="padding: 0 32px 32px;">
                <div style="display: flex; flex-direction: column; gap: 18px; min-width: 320px;">

                    <div>
                        <label class="form-label fw-semibold">프로젝트 이름</label>
                        <p class="form-control-plaintext" id="detailProjectName"></p>
                    </div>

                    <div>
                        <label class="form-label fw-semibold">레포 이름</label>
                        <p class="form-control-plaintext" id="detailRepoName"></p>
                    </div>

                    <div>
                        <label class="form-label fw-semibold">레포 소유자 ID</label>
                        <p class="form-control-plaintext" id="detailOwnerUsername"></p>
                    </div>

                    <div>
                        <label class="form-label fw-semibold">레포 토큰</label>
                        <p class="form-control-plaintext" id="detailRepoToken"></p>
                    </div>

                    <div>
                        <label class="form-label fw-semibold">프로젝트 상태</label>
                        <p class="form-control-plaintext" id="detailCurrentStage"></p>
                    </div>

                    <div>
                        <label class="form-label fw-semibold">프로젝트 멤버</label>
                        <div class="tag-container" id="detailMemberTags"></div>
                    </div>

                    <div>
                        <label class="form-label fw-semibold">운영팀 결재자</label>
                        <div class="tag-container" id="detailApproverTags"></div>
                    </div>

                </div>
            </div>

            <!-- 하단 버튼 -->
            <div class="modal-footer"
                 style="border: none; padding: 16px 32px 28px;">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal"
                        style="border: 1px solid #ddd; color: #555; border-radius: 8px; 
                        font-size: 14px; padding: 8px 20px;">닫기</button>
            </div>

        </div>
    </div>
</div>
<script>
function openDetailModal(project) {
    $("#detailProjectName").text(project.projectName);
    $("#detailRepoName").text(project.repoName);
    $("#detailOwnerUsername").text(project.ownerUsername);
    $("#detailRepoToken").text(project.repoToken);
    $("#detailCurrentStage").text(project.currentStage);

    // 멤버
    $("#detailMemberTags").empty();
    if (project.memberNames) {
        const names = project.memberNames.split(',').map(s => s.trim());
        const dept = project.memberDeptnos.split(',').map(s => s.trim());
        const empnos = project.memberEmpnos.split(',').map(s => s.trim());

        names.forEach((name, idx) => {
            $("#detailMemberTags").append(
                `<div class='tag' data-empno='${empnos[idx]}'>
                    ${name} (${dept[idx]})
                </div>`
            );
        });
    }

    // 결재자
    $("#detailApproverTags").empty();
    if (project.approverName) {
        $("#detailApproverTags").append(
            `<div class='tag approver'>${project.approverName}</div>`
        );
    }

    $("#projectDetailModal").modal("show");
}

</script>
</body>
</html>