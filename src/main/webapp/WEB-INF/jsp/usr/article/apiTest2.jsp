<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="유치원 정보" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    // Ajax로 외부 API 호출
    function loadKinderInfo() {
        $.ajax({
            url: 'https://e-childschoolinfo.moe.go.kr/api/notice/basicInfo2.do',
            method: 'GET',
            data: {
                key: '126f40ebdd034241ba7c74ecca99bae9',
                sidoCode: 11,
                sggCode: 11110,
                pageCnt: 1000,
                currentPage: 1,
                _type: 'json'
            },
            dataType: 'json',
            success: function(data) {
                const items = data.response?.body?.items || [];
                let html = '';

                if (items.length === 0) {
                    html = '<p>데이터가 없습니다.</p>';
                } else {
                    items.forEach(function(item) {
                        const name = item.kindername || '이름 없음';
                        const ldgrname = item.ldgrname || '원장님 이름 없음';
                        const addr = item.addr || '주소 없음';
                        const tel = item.telno || '전화 없음';

                        html += `
                            <div class="p-4 mb-4 border-b bg-white">
                                <h2 class="text-lg font-bold text-orange-600">${name}</h2>
                                <p>${region} | ${addr}</p>
                                <p>${tel}</p>
                            </div>
                        `;
                    });
                }

                // 화면에 출력
                $('#dataContainer').html(html);
            },
            error: function(xhr, status, error) {
                console.error("API 호출 실패:", error);
                $('#dataContainer').html('<p>데이터를 불러오는데 실패했습니다.</p>');
            }
        });
    }

    // 페이지가 로드되면 API 호출
    $(document).ready(function() {
        loadKinderInfo();
    });
</script>

<section class="mt-8">
    <div class="container mx-auto bg-gray-400 p-4" id="dataContainer">
        <!-- 여기에 API 데이터가 출력됨 -->
    </div>
</section>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
