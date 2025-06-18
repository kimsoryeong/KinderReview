<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-100 min-h-screen py-8">
  <div class="container mx-auto max-w-4xl">
    <div class="bg-white rounded-lg shadow p-6 mb-6">
      <h2 class="text-2xl font-bold text-orange-400 mb-4">기관 가입 신청 목록</h2>

      <c:if test="${empty institutionList}">
        <p class="text-gray-500">대기 중인 기관 가입 신청이 없습니다.</p>
      </c:if>

      <c:forEach var="member" items="${institutionList}">
        <div class="border rounded-lg p-4 mb-4 bg-white shadow">
          <p><strong>기관명:</strong> ${member.institutionName}</p>
          <p><strong>사업자등록번호:</strong> ${member.institutionNumber}</p>

          <c:if test="${not empty member.workChkFile}">
            <p><strong>파일:</strong> <a class="text-blue-500 underline" href="${member.workChkFile}" target="_blank">확인하기</a></p>
          </c:if>

          <form action="/admin/institution/approve" method="post" class="inline-block mr-2">
            <input type="hidden" name="memberId" value="${member.id}" />
            <button class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">승인</button>
          </form>

          <form action="/admin/institution/reject" method="post" class="inline-block">
            <input type="hidden" name="memberId" value="${member.id}" />
            <button class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">반려</button>
          </form>
        </div>
      </c:forEach>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
