<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.getName()} 게시판" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<section class="bg-gray-50 py-8">
  <div class="container mx-auto max-w-5xl">
    <div class="bg-white rounded-t-lg shadow-sm p-6 mb-1 border border-red-500">
      <div class="flex justify-between items-center">
        <div>
          <h1 class="text-2xl font-bold text-orange-400">${board.getName()}</h1>
          <p class="text-sm text-gray-500 mt-1">총 ${articlesCnt}개의 게시글</p>
        </div>
        
        <c:if test="${req.getLoginedMember().getId() != 0}">
          <c:choose>
            <c:when test="${req.getLoginedMember().getAuthLevel() == 0}">
              <a href="/usr/article/mainWrite?boardId=${board.getId()}" class="bg-orange-400 hover:bg-orange-500 text-white px-4 py-2 rounded-md transition">글쓰기</a>
            </c:when>
            <c:otherwise>
              <c:if test="${board.getId() != 1}">
                <a href="/usr/article/mainWrite?boardId=${board.getId()}" class="bg-orange-400 hover:bg-orange-500 text-white px-4 py-2 rounded-md transition">글쓰기</a>
              </c:if>
            </c:otherwise>
          </c:choose>
        </c:if>
      </div>
    </div>
    
   <div class="flex">
    <c:if test="${board.id == 1 or board.id == 2 or board.id == 3}">
      <div class="w-1/5 bg-white rounded-lg  p-4 h-fit">
        <div class="font-bold text-lg mb-4 text-gray-800 border-b-2 border-orange-400 pb-2">${board.getName()}</div>
        
        <c:if test="${board.id == 1}">
          <div class="pb-2">
            <a href="/usr/article/list?boardId=7" class="block py-2 pl-1 hover:bg-orange-100 rounded-md ">유치원 정보</a>
            <a href="/usr/article/list?boardId=8" class="block py-2 pl-1 hover:bg-orange-100 rounded-md ">어린이집 정보</a>
          </div>
        </c:if>
        
        <c:if test="${board.id == 2}">
          <div class="pb-2">
            <a href="/usr/article/list?boardId=4" class="block py-2 pl-1 hover:bg-orange-100 rounded-md">근무후기</a>
            <a href="/usr/article/list?boardId=5" class="block py-2 pl-1 hover:bg-orange-100 rounded-md ">면접후기</a>
            <a href="/usr/article/list?boardId=6" class="block py-2 pl-1 hover:bg-orange-100 rounded-md ">실습 및 봉사후기</a>
          </div>
        </c:if>
      </div>
	
	</c:if>
      <div class="w-5/5 border">
        <div class="bg-white rounded-lg shadow-sm p-4 mb-4">
          <div class="flex flex-col ">
            <div class="border border-red-500">
              <div class="text-sm font-medium text-gray-700 mb-2">지역별 기관찾기</div>
              <form method="get" action="/usr/article/list" class="flex gap-2">
                <input type="hidden" name="boardId" value="${board.id}" />
                <select id="city" name="city-select" onchange="updateDistricts()" class="flex-1 border border-gray-500 rounded-md px-3 py-2 outline-none">
                  <option value="" disabled selected>-- 시/도 선택 --</option>
                  <option value="서울">서울</option>
                  <option value="대전">대전</option>
                  <option value="대구">대구</option>
                  <option value="부산">부산</option>
                  <option value="인천">인천</option>
                  <option value="광주">광주</option>
                  <option value="세종">세종</option>
                  <option value="울산">울산</option>
                  <option value="강원">강원</option>
                  <option value="경기">경기</option>
                  <option value="경남">경남</option>
                  <option value="경북">경북</option>
                  <option value="전남">전남</option>
                  <option value="전북">전북</option>
                  <option value="제주">제주</option>
                  <option value="충남">충남</option>
                  <option value="충북">충북</option>
                </select>
                <button type="submit" class="bg-gray-200 hover:bg-gray-500 px-4 py-2 rounded-md ">조회</button>
              </form>
            </div>
			<div class="text-right border border-gray-500 py-2">
			<form action="/"  method="get">
				<select name="searchType" class="border border-gray-500 rounded-md px-1 py-1 outline-none">
					<option selected value="">선택</option>
					<option value="institution">제목</option>
					<option value="content">내용</option>
					<option value="institution+content">제목+내용</option>
				</select>
				<input type="text" name="keyword" id="keyword" class="border border-gray-500 rounded-md px-1 py-1 outline-none">
				<button class="border border-gray-500 rounded-md px-2 py-1 btn-outline" type="submit">검색</button>
			</form>
			</div>
          </div>
        </div>
        
        <div class="bg-white rounded-lg shadow-sm divide-y">
          <c:forEach items="${articles}" var="article">
            <div class="p-5 hover:bg-gray-50 transition">
              <div class="flex justify-between items-start">
                <a href="detail?id=${article.getId()}" class="text-lg font-bold text-gray-800 hover:text-orange-500 transition">
                  ${article.getInstitutionName()}
                </a>
                <span class="text-yellow-500 font-bold flex items-center">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" viewBox="0 0 20 20" fill="currentColor">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                  </svg>
                  ${article.getStar()}
                </span>
              </div>
              <p class="text-gray-600 mt-2 text-sm">
                "${article.getContent()}"
              </p>
              <div class="flex justify-between items-center mt-3">
                <div class="text-xs text-gray-500">
                </div>
              </div>
            </div>
          </c:forEach>
          
          <c:if test="${empty articles}">
            <div class="p-8 text-center text-gray-500">
              등록된 게시글이 없습니다.
            </div>
          </c:if>
        </div>
        
        <div class="flex justify-center mt-6">
          <div class="flex rounded-md">
            <c:set var="queryString" value="?boardId=${board.getId()}" />
            
            <c:if test="${begin != 1}">
              <a href="${queryString}&cPage=1" class="px-3 py-2 bg-white border border-gray-300 rounded-l-md hover:bg-gray-100">
                <i class="fa-solid fa-angles-left"></i>
              </a>
              <a href="${queryString}&cPage=${begin - 1}" class="px-3 py-2 bg-white border-t border-b border-gray-300 hover:bg-gray-100">
                <i class="fa-solid fa-caret-left"></i>
              </a>
            </c:if>
            
            <c:forEach begin="${begin}" end="${end}" var="i">
              <a href="${queryString}&cPage=${i}" class="px-3 py-2 bg-white border border-gray-300 hover:bg-gray-100 ${cPage == i ? 'bg-orange-100 text-orange-600 font-bold' : ''}">
                ${i}
              </a>
            </c:forEach>
            
            <c:if test="${end != totalPagesCnt}">
              <a href="${queryString}&cPage=${end + 1}" class="px-3 py-2 bg-white border-t border-b border-gray-300 hover:bg-gray-100">
                <i class="fa-solid fa-caret-right"></i>
              </a>
              <a href="${queryString}&cPage=${totalPagesCnt}" class="px-3 py-2 bg-white border border-gray-300 rounded-r-md hover:bg-gray-100">
                <i class="fa-solid fa-angles-right"></i>
              </a>
            </c:if>
          </div>
        </div>
      </div>
    </div>
   </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
