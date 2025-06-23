<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="pageTitle" value="마이페이지" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-100 min-h-screen py-8">
  <div class="container mx-auto max-w-4xl">
    <div class="bg-white rounded-t-lg shadow p-6 mb-4 border-b-4 border-orange-300 flex justify-between items-center">
      <div>
        <h1 class="text-2xl font-bold text-orange-400">마이페이지</h1>
      </div>
      <c:set var="isLogined" value="${req.getLoginedMember().getId() != 0}" />
      <c:set var="authLevel" value="${req.getLoginedMember().getAuthLevel()}" />
      <c:set var="boardId" value="${board.getId()}" />
    
    </div>

    <div class="flex flex-col md:flex-row gap-4">
      <aside class="w-full md:w-48 min-w-40 bg-white rounded-lg shadow p-4 h-fit mb-4 md:mb-0">
        <div class="font-bold text-lg mb-4 text-gray-800 border-b-2 border-orange-400 pb-2">마이페이지</div>
        <a href="#" onclick="showSection('sectionMyInformation'); return false;" class="block py-2 pl-2 my-1 rounded-md hover:bg-orange-100 transition">
          회원 정보
        </a>
        <a href="#" onclick="showSection('sectionMyArticles'); return false;" class="block py-2 pl-2 my-1 rounded-md hover:bg-orange-100 transition">
          내가 작성한 글
        </a>
        <a href="#" onclick="showSection('sectionLikedArticles'); return false;" class="block py-2 pl-2 my-1 rounded-md hover:bg-orange-100 transition">
          좋아요 누른 글
        </a>
        <a href="#" onclick="showSection('sectionMyReplies'); return false;" class="block py-2 pl-2 my-1 rounded-md hover:bg-orange-100 transition">
          내가 단 댓글
        </a>
      </aside>

      <div class="flex-1 min-w-0">
		<div id="sectionMyInformation" class="bg-white rounded-lg shadow px-4 py-6 mb-5">
		  <div></div>
		  <h2 class="text-xl font-semibold mb-4">
		    <i class="fas fa-check text-orange-400 pr-2"></i>회원 정보
		  </h2>
		  <c:if test="${authLevel == 1}">
		  <div class="text-gray-500">아이디 : ${member.loginId}</div>
		  <div class="text-gray-500">닉네임 : ${member.nickname}</div>
		  </c:if>
		  <c:if test="${authLevel == 2}">
		  <div class="text-gray-500">아이디 : ${member.loginId}</div>
		  <div class="text-gray-500">기관명 : ${member.nickname}</div>
		  <div class="text-gray-500">기관번호 : ${member.institutionNumber}</div>
		  <div class="text-gray-500">사업자등록증
			<c:choose>
			  <c:when test="${not empty member.workChkFile}">
			    <a href="/usr/member/file/view/${member.workChkFile}" target="_blank">[ 보기 ]</a>
			  </c:when>
			  <c:otherwise>
			    <span class="text-gray-400 text-sm">첨부된 파일이 없습니다</span>
			  </c:otherwise>
			</c:choose>
            </div>
		  <div class="text-gray-500">가입 승인 상태 :
		  <c:if test="${member.approveStatus == 0}">
            <span class="px-2 py-1 bg-yellow-200 text-yellow-800 rounded-full text-sm">승인 대기 중</span>
            <span class="px-2 py-1  rounded-full text-sm">관리자의 승인 후 게시글 및 댓글 작성이 가능합니다.</span>
          </c:if>
		  <c:if test="${member.approveStatus == 1}">
            <span class="px-2 py-1 bg-green-200 text-green-800 rounded-full text-sm">승인 완료</span>
          </c:if>
		  <c:if test="${member.approveStatus == 2}">
		  <span class="px-2 py-1 bg-red-200 text-red-800 rounded-full text-sm">반려</span>
		  <span class="px-2 py-1 text-red-500 rounded-full text-sm">반려사유 : ${member.rejectReason}</span>
		  <form id="reuploadMemberForm" method="post" enctype="multipart/form-data"
		      action="/usr/file/reupload" onsubmit="return submitReuploadMemberForm()">
		  <input type="hidden" name="memberId" value="${member.id}" />
		  <input type="hidden" name="type" value="member" />
		  
		  <label for="workCertFileMember" class="block text-sm pt-2 font-medium text-gray-500 mb-1">
		    사업자등록증 재업로드:
		  </label>
		  <label for="workCertFileMember"
		         class="inline-block cursor-pointer bg-gray-100 text-gray-700 font-semibold py-1 px-4 rounded hover:bg-gray-200 text-sm">
		    파일 선택 
		  </label>
		  <span id="fileNameMember" class="ml-2 text-sm text-gray-600">선택된 파일 없음</span>
		  
		  <input type="file" name="file" id="workCertFileMember"
		         accept=".pdf,.jpg,.jpeg,.png" class="hidden" />
		  
		  <button type="submit"
		          class="ml-2 px-3 py-1 bg-orange-100 text-orange-700 font-semibold rounded hover:bg-orange-200 text-sm transition">
		    재업로드
		  </button>
		</form>
		</c:if>
		  </div>
		  </c:if>
		</div>
		<div id="sectionMyArticles" class="bg-white rounded-lg shadow p-4 mb-5">
		  <h2 class="text-xl font-semibold mb-4"><i class="fas fa-pencil-alt text-orange-400 mr-2"></i>내가 작성한 글</h2>
		  <c:forEach var="article" items="${myArticles}">
		    <div class="border border-gray-200 rounded-lg p-4 mb-4 hover:shadow-md transition-shadow duration-300">
		      <div class="flex justify-between items-center mb-2">
		  <div>
		    <strong class="text-lg text-gray-800">${article.boardName}</strong> - 
		    <span class="text-gray-600">${article.institutionName}</span>
		  </div>
		  <div>
		      <c:if test="${article.boardName == '근무 리뷰'}">
		        <c:choose>
		          <c:when test="${article.reviewStatus == 0}">
		            <span class="px-2 py-1 bg-yellow-200 text-yellow-800 rounded-full text-sm">승인 대기 중</span>
		          </c:when>
		          <c:when test="${article.reviewStatus == 1}">
		            <span class="px-2 py-1 bg-green-200 text-green-800 rounded-full text-sm">승인 완료</span>
		          </c:when>
		          <c:when test="${article.reviewStatus == 2}">
		            <span class="px-2 py-1 bg-red-200 text-red-800 rounded-full text-sm">반려</span>
		          </c:when>
		          <c:otherwise>
		            <span class="px-2 py-1 bg-gray-200 text-gray-700 rounded-full text-sm">상태 없음</span>
		          </c:otherwise>
		        </c:choose>
			      </c:if>
			  </div>
			</div>
		      <c:if test="${article.boardName eq '근무 리뷰' and article.reviewStatus eq 2}">
				  <div class="mb-2 text-red-600 text-sm">반려 사유: ${article.rejectReason}</div>
				  <form id="reuploadArticleForm" method="post" enctype="multipart/form-data"
				        action="/usr/file/reupload" onsubmit="return submitReuploadArticleForm()">
				    <input type="hidden" name="articleId" value="${article.id}" />
				      <input type="hidden" name="type" value="article" />
				    <label for="workProofFileArticle" class="block text-sm pt-2 font-medium text-gray-500 mb-1">
				      재직증빙자료 재업로드:
				    </label>
				    <label for="workProofFileArticle"
				           class="inline-block cursor-pointer bg-gray-100 text-gray-700 font-semibold py-1 px-4 rounded hover:bg-gray-200 text-sm">
				      파일 선택 
				    </label>
				    <span id="fileNameArticle" class="ml-2 text-sm text-gray-600">선택된 파일 없음</span>
				    <input type="file" name="file" id="workProofFileArticle"
				           accept=".pdf,.jpg,.jpeg,.png" class="hidden" />
				    <button type="submit"
				            class="ml-2 px-3 py-1 bg-orange-100 text-orange-700 font-semibold rounded hover:bg-orange-200 text-sm transition">
				      재업로드
				    </button>
				  </form>
				</c:if>
		      <c:if test="${article.boardName != '근무 리뷰' or (article.reviewStatus eq 1)}">
		      <a href="/usr/article/detail?id=${article.id}" 
		         class="inline-block text-orange-500 hover:text-orange-600 font-semibold">
		         [상세보기]
		      </a>
		      </c:if>
		    </div>
		  </c:forEach>
		  <c:if test="${empty myArticles}">
		    <div class="text-center text-gray-500 py-10">작성한 글이 없습니다.</div>
		  </c:if>
		</div>
        <div id="sectionLikedArticles" class="bg-white rounded-lg shadow p-4 mb-5 hidden">
          <h2 class="text-xl font-semibold mb-4"><i class="fas fa-heart text-orange-400 mr-2"></i>
          좋아요 누른 글</h2>
          <c:forEach var="article" items="${likedArticles}">
            <div class="border border-gray-200 rounded-lg p-4 mb-4 hover:shadow-md transition-shadow duration-300">
              <div class="flex justify-between items-center mb-2">
                <div>
                  <strong class="text-lg text-gray-800">${article.boardName}</strong> - 
                  <span class="text-gray-600">${article.institutionName}</span>
                </div>
              </div>
              <a href="/usr/article/detail?id=${article.id}" 
                 class="inline-block text-orange-500 hover:text-orange-600 font-semibold">
                 [상세보기]
              </a>
            </div>
          </c:forEach>
          <c:if test="${empty likedArticles}">
            <div class="text-center text-gray-500 py-10">좋아요 누른 글이 없습니다.</div>
          </c:if>
        </div>
        <div id="sectionMyReplies" class="bg-white rounded-lg shadow p-4 mb-5 hidden">
          <h2 class="text-xl font-semibold mb-4"><i class="fas fa-comments text-orange-400 mr-2"></i>
          내가 단 댓글</h2>
          <c:forEach var="reply" items="${myReplies}">
            <div class="border border-gray-200 rounded-lg p-4 mb-4 hover:shadow-md transition-shadow duration-300">
              <div class="text-gray-800 mb-1">
                <span class="font-semibold">댓글 내용</span>
                <c:if test="${reply.isSecret}">
                  <span class="ml-2 text-sm text-red-500">(비밀댓글)</span>
                </c:if>
              </div>
              <div class="text-gray-700 mb-2">${reply.content}</div>
              <a href="/usr/article/detail?id=${reply.relId}"
                 class="inline-block text-orange-500 hover:text-orange-600 font-semibold text-sm">[원문 보기]</a>
            </div>
          </c:forEach>
          <c:if test="${empty myReplies}">
            <div class="text-center text-gray-500 py-10">작성한 댓글이 없습니다.</div>
          </c:if>
        </div>

        <div class="flex justify-center mt-6">
          <div class="flex rounded-md overflow-hidden shadow">
            <c:set var="queryString" value="?boardId=${board.getId()}" />
            <c:if test="${begin != 1}">
              <a href="${queryString}&cPage=1" class="px-3 py-2 bg-white border border-gray-300 hover:bg-gray-100">
                <i class="fa-solid fa-angles-left"></i>
              </a>
              <a href="${queryString}&cPage=${begin - 1}" class="px-3 py-2 bg-white border-t border-b border-gray-300 hover:bg-gray-100">
                <i class="fa-solid fa-caret-left"></i>
              </a>
            </c:if>
            <c:forEach begin="${begin}" end="${end}" var="i">
              <a href="${queryString}&cPage=${i}" class="px-3 py-2 bg-white border border-gray-300 hover:bg-gray-100 ${cPage == i ? 'bg-orange-100 text-orange-600 font-bold' : ''}">
                ${i}
              </a>
            </c:forEach>
            <c:if test="${end != totalPagesCnt}">
              <a href="${queryString}&cPage=${end + 1}" class="px-3 py-2 bg-white border-t border-b border-gray-300 hover:bg-gray-100">
                <i class="fa-solid fa-caret-right"></i>
              </a>
              <a href="${queryString}&cPage=${totalPagesCnt}" class="px-3 py-2 bg-white border border-gray-300 hover:bg-gray-100">
                <i class="fa-solid fa-angles-right"></i>
              </a>
            </c:if>
          </div>
        </div>

      </div>
    </div> 
  </div> 
