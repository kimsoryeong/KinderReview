<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="pageTitle" value="${board.boardName} 게시판" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-100 min-h-screen py-8">
  <div class="container mx-auto max-w-4xl">
    <div class="bg-white rounded-t-lg shadow p-6 mb-4 border-b-4 border-orange-300 flex justify-between items-center">
      <div>
        <h1 class="text-2xl font-bold text-orange-400">${board.boardName}</h1>
        <p class="text-sm text-gray-500 mt-1">총 <span class="font-semibold text-orange-400">${articlesCnt}</span>개의 게시글</p>
      </div>
      <c:set var="isLogined" value="${req.getLoginedMember().getId() != 0}" />
      <button
        class="bg-orange-400 hover:bg-orange-500 text-white px-5 py-2 rounded-lg font-semibold shadow transition"
        onclick="
          if (!${isLogined}) {
            alert('로그인 후 이용해주세요.');
          } else {
            var authLevel = ${req.getLoginedMember().getAuthLevel()};
            var boardId = ${board.getId()};
            if (authLevel == 0 || boardId != 1) {
              location.href = '/usr/article/mainWrite?boardId=${board.getId()}';
            } else {
              alert('권한이 없습니다.');
            }
          }
        "
      >
        글쓰기
      </button>
    </div>
    
    <div class="flex flex-col md:flex-row gap-4">
      <c:if test="${board.id >= 1 and board.id <= 9}">
        <aside class="w-full md:w-48 min-w-40 bg-white rounded-lg shadow p-4 h-fit mb-4 md:mb-0">
          <div class="font-bold text-lg mb-4 text-gray-800 border-b-2 border-orange-400 pb-2">${board.boardName}</div>
          <c:if test="${board.id == 1 }">
            <a href="/usr/article/list?boardId=7" class="block py-2 pl-2 my-1 rounded-md hover:bg-orange-100 transition">유치원 정보</a>
            <a href="/usr/article/list?boardId=8" class="block py-2 pl-2 my-1 rounded-md hover:bg-orange-100 transition">어린이집 정보</a>
          </c:if>
          <c:if test="${board.id == 2 or board.id == 4 or board.id == 5 or board.id == 6}">
            <a href="/usr/article/list?boardId=4" class="block py-2 pl-2 my-1 rounded-md hover:bg-orange-100 transition">근무 리뷰</a>
            <a href="/usr/article/list?boardId=5" class="block py-2 pl-2 my-1 rounded-md hover:bg-orange-100 transition">면접 리뷰</a>
            <a href="/usr/article/list?boardId=6" class="block py-2 pl-2 my-1 rounded-md hover:bg-orange-100 transition">실습 및 봉사 리뷰</a>
          </c:if>
        </aside>
      </c:if>
      <div class="flex-1 min-w-0">
      <c:if test="${board.id == 4 or board.id == 5 or board.id == 6}">
        <div class="bg-white rounded-lg shadow p-4 mb-4 flex flex-col md:flex-row md:items-center md:justify-between gap-4">
          <form method="get" action="/usr/article/list" class="flex items-center gap-2">
            <input type="hidden" name="boardId" value="${board.id}" />
            <label for="city" class="text-sm font-medium text-gray-700">지역</label>
            <select id="city" name="city" onchange="updateDistricts()" class="border border-gray-300 rounded-md px-3 py-2 outline-none">
              <option value="" disabled selected>시/도</option>
              <option value="">전체</option>
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
            <button type="submit" class="bg-orange-100 hover:bg-orange-300 text-orange-700 px-4 py-2 rounded-md transition">조회</button>
          </form>
          <form action="/usr/article/list" method="get" class="flex items-center gap-2">
            <input type="hidden" name="boardId" value="${board.id}" />
            <select name="searchType" class="border border-gray-300 rounded-md px-2 py-2 outline-none">
              <option selected value="">선택</option>
              <option value="institutionName">기관명</option>
              <option value="content">내용</option>
              <option value="institutionName+cotent">기관명+내용</option>
            </select>
            <input type="text" name="keyword" id="keyword" class="border border-gray-300 rounded-md px-2 py-2 outline-none" placeholder="검색어 입력">
            <button class="bg-orange-100 hover:bg-orange-300 text-orange-700 px-4 py-2 rounded-md transition" type="submit">검색</button>
          </form>
        </div>
		</c:if>
        <div class="px-2 bg-white rounded-lg shadow-sm divide-y-2 divide-gray-200">
	<c:if test="${not empty board and board.id == 2}">
	  <div class="bg-white rounded-lg shadow p-4 mb-4">
	    <div class="font-bold text-lg mb-3 p-2 border-b-2 border-orange-300 flex items-center">
	      <i class="fa-solid fa-briefcase mr-2 text-orange-400"></i>
	      <span>근무 리뷰 인기글</span>
	      <a href="/usr/article/list?boardId=4" class="ml-auto text-sm text-orange-400 hover:underline">더보기</a>
	    </div>
	    <c:forEach items="${workingTopArticles}" var="article">
		  <div class="p-3 hover:bg-orange-50 border-b border-gray-300 transition">
		    <div class="flex items-center mb-1">
		      <span class="text-sm pr-2 font-bold">[${article.city}]</span>
		      <i class="fa-solid fa-school pr-2"></i>
		      <a href="detail?id=${article.id}" class="font-bold text-gray-800 hover:text-orange-500 mr-2">
		        ${article.institutionName}
		      </a>
		      <span class="text-yellow-500 font-bold flex items-center text-sm">
		        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 20 20" fill="currentColor">
		          <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
		        </svg> ${article.star}
		      </span>
		    </div>
		    <div class="text-sm text-gray-700 mt-1 truncate">
		      "${article.interviewComment}"
		    </div>
		    <div class="flex justify-between items-center mt-2">
		      <span class="text-xs text-gray-400">${article.regDate}</span>
		    </div>
		  </div>
		</c:forEach>
	  </div>
	
	  <div class="bg-white rounded-lg shadow p-4 mb-4">
	    <div class="font-bold text-lg mb-3 p-2 border-b-2 border-orange-300 flex items-center">
	      <i class="fa-solid fa-handshake mr-2 text-orange-400"></i>
	      <span>면접 리뷰 인기글</span>
	      <a href="/usr/article/list?boardId=5" class="ml-auto text-sm text-orange-400 hover:underline">더보기</a>
	    </div>
	    <c:forEach items="${interviewTopArticles}" var="article">
		  <div class="p-3 hover:bg-orange-50 border-b border-gray-300 transition">
		    <div class="flex items-center mb-1">
		      <span class="text-sm pr-2 font-bold">[${article.city}]</span>
		      <i class="fa-solid fa-school pr-2"></i>
		      <a href="detail?id=${article.id}" class="font-bold text-gray-800 hover:text-orange-500 mr-2">
		        ${article.institutionName}
		      </a>
		      <span class="text-yellow-500 font-bold flex items-center text-sm">
		        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 20 20" fill="currentColor">
		          <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
		        </svg> ${article.interviewScore}
		      </span>
		    </div>
		    <div class="text-sm text-gray-700 mt-1 truncate">
		      "${article.interviewComment}"
		    </div>
		    <div class="flex justify-between items-center mt-2">
		      <span class="text-xs text-gray-400">${article.regDate}</span>
		    </div>
		  </div>
		</c:forEach>
	  </div>
	
	  <div class="bg-white rounded-lg shadow p-4 mb-4">
	    <div class="font-bold text-lg mb-3 flex p-2 border-b-2 border-orange-300 items-center">
	      <i class="fa-solid fa-seedling mr-2 text-orange-400"></i>
	      <span>실습 및 봉사 리뷰 인기글</span>
	      <a href="/usr/article/list?boardId=6" class="ml-auto text-sm text-orange-400 hover:underline">더보기</a>
	    </div>
	    <c:forEach items="${practiceTopArticles}" var="article">
		  <div class="p-3 hover:bg-orange-50 border-b border-gray-300 transition">
		    <div class="flex items-center mb-1">
		    <span class="text-sm pr-2 font-bold">[${article.city}]</span>
		      <i class="fa-solid fa-school pr-2"></i>
		      <a href="detail?id=${article.id}" class="font-bold text-gray-800 hover:text-orange-500 mr-2">
		        ${article.institutionName}
		      </a>
		      <span class="text-yellow-500 font-bold flex items-center text-sm">
		        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 20 20" fill="currentColor">
		          <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
		        </svg> ${article.practiceScore}
		      </span>
		    </div>
		    <div class="text-sm text-gray-700 mt-1 truncate">
		      "${article.practiceComment}"
		    </div>
		    <div class="flex justify-between items-center mt-2">
		      <span class="text-xs text-gray-400">${article.regDate}</span>
		    </div>
		  </div>
		</c:forEach>
	  </div>
	</c:if>
	
		
		<c:if test="${board.id == 4 or board.id == 5 or board.id == 6 or board.id == 7 or board.id == 8}">
          <c:forEach items="${articles}" var="article">
            <div class="p-5 hover:bg-orange-50 transition">
              <div class="flex items-center">
                <a href="detail?id=${article.id}" class="text-lg font-bold text-gray-800  flex items-center gap-2">
                  <span class="text-sm hover:text-black">[${article.city}]</span>
                  <i class="fa-solid fa-school fa-base text-gray-800"></i>
                  <span class="hover:text-orange-500 transition">${article.institutionName}</span>
                </a>
                <c:if test="${board.id == 4}">
                <span class="text-yellow-500 font-bold pl-3 flex items-center">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" viewBox="0 0 20 20" fill="currentColor">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                  </svg> ${article.getStar()}
                </span>
                </c:if>
                <c:if test="${board.id == 5}">
                <span class="text-yellow-500 font-bold pl-3 flex items-center">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" viewBox="0 0 20 20" fill="currentColor">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                  </svg> ${article.interviewScore}
                </span>
                </c:if>
                <c:if test="${board.id == 6}">
                <span class="text-yellow-500 font-bold pl-3 flex items-center">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" viewBox="0 0 20 20" fill="currentColor">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                  </svg> ${article.practiceScore}
                </span>
                </c:if>
              </div>
			<c:if test="${board.id == 4}">
              <div class="flex pt-3">
                <div class="text-sm text-gray-600 italic truncate max-w-xl">
                  "${article.institutionComment}"
                </div>
              </div>
            </c:if>
			<c:if test="${board.id == 5}">
              <div class="flex pt-3">
                <div class="text-sm text-gray-600 italic truncate max-w-xl">
                  "${article.interviewComment}"
                </div>
              </div>
            </c:if>
			<c:if test="${board.id == 6}">
              <div class="flex pt-3">
                <div class="text-sm text-gray-600 italic truncate max-w-xl">
                  "${article.practiceComment}"
                </div>
              </div>
            </c:if>
              <div class="flex gap-4 pt-2 text-xs text-gray-400">
                <span>작성일: ${article.regDate}</span>
              </div>
            </div>
          </c:forEach>
          <c:if test="${empty articles}">
            <div class="p-8 text-center text-gray-500">
              등록된 게시글이 없습니다.
            </div>
          </c:if>
		</c:if>          
        </div>

        <div class="flex justify-center mt-6">
          <div class="flex rounded-md overflow-hidden shadow">
            <c:set var="queryString" value="?boardId=${board.getId()}" />
            <c:if test="${begin != 1}">
              <a href="${queryString}&cPage=1" class="px-3 py-2 bg-white border border-gray-300 hover:bg-gray-100">
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
              <a href="${queryString}&cPage=${totalPagesCnt}" class="px-3 py-2 bg-white border border-gray-300 hover:bg-gray-100">
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