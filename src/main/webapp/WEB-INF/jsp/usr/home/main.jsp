<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>
<!-- OpenLayers CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ol@v9.2.4/ol.css">
<script src="https://cdn.jsdelivr.net/npm/ol@v9.2.4/dist/ol.js"></script>


<section class="bg-gray-100 p-5 h-screen">
  <div class="container mx-auto max-w-4xl">
    <div class="my-5 text-center">
      <div class="text-4xl font-bold text-orange-500 mb-2">KinderReview</div>
      <div class="text-lg text-gray-600">유아교사를 위한 유아교육기관 리뷰 & 정보 플랫폼</div>
    </div>

    <div class="bg-white shadow-lg rounded-xl p-6 mb-8 flex flex-col md:flex-row gap-6">
      <div class="flex-1 min-h-[300px]">
        <div id="map" class="w-full h-72 flex border border-black-500 items-center justify-center">
          지도
        </div>
      </div>
      <div class="w-full md:w-80 justify-between">
        <div class="">
        <form action="/"  method="get">
          <div class="block  text-sm font-semibold text-gray-700 mb-2">지역별 유아교육기관 찾기</div>
          <input type="search" class="search-input w-62 border border-gray-300 rounded-md px-3 py-2 mb-2 outline-none" placeholder="기관명을 입력하세요" />
          <button class="w-14 bg-orange-100 hover:bg-orange-300 text-orange-700 py-2 rounded-md transition" type="submit">검색</button>
        </form>
        </div>
        <div class=" mt-3">
        <div class="text-sm font-bold text-gray-500">검색목록</div>
        <div class="mt-1 h-fit">
        <div class="flex justify-between items-center  p-2">
        	<i class="fa-solid fa-school fa-base text-gray-800"></i>
            <div class="font-bold text-base text-black-500">afasf유치원${article.institutionName}</div>
            <div><a href="#" class="text-xs text-gray-500 hover:text-orange-400 ml-auto">더보기</a></div>
        </div>
        </div>
        </div>
      </div>
    </div>
    
	<div class="todayReview rounded-md bg-white">
      <div class="flex items-center mb-2 p-3">
        <span class="text-lg font-semibold text-orange-500 mr-2">오늘의 리뷰</span>
        <a href="/usr/article/list?boardId=2" class="text-sm text-gray-400 hover:text-orange-400 ml-auto">더보기</a>
      </div>
      <div class="bg-white px-5 pb-5 pt-3 rounded-lg shadow-lg grid grid-cols-3 md:grid-cols-2 gap-4">
        <div class="bg-gray-50 p-4 rounded-lg shadow-sm grid grid-cols-1">
          <span class="font-bold">[${article.city}]&nbsp;${article.institutionName}</span>
          <div class="pt-2 text-gray-500">"${article.institutionComment}"</div>
        </div >
        <div class="bg-gray-50 p-4 rounded-lg shadow-sm grid grid-cols-1">
          <span class="font-bold">[대전]&nbsp;adfasd유치원</span>
          <div class="pt-2 text-gray-500">"adsfdasf"</div>
        </div>
       <div class="bg-gray-50 p-4 rounded-lg shadow-sm grid grid-cols-1 pt-7">
          <span class="font-bold">[서울]&nbsp;adfasd유치원</span>
          <div class="pt-2 text-gray-500">"adsfdasf"</div>
        </div>
        <div class="bg-gray-50 p-4 rounded-lg shadow-sm grid grid-cols-1 pt-7">
          <span class="font-bold">[부산]&nbsp;adfasd유치원</span>
          <div class="pt-2 text-gray-500">"adsfdasf"</div>
        </div>
      </div>
      </div>
      
	</div>
</section>

<script>
// 지도 초기화
var map = new ol.Map({
  target: 'map',
  layers: [
    // 기본 지도 (OpenStreetMap)
    new ol.layer.Tile({
      source: new ol.source.OSM()
    }),
    // WMS 레이어 (유아시설)
    new ol.layer.Tile({
      source: new ol.source.TileWMS({
        url: 'https://www.safemap.go.kr/openApiService/wms/getLayerData.do',
        params: {
          'apikey': 'SM69Y0vg2XMMU%2FgdP86ol%2BV%2BA4TF%2FOlorBAuweSvglYR4xIFFajCJFjME%2FXud2UymFZDOe4oxcqXqOFhOJ7HKw%3D%3D', // 본인 인증키로 변경!
          'layers': 'A2SM_SAFETY_INFO_CHILD',
          'styles': 'A2SM_SAFETY_INFO_CHILD',
          'format': 'image/png',
          'transparent': true
        },
        serverType: 'geoserver',
        crossOrigin: 'anonymous'
      }),
      opacity: 0.7 // 필요시 투명도 조절
    })
  ],
  view: new ol.View({
    center: ol.proj.fromLonLat([127.7669, 35.9078]), // 대한민국 중심 좌표
    zoom: 7
  })
});

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