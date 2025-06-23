<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="글쓰기" />
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp"%>


<section class="bg-gray-100 min-h-screen py-8">
 <form action="doWrite" method="post" id="communityWrite" enctype="multipart/form-data" >
	<div class="container mx-auto max-w-4xl">
		<div class="bg-white rounded-t-lg shadow p-6 mb-4 border-b-4 border-orange-300 flex justify-between items-center">
			<div>
				<h1 class="text-2xl font-bold text-orange-400">글쓰기</h1>
			</div>
		</div>
		<div class="bg-white border-b-2  rounded-t-lg p-8 shadow">
			<div class="flex flex-wrap gap-3 justify-around items-center">
				<div class="font-bold pb-3 text-orange-400 ">
					<i class="fa-solid fa-pencil pr-5 "></i>게시판
				</div>
				<select style="width: 250px;" id="boardName" 
					class="rounded-md pl-1 select border" name="boardName" required>
					<option class="text-center h-40" value="" disabled selected>게시판을 선택해 주세요</option>
				 <c:if test="${loginedMember != null && loginedMember.authLevel == 0}">
			        <option value="공지사항">공지사항</option>
			    </c:if>
					<option value="자유게시판">자유게시판</option>
					<option value="질문게시판">질문게시판</option>
				</select>
				<div class="font-bold pb-3 text-orange-400 ">
					<i class="fa-solid fa-location-dot pr-5 "></i>지역
				</div>
				<select style="width: 250px;" id="city" onchange="updateDistricts()"
					class="rounded-md select pl-1 border" name="city">
					<option class="text-center h-40" value="" disabled selected>지역을
						선택해 주세요</option>
					<option value="전체">전체</option>
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
				</div>
			<div class=" p-5 border-b-2">
				<span class="font-bold pr-3 text-orange-400"> <i
					class="fa-solid fa-file-image pr-5"></i>첨부 파일
				</span> 
				<label for="workCertFile"
					class="inline-block cursor-pointer  bg-orange-100 text-orange-700 font-semibold py-1 px-4 rounded hover:bg-orange-200 text-sm">
					파일 선택 
				</label> 
				<span id="fileName" class="ml-2 text-sm text-gray-600">선택된 파일 없음</span> 
				<input type="file" name="workCertFile" id="workCertFile" accept=".pdf,.jpg,.jpeg,.png" class="hidden" />
				<div class="text-xs text-gray-400 ">PDF, JPG, PNG 파일만 업로드 가능합니다.</div>
			</div>
			<div class="bg-white  rounded-lg pt-4 pl-2 ">
				<div class="">
					<div class="pb-3">
						<div class="font-bold pb-3 text-orange-400 ">제목</div>
						<input name="title" placeholder="제목을 작성해주세요."
							class="p-2 bg-gray-100 text-sm border-gray-300 rounded-sm w-full" />
					</div>
						<div class="font-bold pb-3 text-orange-400 ">내용</div>
					<textarea name="content" cols=120 rows=10 placeholder="내용을 작성해주세요."
						style="overflow-x: hidden;"
						class="p-2 bg-gray-100 text-sm border-gray-300 rounded-sm w-full"></textarea>
				</div>


				<div class="pt-2 flex justify-between items-center">
					<button
						class="tab-title px-4 py-1 rounded-lg text-3xl text-orange-300 hover:text-orange-400 transition cursor-pointer"
						onclick="history.back();" type="button">
						<i class="fa-solid fa-arrow-left"></i>
					</button>
					<button type="submit"
						class="btn-wide  bg-orange-300 hover:bg-orange-400 text-white font-bold rounded-lg"
						style="width: 150px; height: 40px;">작성</button>
				</div>
			</div>
		</div>
	</div>
	</form>
</section>


<script>
  const fileInput = document.getElementById('workCertFile');
  const fileNameSpan = document.getElementById('fileName');

  fileInput.addEventListener('change', function () {
    if (fileInput.files.length > 0) {
      fileNameSpan.textContent = fileInput.files[0].name;
    } else {
      fileNameSpan.textContent = '선택된 파일 없음';
    }
  });
</script>




<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>