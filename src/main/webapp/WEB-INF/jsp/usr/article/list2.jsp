<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.getName() } 게시판" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

	<section class="mt-8">
		<div class="container mx-auto border-4 border-red-500">
			<div class="ml-8 mb-2">
				<div><span>${board.getName() } 게시판</span></div>
				<div><span>총 : ${articlesCnt }개</span></div>
			</div>
				<div class="border-4 border-green-800">
					<div class="text-right">
					<form action="/"  method="get">
						<select name="searchType">
							<option selected value="">선택</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="title+content">제목+내용</option>
						</select>
						<input type="text" name="keyword" id="keyword">
						<button class="btn btn-neutral btn-outline btn-sm" type="submit">검색</button>
					</form>
					</div>
				</div>
			</div>	
			
			<div class="mx-auto text-left border-4 border-pink-500">
				<div>근무후기</div>
				<div>면접후기</div>
				<div>실습 및 봉사후기</div>
			</div>
			<div class="table-box border-4 border-blue-800 mx-auto">
				<table class="table">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${articles }" var="article">
							<tr class="hover:bg-base-300">
								<td>${article.getId() }</td>
								<td class="hover:underline underline-offset-4"><a href="detail?id=${article.getId() }">${article.getTitle() }</a></td>
								<td>${article.getWriterName() }</td>
								<td>${article.getRegDate().substring(2, 16) }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			
- 			<c:if test="${req.getLoginedMember().getId() != 0 }">
				<c:choose>
					<c:when test="${req.getLoginedMember().getAuthLevel() == 0 }">
						<div class="bg-white px-6 pt-6">
							<div class="text-right"><a class="btn btn-neutral btn-outline btn-xs" href="mainWrite?boardId=${board.getId()}">글쓰기</a>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<c:if test="${board.getId() != 1 }">
							<div class="bg-white px-6 pt-6">
								<div class="text-right"><a class="btn btn-neutral btn-outline btn-xs" href="mainWrite?boardId=${board.getId()}">글쓰기</a>

								</div>
							</div>
						</c:if>
					</c:otherwise>
				</c:choose>
			</c:if>
			
			<div class="flex justify-center mb-8 mt-4">
				<div class="join">
					<c:set var="queryString" value="?boardId=${board.getId() }" />
					
					<c:if test="${begin != 1 }">
						<a class="join-item btn btn-sm" href="${queryString }&cPage=1"><i class="fa-solid fa-angles-left"></i></a>
						<a class="join-item btn btn-sm" href="${queryString }&cPage=${begin - 1 }"><i class="fa-solid fa-caret-left"></i></a>
					</c:if>
					<c:forEach begin="${begin }" end="${end }" var="i">
						<a class="join-item btn-sm btn ${cPage == i ? 'btn-active' : '' }" href="${queryString }&cPage=${i }">${i }</a>
					</c:forEach>
					<c:if test="${end != totalPagesCnt }">
						<a class="join-item btn btn-sm" href="${queryString }&cPage=${end + 1 }"><i class="fa-solid fa-caret-right"></i></a>
						<a class="join-item btn btn-sm" href="${queryString }&cPage=${totalPagesCnt }"><i class="fa-solid fa-angles-right"></i></a>
					</c:if>
				</div>
			</div>
		</div>
	</section>
	
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>