<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
					<form action="/project/add" method="post"
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
									type="password" name="repoToken" class="form-control"
									placeholder="예: ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
									style="font-size: 14px;">
							</div>

							<div>
								<label class="form-label fw-semibold">프로젝트 멤버</label> <input
									type="text" name="members" class="form-control"
									placeholder="예: 김지아 (공공사업1 Div), 박지수 (전략사업2 Div)"
									style="font-size: 14px;">
							</div>

							<div>
								<label class="form-label fw-semibold">운영팀 결재자</label> <input
									type="text" name="approver" class="form-control"
									placeholder="예: 이준호 (운영팀2)" style="font-size: 14px;">
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
											<th>부서번호</th>
											<th>이름</th>
											<th>부서</th>
											<th>직급</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>OTEXA210</td>
											<td>박지현</td>
											<td>공공사업1 Div</td>
											<td>사원</td>
											<td>
												<button type="button" class="btn btn-outline-primary btn-sm"
													style="border-radius: 6px; font-size: 13px;">멤버추가</button>
											</td>
										</tr>
										<tr>
											<td>OTEXA013</td>
											<td>이준호</td>
											<td>운영팀2</td>
											<td>과장</td>
											<td>
												<button type="button" class="btn btn-outline-danger btn-sm"
													style="border-radius: 6px; font-size: 13px;">결재자추가</button>
											</td>
										</tr>
										<tr>
											<td>OTEXA230</td>
											<td>이수빈</td>
											<td>공공사업2 Div</td>
											<td>사원</td>
											<td>
												<button type="button" class="btn btn-outline-primary btn-sm"
													style="border-radius: 6px; font-size: 13px;">멤버추가</button>
											</td>
										</tr>
										<tr>
											<td>OTEXA312</td>
											<td>최예나</td>
											<td>운영팀1</td>
											<td>대리</td>
											<td>
												<button type="button" class="btn btn-outline-danger btn-sm"
													style="border-radius: 6px; font-size: 13px;">결재자추가</button>
											</td>
										</tr>
										<tr>
											<td>OTEXA122</td>
											<td>장종현</td>
											<td>공공사업3 Div</td>
											<td>사원</td>
											<td>
												<button type="button" class="btn btn-outline-primary btn-sm"
													style="border-radius: 6px; font-size: 13px;">멤버추가</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- ✅ 여기 아래에 페이지네이션 추가 -->
							<nav aria-label="Page navigation" style="margin-top: 15px;">
								<ul class="pagination pagination-sm justify-content-center mb-0">
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
					<button type="submit" form="projectAddModal" class="btn"
						style="background-color: #4f46e5; color: #fff; border-radius: 8px; font-weight: 500; font-size: 14px; padding: 8px 20px;">
						완료</button>
				</div>

			</div>
		</div>
	</div>
</body>
</html>