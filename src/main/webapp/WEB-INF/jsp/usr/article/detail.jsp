<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="상세보기" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp"%>

<section class="bg-gray-50 py-10 min-h-screen">
	<c:if test="${board.boardName eq '근무 리뷰'}">
		<jsp:include page="/WEB-INF/jsp/common/articleHeader.jsp" />
		<c:if test="${isAdmin}">
		  <hr/>
		  <h3>첨부파일</h3>
		  <c:forEach var="file" items="${files}">
		  <a href="${pageContext.request.contextPath}/usr/member/file/view/${file.savedName}" target="_blank">

		    ▶ ${file.originName} (클릭해서 미리보기)
		  </a>
		</c:forEach>
		</c:if>
		<div class="bg-white rounded-2xl shadow-xl p-8  space-y-6">
		
			<div class="flex items-center gap-4 border-b pb-4">
				<i class="fa-solid fa-school fa-2xl text-orange-400 pr-4"></i> <span
					class="font-bold text-2xl text-gray-800">${article.institutionName}</span>
				<div class="text-yellow-500 font-bold text-2xl flex items-center">
					<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-1"
						fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603.-921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783.-57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
					</svg>★ ${article.star}
				</div>
			</div>
			<div class="font-bold text-gray-500 text-xl text-center pb-4">
				<i class="fa-solid fa-quote-left text-orange-400 pr-5"></i>${article.institutionComment}<i
					class="text-orange-400 fa-solid fa-quote-right pl-5"></i>
			</div>
				<div class="grid grid-cols-3 gap-4 mb-6">
					<div
						class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
						<i class="fa-solid fa-sack-dollar text-2xl text-orange-400 mb-2"></i>
						<span class="text-gray-500 text-sm">급여</span> <span
							class="text-yellow-500 font-bold text-xl">★
							${article.salaryScore}</span>
					</div>
					<div
						class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
						<i
							class="fa-solid fa-hand-holding-heart text-2xl text-orange-400 mb-2"></i>
						<span class="text-gray-500 text-sm">복지</span> <span
							class="text-yellow-500 font-bold text-xl">★
							${article.welfareScore}</span>
					</div>
					<div
						class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
						<i class="fa-solid fa-users text-2xl text-orange-400 mb-2"></i> <span
							class="text-gray-500 text-sm">근무환경</span> <span
							class="text-yellow-500 font-bold text-xl">★
							${article.environmentScore}</span>
					</div>
				</div>
				<div class="grid grid-cols-1 md:grid-cols-3 gap-4">
				  <div class="bg-yellow-50 rounded-lg p-4 flex-1 overflow-y-auto max-h-150">
				    <h4 class="font-bold text-orange-500 mb-2 flex items-center">
				      <i class="fa-solid fa-sack-dollar pr-2"></i>급여
				    </h4>
				    <div class="mb-2">
				      <div class="mb-2">
				        <span class="font-semibold text-gray-700">코멘트</span>
				        <div class="rounded p-2 mt-1 text-gray-600 break-all w-full overflow-hidden">
				          ${article.salaryComment}
				        </div>
				      </div>
				      <div class="flex flex-wrap gap-2 mt-1">
				        <c:forEach var="opt" items="${article.salaryOptions}">
				          <span class="bg-orange-100 text-orange-700 rounded px-2 py-1 text-sm break-all">${opt}</span>
				        </c:forEach>
				      </div>
				    </div>
				  </div>
				  <div class="bg-green-50 rounded-lg p-4 flex-1 overflow-y-auto max-h-150">
				    <h4 class="font-bold text-orange-500 mb-2 flex items-center">
				      <i class="fa-solid fa-hand-holding-heart pr-2"></i>복지
				    </h4>
				    <div class="mb-2">
				      <div class="mb-2">
				        <span class="font-semibold text-gray-700">코멘트</span>
				        <div class="rounded p-2 mt-1 text-gray-600 break-all w-full overflow-hidden">
				          ${article.welfareComment}
				        </div>
				      </div>
				      <div class="flex flex-wrap gap-2 mt-1">
				        <c:forEach var="opt" items="${article.welfareOptions}">
				          <span class="bg-orange-100 text-orange-700 rounded px-2 py-1 text-sm break-all">${opt}</span>
				        </c:forEach>
				      </div>
				    </div>
				  </div>
				  <div class="bg-blue-50 rounded-lg p-4 flex-1 overflow-y-auto max-h-150">
				    <h4 class="font-bold text-orange-500 mb-2 flex items-center">
				      <i class="fa-solid fa-users pr-2"></i>근무환경
				    </h4>
				    <div class="mb-2">
				      <div class="mb-2">
				        <span class="font-semibold text-gray-700">코멘트</span>
				        <div class="rounded p-2 mt-1 text-gray-600 break-all w-full overflow-hidden">
				          ${article.environmentComment}
				        </div>
				      </div>
				      <div class="mb-2">
				        <span class="font-semibold text-gray-700">출퇴근시간</span>
				        <div class="rounded p-2 mt-1 text-gray-600 break-all w-full overflow-hidden">
				          ${article.commuteTimeComment}
				        </div>
				      </div>
				    </div>
				  </div>
				</div>
				<jsp:include page="/WEB-INF/jsp/common/replyBox.jsp">
				    <jsp:param name="relTypeCode" value="${relTypeCode}" />
				    <jsp:param name="relId" value="${relId}" />
				</jsp:include>
				</div>
			</c:if>

	<c:if test="${board.boardName eq '면접 리뷰'}">
		<jsp:include page="/WEB-INF/jsp/common/articleHeader.jsp" />
		
				<div class="flex items-center gap-4 border-b pb-4">
					<i class="fa-solid fa-school fa-2xl text-orange-400 pr-4"></i> <span
						class="font-bold text-2xl text-gray-800">${article.institutionName}</span>
					<div class="text-yellow-500 font-bold text-2xl flex items-center">
						<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-1"
							fill="currentColor" viewBox="0 0 20 20"> <path d="M9.049 2.927c.3-.921 1.603.-921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783.-57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
						</svg> ★ ${article.interviewScore}
					</div>
				</div>

				<div class="font-bold text-gray-500 text-xl text-center pb-4">"${article.interviewComment}"</div>
				<div class="grid grid-cols-3  mb-6">
					<div
						class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
						<i
							class="fa-solid fa-star-half-stroke text-2xl text-orange-400 mb-2"></i>
						<span class="text-gray-500 text-sm">면접 총 평점</span> <span
							class="text-yellow-500 font-bold text-xl">${article.interviewScore}</span>
					</div>
					<div
						class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
						<i class="fa-solid fa-briefcase text-2xl text-orange-400 mb-2"></i>
						<span class="text-gray-500 text-sm">경력사항</span> <span
							class="text-yellow-500 font-bold text-xl">${article.personalHistory}</span>
					</div>
					<div
						class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
						<i class="fa-solid fa-square-check text-2xl text-orange-400 mb-2"></i>
						<span class="text-gray-500 text-sm">면접 결과</span> <span
							class="text-yellow-500 font-bold text-xl">${article.interviewResults}</span>
					</div>
				</div>
				<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
				  <div class="bg-yellow-50 rounded-lg p-4 flex-1 overflow-y-auto max-h-150">
				    <h4 class="font-bold text-orange-500 mb-2 flex items-center">
				      <i class="fa-solid fa-circle-question pr-2"></i>면접정보
				    </h4>
				    <div class="mb-2">
				      <div class="mb-2">
				        <span class="font-semibold text-gray-700">면접 준비</span>
				        <div class="rounded p-2 mt-1 text-gray-600 break-all w-full overflow-hidden">
				          ${article.interviewMaterial}
				        </div>
				      </div>
				      <div class="mb-2">
				        <span class="font-semibold text-gray-700">면접 진행</span>
				        <div class="rounded p-2 mt-1 text-gray-600 break-all w-full overflow-hidden">
				          ${article.interviewProgress}
				        </div>
				      </div>
				      <div class="mb-2">
				        <span class="font-semibold text-gray-700">면접 마무리</span>
				        <div class="rounded p-2 mt-1 text-gray-600 break-all w-full overflow-hidden">
				          ${article.interviewCompleted}
				        </div>
				      </div>
				    </div>
				  </div>
				  <div class="bg-green-50 rounded-lg p-4 flex-1 overflow-y-auto max-h-150">
				    <h4 class="font-bold text-orange-500 mb-2 flex items-center">
				      <i class="fa-solid fa-circle-question pr-2"></i>질의응답
				    </h4>
				    <div class="mb-2">
				      <div class="mb-2">
				        <span class="font-semibold text-gray-700">질의응답</span>
				        <div class="rounded p-2 mt-1 text-gray-600 break-all w-full overflow-hidden">
				          ${article.interviewQnA}
				        </div>
				      </div>
				      <div class="mb-2">
				        <span class="font-semibold text-gray-700">조언</span>
				        <div class="rounded p-2 mt-1 text-gray-600 break-all w-full overflow-hidden">
				          ${article.interviewTip}
				        </div>
				      </div>
				    </div>
				  </div>
				</div>

				<jsp:include page="/WEB-INF/jsp/common/replyBox.jsp">
				    <jsp:param name="relTypeCode" value="${relTypeCode}" />
				    <jsp:param name="relId" value="${relId}" />
				</jsp:include>
			</c:if>


	<c:if test="${board.boardName eq '실습 및 봉사 리뷰'}">
		<jsp:include page="/WEB-INF/jsp/common/articleHeader.jsp" />
		
				<div class="flex items-center gap-4 border-b pb-4">
					<i class="fa-solid fa-school fa-2xl text-orange-400 pr-4"></i> <span
						class="font-bold text-2xl text-gray-800">${article.institutionName}</span>
					<div class="text-yellow-500 font-bold text-2xl flex items-center">
						<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-1"
							fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603.-921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783.-57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
						</svg>★ ${article.practiceScore}
					</div>
				</div>
				<div class="font-bold text-gray-500 text-xl text-center pb-4">"${article.practiceComment}"</div>
				<div class="grid grid-cols-2  mb-6">
					<div
						class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
						<i class="fa-solid fa-star-half-stroke text-2xl text-orange-400 mb-2"></i>
					 <span class="text-gray-500 text-sm">실습 · 봉사 총 평점</span> <span
							class="text-yellow-500 font-bold text-xl">${article.practiceScore}</span>
					</div>
					<div
						class="bg-white rounded-lg shadow p-4 flex flex-col items-center">
						<i
							class="fa-solid fa-graduation-cap text-2xl text-orange-400 mb-2"></i>
						<span class="text-gray-500 text-sm">학력사항</span> <span
							class="text-yellow-500 font-bold text-xl">${article.educationalBackground}</span>
					</div>
				</div>
				<div class="grid grid-cols-1 md:grid-cols-3 gap-4">
				  <div class="bg-yellow-50 rounded-lg p-4 flex-1 overflow-y-auto max-h-150 ">
				    <h4 class="font-bold text-orange-500 mb-2 flex items-center">
				      <i class="pr-3 fa-solid fa-circle-question pr-2"></i>기관의 분위기
				    </h4>
				    <div class="mb-2">
				      <span class="font-semibold text-gray-700">코멘트</span>
				      <div class="rounded p-2 mt-1 text-gray-600 break-all w-full">
				        <c:out value="${article.practiceAtmosphere}" />
				      </div>
				    </div>
				  </div>
				  <div class="bg-green-50 rounded-lg p-4 flex-1 overflow-y-auto max-h-150 ">
				    <h4 class="font-bold text-orange-500 mb-2 flex items-center">
				      <i class="pr-3 fa-solid fa-circle-question pr-2"></i>세부 경험
				    </h4>
				    <div class="mb-2">
				      <span class="font-semibold text-gray-700">코멘트</span>
				      <div class="rounded p-2 mt-1 text-gray-600 break-all w-full">
				        <c:out value="${article.practiceExperience}" />
				      </div>
				    </div>
				  </div>
				  <div class="bg-blue-50 rounded-lg p-4 flex-1 overflow-y-auto max-h-150 ">
				    <h4 class="font-bold text-orange-500 mb-2 flex items-center">
				      <i class="pr-3 fa-solid fa-circle-question pr-2"></i>기관 지원 및 소감
				    </h4>
				    <div class="mb-2">
				      <span class="font-semibold text-gray-700">코멘트</span>
				      <div class="rounded p-2 mt-1 text-gray-600 break-all w-full">
				        <c:out value="${article.practiceReview}" />
				      </div>
				    </div>
				  </div>
				</div>
				
				<jsp:include page="/WEB-INF/jsp/common/replyBox.jsp">
				    <jsp:param name="relTypeCode" value="${relTypeCode}" />
				    <jsp:param name="relId" value="${relId}" />
				</jsp:include>
				</c:if>
		<c:if test="${board.id == 3 or  board.id == 10 or board.id == 11 or board.id == 12}">
			<jsp:include page="/WEB-INF/jsp/common/articleHeader.jsp" />
				<div class="flex justify-between text-orange-500 ml-auto">
					<span class="font-bold flex justify-start">
						[ ${article.city} ]  ${board.boardName}
					</span>
				</div>
				<div class="flex justify-between items-center gap-4 border-b pb-4">
				  <div class="flex flex-col">
				    <span class="font-bold text-xl text-gray-800">${article.title}</span>
				    <div class="text-sm text-gray-500">작성자 : ${article.nickname}</div>
				  </div>
				  <div class="flex flex-col items-end text-sm text-gray-500">
				    <span>조회수 ${article.views}</span>
				    <span id="replyCount">댓글수 ${article.replyCount}</span>
				    <span class="flex items-center gap-1">
				      추천수
				      <c:if test="${req.getLoginedMember().getId() == 0}">
				        <span id="likePointCnt"></span>
				      </c:if>
				      <c:if test="${req.getLoginedMember().getId() != 0}">
				        <button onclick="clickLikePoint();" class="ml-1">
				          <span id="likePointCnt"></span>
				          <span id="likePointBtn"></span>
				        </button>
				      </c:if>
				    </span>
				    
				  </div>
				</div>
				<div class="text-gray-800 pb-4">${article.content}</div>
				<c:forEach var="file" items="${files}">
				  <c:choose>
				    <c:when test="${file.originName.endsWith('.jpg') 
				                or file.originName.endsWith('.jpeg') 
				                or file.originName.endsWith('.png') 
				                or file.originName.endsWith('.gif')}">
				      <img src="${pageContext.request.contextPath}/usr/member/file/view/${file.savedName}"
				           alt="${file.originName}" style="max-width: 300px;" />
				    </c:when>
				    <c:otherwise>
				      <a href="${pageContext.request.contextPath}/usr/member/file/download/${file.savedName}" target="_blank">
						  ${file.originName} 다운로드
						</a>
				    </c:otherwise>
				  </c:choose>
				</c:forEach>
				<jsp:include page="/WEB-INF/jsp/common/replyBox.jsp">
				    <jsp:param name="relTypeCode" value="${relTypeCode}" />
				    <jsp:param name="relId" value="${relId}" />
				</jsp:include>
			</c:if>
				
			<c:if test="${board.id == 9 }">
				<jsp:include page="/WEB-INF/jsp/common/articleHeader.jsp" />
				<div class="flex justify-between text-orange-500 ml-auto">
					<span class="font-bold flex justify-start">
						[ ${article.city} ]  ${board.boardName}
					</span>
				</div>
				<div class="flex justify-between items-center gap-4 border-b pb-4">
				  <div class="flex flex-col">
				    <span class="font-bold text-xl text-gray-800">${article.title}</span>
				    <div class="text-sm text-gray-500">${article.nickname}</div>
				  </div>
				  <div class="flex flex-col items-end text-sm text-gray-500">
				    <span>조회수 ${article.views}</span>
				    <span class="flex items-center gap-1">
				      추천수
				      <c:if test="${req.getLoginedMember().getId() == 0}">
				        <span id="likePointCnt"></span>
				      </c:if>
				      <c:if test="${req.getLoginedMember().getId() != 0}">
				        <button onclick="clickLikePoint();" class="ml-1">
				          <span id="likePointCnt"></span>
				          <span id="likePointBtn"></span>
				        </button>
				      </c:if>
				    </span>
				  </div>
				</div>
				<div class="flex flex-row gap-2 justify-between">
				<div><i class="fa-solid fa-school pr-2 text-orange-500 "></i>${article.institutionName}</div>
				<div><i class="fa-solid fa-phone pr-2 text-orange-500"></i> 전화번호 : ${article.phoneNumber}</div>
				<div><i class="fa-solid fa-check pr-2 text-orange-500"></i> 마감일 : ${article.deadline}</div>
				</div>
				<div class="flex flex-row gap-2 justify-between border-b pb-4 ">
				<div><i class="fa-solid fa-location-dot pr-2 text-orange-500"></i>근무지역 : ${article.city}</div>
				<div><i class="fa-regular fa-user pr-2 text-orange-500"></i>구인 직종 : ${article.workType}</div>
				<div><i class="fa-solid fa-briefcase pr-2 text-orange-500"></i>경력사항 : ${article.personalHistory}</div>
				<div><i class="fa-solid fa-sack-dollar pr-2 text-orange-500"></i> 급여 : ${article.hireSalary}</div>
				</div>
				<div class="text-gray-800">${article.content}</div>
				<div class= "pb-20">
				<c:forEach var="file" items="${files}">
				  <c:choose>
				    <c:when test="${file.originName.endsWith('.jpg') 
				                or file.originName.endsWith('.jpeg') 
				                or file.originName.endsWith('.png') 
				                or file.originName.endsWith('.gif')}">
				      <img src="${pageContext.request.contextPath}/usr/member/file/view/${file.savedName}"
				           alt="${file.originName}" style="max-width: 300px;" />
				    </c:when>
				    <c:otherwise>
				      <a href="${pageContext.request.contextPath}/usr/member/file/download/${file.savedName}" target="_blank">
						  ${file.originName} 다운로드
						</a>
				    </c:otherwise>
				  </c:choose>
				</c:forEach>
				</div>
			</c:if>
		</section>

<script>
	$(function(){
		getLikePoint();
	})

	const clickLikePoint = async function () {
		let likePointBtn = $('#likePointBtn > i').hasClass('fa-solid');
		
		await $.ajax({
			url : '/usr/likePoint/clickLikePoint',
			type : 'GET',
			data : {
				relTypeCode : 'article',
				relId : ${article.getId() },
				likePointBtn : likePointBtn
			},
		})
		await getLikePoint();
	}
		
		const getLikePoint = function () {
			$.ajax({
				url : '/usr/likePoint/getLikePoint',
				type : 'GET',
				data : {
					relTypeCode : 'article',
					relId : ${article.getId() },
				},
				dataType : 'json',
				success : function (data) {
					$('#likePointCnt').html(data.rsData);
					
					if (data.success) {
						$('#likePointBtn').html(`<i class="fa-solid fa-thumbs-up"></i>`);
					} else {
						$('#likePointBtn').html(`<i class="fa-regular fa-thumbs-up"></i>`);
					}
				},
				error : function (xhr, status, error) {
					console.log(error);
				}
			})
		}
		
	</script>



<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>