<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-100 min-h-screen py-8">
<div class="container mx-auto max-w-4xl">
  <div class="bg-white rounded-t-lg shadow p-6 mb-4 border-b-4 border-orange-300 flex justify-between items-center">
	  <div class="flex items-end gap-2">
	    <span class="text-2xl pr-5 font-bold text-orange-400">근무 리뷰 관리</span>
	  </div>
	</div>
    <div class="bg-white rounded-lg shadow p-6 mb-6">
      <c:if test="${empty reviews}">
        <p class="text-gray-500">대기 중인 근무 리뷰가 없습니다.</p>
      </c:if>
		<c:forEach var="review" items="${reviews}">
		  <div class="border rounded-lg p-4 mb-4 bg-white shadow flex justify-between items-center">
		    <div>
		      <p><strong>기관명 :</strong> ${review.institutionName}</p>
		      <p><strong>한줄평 :</strong> ${review.institutionComment}</p>
		    </div>
		
		    <div class="flex items-center space-x-2">
		      <form action="/admin/review/approve" method="post">
		        <input type="hidden" name="id" value="${review.id}" />
		        <button class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">승인</button>
		      </form>
		
		      <form action="/admin/review/reject" method="post" class="flex items-center">
		        <input type="hidden" name="id" value="${review.id}" />
		        <input type="text" name="rejectReason" placeholder="반려 사유" required
		               class="border rounded px-2 py-1 mr-2" />
		        <button type="submit" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">반려</button>
		      </form>
		
		      <a href="/usr/article/detail?id=${review.id}" 
				   class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 ml-4">
				  자세히 보기
				</a>
		
		    </div>
		  </div>
		</c:forEach>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>