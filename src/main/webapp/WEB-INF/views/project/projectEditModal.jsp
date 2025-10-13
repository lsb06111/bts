<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 프로젝트 수정 모달 -->
	<div class="modal fade" id="projectEditModal" tabindex="-1"
		aria-labelledby="projectEditModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content"
				style="border: none; border-radius: 16px; box-shadow: 0 4px 24px rgba(0, 0, 0, 0.15);">

				<!-- 헤더 -->
				<div class="modal-header"
					style="border: none; padding: 24px 32px 10px;">
					<div>
						<h5 class="modal-title" id="projectEditModalLabel"
							style="font-weight: 700; color: #222;">프로젝트 수정</h5>
						<p style="font-size: 13px; color: #777;">프로젝트 정보를 수정합니다.</p>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 본문 -->
				<div class="modal-body" style="padding: 0 32px 32px;">
					<form style="display: flex; flex-direction: column; gap: 18px;">
						<div>
							<label class="form-label" style="font-weight: 600;">프로젝트
								이름</label> <input type="text" class="form-control"
								value="고용보험 이력 통합 조회 서비스 구축" style="font-size: 14px;">
						</div>

						<div>
							<label class="form-label" style="font-weight: 600;">레포 이름</label>
							<input type="text" class="form-control"
								value="employment-integration-service" style="font-size: 14px;">
						</div>

						<div>
							<label class="form-label" style="font-weight: 600;">레포
								소유자 ID</label> <input type="text" class="form-control" value="minjun123"
								style="font-size: 14px;">
						</div>

						<div>
							<label class="form-label" style="font-weight: 600;">프로젝트
								상태</label> <select class="form-select" style="font-size: 14px;">
								<option selected>진행중</option>
								<option>승인</option>
								<option>반려</option>
							</select>
						</div>
					</form>
				</div>

				<!-- 하단 버튼 -->
				<div class="modal-footer"
					style="border: none; padding: 16px 32px 28px;">
					<button type="button" class="btn btn-light" data-bs-dismiss="modal"
						style="border: 1px solid #ddd; color: #555; border-radius: 8px; font-size: 14px; padding: 8px 20px;">
						취소</button>
					<button type="button" class="btn"
						style="background-color: #4f46e5; color: #fff; border-radius: 8px; font-weight: 500; font-size: 14px; padding: 8px 20px;">
						저장</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>