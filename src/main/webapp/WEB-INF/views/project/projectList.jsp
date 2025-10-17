<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
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
				<h4 style="font-weight: 700; color: #222;">프로젝트 관리</h4>
				<div class="input-group" style="width: 240px;">
					<input type="text" class="form-control" placeholder="검색..."
						style="font-size: 13px; border-right: 0; background-color: #fafafa;">
					<button class="btn btn-outline-light" type="button"
						style="border-left: 0; border-color: #ddd; background-color: #fff;">
						<i class="bi bi-search" style="color: #777;"></i>
					</button>
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
							<th style="width: 10%;">프로젝트명</th>
							<th style="width: 8%;">레포이름</th>
							<th style="width: 13%;">레포 소유자 ID</th>
							<th style="width: 10%;">프로젝트 팀원</th>
							<th style="width: 15%;">프로젝트 상태</th>
							<th style="width: 10%;">삭제</th>
						</tr>
					</thead>
					<tbody style="text-align: center; color: #333;">
						<tr>
							<td>고용보험 이력 통합 조회 서비스 구축</td>
							<td>employment-integration-service</td>
							<td>minjun123</td>
							<td>이하나, 박지훈</td>
							<td><span class="badge rounded-pill bg-secondary"
								style="padding: 6px 10px; font-weight: 500;">진행중</span></td>
							<td>
								<button class="btn btn-light"
									style="border: none; background: transparent; padding: 4px 8px;">
									<i class="bi bi-trash" style="color: #808080; font-size: 16px;"></i>
								</button>
							</td>
						</tr>
						<tr>
							<td>고용24 통합 로그인 시스템 개선</td>
							<td>employ24-login-enhancement</td>
							<td>seo394</td>
							<td>정민수, 최윤정, 임대현</td>
							<td><span class="badge rounded-pill bg-success"
								style="padding: 6px 10px; font-weight: 500;">승인</span></td>
							<td>
								<button class="btn btn-light"
									style="border: none; background: transparent; padding: 4px 8px;">
									<i class="bi bi-trash" style="color: #808080; font-size: 16px;"></i>
								</button>
							</td>
						</tr>
						<tr>
							<td>비급여 항목 관리 시스템 고도화</td>
							<td>nonbenefit-management-upgrade</td>
							<td>dodo3</td>
							<td>강준혁, 윤지아</td>
							<td><span class="badge rounded-pill bg-danger"
								style="padding: 6px 10px; font-weight: 500;">반려</span></td>
							<td>
								<button class="btn btn-light"
									style="border: none; background: transparent; padding: 4px 8px;">
									<i class="bi bi-trash" style="color: #808080; font-size: 16px;"></i>
								</button>
							</td>
						</tr>
						<tr>
							<td>건강검진 이력 통합 조회 시스템 구축</td>
							<td>healthcheck-integration-system</td>
							<td>jihun144</td>
							<td>서예은, 김성진</td>
							<td><span class="badge rounded-pill bg-secondary"
								style="padding: 6px 10px; font-weight: 500;">진행중</span></td>
							<td>
								<button class="btn btn-light"
									style="border: none; background: transparent; padding: 4px 8px;">
									<i class="bi bi-trash" style="color: #808080; font-size: 16px;"></i>
								</button>
							</td>
						</tr>
						<tr>
							<td>모바일 앱 리뉴얼</td>
							<td>mobile-app-renewal</td>
							<td>yujin004</td>
							<td>오현우, 하서연</td>
							<td><span class="badge rounded-pill bg-success"
								style="padding: 6px 10px; font-weight: 500;">승인</span></td>
							<td>
								<button class="btn btn-light"
									style="border: none; background: transparent; padding: 4px 8px;">
									<i class="bi bi-trash" style="color: #808080; font-size: 16px;"></i>
								</button>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- 페이지네이션 -->
				<nav
					style="display: flex; justify-content: center; margin-top: 25px;">
					<ul class="pagination pagination-sm" style="margin: 0;">
						<li class="page-item disabled"><a class="page-link" href="#"
							style="border: none; color: #aaa;">&lt;</a></li>
						<li class="page-item active"><a class="page-link" href="#"
							style="background-color: #4f46e5; border: none;">1</a></li>
						<li class="page-item"><a class="page-link" href="#"
							style="color: #555; border: none;">2</a></li>
						<li class="page-item"><a class="page-link" href="#"
							style="color: #555; border: none;">3</a></li>
						<li class="page-item"><a class="page-link" href="#"
							style="color: #555; border: none;">&gt;</a></li>
					</ul>
				</nav>
			</div>

			<!-- 하단 버튼 -->
			<div
				style="display: flex; justify-content: flex-end; margin-top: 25px;">
				<button type="button" class="btn"
					style="background-color: #4f46e5; color: #fff; font-weight: 500; padding: 10px 24px; border-radius: 8px; font-size: 14px;"
					data-bs-toggle="modal" data-bs-target="#projectAddModal">
					프로젝트 추가</button>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<%@ include file="/WEB-INF/views/project/projectAddModal.jsp"%>
	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->
</body>
</html>