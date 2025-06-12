<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="수정" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="mt-10 max-w-2xl mx-auto bg-white p-8 rounded-lg border border-gray-300">
    <h2 class="text-xl font-bold mb-6 border-b pb-2">기관 정보 수정</h2>

    <form action="doModify" method="post" class="space-y-6">
        <input name="id" type="hidden" value="${article.id}" />

        <div class="text-sm grid grid-cols-2 gap-4 border border-red-300">
            <div>
                <label class="block text-gray-700 font-semibold mb-1">번호</label>
                <div class="text-gray-900">${article.id}</div>
            </div>
            <div>
                <label class="block text-gray-700 font-semibold mb-1">작성일</label>
                <div class="text-gray-900">${article.regDate.substring(2, 16)}</div>
            </div>
            <div>
                <label class="block text-gray-700 font-semibold mb-1">수정일</label>
                <div class="text-gray-900">${article.updateDate.substring(2, 16)}</div>
            </div>
        </div>
        <div class="border border-red-300">
            <div>
                <label for="institutionName" class="block text-gray-700 font-semibold mb-1">기관명</label>
                <input id="institutionName" name="institutionName" type="text" value="${article.institutionName}"
                    class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-#FFCC80" />
            </div>
            <label for="institutionComment" class="block text-gray-700 font-semibold mb-1">한 줄 평</label>
            <textarea id="institutionComment" name="institutionComment" rows="3"
                class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-500">${article.institutionComment}</textarea>
        </div>

        <!-- 급여 섹션 -->
        <section class="border rounded-md p-4 bg-gray-50">
            <h3 class="text-xl font-bold mb-3">급여 정보</h3>
            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label for="salaryScore" class="block text-gray-700 font-semibold mb-1">평점 (0-5)</label>
                    <input id="salaryScore" name="salaryScore" type="number" min="0" max="5" value="${article.salaryScore}"
                        class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400" />
                </div>

                <div>
                    <label class="block text-gray-700 font-semibold mb-1">지원 항목</label>
                    <div class="max-h-32 overflow-auto border border-gray-300 rounded-md p-2 bg-white">
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

                <div class="col-span-2">
                    <label for="salaryComment" class="block text-gray-700 font-semibold mb-1">코멘트</label>
                    <textarea id="salaryComment" name="salaryComment" rows="3"
                        class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400">${article.salaryComment}</textarea>
                </div>
            </div>
        </section>

        <!-- 복지 섹션 -->
        <section class="border rounded-md p-4 bg-gray-50">
            <h3 class="text-xl font-bold mb-3">복지 정보</h3>
            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label for="welfareScore" class="block text-gray-700 font-semibold mb-1">평점 (0-5)</label>
                    <input id="welfareScore" name="welfareScore" type="number" min="0" max="5" value="${article.welfareScore}"
                        class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-400" />
                </div>

                <div>
                    <label class="block text-gray-700 font-semibold mb-1">지원 항목</label>
                    <div class="max-h-32 overflow-auto border border-gray-300 rounded-md p-2 bg-white">
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

                <div class="col-span-2">
                    <label for="welfareComment" class="block text-gray-700 font-semibold mb-1">코멘트</label>
                    <textarea id="welfareComment" name="welfareComment" rows="3"
                        class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-400">${article.welfareComment}</textarea>
                </div>
            </div>
        </section>

        <!-- 근무환경 섹션 -->
        <section class="border rounded-md p-4 bg-gray-50">
            <h3 class="text-xl font-bold mb-3">근무환경 정보</h3>
            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label for="environmentScore" class="block text-gray-700 font-semibold mb-1">평점 (0-5)</label>
                    <input id="environmentScore" name="environmentScore" type="number" min="0" max="5"
                        value="${article.environmentScore}"
                        class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
                </div>

                <div class="col-span-2">
                    <label for="environmentComment" class="block text-gray-700 font-semibold mb-1">코멘트</label>
                    <textarea id="environmentComment" name="environmentComment" rows="3"
                        class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400">${article.environmentComment}</textarea>
                </div>
            </div>
        </section>

        <div class="flex justify-end">
            <button type="submit"
                class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg shadow-md transition duration-300">
                수정
            </button>
        </div>
    </form>

    <div class="mt-6 text-right">
        <button onclick="history.back();"
            class="text-gray-600 hover:text-gray-900 underline cursor-pointer focus:outline-none">뒤로가기</button>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>