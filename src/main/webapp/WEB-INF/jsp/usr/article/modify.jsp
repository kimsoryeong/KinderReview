<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pageTitle" value="수정" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-50 py-10 min-h-screen">
  <div class="container mx-auto max-w-4xl">
    <div class="bg-white rounded-t-lg shadow-sm border-b-4 border-orange-300 p-6 mb-1">
      <div class="flex justify-between items-center">
      <c:if test="${article.boardId == 4 || article.boardId == 5 || article.boardId == 6}">
        <div class="text-2xl font-bold text-orange-400">기관 리뷰 수정</div>
       </c:if>
      <c:if test="${article.boardId == 9 || article.boardId == 10 || article.boardId == 11 || article.boardId == 12}">
        <div class="text-2xl font-bold text-orange-400">게시글 수정</div>
       </c:if>
      </div>
    </div>
    <div class="bg-white rounded-2xl shadow-xl p-8 space-y-8">
      <form action="doModify" method="post" class="space-y-8 " enctype="multipart/form-data">
        <input name="id" type="hidden" value="${article.id}" />
	       <div class="px-6  flex justify-between text-sm text-gray-500">
	          <span>번호: ${article.getId()}</span>
	          <span>작성일: ${article.getUpdateDate()}</span>
	      </div>
	      <c:if test="${article.boardId == 4 || article.boardId == 5 || article.boardId == 6}">
          <div>
            <label for="institutionName" class="block px-6  font-semibold mb-1 text-gray-700">
              <i class="fa-solid fa-school text-orange-400 pr-3"></i>기관명 : ${article.institutionName}
            </label>
          </div>
          </c:if>
	   	<c:if test="${article.boardId == 4}">
        <div class="grid grid-col px-6 ">
            <label for="institutionComment" class="block font-semibold mb-1 text-gray-700">
              <i class="fa-solid fa-quote-left text-orange-400 pr-3"></i>한 줄 평
            </label>
            <input id="institutionComment" name="institutionComment" pattern=".{10,20}" value="${article.institutionComment}" required title="10~100자로 작성해주세요" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
         </div>
        <div class="bg-yellow-50 rounded-lg px-6 py-4 space-y-4">
          <h3 class="font-bold text-orange-500 text-lg flex items-center mb-2">
            <i class="fa-solid fa-sack-dollar pr-2"></i>급여 정보
          </h3>
          <div class="grid grid-cols-3 gap-6">
            <div>
              <label for="salaryScore" class="block font-semibold mb-1 text-gray-700">평점 (0-5)</label>
              <input id="salaryScore" name="salaryScore" type="number" min="0" max="5" value="${article.salaryScore}"
                class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-400" />
            </div>
            <div class="col-span-2">
              <label class="block font-semibold mb-1 text-gray-700">지원 항목</label>
              <div class="flex flex-wrap gap-2 bg-yellow-50 rounded p-2 border border-gray-300 min-h-[42px]">
                <c:set var="salaryList" value="${article.salaryOptions}" />
				<label>
				  <input type="checkbox" name="salaryOptions" value="시간 외 수당"
				    <c:if test="${fn:contains(salaryList, '시간 외 수당')}">checked</c:if> /> 시간 외 수당
				  <input type="checkbox" name="salaryOptions" value="퇴직금"
				    <c:if test="${fn:contains(welfareList, '퇴직금')}">checked</c:if> /> 퇴직금
				  <input type="checkbox" name="salaryOptions" value="상여금"
				    <c:if test="${fn:contains(salaryList, '상여금')}">checked</c:if> /> 상여금
				  <input type="checkbox" name="salaryOptions" value="식비"
				    <c:if test="${fn:contains(salaryList, '식비')}">checked</c:if> /> 식비
				</label>
              </div>
            </div>
          </div>
          <div>
            <label for="salaryComment" class="block font-semibold mb-1 text-gray-700">코멘트</label>
            <input id="salaryComment" name="salaryComment" pattern=".{5,50}" value="${article.salaryComment}" required title="5~50자로 작성해주세요" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
          </div>
        </div>

        <div class="bg-green-50 rounded-lg px-6 py-4 space-y-4">
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
              <div class="flex flex-wrap gap-2 bg-green-50 rounded p-2 border border-gray-300 min-h-[42px]">
                <c:set var="welfareList" value="${article.welfareOptions}" />
				<label>
				  <input type="checkbox" name="welfareOptions" value="연반차 사용"
				    <c:if test="${fn:contains(welfareList, '연반차 사용')}">checked</c:if> /> 연반차 사용
				  <input type="checkbox" name="welfareOptions" value="병가"
				    <c:if test="${fn:contains(welfareList, '병가')}">checked</c:if> /> 병가
				  <input type="checkbox" name="welfareOptions" value="방학"
				    <c:if test="${fn:contains(welfareList, '방학')}">checked</c:if> /> 방학
				  <input type="checkbox" name="welfareOptions" value="육아휴직"
				    <c:if test="${fn:contains(welfareList, '육아휴직')}">checked</c:if> /> 육아휴직
				  <input type="checkbox" name="welfareOptions" value="휴게시간"
				    <c:if test="${fn:contains(welfareList, '휴게시간')}">checked</c:if> /> 휴게시간
				</label>
              </div>
            </div>
          </div>
          <div>
            <label for="welfareComment" class="block font-semibold mb-1 text-gray-700">코멘트</label>
            <input id="welfareComment" name="welfareComment" pattern=".{5,50}" value="${article.welfareComment}" required title="5~50자로 작성해주세요" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
          </div>
        </div>

        <div class="bg-blue-50 rounded-lg px-6 py-4 space-y-4">
          <h3 class="font-bold text-orange-500 text-lg flex items-center mb-2">
            <i class="fa-solid fa-users pr-2"></i>근무환경 정보
          </h3>
          <div class="grid grid-cols-3 gap-6">
            <div>
              <label for="environmentScore" class="block font-semibold mb-1 text-gray-700">평점 (0-5)</label>
              <input id="environmentScore" name="environmentScore" type="number" min="0" max="5" value="${article.environmentScore}"
                class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-400" />
            </div>
	          <div>
	            <label for="commuteTimeComment" class="block font-semibold mb-1 text-gray-700">출퇴근시간</label>
	            <input id="commuteTimeComment" name="commuteTimeComment" value="${article.commuteTimeComment}"
	              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"></>
	          </div>
            </div>
          <div>
            <label for="environmentComment" class="block font-semibold mb-1 text-gray-700">코멘트</label>
            <input id="environmentComment" name="environmentComment" pattern=".{5,50}" value="${article.environmentComment}" required title="5~50자로 작성해주세요" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
          </div>
        </div>
        </c:if>	
        
	   	<c:if test="${article.boardId == 5}">
	   	<div class="grid grid-cols-2 px-6 gap-6">
          <div>
            <label for="institutionComment" class="block font-semibold mb-1 text-gray-700">
              <i class="fa-solid fa-quote-left text-orange-400 pr-3"></i>한 줄 평
            </label>
            <input id="institutionComment" name="institutionComment" pattern=".{10,20}" value="${article.institutionComment}" required title="10~100자로 작성해주세요" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
          </div>
          <div>
            <label for="interviewScore" class="block font-semibold mb-1 text-gray-700">
              <i class="fa-regular fa-star-half-stroke text-orange-400 pr-3"></i>면접 총 평점 (0-5)
            </label>
            <div>
              <input id="interviewScore" name="interviewScore" type="number" min="0" max="5" value="${article.interviewScore}"
                class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400" />
            </div>
          </div>
			<div>
			  <label class="block font-semibold mb-1 text-gray-700">
			    <i class="fa-solid fa-briefcase text-orange-400 pr-3"></i>경력사항
			  </label>
			  <label>
			    <input type="radio" name="personalHistory" value="신입 교사" 
			      ${article.personalHistory == '신입 교사' ? 'checked' : ''} />
			    신입 교사
			  </label>
			  <label class="ml-4">
			    <input type="radio" name="personalHistory" value="경력 교사" 
			      ${article.personalHistory == '경력 교사' ? 'checked' : ''} />
			    경력 교사
			  </label>
			</div>
			
			<div class="">
			  <label class="block font-semibold mb-1 text-gray-700">
			    <i class="fa-regular fa-square-check text-orange-400 pr-3"></i>면접결과
			  </label>
			  <label>
			    <input type="radio" name="interviewResults" value="합격" 
			      ${article.interviewResults == '합격' ? 'checked' : ''} />
			    합격
			  </label>
			  <label class="ml-4">
			    <input type="radio" name="interviewResults" value="불합격" 
			      ${article.interviewResults == '불합격' ? 'checked' : ''} />
			    불합격
			  </label>
			</div>

          </div>
        <div class="bg-yellow-50 rounded-lg p-6 space-y-4">
          <h3 class="font-bold text-orange-500 text-lg flex items-center mb-2">
            <i class="fa-solid fa-circle-info pr-2"></i>면접 정보
          </h3>
          <div>
            <label for="interviewMaterial" class="block font-semibold mb-1 text-gray-700">면접 준비</label>
            <input id="interviewMaterial" name="interviewMaterial" pattern=".{10,100}" value="${article.interviewMaterial}" required title="10~100자로 작성해주세요" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
          </div>
          <div>
            <label for="interviewProgress" class="block font-semibold mb-1 text-gray-700">면접 진행</label>
            <textarea id="interviewProgress" name="interviewProgress" rows="1" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400">${article.interviewProgress}</textarea>
          </div>
          <div>
            <label for="interviewCompleted" class="block font-semibold mb-1 text-gray-700">면접 마무리</label>
            <textarea id="interviewCompleted" name="interviewCompleted" rows="1"
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400">${article.interviewCompleted}</textarea>
          </div>
        </div>
        <div class="bg-yellow-50 rounded-lg p-6 space-y-4">
          <h3 class="font-bold text-orange-500 text-lg flex items-center mb-2">
           <i class="fa-solid fa-circle-question pr-2"></i>질의응답
          </h3>
          <div>
            <label for="interviewQnA" class="block font-semibold mb-1 text-gray-700">질의응답</label>
            <input id="interviewQnA" name="interviewQnA" pattern=".{10,100}" value="${article.interviewQnA}" required title="10~100자로 작성해주세요" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
          </div>
          <div>
            <label for="interviewTip" class="block font-semibold mb-1 text-gray-700">조언</label>
            <textarea id="interviewTip" name="interviewTip" rows="1" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400">${article.interviewTip}</textarea>
          </div>
        </div>
        </c:if>	
	   	<c:if test="${article.boardId == 6}">
	   	<div class="grid grid-cols-2 gap-6 px-6">
          <div>
            <label for="practiceComment" class="block font-semibold mb-1 text-gray-700">
              <i class="fa-solid fa-quote-left text-orange-400 pr-3"></i>한 줄 평
            </label>
            <input id="practiceComment" name="practiceComment" pattern=".{10,20}" value="${article.practiceComment}" required title="10~100자로 작성해주세요" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
          </div>
          <div>
            <label for="practiceScore" class="block font-semibold mb-1 text-gray-700">
              <i class="fa-regular fa-star-half-stroke text-orange-400 pr-3"></i>실습 및 봉사 총 평점 (0-5)
            </label>
            <div>
              <input id="practiceScore" name="practiceScore" type="number" min="0" max="5" value="${article.practiceScore}"
                class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400" />
            </div>
          </div>
          </div>
			<div class="px-6">
			  <label class="block font-semibold mb-1 ">
			  <i class= "fa-solid fa-graduation-cap text-orange-400 pr-2"></i>학력사항
			  </label>
			  <label>
			    <input type="radio" name="educationalBackground" value="2~3년제" 
			      ${article.educationalBackground == '2~3년제' ? 'checked' : ''} />
			    2~3년제
			  </label>
			  <label class="ml-4">
			    <input type="radio" name="educationalBackground" value="4년제" 
			      ${article.educationalBackground == '4년제' ? 'checked' : ''} />
			    4년제
			  </label>
			  <label class="ml-4">
			    <input type="radio" name="educationalBackground" value="학점은행제" 
			      ${article.educationalBackground == '학점은행제' ? 'checked' : ''} />
			    학점은행제
			  </label>
			  <label class="ml-4">
			    <input type="radio" name="educationalBackground" value="사이버대" 
			      ${article.educationalBackground == '사이버대' ? 'checked' : ''} />
			    사이버대
			  </label>
          </div>
        <div class="bg-yellow-50 rounded-lg p-6 space-y-4">
          <h3 class="font-bold text-orange-500 text-lg flex items-center mb-2">
            <i class="fa-solid fa-circle-info pr-2"></i>활동 내용 및 소감
          </h3>
          <div>
            <label for="practiceAtmosphere" class="block font-semibold mb-1 text-gray-700">기관의 분위기</label>
            <input id="practiceAtmosphere" name="practiceAtmosphere" pattern=".{10,100}" value="${article.practiceAtmosphere}" required title="10~100자로 작성해주세요" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
          </div>
          <div>
            <label for="practiceExperience" class="block font-semibold mb-1 text-gray-700">세부 경험</label>
            <textarea id="practiceExperience" name="practiceExperience" rows="1" 
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400">${article.practiceExperience}</textarea>
          </div>
          <div>
            <label for="practiceReview" class="block font-semibold mb-1 text-gray-700">기관의 지원 및 소감</label>
            <textarea id="practiceReview" name="practiceReview" rows="1"
              class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-yellow-400">${article.practiceReview}</textarea>
          </div>
        </div>
        </c:if>
      <c:if test="${article.boardId == 9}">
	    <input type="hidden" name="id" value="${article.id}" />
	    <div class="grid gap-6">
	      <div>
	        <label for="title" class="block font-semibold mb-1 text-orange-400">제목</label>
	        <input id="title" name="title" value="${article.title}" required
	          class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300" />
	      </div>
	      <div class="flex flex-row gap-2 justify-between">
	        <div class="flex-1">
	          <label for="phoneNumber" class="block font-semibold mb-1 text-orange-400">
	            <i class="fa-solid fa-phone pr-2 text-orange-500"></i>전화번호
	          </label>
	          <input id="phoneNumber" name="phoneNumber" value="${article.phoneNumber}" required
	            class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300" />
	        </div>
	        <div class="flex-1">
	          <label for="deadline" class="block font-semibold mb-1 text-orange-400">
	            <i class="fa-solid fa-check pr-2 text-orange-500"></i>마감일
	          </label>
	          <input id="deadline" name="deadline" type="date" value="${article.deadline}" required
	            class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300" />
	        </div>
	        <div class="flex-1">
	          <label for="personalHistory" class="block font-semibold mb-1 text-orange-400">
	            <i class="fa-solid fa-briefcase pr-2 text-orange-500"></i>경력사항
			  </label>
			  <label>
			    <input type="radio" name="personalHistory" value="유" 
			      ${article.personalHistory == '유' ? 'checked' : ''} />
			    유
			  </label>
			  <label class="ml-4">
			    <input type="radio" name="personalHistory" value="무관" 
			      ${article.personalHistory == '무관' ? 'checked' : ''} />
			    무관
			  </label>
				</div>
	      </div>
	      <div class="flex flex-row gap-2 justify-between pb-4">
	        <div class="flex-1">
	            <label for="city" class="block font-semibold mb-1 text-gray-700">
	                <i class="fa-solid fa-location-dot text-orange-400 pr-3"></i>지역
	            </label>
	            <select id="city" name="city" class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300" onchange="updateDistricts()">
	                <option value="" disabled selected>지역을 선택해 주세요</option>
	                <option value="전체" <c:if test="${article.city == '전체'}">selected</c:if>>전체</option>
	                <option value="서울" <c:if test="${article.city == '서울'}">selected</c:if>>서울</option>
	                <option value="대전" <c:if test="${article.city == '대전'}">selected</c:if>>대전</option>
	                <option value="대구" <c:if test="${article.city == '대구'}">selected</c:if>>대구</option>
	                <option value="부산" <c:if test="${article.city == '부산'}">selected</c:if>>부산</option>
	                <option value="인천" <c:if test="${article.city == '인천'}">selected</c:if>>인천</option>
	                <option value="광주" <c:if test="${article.city == '광주'}">selected</c:if>>광주</option>
	                <option value="세종" <c:if test="${article.city == '세종'}">selected</c:if>>세종</option>
	                <option value="울산" <c:if test="${article.city == '울산'}">selected</c:if>>울산</option>
	                <option value="강원" <c:if test="${article.city == '강원'}">selected</c:if>>강원</option>
	                <option value="경기" <c:if test="${article.city == '경기'}">selected</c:if>>경기</option>
	                <option value="경남" <c:if test="${article.city == '경남'}">selected</c:if>>경남</option>
	                <option value="경북" <c:if test="${article.city == '경북'}">selected</c:if>>경북</option>
	                <option value="전남" <c:if test="${article.city == '전남'}">selected</c:if>>전남</option>
	                <option value="전북" <c:if test="${article.city == '전북'}">selected</c:if>>전북</option>
	                <option value="제주" <c:if test="${article.city == '제주'}">selected</c:if>>제주</option>
	                <option value="충남" <c:if test="${article.city == '충남'}">selected</c:if>>충남</option>
	                <option value="충북" <c:if test="${article.city == '충북'}">selected</c:if>>충북</option>
	            </select>
	        </div>
	        <div class="flex-1">
	          <label for="workType" class="block font-semibold mb-1 text-orange-400">
	            <i class="fa-regular fa-user pr-2 text-orange-500"></i>구인 직종
	          </label>
	          <select id="workType" name="workType" class="focus:outline-none focus:ring-2 focus:ring-orange-300 rounded-md border px-3 py-2 w-60">
		        <option value="" disabled selected>${article.workType}</option>
		        <option value="원장">원장</option>
		        <option value="원감">원감</option>
		        <option value="정교사">정교사</option>
		        <option value="보조교사">보조교사</option>
		        <option value="방과후교사">방과후교사</option>
		        <option value="종일반교사">종일반교사</option>
		        <option value="파트타임">파트타임</option>
		        <option value="방문교사">방문교사</option>
		        <option value="영양사">영양사</option>
		        <option value="기타">기타</option>
		      </select>
	        </div>
	        <div class="flex-1">
	          <label for="hireSalary" class="block font-semibold mb-1 text-orange-400">
	            <i class="fa-solid fa-sack-dollar pr-2 text-orange-500"></i>급여
	          </label>
	          <input id="hireSalary" name="hireSalary" value="${article.hireSalary}" required
	            class="w-50% border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300" />
	        </div>
		   </div>
	      <div>
	        <label for="content" class="block font-semibold mb-1 text-orange-400 border-t-2 py-5">내용</label>
	        <textarea id="content" name="content" required pattern=".{10,1000}" title="10~1000자"
	          class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300" rows="8">${article.content}</textarea>
	      </div>
	      <div class="file-upload">
	        <label for="workCertFile" class="inline-block cursor-pointer bg-orange-100 text-orange-700 font-semibold py-1 px-4 rounded hover:bg-orange-200 text-sm">
	          파일 선택
	        </label>
	        <input type="file" name="workCertFile" id="workCertFile" accept=".pdf,.jpg,.jpeg,.png" class="hidden" />
	        <span id="fileName" class="ml-2 text-sm text-gray-600">
	          <c:if test="${not empty files}">
	            <c:forEach items="${files}" var="file">
	              <span>${file.originName}</span>
	            </c:forEach>
	          </c:if>
	          <c:if test="${empty files}">
	            선택된 파일 없음
	          </c:if>
	        </span>
	        <c:if test="${not empty files}">
	          <ul class="mt-2">
	            <c:forEach items="${files}" var="file">
	              <li>
	                ${file.originName} 
	                <a href="/usr/member/file/delete/${file.id}?articleId=${article.id}" class="text-red-600 ml-2" onclick="return confirm('이 파일을 삭제하시겠습니까?');">삭제</a>
	              </li>
	            </c:forEach>
	          </ul>
	        </c:if>
	        <div class="text-xs text-gray-400 mt-2">PDF, JPG, PNG 파일만 업로드 가능합니다.</div>
	      </div>
    	</div>
		  <script>
		    document.getElementById('workCertFile').addEventListener('change', function () {
		      const fileNameSpan = document.getElementById('fileName');
		      if (this.files.length > 0) {
		        let names = [];
		        for(let i=0; i < this.files.length; i++) {
		          names.push(this.files[i].name);
		        }
		        fileNameSpan.textContent = names.join(', ');
		      } else {
		        fileNameSpan.textContent = '선택된 파일 없음';
		      }
		    });
		  </script>
		</c:if>
	   	<c:if test="${article.boardId == 11}">
    	<div class="grid gap-6 px-6">
	    <div class="grid grid-cols-2 gap-6">
	        <div>
	            <label for="boardName" class="block font-semibold mb-1 text-gray-700">
	                <i class="fa-solid fa-pencil text-orange-400 pr-3"></i>게시판
	            </label>
	            <select id="boardName" name="boardName" class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300" required>
				    <option value="${article.boardName}" disabled 
				    <c:if test="${empty article.boardName}">selected</c:if>>게시판을 선택해 주세요</option>
				    <c:if test="${loginedMember != null && loginedMember.authLevel == 0}">
				        <option value="공지사항" <c:if test="${article.boardName == '공지사항'}">selected</c:if>>공지사항</option>
				    </c:if>
				    <option value="자유게시판" <c:if test="${article.boardName == '자유게시판'}">selected</c:if>>자유게시판</option>
				    <option value="질문게시판" <c:if test="${article.boardName == '질문게시판'}">selected</c:if>>질문게시판</option>
				</select>

			</div>
		<div>
            <label for="city" class="block font-semibold mb-1 text-gray-700">
                <i class="fa-solid fa-location-dot text-orange-400 pr-3"></i>지역
            </label>
            <select id="city" name="city" class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300" onchange="updateDistricts()">
                <option value="" disabled selected>지역을 선택해 주세요</option>
                <option value="전체" <c:if test="${article.city == '전체'}">selected</c:if>>전체</option>
                <option value="서울" <c:if test="${article.city == '서울'}">selected</c:if>>서울</option>
                <option value="대전" <c:if test="${article.city == '대전'}">selected</c:if>>대전</option>
                <option value="대구" <c:if test="${article.city == '대구'}">selected</c:if>>대구</option>
                <option value="부산" <c:if test="${article.city == '부산'}">selected</c:if>>부산</option>
                <option value="인천" <c:if test="${article.city == '인천'}">selected</c:if>>인천</option>
                <option value="광주" <c:if test="${article.city == '광주'}">selected</c:if>>광주</option>
                <option value="세종" <c:if test="${article.city == '세종'}">selected</c:if>>세종</option>
                <option value="울산" <c:if test="${article.city == '울산'}">selected</c:if>>울산</option>
                <option value="강원" <c:if test="${article.city == '강원'}">selected</c:if>>강원</option>
                <option value="경기" <c:if test="${article.city == '경기'}">selected</c:if>>경기</option>
                <option value="경남" <c:if test="${article.city == '경남'}">selected</c:if>>경남</option>
                <option value="경북" <c:if test="${article.city == '경북'}">selected</c:if>>경북</option>
                <option value="전남" <c:if test="${article.city == '전남'}">selected</c:if>>전남</option>
                <option value="전북" <c:if test="${article.city == '전북'}">selected</c:if>>전북</option>
                <option value="제주" <c:if test="${article.city == '제주'}">selected</c:if>>제주</option>
                <option value="충남" <c:if test="${article.city == '충남'}">selected</c:if>>충남</option>
                <option value="충북" <c:if test="${article.city == '충북'}">selected</c:if>>충북</option>
            </select>
        </div>
		</div>
        <div>
            <label for="title" class="block font-semibold mb-1 text-orange-400 border-t-2 py-5">제목</label>
            <input id="title" name="title" value="${article.title}" required title="10~100자로 작성해주세요"
                class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300"/>
        </div>
        <div>
            <label for="content" class="block font-semibold mb-1 text-orange-400">내용</label>
            <textarea id="content" name="content" pattern=".{10,500}" required title="10~500자로 작성해주세요" 
                class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-orange-300">${article.content}</textarea>
        </div>
