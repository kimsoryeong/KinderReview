<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-100 min-h-screen py-8">
<div class="container mx-auto max-w-4xl">
  <div class="bg-white rounded-t-lg shadow p-6 mb-4 border-b-4 border-orange-300 flex justify-between items-center">
	  <div class="flex items-end gap-2">
	    <span class="text-2xl pr-5 font-bold text-orange-400">기관 가입 신청 목록</span>
	  </div>
	</div>
    <div class="bg-white rounded-lg shadow p-6 mb-6">
      <c:if test="${empty institutionList}">
        <p class="text-gray-500">대기 중인 기관 가입 신청이 없습니다.</p>
      </c:if>

      <c:forEach var="member" items="${institutionList}">
        <div class="border rounded-lg p-4 mb-4 bg-white shadow">
          <p><strong>기관명:</strong> ${member.institutionName}</p>
          <p><strong>사업자등록번호:</strong> ${member.institutionNumber}</p>
            <p><strong>사업자등록증:</strong> 
				<c:choose>
			  <c:when test="${not empty member.workChkFile}">
			    <a href="/usr/member/file/view/${member.workChkFile}" target="_blank">[ 보기 ]</a>
			  </c:when>
			  <c:otherwise>
			    <span class="text-gray-400 text-sm">첨부된 파일이 없습니다</span>
			  </c:otherwise>
			</c:choose>
            </p>
          <div class="flex items-center space-x-2 mt-4">
            <form action="/admin/institution/approve" method="post">
              <input type="hidden" name="memberId" value="${member.id}" />
              <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">
                승인
              </button>
            </form>
            <form action="/admin/institution/reject" method="post" class="flex items-center space-x-2">
              <input type="hidden" name="memberId" value="${member.id}" />
              <input type="text" name="rejectReason" placeholder="반려 사유" required
                     class="border rounded px-2 py-1" />
              <button type="submit" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">
                반려
              </button>
            </form>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>