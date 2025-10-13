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
		<div class="modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content"
				style="border: none; border-radius: 16px; box-shadow: 0 4px 24px rgba(0, 0, 0, 0.15);">

				<!-- 헤더 -->
				<div class="modal-header"
					style="border: none; padding: 24px 32px 10px;">
					<div>
						<h5 class="modal-title" id="projectAddModalLabel"
							style="font-weight: 700; color: #222;">프로젝트 추가</h5>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 본문 -->
				<div class="modal-body" style="padding: 0 32px 32px;">
					<form style="display: flex; flex-direction: column; gap: 18px;">

						<!-- 프로젝트 이름 -->
						<div>
							<label class="form-label" style="font-weight: 600;">프로젝트
								이름</label> <input type="text" class="form-control"
								placeholder="예: 고용24 통합 로그인 시스템 개선" style="font-size: 14px;">
						</div>

						<!-- 레포 이름 -->
						<div>
							<label class="form-label" style="font-weight: 600;">레포 이름</label>
							<input type="text" class="form-control"
								placeholder="예: employ24-login-enhancement"
								style="font-size: 14px;">
						</div>

						<!-- 레포 소유자 ID -->
						<div>
							<label class="form-label" style="font-weight: 600;">레포
								소유자 ID</label> <input type="text" class="form-control"
								placeholder="예: github_user_kim" style="font-size: 14px;">
						</div>

						<!-- 레포 토큰 -->
						<div>
							<label class="form-label" style="font-weight: 600;">레포 토큰</label>
							<input type="password" class="form-control"
								placeholder="예: ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
								style="font-size: 14px;">
						</div>

						<!-- 프로젝트 멤버 -->
						<div>
							<label class="form-label" style="font-weight: 600;">프로젝트
								멤버</label> <input type="text" class="form-control"
								placeholder="예: 김지아 (공공사업1 Div), 박지수 (전략사업2 Div)"
								style="font-size: 14px;">
						</div>

						<!-- 운영팀 결재자 -->
						<div>
							<label class="form-label" style="font-weight: 600;">운영팀
								결재자</label> <input type="text" class="form-control"
								placeholder="예: 이준호 (운영팀2)" style="font-size: 14px;">
						</div>

						<!-- 인원 검색 및 추가 -->
						<div style="margin-top: 10px;">
							<label class="form-label" style="font-weight: 600;">인원 검색
								및 추가</label>
							<div class="input-group"
								style="margin-bottom: 15px; width: 100%;">
								<span class="input-group-text"
									style="background-color: #fff; border-right: 0;"> <i
									class="bi bi-search" style="color: #777;"></i>
								</span> <input type="text" class="form-control"
									placeholder="이름 또는 부서로 검색..."
									style="font-size: 14px; border-left: 0;">
							</div>

							<!-- 인원 목록 테이블 -->
							<div
								style="background-color: #fff; border: 1px solid #eee; border-radius: 10px; padding: 10px 15px;">
								<table class="table table-hover align-middle"
									style="margin-bottom: 0; font-size: 14px; text-align: center;">
									<tr
										style="background-color: #f9fafc; color: #555; font-weight: 600;">
										<th>부서번호</th>
										<th>이름</th>
										<th>부서</th>
										<th>직급</th>
										<th>상태</th>
									</tr>
									<tr>
										<td>OTEXA210</td>
										<td>박지현</td>
										<td>공공사업1 Div</td>
										<td>사원</td>
										<td>
											<button class="btn btn-outline-primary btn-sm"
												style="border-radius: 6px; font-size: 13px;">멤버추가</button>
										</td>
									</tr>
									<tr>
										<td>OTEXA013</td>
										<td>이준호</td>
										<td>운영팀2</td>
										<td>과장</td>
										<td>
											<button class="btn btn-outline-danger btn-sm"
												style="border-radius: 6px; font-size: 13px;">결재자추가</button>
										</td>
									</tr>
									<tr>
										<td>OTEXA230</td>
										<td>이수빈</td>
										<td>공공사업2 Div</td>
										<td>사원</td>
										<td>
											<button class="btn btn-outline-primary btn-sm"
												style="border-radius: 6px; font-size: 13px;">멤버추가</button>
										</td>
									</tr>
									<tr>
										<td>OTEXA312</td>
										<td>최예나</td>
										<td>운영팀1</td>
										<td>대리</td>
										<td>
											<button class="btn btn-outline-danger btn-sm"
												style="border-radius: 6px; font-size: 13px;">결재자추가</button>
										</td>
									</tr>
									<tr>
										<td>OTEXA122</td>
										<td>장종현</td>
										<td>공공사업3 Div</td>
										<td>사원</td>
										<td>
											<button class="btn btn-outline-primary btn-sm"
												style="border-radius: 6px; font-size: 13px;">멤버추가</button>
										</td>
									</tr>
								</table>
							</div>
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
						완료</button>
				</div>

			</div>
		</div>
	</div>
</body>
</html>