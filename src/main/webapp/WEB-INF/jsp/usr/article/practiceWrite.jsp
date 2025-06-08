<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="작성" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
	<div>실습 및 봉사활동 후기작성페이지!!!!</div>
	<section class="mt-8">
		<div class="container mx-auto">
			<form action="doWrite" method="post">
				<div class="table-box">
					<table class="table">
						<tr>
							<th>게시판</th>
							<td>
								<c:if test="${req.getLoginedMember().getAuthLevel() == 0 }">
									<label>
										<input class="radio radio-neutral radio-xs" name="boardId" type="radio" value="1" />
										공지사항
									</label>
									&nbsp;&nbsp;&nbsp;
								</c:if>
								<label>
									<input class="radio radio-neutral radio-xs" name="boardId" type="radio" value="2"  />
									근무 후기
								</label>
								&nbsp;&nbsp;&nbsp;
								<label>
									<input class="radio radio-neutral radio-xs" name="boardId" type="radio" value="3" />
									면접 후기
								</label>
								&nbsp;&nbsp;&nbsp;
								<label>
									<input class="radio radio-neutral radio-xs" name="boardId" type="radio" value="4" checked/>
									실습 및 봉사 후기
								</label>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input class="input input-neutral" name="title" type="text" /></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea class="textarea textarea-neutral" name="content"></textarea></td>
						</tr>
						<tr>
							<td colspan="2"><button class="btn btn-neutral btn-outline btn-sm btn-wide">저장</button></td>
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