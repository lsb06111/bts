<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<!-- 헤드부분 고정 -->
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
				<h4 style="font-weight: 700; color: #222;">사원 목록</h4>
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
						<tr>
							<td>20230101</td>
							<td>1001</td>
							<td>010-1234-5678</td>
							<td>이동명</td>
							<td>공공사업1 Div</td>
							<td>과장</td>
							<td><span class="badge rounded-pill bg-success"
								style="padding: 6px 10px; font-weight: 500;">재직중</span></td>
						</tr>
						<tr>
							<td>20230102</td>
							<td>1002</td>
							<td>010-2345-6789</td>
							<td>이하빈</td>
							<td>공공사업1 Div</td>
							<td>사원</td>
							<td><span class="badge rounded-pill bg-success"
								style="padding: 6px 10px; font-weight: 500;">재직중</span></td>
						</tr>
						<tr>
							<td>20230109</td>
							<td>1010</td>
							<td>010-9072-3456</td>
							<td>오시현</td>
							<td>전력사업2 Div</td>
							<td>차장</td>
							<td><span class="badge rounded-pill bg-danger"
								style="padding: 6px 10px; font-weight: 500;">퇴사</span></td>
						</tr>
						<tr>
							<td>20230114</td>
							<td>1014</td>
							<td>010-4455-6677</td>
							<td>송현준</td>
							<td>운영팀2</td>
							<td>대리</td>
							<td><span class="badge rounded-pill bg-success"
								style="padding: 6px 10px; font-weight: 500;">재직중</span></td>
						</tr>
						<tr>
							<td>20230115</td>
							<td>1015</td>
							<td>010-5566-7788</td>
							<td>문태준</td>
							<td>운영팀2</td>
							<td>부장</td>
							<td><span class="badge rounded-pill bg-success"
								style="padding: 6px 10px; font-weight: 500;">재직중</span></td>
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
					data-bs-toggle="modal" data-bs-target="#employeeAddModal">
					사원 추가</button>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<%@ include file="/WEB-INF/views/employee/employeeAddModal.jsp"%>
	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->
</body>
</html>