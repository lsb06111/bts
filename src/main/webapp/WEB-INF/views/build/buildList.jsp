<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/jspf/head.jspf" %> <!-- 헤드부분 고정 -->
<style>
  /* 모달 바디 기본 배경만 살짝 톤 맞추기 */
  #buildModalBody {
    background-color:#f9fafb;
  }

  /* 로딩 상태 전체 래퍼 */
  .build-loading-state {
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    gap:16px;
    padding:24px 12px;
    font-family:inherit; /* 콘솔 폰트 말고 일반 폰트 */
  }

  /* 점 세 개 튕기는 스피너 */
  .build-loading-spinner {
    display:flex;
    gap:8px;
    align-items:flex-end;
    justify-content:center;
  }
  .build-loading-spinner span {
    width:10px;
    height:10px;
    border-radius:50%;
    background-color:#4a5eff;
    opacity:0.4;
    animation:build-bounce 0.9s infinite ease-in-out;
  }
  .build-loading-spinner span:nth-child(2) {
    animation-delay:0.15s;
  }
  .build-loading-spinner span:nth-child(3) {
    animation-delay:0.3s;
  }

  @keyframes build-bounce {
    0%, 80%, 100% {
      transform:translateY(0);
      opacity:0.4;
    }
    40% {
      transform:translateY(-6px);
      opacity:1;
    }
  }

  .build-loading-text .title {
    font-weight:600;
    color:#111827;
    font-size:0.95rem;
    text-align:center;
  }
  .build-loading-text .subtitle {
    font-size:0.8rem;
    color:#6b7280;
    text-align:center;
  }

  /* 아랫쪽 슬라이딩 바 */
  .build-loading-progress {
    position:relative;
    width:100%;
    max-width:360px;
    height:4px;
    border-radius:999px;
    background:#e5e7eb;
    overflow:hidden;
  }
  .build-loading-progress .bar {
    position:absolute;
    inset:0;
    width:40%;
    border-radius:inherit;
    background:linear-gradient(90deg,#4a5eff,#9f7aea);
    animation:build-progress 1.3s infinite;
  }

  @keyframes build-progress {
    0%   { transform:translateX(-100%); }
    50%  { transform:translateX(20%); }
    100% { transform:translateX(120%); }
  }
</style>
</head>

<body>
<%@ include file="/WEB-INF/views/jspf/header.jspf" %> <!-- 헤더 네비부분 고정 -->

<%@ include file="/WEB-INF/views/jspf/build/buildList.jspf" %>
          
<%@ include file="/WEB-INF/views/jspf/footer.jspf" %> <!-- 푸터부분 고정 -->    
</body>
</html>
