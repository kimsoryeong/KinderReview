<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script>
    const api_key = 'SM69Y0vg2XMMU/gdP86ol+V+A4TF/OlorBAuweSvglYR4xIFFajCJFjME/Xud2UymFZDOe4oxcqXqOFhOJ7HKw==';
    const url = 'https://apis.data.go.kr/6300000/openapi2022/kinderschInfo/getkinderschInfo';

    function apiTest() {
        $.ajax({
            url: url,
            type: 'GET',
            data: {
                serviceKey: api_key,
                gu: 'A',
                pageNo: 1,
                numOfRows: 1000,
                _type: 'json'
            },
            dataType: 'json',
            success: function (data) {
                const items = data.response?.body?.items || [];

                let html = '';
                if (items.length === 0) {
                    html = '<p>데이터가 없습니다.</p>';
                } else {
                    items.forEach((item, i) => {
                        const name = item.kndrgrNm || '이름 없음';
                        const city = item.signgu || '지역 없음';
                        const addr = item.locplc || '주소 없음';
                        const tel = item.telno || '전화 없음';

                        html += `
                            <div class="p-4 mb-4 border-b bg-white">
                        	   <h2 class="text-lg font-bold text-orange-600">${'$'}{name}</h2>
						    <p>대전광역시 ${'$'}{city} | 대전광역시 ${'$'}{addr}</p>
						    <p>042-${'$'}{tel}</p>
						  </div>
                        `;
                    });
                }

                document.getElementById("dataContainer").innerHTML = html;
            },
            error: function (xhr, status, error) {
                console.error("❌ API 호출 실패", error);
            }
        });
    }

    document.addEventListener("DOMContentLoaded", apiTest);
</script>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-100 min-h-screen py-8">
  <div class="container mx-auto max-w-4xl" >
    <div class="bg-white rounded-t-lg shadow p-6 mb-4 border-b-4 border-orange-300 flex justify-between items-center">
	  <div class="items-center">
	    <span class="text-2xl pr-5 font-bold text-orange-400">유치원 정보</span>
        <div class="bg-white rounded-lg shadow p-4 mb-4 flex flex-col md:flex-row md:items-center md:justify-between gap-4">
          <form method="get" action="/usr/article/list" class="flex items-center gap-2">
            <input type="hidden" name="boardId" value="${board.id}" />
            <label for="city" class="text-sm font-medium text-gray-700">지역</label>
            <select id="city" name="city" onchange="updateDistricts()" class="border border-gray-300 rounded-md px-3 py-2 outline-none">
              <option value="" disabled selected>시/도</option>
              <option value="">전체</option>
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
            <button type="submit" class="bg-orange-100 hover:bg-orange-300 text-orange-700 px-4 py-2 rounded-md transition">조회</button>
          </form>
          <form action="/usr/article/list" method="get" class="flex items-center gap-2">
            <input type="hidden" name="boardId" value="${board.id}" />
            <select name="searchType" class="border border-gray-300 rounded-md px-2 py-2 outline-none">
              <option selected value="">선택</option>
              <option value="institutionName">기관명</option>
              <option value="content">내용</option>
              <option value="institutionName+cotent">기관명+내용</option>
            </select>
            <input type="text" name="keyword" id="keyword" class="border border-gray-300 rounded-md px-2 py-2 outline-none" placeholder="검색어 입력">
            <button class="bg-orange-100 hover:bg-orange-300 text-orange-700 px-4 py-2 rounded-md transition" type="submit">검색</button>
          </form>
        </div>
        <div id="dataContainer" class="container mx-auto bg-gray-100 p-4"></div>
	  </div>
    </div>
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>

