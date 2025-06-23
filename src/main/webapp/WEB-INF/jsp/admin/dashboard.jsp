<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-100 min-h-screen py-8">
  <div class="container mx-auto max-w-4xl">
    <div class="bg-white rounded-t-lg shadow p-6 mb-8 border-b-4 border-orange-300 flex justify-between items-center">
      <h1 class="text-2xl font-extrabold text-orange-400">관리자 페이지</h1>
    </div>
 <div class="bg-white rounded-lg shadow p-10">
    <div class="flex gap-6 mb-10">
      <a href="/admin/review/list" 
         class="flex-1 bg-gray-100 shadow rounded-lg px-6 py-8 text-gray-700 font-semibold
                flex flex-col items-center space-y-3
                transition-colors duration-300 hover:bg-orange-100 hover:text-orange-600">
        <i class="fas fa-pen-to-square text-orange-400 text-4xl"></i>
        <span class="text-lg">근무 리뷰 관리</span>
      </a>

      <a href="/admin/institution/list" 
         class="flex-1 bg-gray-100 shadow rounded-lg px-6 py-8 text-gray-700 font-semibold
                flex flex-col items-center space-y-3
                transition-colors duration-300 hover:bg-orange-100 hover:text-orange-600">
        <i class="fas fa-school text-orange-400 text-4xl"></i>
        <span class="text-lg">기관 가입 관리</span>
      </a>

      <a href="/usr/article/list?boardId=10" 
         class="flex-1 bg-gray-100 shadow rounded-lg px-6 py-8 text-gray-700 font-semibold
                flex flex-col items-center space-y-3
                transition-colors duration-300 hover:bg-orange-100 hover:text-orange-600">
        <i class="fas fa-bullhorn text-orange-400 text-4xl"></i>
        <span class="text-lg">공지사항 관리</span>
      </a>
   	 </div>
  <div class="container mx-auto max-w-4xl">
    <div class="bg-white border-l-4 border-gray-200 p-6 mb-6">
      <h2 class="text-xl font-bold text-orange-400 mb-4">최근 기관 가입 신청 목록</h2>
      <c:if test="${empty institutionList}">
        <p class="text-gray-500">대기 중인 기관 가입 신청이 없습니다.</p>
      </c:if>
      <c:forEach var="member" items="${institutionList}">
        <div class="border rounded-lg p-4 mb-4 bg-white shadow">
          <p><strong>기관명:</strong> ${member.nickname}</p>
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
       
    <div class="bg-white border-l-4 border-gray-200 p-6 mb-6">
     	 <h2 class="text-xl font-bold  text-orange-400 mb-4">근무 리뷰 관리</h2>
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
			      <a href="/usr/article/detail?id=${review.id}"  class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 ml-4">
					  자세히 보기</a>
			    </div>
			  </div>
			</c:forEach>
    	 </div>
    	 
  	  </div>
  	</div>
  </div>
</section>