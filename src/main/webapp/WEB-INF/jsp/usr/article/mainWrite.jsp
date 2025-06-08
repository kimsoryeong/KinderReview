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
		<div class=" icon-box flex justify-end h-20 items-center">
			<i class="fa-solid fa-house fa-2xl"></i>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<i class="fa-regular fa-user fa-2xl"></i>
		</div>			  
		<div class="container">
			<form id="reviewForm" onsubmit="return false;">
			<div class="rounded-2xl mx-auto text-center w-full max-w-2xl px-4">
				<div class=" mt-5">
				<span class="px-2 items-center text-orange-500 font-bold text-3xl"><a href="/">KinderReview</a></span>
				<span class="px-2 items-center font-bold text-2xl">기관 리뷰 작성</span>
				</div>
				<br></br>
				
				<div class="">
					<div class="pr-10 pl-10 pt-4 pb-4">
						<div class="font-bold pb-4 ">근무유형</div>
					    <select style ="height:40px; border-radius: 5px; width: 70%;  " class="select " name="work-type-select">
						   <option class ="text-center h-40 " value="" disabled selected >근무유형을 선택해주세요</option>
					       <option>담임교사</option>
					       <option>부담임, 보조 및 연장반 교사</option>
					       <option>실습 및 봉사학생</option>
					       <option>대체교사</option>
					       <option>기타종사자</option>
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
					  <select id="district" style ="height:40px; border-radius: 5px; width: 34%;" class="select" name="district-select">
					    <option class ="text-center h-40" value="" disabled selected>-- 구/군 선택 --</option>
					  	</select>
					</div>
				 <div class="option pr-10 pl-10 pt-4 pb-4 ">
					 <div class="font-bold pb-4">기관유형</div>
				     <select style ="height:40px; border-radius: 5px; width: 70%; " name="insitution-type-select" class="select">
					   <option class ="text-center h-40" value="" disabled selected>기관유형을 선택해주세요</option>
				       <option>유치원</option>
				       <option>어린이집</option>
				     </select>
				 </div>	
				 <div class="text-center">
					<div class="text-center font-bold pt-4">후기유형</div>
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
					        class="btn-wide btn-m text-black bg-[#ffbf73] border-none hover:bg-[#f79614df] hover:border-[#ff9d23]"
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
		  function goToWritePage() {
		    const selected = document.querySelector('input[name="boardId"]:checked');
		    if (!selected) {
		      alert("후기 유형을 선택해주세요.");
		      return;
		    }
		
		    const boardId = selected.value;
		    let url = "";
		
		    switch (boardId) {
		      case "1":
		        url = "/usr/article/workingWrite";
		        break;
		      case "2":
		        url = "/usr/article/interviewWrite";
		        break;
		      case "3":
		        url = "/usr/article/practiceWrite";
		        break;
		    }
		
		    location.href = url;
		  }


	
	    const districtsByCity = {
	      "서울": ["강남구", "서초구", "송파구", "강북구", "강동구"],
	      "대전": ["서구", "중구", "동구", "대덕구", "유성구"],
	      "대구": ["중구", "동구", "서구", "남구", "북구", "수성구", "달서구"],
	      "부산": ["중구", "서구", "동구", "영도구", "부산진구", "해운대구"],
	      "인천": ["중구", "동구", "남동구", "부평구", "연수구"],
	      "광주": ["동구", "서구", "남구", "북구", "광산구"],
	      "세종": ["세종시 전체"],
	      "울산": ["중구", "남구", "동구", "북구", "울주군"],
	      "강원": ["춘천시", "원주시", "강릉시", "속초시", "동해시"],
	      "경기": ["수원시", "성남시", "고양시", "용인시", "부천시"],
	      "경남": ["창원시", "진주시", "김해시", "양산시", "거제시"],
	      "경북": ["포항시", "경주시", "구미시", "김천시", "안동시"],
	      "전남": ["목포시", "여수시", "순천시", "나주시", "광양시"],
	      "전북": ["전주시", "군산시", "익산시", "정읍시", "남원시"],
	      "제주": ["제주시", "서귀포시"],
	      "충남": ["천안시", "공주시", "아산시", "서산시", "논산시"],
	      "충북": ["청주시", "충주시", "제천시", "보은군", "옥천군"]
	    };
	
	    function updateDistricts() {
	      const citySelect = document.getElementById("city");
	      const districtSelect = document.getElementById("district");
	
	      const selectedCity = citySelect.value;
	      const districts = districtsByCity[selectedCity] || [];
	
	      // 기존 옵션 초기화
	      districtSelect.innerHTML = '<option value="">-- 구/군 선택 --</option>';
	
	      // 새 옵션 추가
	      districts.forEach(d => {
	        const option = document.createElement("option");
	        option.value = d;
	        option.textContent = d;
	        districtSelect.appendChild(option);
	      });
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

		/* const mainWriteChk = function (form) {
			
			if (form.loginId.value.length == 0) {
				alert('아이디는 필수 입력 정보입니다');
				form.loginId.focus();
				return false;
			}
			
			if (form.loginPw.value.length == 0) {
				alert('비밀번호는 필수 입력 정보입니다');
				form.loginPw.focus();
				return false;
			}
			
			return true;
		} */

	  </script>
	  
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>