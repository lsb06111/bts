<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 사원 추가 모달 -->
	<div class="modal fade" id="employeeAddModal" tabindex="-1"
		aria-labelledby="employeeAddModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content"
				style="border-radius: 16px; border: none; box-shadow: 0 4px 24px rgba(0, 0, 0, 0.15);">

				<!-- 헤더 -->
				<div class="modal-header"
					style="border: none; padding: 24px 24px 10px;">
					<div>
						<h5 class="modal-title" id="employeeAddModalLabel"
							style="font-weight: 700; color: #222;">사원 추가</h5>
						<p style="font-size: 13px; color: #777; margin-top: 6px;">새로운
							직원의 정보를 입력하여 목록에 추가합니다.</p>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<!-- 본문 -->
				<div class="modal-body" style="padding: 0 24px 24px;">
					<form>
						<div class="row g-3">
							<div class="col-md-6">
								<label class="form-label" style="font-weight: 600;">사원번호</label>
								<input type="text" class="form-control" placeholder="예: 2023001"
									style="font-size: 14px;">
							</div>
							<div class="col-md-6">
								<label class="form-label" style="font-weight: 600;">내선번호</label>
								<input type="text" class="form-control" placeholder="예: 1001"
									style="font-size: 14px;">
							</div>

							<div class="col-md-6">
								<label class="form-label" style="font-weight: 600;">휴대전화</label>
								<input type="text" class="form-control"
									placeholder="예: 010-1234-5678" style="font-size: 14px;">
							</div>
							<div class="col-md-6">
								<label class="form-label" style="font-weight: 600;">이름</label> <input
									type="text" class="form-control" placeholder="예: 홍길동"
									style="font-size: 14px;">
							</div>

							<div class="col-md-6">
								<label class="form-label" style="font-weight: 600;">부서</label> <select
									class="form-select" style="font-size: 14px;">
									<option selected>공공사업1 Div</option>
									<option>공공사업2 Div</option>
									<option>공공사업3 Div</option>
									<option>공공사업4 Div</option>
									<option>전력사업1 Div</option>
									<option>전력사업2 Div</option>
								</select>
							</div>

							<div class="col-md-3">
								<label class="form-label" style="font-weight: 600;">직위</label> <select
									class="form-select" style="font-size: 14px;">
									<option selected>사원</option>
									<option>주임</option>
									<option>대리</option>
									<option>과장</option>
									<option>차장</option>
									<option>부장</option>
								</select>
							</div>

							<div class="col-md-3">
								<label class="form-label" style="font-weight: 600;">상태</label> <select
									class="form-select" style="font-size: 14px;">
									<option selected>재직중</option>
									<option>휴직</option>
									<option>퇴직</option>
								</select>
							</div>
						</div>
					</form>
					
					<!-- <form style="display:flex; flex-direction:column; gap:14px;">
  <div>
    <label class="form-label" style="font-weight:600;">사원번호</label>
    <input type="text" class="form-control" placeholder="예: 2023001" style="font-size:14px;">
  </div>

  <div>
    <label class="form-label" style="font-weight:600;">내선번호</label>
    <input type="text" class="form-control" placeholder="예: 1001" style="font-size:14px;">
  </div>

  <div>
    <label class="form-label" style="font-weight:600;">휴대전화</label>
    <input type="text" class="form-control" placeholder="예: 010-1234-5678" style="font-size:14px;">
  </div>

  <div>
    <label class="form-label" style="font-weight:600;">이름</label>
    <input type="text" class="form-control" placeholder="예: 홍길동" style="font-size:14px;">
  </div>

  <div>
    <label class="form-label" style="font-weight:600;">부서</label>
    <select class="form-select" style="font-size:14px;">
      <option selected>공공사업1 Div</option>
      <option>공공사업2 Div</option>
      <option>공공사업3 Div</option>
      <option>전력사업1 Div</option>
      <option>전력사업2 Div</option>
    </select>
  </div>

  <div>
    <label class="form-label" style="font-weight:600;">직위</label>
    <select class="form-select" style="font-size:14px;">
      <option selected>사원</option>
      <option>주임</option>
      <option>대리</option>
      <option>과장</option>
      <option>차장</option>
      <option>부장</option>
    </select>
  </div>

  <div>
    <label class="form-label" style="font-weight:600;">상태</label>
    <select class="form-select" style="font-size:14px;">
      <option selected>재직중</option>
      <option>휴직</option>
      <option>퇴직</option>
    </select>
  </div>
</form> -->
				</div>

				<!-- 하단 버튼 -->
				<div class="modal-footer"
					style="border: none; padding: 16px 24px 24px;">
					<button type="button" class="btn btn-light" data-bs-dismiss="modal"
						style="border: 1px solid #ddd; color: #555; border-radius: 8px; font-size: 14px; padding: 8px 20px;">
						취소</button>
					<button type="button" class="btn"
						style="background-color: #4f46e5; color: #fff; border-radius: 8px; font-weight: 500; font-size: 14px; padding: 8px 20px;">
						추가</button>
				</div>

			</div>
		</div>
	</div>
</body>
</html>