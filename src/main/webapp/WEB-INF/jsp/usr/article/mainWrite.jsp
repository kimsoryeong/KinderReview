<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="기관리뷰 작성" />
<%@ include file="/WEB-INF/jsp/common/header.jsp" %> 

	<section class="flex items-center pt-2 justify-center bg-gray-100 min-h-screen">
		<div class="bg-white mx-auto  max-w-2xl shadow-xl rounded-xl mb-20 ">
		<div class="flex justify-end pr-5 pt-2 text-orange-300 hover:text-orange-400 items-center h-15">
			<a href="/usr/article/list?boardId=2"><i class="fa-solid fa-arrow-right-from-bracket fa-2xl"></i></a>
		</div>
	    <aside id="noticeBox" class="bg-gray-50 border-l-4 shadow border-orange-400 text-orange-800 p-4 rounded-md mx-6 mt-2 mb-4 relative">
	      <button onclick="document.getElementById('noticeBox').style.display='none'"
	        class="absolute top-2 right-2 text-orange-600 hover:text-orange-800">
	        <i class="fa-solid fa-xmark"></i>
	      </button>
	      <h2 class="font-bold text-lg mb-2 text-orange-700">후기 작성 전 유의사항</h2>
	      <ul class="list-disc list-inside text-sm space-y-1">
	        <li>본 게시판은 유아교육기관에 대한 <strong>개인의 근무 경험 공유</strong> 공간입니다.</li>
	        <li><strong>익명으로 운영되며, 작성자의 개인정보는 공개되지 않습니다.</strong></li>
	        <li>후기는 <strong>사실에 기반하여 신중하게 작성</strong>해 주세요.</li>
	        <li><strong>허위사실 작성, 명예훼손</strong> 시 민형사상 책임이 따를 수 있습니다.</li>
	        <li>작성자는 본 고지에 동의한 것으로 간주됩니다.</li>
	      </ul>
	    </aside>
			<form id="reviewForm" onsubmit="return false;">
			
			
			
			<div class=" rounded-2xl mx-auto text-center w-full max-w-2xl px-4">
				<div class="">
				<span class="px-2 items-center text-orange-500 font-bold text-3xl">KinderReview</span>
				<span class="px-2 items-center font-bold text-2xl">기관 리뷰 작성</span>
				</div>
			<div class="px-15 pt-5 pb-10">
				<input type="hidden" name="workType" id="hiddenWorkType" />
				<input type="hidden" name="city" id="hiddenCity" />
				<input type="hidden" name="institutionType" id="hiddenInstitutionType" />
				<div class="px-5 ">
					<div class="p-5">
						<div class="font-bold pb-4 text-lg text-orange-400"><i class="fa-regular fa-user pr-5"></i>근무유형</div>
					    <select style="width:400px;" id="workType" class="select h-10 rounded-md" name="work-type-select">
						   <option class ="text-center h-40 " value="" disabled selected >근무유형을 선택해주세요</option>
					       <option value="담임교사">담임교사</option>
					       <option value="부담임, 보조 및 연장반 교사">부담임, 보조 및 연장반 교사</option>
					       <option value="실습 및 봉사생">실습 및 봉사생</option>
					       <option value="대체교사">대체교사</option>
					       <option value="기타종사자">기타종사자</option>
					     </select>
					</div>
					<div class="p-5 ">
					 <div class="font-bold text-lg text-orange-400 pb-4"><i class="fa-solid fa-location-dot pr-5"></i>근무지역</div>
					 <select style="width:400px;" id="city" onchange="updateDistricts()" class="h-10 rounded-md select" name="city-select">
					    <option class ="text-center h-40" value="" disabled selected>-- 시/도 선택 --</option>
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
					  
					</div>
				 <div class="option p-5 ">
					 <div class="font-bold text-lg text-orange-400 pb-4"><i class="fa-solid fa-school pr-5"></i>기관유형</div>
				     <select style="width:400px;" id="institutionType" name="institution-type-select" class="h-10 rounded-md select">
					   <option class ="text-center" value=""  disabled selected>기관유형을 선택해주세요</option>
				       <option value="유치원">유치원</option>
				       <option value="어린이집">어린이집</option>
				     </select>
				 </div>	
				 <div class="text-center">
					<div class="text-center font-bold pt-4 text-lg text-orange-400"><i class="fa-regular fa-pen-to-square pr-5"></i>리뷰유형</div>
					<br />
						<div class="">
						<label>
							<input class="radio radio-neutral radio-xs" name="boardName" type="radio" value="근무 리뷰" />
							근무 리뷰
						</label>
						&nbsp;&nbsp;&nbsp;
						<label>
							<input class="radio radio-neutral radio-xs" name="boardName" type="radio" value="면접 리뷰" />
							면접 리뷰
						</label>
						&nbsp;&nbsp;&nbsp;
						<label>
							<input class="radio radio-neutral radio-xs" name="boardName" type="radio" value="실습 및 봉사 리뷰" />
							실습 및 봉사 리뷰
						</label>
						</div>
					</div>
				</div> 
				<div class="text-center pt-10">
				  <button type="button"
					        class="btn-wide w-150px h-10 rounded-md btn-m text-black bg-orange-300 hover:bg-orange-400 border-none transition hover:border-[#ff9d23]"
					        onclick="goToWritePage()">
					  다음
					</button>
					
				</div>
				</div>
				</div>
			</form>
		</div>
		
	</section>


	<script>
