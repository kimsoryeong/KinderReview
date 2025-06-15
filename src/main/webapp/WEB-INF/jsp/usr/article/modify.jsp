<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="수정" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-50 py-10 min-h-screen">
  <div class="container mx-auto max-w-4xl">
    <div class="bg-white rounded-t-lg shadow-sm p-6 mb-1">
      <div class="flex justify-between items-center">
        <div class="text-2xl font-bold text-orange-400">기관 리뷰 수정</div>
      </div>
    </div>
    <div class="bg-white rounded-2xl shadow-xl p-8 space-y-8">
      <form action="doModify" method="post" class="space-y-8">
        <input name="id" type="hidden" value="${article.id}" />
        
       <div class="flex justify-between text-sm text-gray-500">
          <span>번호: ${article.getId()}</span>
          <span>작성일: ${article.getUpdateDate()}</span>
      </div>

        <!-- 기관명, 한줄평 -->
        <div class="grid grid-cols-2 gap-6">
          <div>
            <label for="institutionName" class="block font-semibold mb-1 text-gray-700">
              <i class="fa-solid fa-school text-orange-400 mr-1"></i>기관명
            </label>
            <input id="institutionName" name="institutionName" type="text" value="${article.institutionName}"
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300" />
          </div>
          <div>
            <label for="institutionComment" class="block font-semibold mb-1 text-gray-700">
              <i class="fa-solid fa-quote-left text-orange-400 mr-1"></i>한 줄 평
            </label>
            <textarea id="institutionComment" name="institutionComment" rows="2"
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300">${article.institutionComment}</textarea>
          </div>
        </div>

        <!-- 급여 정보 -->
        <div class="bg-yellow-50 rounded-lg p-6 space-y-4">
          <h3 class="font-bold text-orange-500 text-lg flex items-center mb-2">
            <i class="fa-solid fa-sack-dollar pr-2"></i>급여 정보
          </h3>
          <div class="grid grid-cols-3 gap-6">
            <div>
              <label for="salaryScore" class="block font-semibold mb-1 text-gray-700">평점 (0-5)</label>
              <input id="salaryScore" name="salaryScore" type="number" min="0" max="5" value="${article.salaryScore}"
                class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400" />
            </div>
            <div class="col-span-2">
              <label class="block font-semibold mb-1 text-gray-700">지원 항목</label>
              <div class="flex flex-wrap gap-2 bg-white rounded p-2 border border-gray-300 min-h-[42px]">
                <c:choose>
                  <c:when test="${not empty article.salaryOptions}">
                    <c:forEach var="opt" items="${article.salaryOptions}">
                      <label class="inline-flex items-center mr-4 mb-2">
                        <input type="checkbox" name="salaryOptions" value="${opt}" checked
                          class="form-checkbox text-yellow-400" />
                        <span class="ml-2 text-gray-700">${opt}</span>
                      </label>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <span class="text-gray-500 italic">지원 정보 없음</span>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
          <div>
            <label for="salaryComment" class="block font-semibold mb-1 text-gray-700">코멘트</label>
            <textarea id="salaryComment" name="salaryComment" rows="2"
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400">${article.salaryComment}</textarea>
          </div>
        </div>

        <!-- 복지 정보 -->
        <div class="bg-green-50 rounded-lg p-6 space-y-4">
          <h3 class="font-bold text-orange-500 text-lg flex items-center mb-2">
            <i class="fa-solid fa-hand-holding-heart pr-2"></i>복지 정보
          </h3>
          <div class="grid grid-cols-3 gap-6">
            <div>
              <label for="welfareScore" class="block font-semibold mb-1 text-gray-700">평점 (0-5)</label>
              <input id="welfareScore" name="welfareScore" type="number" min="0" max="5" value="${article.welfareScore}"
                class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-400" />
            </div>
            <div class="col-span-2">
              <label class="block font-semibold mb-1 text-gray-700">지원 항목</label>
              <div class="flex flex-wrap gap-2 bg-white rounded p-2 border border-gray-300 min-h-[42px]">
                <c:choose>
                  <c:when test="${not empty article.welfareOptions}">
                    <c:forEach var="opt" items="${article.welfareOptions}">
                      <label class="inline-flex items-center mr-4 mb-2">
                        <input type="checkbox" name="welfareOptions" value="${opt}" checked
                          class="form-checkbox text-green-400" />
                        <span class="ml-2 text-gray-700">${opt}</span>
                      </label>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <span class="text-gray-500 italic">지원 정보 없음</span>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
          <div>
            <label for="welfareComment" class="block font-semibold mb-1 text-gray-700">코멘트</label>
            <textarea id="welfareComment" name="welfareComment" rows="2"
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-400">${article.welfareComment}</textarea>
          </div>
        </div>

        <!-- 근무환경 정보 -->
        <div class="bg-blue-50 rounded-lg p-6 space-y-4">
          <h3 class="font-bold text-orange-500 text-lg flex items-center mb-2">
            <i class="fa-solid fa-users pr-2"></i>근무환경 정보
          </h3>
          <div class="grid grid-cols-3 gap-6">
            <div>
              <label for="environmentScore" class="block font-semibold mb-1 text-gray-700">평점 (0-5)</label>
              <input id="environmentScore" name="environmentScore" type="number" min="0" max="5"
                value="${article.environmentScore}"
                class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
            </div>
            <div class="col-span-2"></div>
          </div>
          <div>
            <label for="environmentComment" class="block font-semibold mb-1 text-gray-700">코멘트</label>
            <textarea id="environmentComment" name="environmentComment" rows="2"
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400">${article.environmentComment}</textarea>
          </div>
        </div>
        <!-- 버튼 -->
        <div class="flex justify-end gap-4">
          <button type="submit"
            class="bg-orange-500 hover:bg-orange-600 text-white font-bold py-2 px-6 rounded-lg shadow-md transition duration-300">
            <i class="fa-solid fa-pen-to-square mr-2"></i>수정
          </button>
          <button type="button" onclick="history.back();"
            class="bg-white border border-gray-300 text-gray-600 hover:text-orange-500 font-bold py-2 px-6 rounded-lg shadow transition duration-200">
            뒤로가기
          </button>
        </div>
      </form>
    </div>
  </div>
</section>


<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>