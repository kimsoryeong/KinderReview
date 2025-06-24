<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ol@v9.2.4/ol.css">
<script src="https://cdn.jsdelivr.net/npm/ol@v9.2.4/dist/ol.js"></script>

<section class="bg-gray-100 p-5 h-screen">
  <div class="container mx-auto max-w-4xl">
    <div class="my-5 text-center">
      <div class="text-4xl font-bold text-orange-500 mb-2">KinderReview</div>
      <div class="text-lg text-gray-600">교사와 기관이 함께 만드는 신뢰의 공간</div>
    </div>
    <div class="bg-white shadow-lg rounded-xl p-6 mb-8 flex flex-col md:flex-row gap-6">
      <div class="flex-1 min-h-[300px]">
        <div id="map" class="w-full h-72 flex border border-black-500 items-center justify-center">
        </div>
      </div>
      <div class="w-full md:w-80 justify-between">
      <div class="pb-5">
		  <form action="/" method="get" class="flex flex-col space-y-2">
		    <div class="block text-sm font-semibold text-gray-700">지역별 유아교육기관</div>
		    <select id="regionSelect" name="region"
		            class="search-input w-40 border border-gray-300 rounded-md px-3 py-2 outline-none cursor-pointer">
		      <option value="" selected>지역 선택</option>
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
		  </form>
		</div>
        <div class="">
          <form action="/" method="get">
            <div class="block text-sm font-semibold text-gray-700 mb-2">유아교육기관 찾기</div>
            <input type="search" class="search-input w-62 border border-gray-300 rounded-md px-3 py-2 mb-2 outline-none" placeholder="기관명을 입력하세요" />
            <button class="w-14 bg-orange-100 hover:bg-orange-300 text-orange-700 py-2 rounded-md transition" type="submit">검색</button>
          </form>
        </div>
		<div class=" mt-3">
		  <div class="text-sm font-bold ">검색목록</div>
		  <ul id="searchList" class="text-sm list-none text-gray-700 mt-2 list-disc list-inside max-h-48 overflow-auto"></ul>
		</div>
		
      </div>
    </div>

    <div class="todayReview rounded-md bg-white">
      <div class="flex items-center mb-2 p-3">
        <span class="text-lg font-semibold text-orange-500 mr-2">최신 근무 리뷰</span>
        <a href="/usr/article/list?boardId=4" class="text-sm text-gray-400 hover:text-orange-400 ml-auto">더보기</a>
      </div>
      <div class="bg-white px-5 pb-5 pt-3 rounded-lg shadow-lg grid grid-cols-1 md:grid-cols-2 gap-4">
        <c:forEach var="article" items="${latestReviewArticles}">
          <div class="bg-gray-50 p-4 border border-gray-200 rounded-lg shadow-lg">
            <div class="flex items-center text-sm font-semibold text-gray-800 mb-1">
              <span class="pr-2 font-bold text-gray-700">[${article.city}]</span>
              <i class="fa-solid fa-school pr-2 text-base "></i>
              <a href="/usr/article/detail?id=${article.id}" class="hover:text-orange-500 mr-2 truncate">
                ${article.institutionName}
              </a>
              <span class="text-yellow-500 flex items-center text-xs ml-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 20 20" fill="currentColor">
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                </svg>
                ${article.star}
              </span>
            </div>
            <div class="text-sm text-gray-700 mt-1 truncate">
              "${article.institutionComment}"
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
</section>


<script>
  const regionCoords = {
    "서울": [126.9784, 37.5665],
    "대전": [127.3845, 36.3504],
    "대구": [128.6014, 35.8714],
    "부산": [129.0756, 35.1796],
    "인천": [126.7052, 37.4563],
    "광주": [126.8514, 35.1595],
    "세종": [127.2890, 36.4800],
    "울산": [129.3114, 35.5384],
    "강원": [128.2119, 37.8228],
    "경기": [127.5183, 37.4138],
    "경남": [128.2132, 35.4606],
    "경북": [128.5912, 36.4919],
    "전남": [126.9173, 34.8161],
    "전북": [127.1530, 35.8242],
    "제주": [126.5312, 33.4996],
    "충남": [126.7052, 36.5184],
    "충북": [127.7276, 36.6580]
  };

  <c:choose>
    <c:when test="${not empty sessionScope.member}">
      const userRegion = "${sessionScope.member.address}";
    </c:when>
    <c:otherwise>
      const userRegion = "";
    </c:otherwise>
  </c:choose>

  const defaultCenter = [126.9784, 37.5665]; // 서울
  const centerCoords = regionCoords[userRegion] || defaultCenter;

  const baseLayer = new ol.layer.Tile({
    source: new ol.source.OSM()
  });

  const wmsLayer = new ol.layer.Tile({
    source: new ol.source.TileWMS({
      url: 'https://www.safemap.go.kr/openApiService/wms/getLayerData.do',
      params: {
        'LAYERS': 'A2SM_SAFETY_INFO_CHILD',
        'STYLES': 'A2SM_SAFETY_INFO_CHILD',
        'FORMAT': 'image/png',
        'TRANSPARENT': true,
        'apikey': 'TYVGBMLA-TYVG-TYVG-TYVG-TYVGBMLAF1'
      },
      serverType: 'geoserver',
      crossOrigin: 'anonymous'
    }),
    opacity: 1.0,
    visible: true
  });

  const map = new ol.Map({
    target: 'map',
    layers: [baseLayer, wmsLayer],
    view: new ol.View({
      center: ol.proj.fromLonLat(centerCoords),
      zoom: 13
    })
  });

  // DOM 로드 이후 실행
  document.addEventListener('DOMContentLoaded', function () {
    const regionSelect = document.getElementById('regionSelect');

    // select box 초기화
    if (userRegion && regionCoords[userRegion]) {
      regionSelect.value = userRegion;
    } else {
      regionSelect.value = ""; // "지역 선택"으로 초기화
    }

    regionSelect.addEventListener('change', function () {
      const selected = this.value;
      if (regionCoords[selected]) {
        const coords = regionCoords[selected];
        const view = map.getView();
        view.animate({
          center: ol.proj.fromLonLat(coords),
          duration: 700,
          zoom: 13
        });
      }
    });

    console.log("userRegion:", userRegion);
    console.log("regionSelect.value:", regionSelect.value);
    console.log("centerCoords:", centerCoords);
  });
</script>


<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>