</section>

<script>
const fileInputMember = document.getElementById("workCertFileMember");
const fileNameDisplayMember = document.getElementById("fileNameMember");

if (fileInputMember) {
  fileInputMember.addEventListener("change", function () {
    const fileName = this.files.length > 0 ? this.files[0].name : "선택된 파일 없음";
    fileNameDisplayMember.textContent = fileName;
  });
}

function submitReuploadMemberForm() {
  if (!fileInputMember || !fileInputMember.files.length) {
    alert("파일을 선택해주세요.");
    return false;
  }
  return true;
}

const fileInputArticle = document.getElementById("workProofFileArticle");
const fileNameDisplayArticle = document.getElementById("fileNameArticle");

if (fileInputArticle) {
  fileInputArticle.addEventListener("change", function () {
    const fileName = this.files.length > 0 ? this.files[0].name : "선택된 파일 없음";
    fileNameDisplayArticle.textContent = fileName;
  });
}

function submitReuploadArticleForm() {
  if (!fileInputArticle || !fileInputArticle.files.length) {
    alert("파일을 선택해주세요.");
    return false;
  }
  return true;
}


function showSection(sectionId) {
  const sections = ['sectionMyInformation', 'sectionMyArticles', 'sectionLikedArticles', 'sectionPendingArticles', 'sectionMyReplies'];

  sections.forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      if (id === sectionId) {
        el.classList.remove('hidden');
      } else {
        el.classList.add('hidden');
      }
    }
  });
}

document.addEventListener('DOMContentLoaded', () => {
  showSection('sectionMyInformation');
});

</script>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>