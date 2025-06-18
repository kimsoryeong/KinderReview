<%@ page pageEncoding="UTF-8" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="bg-white rounded-2xl  mt-3">
    <form action="/usr/reply/doWrite" method="post" class="space-y-4 flex flex-col" id="mainReplyForm">
        <input type="hidden" name="relTypeCode" value="${relTypeCode}" />
        <input type="hidden" name="relId" value="${relId}" />
        <input type="hidden" name="parentId" value="0" />
        <input type="hidden" name="isSecret" value="false" class="isSecretInput" />
        <div class="flex flex-col">
            <textarea id="content" name="content" rows="2" maxlength="500" class="border border-gray-300 rounded-sm p-3 mt-2 text-gray-700 w-full"
             placeholder="댓글을 입력하세요" required></textarea>
        </div>
        <div class="flex items-center justify-end gap-2 ">
            <button type="button" class="pr-2 secretToggleBtn focus:outline-none group">
                <i class="fa-solid fa-unlock text-gray-500 text-xl "></i>
            </button>
            <button type="submit" class="bg-gray-200 hover:bg-orange-200  px-4 py-2 rounded-md transition">
                등록
            </button>
        </div>
    </form>
<div class="p-3 pt-10">
    <c:forEach var="reply" items="${replies}">
        <c:if test="${reply.parentId == 0}">
            <div class="flex  items-center border-b border-gray-300 pb-4 mb-4">
                <div class="flex flex-col gap-2 w-full">
                    <div class="flex justify-between items-center gap-2">
                    <div>
                        <strong>${reply.nickname}</strong>
                        <c:if test="${reply.memberId == article.memberId}">
                            <span class="text-orange-700 text-xs ml-2 rounded-sm bg-orange-100">작성자</span>
								</c:if>
                        <span class="text-xs pl-2 text-gray-500 ">
                                ${fn:substring(reply.regDate, 2, 16)}
                        </span>
                        </div>
                        <button type="button"
                                class="text-gray-500 hover:text-orange-500  text-xs ml-2 reply-toggle-btn"
                                data-reply-id="${reply.id}">
                            답글쓰기
                        </button>
                    </div>
                    <span class="text-gray-600 items-center gap-1">
                        <c:if test="${reply.isSecret}">
                            <i class="fa-solid fa-lock text-orange-500 mr-1"></i>
                        </c:if>
                        ${reply.content}
                    
                    </span>
                    <!-- 대댓글 입력 폼 (초기에는 숨김) -->
                    <form action="/usr/reply/doWrite" method="post"
                          class="reply-form mt-2 ml-4 w-full hidden flex flex-col gap-2"
                          id="reply-form-${reply.id}">
                        <input type="hidden" name="relTypeCode" value="${relTypeCode}" />
                        <input type="hidden" name="relId" value="${relId}" />
                        <input type="hidden" name="parentId" value="${reply.id}" />
                        <input type="hidden" name="isSecret" value="false" class="isSecretInput" />
                        <textarea name="content" rows="1" class="border rounded-lg p-2 mt-1 text-gray-700 w-full" placeholder="댓글을 입력하세요" required></textarea>
                        <div class="flex items-center justify-end gap-2 h-8">
                            <button type="button" class="flex items-center secretToggleBtn focus:outline-none h-8 group">
                                <i class="fa-solid fa-unlock text-gray-500 text-base "></i>
                            </button>
                            <button type="submit" class="bg-gray-200 hover:bg-orange-300 text-gray-700 px-3 py-1 rounded text-xs h-8 flex items-center">
                                등록
                            </button>
                        </div>
                    </form>
                    <!-- 대댓글 목록 -->
                    <c:forEach var="child" items="${replies}">
                        <c:if test="${child.parentId == reply.id}">
                            <div class="ml-6 mt-2 pb-2 pl-4">
                                <div class="flex items-center gap-2">
                                    <strong>${child.nickname}</strong>
                                    <c:if test="${child.memberId == article.memberId}">
			                            <span class="text-orange-700 text-xs ml-2 rounded-sm bg-orange-100">작성자</span>
			                        </c:if>
			                         <span class="text-xs text-gray-500 ">
                                        ${fn:substring(child.regDate, 2, 16)}
                                </span>
                                </div>
                                
                                <div class="text-gray-600 flex items-center gap-1">
                                    <c:if test="${child.isSecret}">
                                        <i class="fa-solid fa-lock text-orange-500 mr-1"></i>
                                    </c:if>
                                    ${child.content}
                                </div>
                               
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </c:forEach>
</div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // 답글쓰기/답글접기 토글
    document.querySelectorAll('.reply-toggle-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            var replyId = btn.getAttribute('data-reply-id');
            var form = document.getElementById('reply-form-' + replyId);

            // 이미 열려있으면 닫기(접기)
            if (form && !form.classList.contains('hidden')) {
                form.classList.add('hidden');
                btn.textContent = "답글쓰기";
                return;
            }

            // 모든 폼 닫고, 버튼 텍스트 원래대로
            document.querySelectorAll('.reply-form').forEach(function(f) {
                f.classList.add('hidden');
            });
            document.querySelectorAll('.reply-toggle-btn').forEach(function(b) {
                b.textContent = "답글쓰기";
            });

            // 현재 폼 열고, 버튼 텍스트 변경
            if (form) {
                form.classList.remove('hidden');
                form.querySelector('textarea').focus();
                btn.textContent = "답글접기";
            }
        });
    });

    // 모든 댓글/대댓글 폼의 비밀댓글 토글
    document.querySelectorAll('form').forEach(function(form) {
        var secretBtn = form.querySelector('.secretToggleBtn');
        var secretIcon = secretBtn && secretBtn.querySelector('i');
        var isSecretInput = form.querySelector('.isSecretInput');
        if (!secretBtn || !secretIcon || !isSecretInput) return; // 해당 요소 없으면 패스

        // 폼마다 독립적으로 isSecret 상태 관리
        let isSecret = false;
        secretBtn.addEventListener('click', function(e) {
            e.preventDefault(); // 폼 submit 방지
            isSecret = !isSecret;
            if (isSecret) {
                secretIcon.classList.remove('fa-unlock', 'text-gray-500');
                secretIcon.classList.add('fa-lock', 'text-orange-500');
                isSecretInput.value = "true";
            } else {
                secretIcon.classList.remove('fa-lock', 'text-orange-500');
                secretIcon.classList.add('fa-unlock', 'text-gray-500');
                isSecretInput.value = "false";
            }
        });
    });
});
</script>

