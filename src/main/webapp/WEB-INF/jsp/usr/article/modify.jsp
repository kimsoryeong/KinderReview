<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="수정" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

	<section class="mt-8">
		<div class="container mx-auto">
			<form action="doModify" method="post">
				<input name="id" type="hidden" value="${article.getId() }" />
				<div class="table-box">
					<table class="table">
						<tr>
							<th>번호</th>
							<td>${article.getId() }</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td>${article.getRegDate().substring(2, 16) }</td>
						</tr>
						<tr>
							<th>수정일</th>
							<td>${article.getUpdateDate().substring(2, 16) }</td>
						</tr>
						<tr>
							<th>기관명</th>
							<td><input class="input input-neutral" name="institutionName" type="text" value="${article.getInstitutionName() }" /></td>
						</tr>
						<tr>
							<th>한 줄 평</th>
							<td><textarea class="textarea textarea-neutral" name="content">${article.getContent() }</textarea></td>
						</tr>
						<tr>
							<td colspan="2"><button class="btn btn-neutral btn-outline btn-sm btn-wide">수정</button></td>
						</tr>
					</table>
				</div>
			</form>
			
			<div class="bg-white p-6">
				<div><button class="btn btn-neutral btn-outline btn-xs" onclick="history.back();">뒤로가기</button></div>
			</div>
		</div>
	</section>
	
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>