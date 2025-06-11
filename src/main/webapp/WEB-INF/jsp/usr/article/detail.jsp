<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="상세보기" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<section class="bg-gray-50 py-10 min-h-screen">
  <div class="container mx-auto max-w-5xl">
    <div class="bg-white rounded-t-lg shadow-sm p-6 mb-1 border border-red-500">
      <div class="flex justify-between items-center">
        <div class="text-2xl font-bold text-orange-400">${board.boardName} 후기 </div>
      </div>
    </div>
      <div class="w-5/5">
        <div class="bg-white rounded-2xl shadow-xl p-8 space-y-6">
          <div class="flex items-center gap-4 border-b pb-4">
            <i class="fa-solid sl fa-2xl text-orange-400"></i>
            <span class="font-bold text-2xl text-gray-800">${article.institutionName}</span>
            <span class="text-yellow-500 font-bold text-xl flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-1" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/></svg>
              ${article.star}
            </span>
          </div>
          <div class="flex justify-between text-sm text-gray-500">
            <div>
              <span class="mr-2">번호: <b>${article.getId()}</b></span>
              <span class="mr-2">작성일: ${article.getRegDate().substring(2, 16)}</span>
              <span class="mr-2">수정일: ${article.getUpdateDate().substring(2, 16)}</span>
            </div>
          </div>
          <div class="bg-gray-50 rounded-lg p-4 text-gray-700">
            <div class="mb-2">
              <span class="font-bold">근무형태:</span> ${article.workType}
              <span class="mx-2">|</span>
              <span class="font-bold">지역:</span> ${article.city}
              <span class="mx-2">|</span>
              <span class="font-bold">기관 종류:</span> ${article.institutionType}
            </div>
          </div>
          <div class="text-center">
            <div class="bg-white rounded-lg shadow p-3">
              <span class="block text-gray-500 text-sm">급여</span>
              <span class="text-yellow-500 font-bold text-xl">★ ${article.salaryScore}</span>
	            <div>
	              <h4 class="font-bold text-orange-500 mb-2">급여</h4>
	              <div class="mb-2">
	                <span class="font-semibold text-gray-700">지원:</span>
	                <c:forEach var="opt" items="${article.salaryOptions}">
	                  <span class="inline-block bg-orange-100 text-orange-700 rounded px-2 py-1 mr-1 mb-1">${opt}</span>
	                </c:forEach>
	              </div>
	              <div class="mb-2">
	                <span class="font-semibold text-gray-700">코멘트:</span>
	                <span class="block text-gray-600">${article.salaryComment}</span>
	              </div>
	            </div>
            </div>
            <div class="bg-white rounded-lg shadow p-3">
              <span class="block text-gray-500 text-sm">복지</span>
              <span class="text-yellow-500 font-bold text-xl">★ ${article.welfareScore}</span>
            </div>
            <div class="bg-white rounded-lg shadow p-3">
              <span class="block text-gray-500 text-sm">근무환경</span>
              <span class="text-yellow-500 font-bold text-xl">★ ${article.environmentScore}</span>
            </div>
          </div>
          <div class="mt-4">
            <div>
              <h4 class="font-bold text-orange-500 mb-2">복지</h4>
              <div class="mb-2">
                <span class="font-semibold text-gray-700">특징:</span>
                <c:forEach var="opt" items="${article.welfareOptions}">
                  <span class="inline-block bg-orange-100 text-orange-700 rounded px-2 py-1 mr-1 mb-1">${opt}</span>
                </c:forEach>
              </div>
              <div class="mb-2">
                <span class="font-semibold text-gray-700">코멘트:</span>
                <span class="block text-gray-600">${article.welfareComment}</span>
              </div>
            </div>
            <div>
              <h4 class="font-bold text-orange-500 mb-2">근무환경</h4>
              <div class="mb-2">
                <span class="font-semibold text-gray-700">특징:</span>
                <c:forEach var="opt" items="${article.environmentOptions}">
                  <span class="inline-block bg-orange-100 text-orange-700 rounded px-2 py-1 mr-1 mb-1">${opt}</span>
                </c:forEach>
              </div>
              <div class="mb-2">
                <span class="font-semibold text-gray-700">코멘트:</span>
                <span class="block text-gray-600">${article.environmentComment}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="flex justify-between mt-6">
          <button class="btn btn-neutral btn-outline btn-xs" onclick="history.back();">뒤로가기</button>
          <c:if test="${article.getMemberId() == req.getLoginedMember().getId()}">
            <div class="flex gap-2">
              <a class="btn btn-neutral btn-outline btn-xs" href="modify?id=${article.getId()}">수정</a>
              <a class="btn btn-neutral btn-outline btn-xs" href="delete?id=${article.getId()}&boardId=${article.getBoardId()}" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>