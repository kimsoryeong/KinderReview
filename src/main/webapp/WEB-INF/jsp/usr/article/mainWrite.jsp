<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="기관리뷰 작성" />

<!DOCTYPE html>
<html>
<head>
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- 테일윈드, 데이지UI -->
<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
<link href="https://cdn.jsdelivr.net/npm/daisyui@5" rel="stylesheet" type="text/css" />
<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- 공용 CSS -->
<link rel="stylesheet" href="/resource/common.css" />
<meta charset="UTF-8">
<title>${pageTitle }</title>
<link rel="shortcut icon" href="/resource/images/favicon.ico" />
</head>

<%-- <%@ include file="/WEB-INF/jsp/common/header.jsp" %> --%>

	<section class="mt-4 mx-auto container">
		<div class=" icon-box flex justify-end h-15 text-orange-300 items-center">
			<i class="fa-solid fa-house fa-2xl"></i>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<i class="fa-regular fa-user fa-2xl"></i>
		</div>			  
		<div class="container border-2 bg-gray-100 shadow-xl">
			<form id="reviewForm" onsubmit="return false;">
			<div class="mx-auto text-center w-full max-w-2xl px-4 border-2">
				<div class="mt-5 border">
				<span class="px-2 items-center text-orange-500 font-bold text-3xl"><a href="/">KinderReview</a></span>
				<span class="px-2 items-center font-bold text-2xl">기관 리뷰 작성</span>
				</div>
				
				<input type="hidden" name="workType" id="hiddenWorkType" />
				<input type="hidden" name="city" id="hiddenCity" />
				<input type="hidden" name="institutionType" id="hiddenInstitutionType" />
				
				<div class="py-5">
					<div class="">
						<div class="font-bold text-lg text-gray-700 mb-2 block">근무유형</div>
					    <select id="workType" class="select w-full border rounded-md h-40 " name="work-type-select">
						   <option class ="text-center h-40 " value="" disabled selected >근무유형을 선택해주세요</option>
					       <option value="담임교사">담임교사</option>
					       <option value="부담임, 보조 및 연장반 교사">부담임, 보조 및 연장반 교사</option>
					       <option value="실습 및 봉사생">실습 및 봉사생</option>
					       <option value="대체교사">대체교사</option>
					       <option value="기타종사자">기타종사자</option>
					     </select>
					</div>
					<div class="pr-10 pl-10 pt-4 pb-4 ">
					 <div class="font-bold pb-4">근무지역</div>
					 <select id="city" onchange="updateDistricts()" style ="height:40px; width: 35%; border-radius: 5px;"class="select" name="city-select">
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
				 <div class="option pr-10 pl-10 pt-4 pb-4 ">
					 <div class="font-bold pb-4">기관유형</div>
				     <select id="institutionType" style ="height:40px; border-radius: 5px; width: 70%; " name="institution-type-select" class="select">
					   <option class ="text-center h-40" value="" disabled selected>기관유형을 선택해주세요</option>
				       <option value="유치원">유치원</option>
				       <option value="어린이집">어린이집</option>
				     </select>
				 </div>	
				 <div class="text-center">
					<div class="font-bold text-lg text-gray-700 mb-2 block">후기유형</div>
					<br />
						<div >
						<label>
							<input class="radio radio-neutral radio-xs" name="boardId" type="radio" value="1" />
							근무 후기
						</label>
						&nbsp;&nbsp;&nbsp;
						<label>
							<input class="radio radio-neutral radio-xs" name="boardId" type="radio" value="2" />
							면접 후기
						</label>
						&nbsp;&nbsp;&nbsp;
						<label>
							<input class="radio radio-neutral radio-xs" name="boardId" type="radio" value="3" />
							실습 및 봉사 후기
						</label>
						</div>
					</div>
				</div> 
				<div class="text-center p-10">
				  <button type="button"
					        class="btn-wide btn-m text-black bg-[#ffbf73] border-none hover:bg-[#f79614df] hover:border-[#ff9d23] transition"
					        style="width:150px; height:40px; border-radius: 5px;"
					        onclick="goToWritePage()">
					  다음
					</button>
				</div>
				</div>
			</form>
		</div>
			<div class="bg-white p-6 text-center flex justify-end">
				<div><button class="btn btn-outline btn-s" onclick="history.back();" style="border-radius: 5px;">뒤로가기</button></div>
			</div>
	</section>


	<script>
	
	<!-- hidden fields 추가 -->
	

	function goToWritePage() {
	    const workType = document.querySelector('select[name="work-type-select"]').value;
	    const city = document.querySelector('select[name="city-select"]').value;
	    const institutionType = document.querySelector('select[name="institution-type-select"]').value;
	    const selectedReviewType = document.querySelector('input[name="boardId"]:checked');

	    if (!workType) { alert("근무유형을 선택해주세요."); return; }
	    if (!city) { alert("근무지역을 선택해주세요."); return; }
	    if (!institutionType) { alert("기관유형을 선택해주세요."); return; }
	    if (!selectedReviewType) { alert("후기 유형을 선택해주세요."); return; }

	    // hidden 필드에 값 세팅 (POST 폼 제출용)
	    document.getElementById('hiddenWorkType').value = workType;
	    document.getElementById('hiddenCity').value = city;
	    document.getElementById('hiddenInstitutionType').value = institutionType;

	    const boardId = selectedReviewType.value;
	    let url = "";
	    switch (boardId) {
	        case "1":
	            url = "/usr/article/workingWrite?workType=" + encodeURIComponent(workType)
	                + "&city=" + encodeURIComponent(city)
	                + "&institutionType=" + encodeURIComponent(institutionType);
	            break;
	        case "2":
	            url = "/usr/article/interviewWrite?workType=" + encodeURIComponent(workType)
	                + "&city=" + encodeURIComponent(city)
	                + "&institutionType=" + encodeURIComponent(institutionType);
	            break;
	        case "3":
	            url = "/usr/article/practiceWrite?workType=" + encodeURIComponent(workType)
	                + "&city=" + encodeURIComponent(city)
	                + "&institutionType=" + encodeURIComponent(institutionType);
	            break;
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