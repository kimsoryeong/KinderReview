<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="상세보기" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

	<section class="mt-8">
	<div class="container mx-auto max-w-5xl border-4 border-red-500">
			<div class="ml-8 mb-2">
				<div><span>${board.getName() } 게시판</span></div>
				<div><span>총 : ${articlesCnt }개</span></div>
			</div>
	</div>
	<div class="max-w-5xl flex mx-auto border-4 border-yellow-500">
				<div class=" w-1/5 border-4 border-pink-500">
				<div>ddd</div>
					<div class="font-bold mt-5 mb-5 ml-2"><span>${board.getName() }</span></div>
				</div>
				<div class="w-4/5 border-4 border-blue-500">
					<div class="border-4 border-green-500 mx-2 mt-2 mb-2 ">
					<div class="flex justify-between text-xs border-2 border-red-500">
						<div>
							<span>번호</span>
							<span>${article.getId() }</span>
						</div>
						<div>
							<span>작성일</span>
							<span>${article.getRegDate().substring(2, 16) }</span>
							<br>
							<span>수정일</span>
							<span>${article.getUpdateDate().substring(2, 16) }</span>
						</div>
					</div>
					<div class="border-2 border-blue-500">
					<div class=" icon-box flex justify-start h-15 items-center">
						<i class="fa-solid fa-city fa-2xl"></i>
						<span class="mr-5 ml-5 font-bold text-2xl text-[#333]">${article.getInstitutionName() }</span>
						<span class="text-yellow-500 font-bold">★ ${article.getStar() }</span>
					</div>
	    				<div class="ml-2 text-xl text-gray-600 mb-3">“${article.getContent() }”</div>
					</div>
					<div class="ml-2 border-2 border-red-500">
						  <div>급여</div>
						  <p>별점: ★ ${article.salaryScore}</p>
						  <p>특징: ${article.salaryOptions}</p>
						  <p>코멘트: ${article.salaryComment}</p>
						
						  <h4>복지</h4>
						  <p>별점: ★ ${article.welfareScore}</p>
						  <p>특징: ${article.welfareOptions}</p>
						  <p>코멘트: ${article.welfareComment}</p>
						
						  <h4>근무환경</h4>
						  <p>별점: ★ ${article.environmentScore}</p>
						  <p>특징: ${article.environmentOptions}</p>
						  <p>코멘트: ${article.environmentComment}</p>
					</div>
					</div>
				</div>
			</div>
		<div class="container mx-auto">
			<div class="bg-white p-6 flex justify-between">
				<div><button class="btn btn-neutral btn-outline btn-xs" onclick="history.back();">뒤로가기</button></div>
				<c:if test="${article.getMemberId() == req.getLoginedMember().getId() }">
					<div class="flex">
						<div class="mr-2"><a class="btn btn-neutral btn-outline btn-xs" href="modify?id=${article.getId() }">수정</a></div>
						<div><a class="btn btn-neutral btn-outline btn-xs" href="delete?id=${article.getId() }&boardId=${article.getBoardId() }" onclick="if(confirm('정말로 삭제하시겠습니까?') == false) return false;">삭제</a></div>
					</div>
				</c:if>
			</div>
		</div>
	</section>
	
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>