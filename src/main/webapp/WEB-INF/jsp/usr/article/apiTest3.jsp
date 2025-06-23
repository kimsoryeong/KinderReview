<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="유치원 정보" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
  const apiKey = 'TYVGBMLA-TYVG-TYVG-TYVG-TYVGBMLAF1'; // 본인 인증키로 변경
  const apiUrl = 'https://safemap.go.kr/openApiService/data/getInfantFacilityData.do';

  function fetchKindergartenData() {
    $.ajax({
      url: apiUrl,
      method: "GET",
      data: {
        serviceKey: apiKey,
        pageNo: 1,
        numOfRows: 100,  // 필요하면 조정
        type: "xml"
      },
      dataType: "xml",
      success: function(xml) {
        const items = $(xml).find('item');
        if (items.length === 0) {
          $('#result').html('<p>데이터가 없습니다.</p>');
          return;
        }

        let html = '<ul>';
        items.each(function() {
        	  const fcltyty = $(this).find('FCLTYTY').text();
        	  if (fcltyty !== '05') return; // 유치원만 필터

        	  const name = $(this).find('FACILITY_NM').text();
        	  const address = $(this).find('ADDRESS').text();
        	  const lat = $(this).find('LATITUDE').text();
        	  const lon = $(this).find('LONGITUDE').text();

        	  console.log('유치원명:', name, '위도:', lat, '경도:', lon);

        	  if (name.indexOf(keyword) !== -1) {
        	    if (lat && lon) {
        	      foundItems.push({ name, address, lat: parseFloat(lat), lon: parseFloat(lon) });
        	    } else {
        	      console.warn('위치 정보 누락:', name);
        	    }
        	  }
        	});

        });
        html += '</ul>';

        $('#result').html(html);
      },
      error: function(xhr, status, error) {
        console.error("AJAX 호출 실패:", error);
        $('#result').html('<p>API 호출에 실패했습니다.</p>');
      }
    });
  }

  $(document).ready(function() {
    fetchKindergartenData();
  });
</script>

<div id="result" class="container mx-auto p-4 bg-white rounded shadow"></div>

<section class="mt-8">
  <div class="container mx-auto bg-gray-400 p-4" id="dataContainer">
    <!-- 추가 데이터 출력 영역 -->
  </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