<div class="file-upload">
    <label for="workCertFile" class="inline-block cursor-pointer bg-orange-100 text-orange-700 font-semibold py-1 px-4 rounded hover:bg-orange-200 text-sm">
        파일 선택
    </label>
    <input type="file" name="workCertFile" id="workCertFile" accept=".pdf,.jpg,.jpeg,.png" class="hidden" />
    <span id="fileName" class="ml-2 text-sm text-gray-600">
        <c:if test="${not empty files}">
            <c:forEach items="${files}" var="file">
                <span>${file.originName}</span> <
            </c:forEach>
        </c:if>
        <c:if test="${empty files}">
            선택된 파일 없음
        </c:if>
    </span>
	    <c:if test="${not empty files}">
	        <ul class="mt-2">
	            <c:forEach items="${files}" var="file">
	                <li>
	                    ${file.originName} 
	                    <a href="/usr/member/file/delete/${file.id}?articleId=${article.id}" class="text-red-600 ml-2" onclick="return confirm('이 파일을 삭제하시겠습니까?');">삭제</a>
	                </li>
			     </c:forEach>
			   </ul>
		 </c:if>
   			 <div class="text-xs text-gray-400 mt-2">PDF, JPG, PNG 파일만 업로드 가능합니다.</div>
		</div>
    </div>
</c:if>

        <div class="flex pt-10 justify-end gap-4">
          <button type="submit"
            class="bg-orange-100 hover:bg-orange-300 text-orange-700 font-bold py-2 px-4 rounded-md transition ">
            수정
          </button>
          <button type="button" onclick="history.back();"
            class="bg-orange-100 hover:bg-orange-300 text-orange-700  font-bold py-2 px-6 rounded-md transition">
            뒤로가기
          </button>
        </div>
        
      </form>
     </div>
    </div>
</section>

<script>
    const fileInput = document.getElementById('workCertFile');
    const fileNameSpan = document.getElementById('fileName');

    fileInput.addEventListener('change', function () {
        if (fileInput.files.length > 0) {
            fileNameSpan.textContent = fileInput.files[0].name;
        } else {
            fileNameSpan.textContent = '선택된 파일 없음'; 
        }
    });
</script>
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>