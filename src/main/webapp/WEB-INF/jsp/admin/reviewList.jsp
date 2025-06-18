<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-100 min-h-screen py-8">
  <div class="container mx-auto max-w-4xl">
    <div class="bg-white rounded-lg shadow p-6 mb-6">
      <h2 class="text-2xl font-bold text-orange-400 mb-4">근무 리뷰 관리</h2>

      <c:if test="${empty reviews}">
        <p class="text-gray-500">대기 중인 근무 리뷰가 없습니다.</p>
      </c:if>

      <c:forEach var="review" items="${reviews}">
        <div class="border rounded-lg p-4 mb-4 bg-white shadow">
          <p><strong>기관명:</strong> ${article.institutionName}</p>
          <p><strong>한줄평:</strong> ${article.institutionComment}</p>

          <form action="/admin/review/approve" method="post" class="inline-block mr-2">
            <input type="hidden" name="articleId" value="${review.id}" />
            <button class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">승인</button>
          </form>

          <form action="/admin/review/reject" method="post" class="inline-block">
            <input type="hidden" name="articleId" value="${review.id}" />
            <button class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">반려</button>
          </form>
        </div>
      </c:forEach>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
