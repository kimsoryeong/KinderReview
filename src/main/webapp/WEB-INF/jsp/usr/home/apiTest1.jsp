<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>


	<script>
	/* ?serviceKey=&numOfRows=10&pageNo=1&dataType=XML */
		const api_key = 'TYVGBMLA-TYVG-TYVG-TYVG-TYVGBMLAF1';
		const url = 'https://www.safemap.go.kr/openApiService/data/getInfantFacilityData.do';
		
		const apiTest = function (){
			$.ajax({
				url: url,
				type: 'GET',
				data: {
					serviceKey: api_key,
					numOfRows: 5000,
					pageNo: 1,
					dataType: 'XML'
				},
				dataType: 'XML',
				success: function (data){
					console.log(data);
					/* $('#apiTest'); */
				},
				error: function (xhr, status, error) {
					console.log(error);
				}
			})
		}
		
		apiTest();
	
	</script>
	
	<section class="mt-8">
		<div class="container mx-auto">
			<div>api test 페이지</div>
			<div>
			    <pre>${xmlData}</pre>
			</div>	
			<div id="apiTest"></div>
		</div>
	</section>


	
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>