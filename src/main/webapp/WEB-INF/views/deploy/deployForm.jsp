<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ include file="/WEB-INF/views/jspf/head.jspf"%>
<!-- 헤드부분 고정 -->

</head>


<body style="background-color: #f7f7fb;">
	<%@ include file="/WEB-INF/views/jspf/header.jspf"%>
	<!-- 헤더 네비부분 고정 -->



	<div class="content-wrapper">
		<div class="container-xxl felx-grow-1 container-p-y">
			<div class="row">
				<div class="col-md-12">

					<div class="d-flex justify-content-between align-item-center mt-4">
						<h3 class="mb-0">배포신청</h3>
						<div>
							<button type="button" class="btn btn-outline-secondary me-2">임시
								저장</button>
							<button type="button" class="btn btn-primary" onclick="">다음</button>
						</div>
					</div>
					<hr>

					<form method="post" name="deployForm"
						action="/bts/deployForm/sumbmitDeployForm">
						<div class="card mb-4">
							<div class="card-body">
								<div>
									<h5 class="mb-2">프로젝트명</h5>
									<select id="projectNameOptions" name="devRepoId"
										class="form-select form-select-lg">
										<c:forEach var="devrepoList" items="${devRepoByUserIdList}">
											<option value="${devrepoList.id }">${devrepoList.projectName }</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>


						<div class="card mb-4">
							<div>
								<div class="card-body">
									<div class="mb-4">
										<h5 class="mb-2">보고서 제목</h5>
										<input type="text" id="title" name="title"
											class="form-control">
									</div>
									<div class="mb-3">
										<h5 class="mb-2">보고서 내용</h5>
										<textarea class="form-control" id="content" name="content"
											rows="14"></textarea>
									</div>
								</div>
							</div>
						</div>
						<button type="submit">asd</button>
					</form>


				</div>
			</div>
		</div>
	</div>


	<%@ include file="/WEB-INF/views/jspf/footer.jspf"%>
	<!-- 푸터부분 고정 -->
	


</body>
</html>
