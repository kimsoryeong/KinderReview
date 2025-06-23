<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="bg-white rounded-2xl mt-3">
    <form action="/usr/reply/doWrite" method="post" class="space-y-4 flex flex-col" id="mainReplyForm">
        <input type="hidden" name="relTypeCode" value="${relTypeCode}" />
        <input type="hidden" name="relId" value="${relId}" />
        <input type="hidden" name="parentId" value="0" />
        <input type="hidden" name="id" value="${reply.id}">
 	    <input type="hidden" name="memberId" value="${reply.memberId}">
        <input type="hidden" name="isSecret" value="false" class="isSecretInput" />
        <div class="flex flex-col">
            <textarea id="content" name="content" rows="2" maxlength="500" class="border border-gray-300 rounded-sm p-3 mt-2 text-gray-700 w-full"
             placeholder="댓글을 입력하세요" required></textarea>
        </div>
        <div class="flex items-center justify-end gap-2">
            <button type="button" class="pr-2 secretToggleBtn focus:outline-none group">
                <i class="fa-solid fa-unlock text-gray-500 text-xl "></i>
            </button>
            <button type="submit" class="bg-gray-200 hover:bg-orange-200 px-4 py-2 rounded-md transition">
                등록
            </button>
        </div>
    </form>
   <div class="p-3 pt-10" id="replies-container">
    <c:forEach var="reply" items="${replies}">
        <c:if test="${reply.parentId == 0}">
            <div class="reply border-b border-gray-300 pb-4 mb-4" id="${reply.id}">
                <div class="flex flex-col gap-2 w-full">
                    <div class="flex justify-between items-center gap-2">
                        <div>
                            <strong>${reply.nickname}</strong>
                            <c:if test="${reply.memberId == article.memberId}">
                                <span class="text-orange-700 text-xs ml-2 rounded-sm bg-orange-100">작성자</span>
                            </c:if>
                            <span class="text-xs pl-2 text-gray-500">
                                ${fn:substring(reply.regDate, 2, 16)}
                            </span>
                        </div>
                        <div class="flex items-center gap-2">
                            <c:if test="${reply.memberId == loginedMember.id}">
                                <button type="button"
                                        class="text-gray-500 hover:text-blue-500 text-xs ml-2 edit-reply-btn"
                                        data-reply-id="${reply.id}" data-reply-content="${reply.content}">
                                    수정
                                </button>
                            </c:if>
                            <c:if test="${reply.memberId == loginedMember.id || req.getLoginedMember().authLevel == 0}">
                                <button class="delete-reply-btn text-xs text-red-500" data-reply-id="${reply.id}">삭제</button>
                            </c:if>
                        </div>
                    </div>

                    <div class="reply-content text-gray-700 text-sm">
                        <c:if test="${reply.isSecret}">
                            <c:if test="${reply.memberId == loginedMember.id || article.memberId == loginedMember.id}">
                                <i class="fa-solid fa-lock text-orange-500 mr-1"></i>
                                ${reply.content}
                            </c:if>
                            <c:if test="${reply.memberId != loginedMember.id && article.memberId != loginedMember.id}">
                                <span class="text-gray-500">비밀댓글입니다.</span>
                            </c:if>
                        </c:if>
                        <c:if test="${!reply.isSecret}">
                            ${reply.content}
                        </c:if>
                    </div>

                    <div class="edit-reply-form hidden">
                        <form action="/usr/reply/doModify" method="post">
                            <input type="hidden" name="id" value="${reply.id}" />
                            <textarea name="content" rows="2" maxlength="500"
                                      class="border border-gray-300 rounded-sm p-3 mt-2 text-gray-700 w-full">${reply.content}</textarea>
                            <div class="flex items-center justify-end gap-2 mt-2">
                                <button type="button" class="cancel-edit-btn text-xs text-red-500">취소</button>
                                <button type="submit"
                                        class="save-edit-btn bg-gray-200 hover:bg-orange-200 px-2 py-1 text-sm rounded-sm transition">
                                    수정
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>
</div>
<script>
    const CURRENT_ARTICLE_ID = ${article.id};
</script>

<script>
document.addEventListener("DOMContentLoaded", function () {

    const secretBtn = document.querySelector('.secretToggleBtn');
    const isSecretInput = document.querySelector('.isSecretInput');
    const icon = secretBtn.querySelector('i');

    let isSecret = false;

    secretBtn.addEventListener('click', function () {
        isSecret = !isSecret;

        if (isSecret) {
            icon.classList.remove('fa-unlock', 'text-gray-500');
            icon.classList.add('fa-lock', 'text-orange-500');
            isSecretInput.value = 'true';
        } else {
            icon.classList.remove('fa-lock', 'text-orange-500');
            icon.classList.add('fa-unlock', 'text-gray-500');
            isSecretInput.value = 'false';
        }
    });

    document.querySelectorAll('.edit-reply-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
            const replyBox = btn.closest('.reply');
            const editForm = replyBox.querySelector('.edit-reply-form');
            const replyContent = replyBox.querySelector('.reply-content');

            editForm.classList.remove('hidden');
            replyContent.classList.add('hidden');

            const textarea = editForm.querySelector('textarea');
            textarea.value = btn.dataset.replyContent;
        });
    });

    document.querySelectorAll('.cancel-edit-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
            const replyBox = btn.closest('.reply');
            replyBox.querySelector('.edit-reply-form').classList.add('hidden');
            replyBox.querySelector('.reply-content').classList.remove('hidden');
        });
    });

    document.querySelectorAll('.delete-reply-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
            const replyId = btn.getAttribute('data-reply-id');

            if (!confirm("댓글을 삭제하시겠습니까?")) return;

            $.ajax({
                url: '/usr/reply/delete',
                type: 'POST',
                data: { id: replyId },
                success: function () {
                    $('#' + replyId).remove();

                    $.ajax({
                        url: '/usr/reply/count',
                        type: 'GET',
                        data: { relId: CURRENT_ARTICLE_ID },
                        success: function (res) {
                            $('#replyCount').text('댓글수 ' + res);
                        },
                        error: function () {
                            alert("댓글수 갱신 실패");
                        }
                    });
                },
                error: function () {
                    alert("댓글 삭제 실패");
                }
            });
        });
    });

});
</script>