function goToWritePage() {
    const workType = document.querySelector('select[name="work-type-select"]').value;
    const city = document.querySelector('select[name="city-select"]').value;
    const institutionType = document.querySelector('select[name="institution-type-select"]').value;
    const selectedReviewType = document.querySelector('input[name="boardName"]:checked');

    if (!workType) { alert("근무유형을 선택해주세요."); return; }
    if (!city) { alert("근무지역을 선택해주세요."); return; }
    if (!institutionType) { alert("기관유형을 선택해주세요."); return; }
    if (!selectedReviewType) { alert("후기 유형을 선택해주세요."); return; }

    if (document.getElementById('hiddenWorkType')) document.getElementById('hiddenWorkType').value = workType;
    if (document.getElementById('hiddenCity')) document.getElementById('hiddenCity').value = city;
    if (document.getElementById('hiddenInstitutionType')) document.getElementById('hiddenInstitutionType').value = institutionType;

    const boardName = selectedReviewType.value; 
    let url = "";

    switch (boardName) {
        case "근무 리뷰":
            url = "/usr/article/workingWrite?workType=" + encodeURIComponent(workType)
                + "&city=" + encodeURIComponent(city)
                + "&institutionType=" + encodeURIComponent(institutionType)
                + "&boardName=" + encodeURIComponent(boardName);
            break;
        case "면접 리뷰":
            url = "/usr/article/interviewWrite?workType=" + encodeURIComponent(workType)
                + "&city=" + encodeURIComponent(city)
                + "&institutionType=" + encodeURIComponent(institutionType)
                + "&boardName=" + encodeURIComponent(boardName);
            break;
        case "실습 및 봉사 리뷰":
            url = "/usr/article/practiceWrite?workType=" + encodeURIComponent(workType)
                + "&city=" + encodeURIComponent(city)
                + "&institutionType=" + encodeURIComponent(institutionType)
                + "&boardName=" + encodeURIComponent(boardName);
            break;
        default:
            alert("리뷰 유형을 다시 선택해주세요.");
            return;
    }
    location.href = url;
}

$(function() {
    $('.select')
        .css({
            'border-color': 'black',
            'border-width': '1px',
            'border-style': 'solid'
        })
        .on('focus', function () {
            $(this).css({
                'border-color': '#ff6900',
                'border-width': '2px',
                'border-style': 'solid'
            });
        })
        .on('blur', function () {
            $(this).css({
                'border-color': 'black',
            });
        });
});
</script>


	  
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>