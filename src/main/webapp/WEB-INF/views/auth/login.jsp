<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body
	style="background-color: #f7f7fb; font-family: 'Noto Sans KR', sans-serif;">
	<!-- 중앙 정렬 전체 컨테이너 -->
	<div
		style="display: flex; justify-content: center; align-items: center; height: 100vh;">

		<!-- 로그인 카드 -->
		<div
			style="width: 380px; background-color: #fff; border-radius: 12px; box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06); padding: 40px 36px;">

			<!-- 로고 -->
			<div style="text-align: center; margin-bottom: 22px;">
				<i class="bi bi-infinity" style="color: #4f46e5; font-size: 36px;"></i>
				<div
					style="font-size: 20px; font-weight: 700; color: #222; margin-top: 8px;">BTS</div>
			</div>

			<!-- 안내문 -->
			<p
				style="text-align: center; font-size: 14px; color: #555; margin-bottom: 26px;">
				계정으로 로그인하여 시스템을 이용하세요.</p>

			<!-- 로그인 폼 -->
			<form action="${pageContext.request.contextPath}/auth/login"
				method="post"
				style="display: flex; flex-direction: column; gap: 16px;">

				<!-- 사원번호 -->
				<div>
					<c:if test="${not empty errorEmail}">
						<div class="alert alert-danger text-center" role="alert"
							style="margin-bottom: 10px; padding: 6px 0; font-size: 13px; border-radius: 6px;">
							${errorEmail}</div>
					</c:if>
					<c:if test="${not empty errorNotUser}">
						<div class="alert alert-danger text-center" role="alert"
							style="margin-bottom: 10px; padding: 6px 0; font-size: 13px; border-radius: 6px;">
							${errorNotUser}</div>
					</c:if>
					<c:if test="${not empty errorPassword}">
						<div class="alert alert-danger text-center" role="alert"
							style="margin-bottom: 10px; padding: 6px 0; font-size: 13px; border-radius: 6px;">
							${errorPassword}</div>
					</c:if>
					<label class="form-label"
						style="font-weight: 600; font-size: 13px; color: #333;">사원번호</label>
					<input type="text" name="email" class="form-control"
						placeholder="사원번호를 입력하세요."
						style="font-size: 14px; padding: 10px 12px; border-radius: 8px; border: 1px solid #ddd; background-color: #f8f9fa;">
				</div>

				<!-- 비밀번호 -->
				<div>
					<div
						style="display: flex; justify-content: space-between; align-items: center;">
						<label class="form-label"
							style="font-weight: 600; font-size: 13px; color: #333;">비밀번호</label>
						<a href="#"
							style="font-size: 13px; color: #4f46e5; text-decoration: none;">비밀번호를
							잊으셨나요?</a>
					</div>

					<div class="input-group">
						<input type="password" name="password" id="password"
							class="form-control" placeholder="********"
							style="font-size: 14px; padding: 10px 12px; border-radius: 8px 0 0 8px; border: 1px solid #ddd; background-color: #f8f9fa;">
						<button type="button" class="btn btn-outline-light"
							id="togglePassword"
							style="border: 1px solid #ddd; border-left: none; border-radius: 0 8px 8px 0;">
							<i class="bi bi-eye-slash" id="eyeIcon" style="color: #888;"></i>
						</button>
					</div>
				</div>

				<!-- 로그인 정보 저장 -->
				<div class="form-check" style="margin-top: -4px;">
					<input class="form-check-input" type="checkbox" id="rememberMe"
						style="border-color: #aaa; width: 14px; height: 14px;"> <label
						class="form-check-label" for="rememberMe"
						style="font-size: 13px; color: #555;"> 로그인 정보 저장 </label>
				</div>

				<!-- 로그인 버튼 -->
				<button type="submit" class="btn"
					style="background-color: #4f46e5; color: #fff; font-weight: 600; font-size: 15px; padding: 10px 0; border-radius: 8px; margin-top: 8px;">
					로그인</button>
			</form>

		</div>
	</div>

	<!-- 비밀번호 보기 토글 -->
	<script>
    const togglePassword = document.getElementById('togglePassword');
    const passwordField = document.getElementById('password');
    const eyeIcon = document.getElementById('eyeIcon');

    togglePassword.addEventListener('click', () => {
      const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
      passwordField.setAttribute('type', type);
      eyeIcon.classList.toggle('bi-eye');
      eyeIcon.classList.toggle('bi-eye-slash');
    });
  </script>

</body>
</html>