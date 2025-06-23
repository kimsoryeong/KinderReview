<%@ page pageEncoding="UTF-8" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="container mx-auto max-w-4xl">
      <div class="flex flex-col md:flex-row gap-6">
        <div class="flex-1">
			<div class="bg-white rounded-t-lg border-orange-300 border-b-4 shadow-sm p-6 mb-1">
				<div class="flex justify-between  items-center">
					<div class="text-2xl font-bold text-orange-400">${board.boardName}</div>
				</div>
			</div>
			<div class="bg-white rounded-2xl shadow-xl px-10 space-y-6">
			<div class="flex justify-between border-b border-gray-300 py-2">
					<a href="/usr/article/list?boardId=${article.boardId}"
					   class="border border-gray-200 hover:bg-orange-200 text-sm px-3 py-1 rounded-md transition">
					   목록
					</a>

					<c:if
						test="${article.getMemberId() == req.getLoginedMember().getId()}">
						<div class="flex gap-2">
							<a
								class="border border-gray-200 hover:bg-orange-200  text-sm px-3 py-1 rounded-sm transition"
								href="modify?id=${article.getId()}">수정</a> <a
								class="border border-gray-200 hover:bg-orange-200 text-sm px-3 py-1 rounded-sm transition"
								href="delete?id=${article.getId()}&boardId=${article.getBoardId()}"
								onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
						</div>
					</c:if>
				</div>
				<div class="flex justify-between text-xs text-gray-500">
					<div class="truncate max-w-full sm:max-w-[45%]">번호:
						${article.getId()}</div> 
					<div class="truncate max-w-full pb-2 sm:max-w-[45%] text-right">
					작성일 : ${article.getRegDate()}<br>
					수정일 : ${article.getUpdateDate() }</div>
				</div>
				<c:if test="${board.id == 3 or board.id == 4 or board.id == 5}">
				<div class="flex pb-3 items-center gap-4 text-gray-700 mb-4">
				  <i class="fa-solid fa-location-dot text-orange-400"></i>
				  <span>${article.city}</span>
				  <i class="fa-solid fa-user text-orange-400"></i>
				  <span>${article.institutionType}</span>
				  <i class="fa-solid fa-briefcase text-orange-400"></i>
				  <span>${article.workType}</span>
				
				  <div class="flex items-center text-sm gap-2 text-gray-500 ml-auto">
				    <span>추천수</span>
				    <span>
				      <c:if test="${req.getLoginedMember().getId() == 0}">
				        <span id="likePointCnt"></span>
				      </c:if>
				      <c:if test="${req.getLoginedMember().getId() != 0}">
				        <button onclick="clickLikePoint();">
				          <span id="likePointCnt"></span>
				          <span id="likePointBtn"></span>
				        </button>
				      </c:if>
				    </span>
				    <span>조회수 ${article.views}</span>
				    <span id="replyCount">댓글수 ${article.replyCount}</span>
				  </div>
				 </div>
				 </c:if>
				 