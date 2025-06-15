<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="상세보기" />
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-50 py-10 min-h-screen">
  <div class="container mx-auto max-w-4xl">
    <div class="bg-white rounded-t-lg shadow-sm p-6 mb-1">
      <div class="flex justify-between items-center">
        <div class="text-2xl font-bold text-orange-400">${board.boardName} 후기</div>
      </div>
    </div>
    <div class="bg-white rounded-2xl shadow-xl p-8 space-y-6">
      <div class="flex justify-between text-sm text-gray-500">
          <span>번호: ${article.getId()}</span>
          <span>작성일: ${article.getUpdateDate()}</span>
      </div>
      <div class="flex  pb-4 items-center gap-4 text-gray-700 mb-4">
        <i class="fa-solid fa-location-dot text-orange-400"></i>
        <span>${article.city}</span>
        <i class="fa-solid fa-user text-orange-400"></i>
        <span>${article.institutionType}</span>
        <i class="fa-solid fa-briefcase text-orange-400"></i>
        <span>${article.workType}</span>
      </div>
      <c:if test="${board.boardName eq '근무 리뷰'}">
      <div class="flex items-center gap-4 border-b pb-4">
        <i class="fa-solid fa-school fa-2xl text-orange-400 pr-4"></i>
        <span class="font-bold text-2xl text-gray-800">${article.institutionName}</span>
        <div class="text-yellow-500 font-bold text-2xl flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-1" fill="currentColor" viewBox="0 0 20 20">
            <path d="M9.049 2.927c.3-.921 1.603.-921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783.-57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
          </svg>★ ${article.star}</div>
      </div>
      <div class="font-bold text-gray-500 text-xl text-center pb-4">"${article.institutionComment}"</div>
      <div class="grid grid-cols-3 gap-4 mb-6">
        <div class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
          <i class="fa-solid fa-sack-dollar text-2xl text-orange-400 mb-2"></i>
          <span class="text-gray-500 text-sm">급여</span>
          <span class="text-yellow-500 font-bold text-xl">★ ${article.salaryScore}</span>
        </div>
        <div class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
          <i class="fa-solid fa-hand-holding-heart text-2xl text-orange-400 mb-2"></i>
          <span class="text-gray-500 text-sm">복지</span>
          <span class="text-yellow-500 font-bold text-xl">★ ${article.welfareScore}</span>
        </div>
        <div class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
          <i class="fa-solid fa-users text-2xl text-orange-400 mb-2"></i>
          <span class="text-gray-500 text-sm">근무환경</span>
          <span class="text-yellow-500 font-bold text-xl">★ ${article.environmentScore}</span>
        </div>
      </div>
      <div class="space-y-6">
        <div class="bg-yellow-50 rounded-lg p-4">
          <h4 class="font-bold text-orange-500 mb-2 flex items-center"><i class="fa-solid fa-sack-dollar pr-2"></i>급여</h4>
          <div class="mb-2">
          <div class="mb-2">
            <span class="font-semibold text-gray-700">코멘트</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.salaryComment}</div>
          </div>
            <div class="flex flex-wrap gap-2 mt-1">
              <c:forEach var="opt" items="${article.salaryOptions}">
                <span class="bg-orange-100 text-orange-700 rounded px-2 py-1 text-sm">${opt}</span>
              </c:forEach>
            </div>
          </div>
        </div>
        <div class="bg-green-50 rounded-lg p-4">
          <h4 class="font-bold text-orange-500 mb-2 flex items-center"><i class="fa-solid fa-hand-holding-heart pr-2"></i>복지</h4>
          <div class="mb-2">
          <div class="mb-2">
            <span class="font-semibold text-gray-700">코멘트</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.welfareComment}</div>
          </div>
            <div class="flex flex-wrap gap-2 mt-1">
              <c:forEach var="opt" items="${article.welfareOptions}">
                <span class="bg-orange-100 text-orange-700 rounded px-2 py-1 text-sm">${opt}</span>
              </c:forEach>
            </div>
          </div>
        </div>
        <div class="bg-blue-50 rounded-lg p-4">
          <h4 class="font-bold text-orange-500 mb-2 flex items-center"><i class="fa-solid fa-users pr-2"></i>근무환경</h4>
          <div class="mb-2">
          <div class="mb-2">
            <span class="font-semibold text-gray-700">코멘트</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.environmentComment}</div>
          </div>
            <span class="font-semibold text-gray-700">출퇴근시간</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.commuteTimeComment}</div>
          </div>
        </div>
      </div>
      </c:if>
      
      <c:if test="${board.boardName eq '면접 리뷰'}">
      <div class="flex items-center gap-4 border-b pb-4">
        <i class="fa-solid fa-school fa-2xl text-orange-400 pr-4"></i>
        <span class="font-bold text-2xl text-gray-800">${article.institutionName}</span>
        <div class="text-yellow-500 font-bold text-2xl flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-1" fill="currentColor" viewBox="0 0 20 20">
            <path d="M9.049 2.927c.3-.921 1.603.-921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783.-57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
          </svg>★ ${article.interviewScore}</div>
      </div>
      <div class="font-bold text-gray-500 text-xl text-center pb-4">"${article.interviewComment}"</div>
      <div class="grid grid-cols-3  mb-6">
        <div class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
          <i class="fa-solid fa-star-half-stroke text-2xl text-orange-400 mb-2"></i>
          <span class="text-gray-500 text-sm">면접 총 평점</span>
          <span class="text-yellow-500 font-bold text-xl">${article.interviewScore}</span>
        </div>
        <div class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
          <i class= "fa-solid fa-briefcase text-2xl text-orange-400 mb-2"></i>
          <span class="text-gray-500 text-sm">경력사항</span>
          <span class="text-yellow-500 font-bold text-xl">${article.personalHistory}</span>
        </div>
        <div class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
          <i class= "fa-solid fa-square-check text-2xl text-orange-400 mb-2"></i>
          <span class="text-gray-500 text-sm">면접 결과</span>
          <span class="text-yellow-500 font-bold text-xl">${article.interviewResults}</span>
        </div>
      </div>
      <div class="space-y-6">
        <div class="bg-yellow-50 rounded-lg p-4">
          <h4 class="font-bold text-orange-500 mb-2 flex items-center"><i class="fa-solid fa-circle-question pr-2"></i>면접정보</h4>
          <div class="mb-2">
          <div class="mb-2">
            <span class="font-semibold text-gray-700">면접 준비</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.interviewMaterial}</div>
          </div>
          <div class="mb-2">
            <span class="font-semibold text-gray-700">면접 진행</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.interviewProgress}</div>
          </div>
          <div class="mb-2">
            <span class="font-semibold text-gray-700">면접 마무리</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.interviewCompleted}</div>
          </div>
          </div>
        </div>
        <div class="bg-green-50 rounded-lg p-4">
          <h4 class="font-bold text-orange-500 mb-2 flex items-center"><i class="fa-solid fa-circle-question pr-2"></i>질의응답</h4>
          <div class="mb-2">
          <div class="mb-2">
            <span class="font-semibold text-gray-700">질의응답</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.interviewQnA}</div>
          </div>
          <div class="mb-2">
            <span class="font-semibold text-gray-700">조언</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.interviewTip}</div>
          </div>
          </div>
        </div>
       </div>
      </c:if>
      
      <c:if test="${board.boardName eq '실습 및 봉사 리뷰'}">
      <div class="flex items-center gap-4 border-b pb-4">
        <i class="fa-solid fa-school fa-2xl text-orange-400 pr-4"></i>
        <span class="font-bold text-2xl text-gray-800">${article.institutionName}</span>
        <div class="text-yellow-500 font-bold text-2xl flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-1" fill="currentColor" viewBox="0 0 20 20">
            <path d="M9.049 2.927c.3-.921 1.603.-921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783.-57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
          </svg>★ ${article.practiceScore}</div>
      </div>
      <div class="font-bold text-gray-500 text-xl text-center pb-4">"${article.practiceComment}"</div>
      <div class="grid grid-cols-2  mb-6">
        <div class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
          <i class="fa-solid fa-star-half-stroke text-2xl text-orange-400 mb-2"></i>
          <span class="text-gray-500 text-sm">실습 · 봉사 총 평점</span>
          <span class="text-yellow-500 font-bold text-xl">${article.practiceScore}</span>
        </div>
        <div class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
          <i class= "fa-solid fa-graduation-cap text-2xl text-orange-400 mb-2"></i>
          <span class="text-gray-500 text-sm">학력사항</span>
          <span class="text-yellow-500 font-bold text-xl">${article.educationalBackground}</span>
        </div>
      </div>
      <div class="space-y-6">
        <div class="bg-yellow-50 rounded-lg p-4">
          <h4 class="font-bold text-orange-500 mb-2 flex items-center"><i class="pr-3 fa-solid fa-circle-question pr-2"></i>기관의 분위기</h4>
          <div class="mb-2">
            <span class="font-semibold text-gray-700">코멘트</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.practiceAtmosphere}</div>
          </div>
        </div>
        <div class="bg-green-50 rounded-lg p-4">
          <h4 class="font-bold text-orange-500 mb-2 flex items-center"><i class="pr-3 fa-solid fa-circle-question pr-2"></i>세부 경험</h4>
          <div class="mb-2">
            <span class="font-semibold text-gray-700">코멘트</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.practiceExperience}</div>
          </div>
        </div>
        <div class="bg-blue-50 rounded-lg p-4">
          <h4 class="font-bold text-orange-500 mb-2 flex items-center"><i class="pr-3 fa-solid fa-circle-question pr-2"></i>기관 지원 및 소감</h4>
          <div class="mb-2">
            <span class="font-semibold text-gray-700">코멘트</span>
            <div class="bg-white rounded p-2 mt-1 text-gray-600">${article.practiceReview}</div>
          </div>
        </div>
      </div>
      </c:if>
      <div class="flex justify-between mt-6">
        <button class="bg-orange-100 hover:bg-orange-300 text-orange-700 px-4 py-2 rounded-md transition" onclick="history.back();">뒤로가기</button>
        <c:if test="${article.getMemberId() == req.getLoginedMember().getId()}">
          <div class="flex gap-2">
            <a class="bg-orange-100 hover:bg-orange-300 text-orange-700 px-4 py-2 rounded-md transition" href="modify?id=${article.getId()}">수정</a>
            <a class="bg-orange-100 hover:bg-orange-300 text-orange-700 px-4 py-2 rounded-md transition" href="delete?id=${article.getId()}&boardId=${article.getBoardId()}" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
          </div>
        </c:if>
      </div>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
