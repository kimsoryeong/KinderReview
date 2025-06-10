<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<section class="bg-gray-50 py-5 ">
  <div class="container mx-auto max-w-5xl border border-red-500 ">
    <div class="mb-5 text-center">
      <div class="text-4xl font-bold text-orange-500 mb-2">KinderReview</div>
      <div class="text-lg text-gray-600">유아교사를 위한 유아교육기관 리뷰 & 정보 플랫폼</div>
    </div>

    <div class="bg-white shadow-lg rounded-xl p-6 mb-8 flex flex-col md:flex-row gap-6">
      <div class="flex-1 min-h-[300px]">
        <div id="map" class="w-full h-72 flex border border-black-500 items-center justify-center">
          지도
        </div>
      </div>
      <div class="w-full md:w-80 flex flex-col justify-between">
        <div>
          <div class="block text-sm font-semibold text-gray-700 mb-2">지역별 유아교육기관 찾기</div>
          <input type="search" class="search-input w-full border border-gray-300 rounded-md px-3 py-2 mb-2 outline-none" placeholder="지역명, 기관명 등 검색" />
          <button class="w-full bg-orange-300 hover:bg-orange-400 text-white font-bold py-2 rounded-md transition">검색</button>
        </div>
        <div class="mt-4">
          <label class="block text-xs text-gray-500 mb-1">기관 유형 선택</label>
          <div class="flex flex-wrap gap-2 mb-3">
            <button class="bg-gray-200 hover:bg-orange-300 text-gray-700 px-3 py-1 rounded">유치원</button>
            <button class="bg-gray-200 hover:bg-orange-300 text-gray-700 px-3 py-1 rounded">어린이집</button>
          </div>
        </div>
      </div>
    </div>
	<div class="todayReview border border-red-500 ">
      <div class="flex items-center mb-2 p-3 border border-green-500 ">
        <span class="text-lg font-semibold text-orange-500 mr-2">오늘의 리뷰</span>
        <a href="#" class="text-sm text-gray-400 hover:text-orange-400 ml-auto">더보기</a>
      </div>
      <div class="bg-white rounded-lg shadow-lg grid grid-cols-3 md:grid-cols-2 gap-4">
        <div class="bg-gray-50 p-4 rounded-lg shadow-lg grid grid-cols-1">
          <span class="font-bold">[${article.city}]&nbsp;${article.institutionName}</span>
          <div class="pt-2 text-gray-500">"${article.content}"</div>
        </div >
        <div class="bg-gray-50 p-4 rounded-lg shadow-lg grid grid-cols-1">
          <span class="font-bold">[대전]&nbsp;adfasd유치원</span>
          <div class="pt-2 text-gray-500">"adsfdasf"</div>
        </div>
       <div class="bg-gray-50 p-4 rounded-lg shadow-lg grid grid-cols-1 pt-7">
          <span class="font-bold">[서울]&nbsp;adfasd유치원</span>
          <div class="pt-2 text-gray-500">"adsfdasf"</div>
        </div>
        <div class="bg-gray-50 p-4 rounded-lg shadow-lg grid grid-cols-1 pt-7">
          <span class="font-bold">[부산]&nbsp;adfasd유치원</span>
          <div class="pt-2 text-gray-500">"adsfdasf"</div>
        </div>
      </div>
      </div>
	</div>
</section>

<script>
	$(function() {
	    $('.search-input')
	        .css({
	            'border-color': 'gray',
	            'border-width': '1px',
	            'border-style': 'solid'
	        })
	        .on('focusin', function () {
	            $(this).css({
	                'border-color': 'gray',
	                'border-width': '2px',
	                'border-style': 'solid'
	            });
	        })
	        .on('focusout', function () {
	            $(this).css({
	                'border-color': 'gray',
	                'border-width': '1px',
	                'border-style': 'solid'
	            });
	        });
	});

</script>
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
