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

    <div class="p-3 pt-10">
        <c:forEach var="reply" items="${replies}">
            <c:if test="${reply.parentId == 0}">
                <div class="flex items-center border-b border-gray-300 pb-4 mb-4">
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

                            <c:if test="${reply.memberId == loginedMember.id}">
                                <button type="button" class="text-gray-500 hover:text-orange-500 text-xs ml-2 edit-reply-btn"
                                        data-reply-id="${reply.id}" data-reply-content="${reply.content}">
                                    수정
                                </button>
                                <button type="button" class="text-red-500 hover:text-red-600 text-xs ml-2 delete-reply-btn"
                                        data-reply-id="${reply.id}">
                                    삭제
                                </button>
                            </c:if>
                        </div>

                        <div class="edit-reply-form hidden">
                            <form action="/usr/reply/doModify" method="post">
                                <input type="hidden" name="id" value="${reply.id}" />
                                <textarea name="content" rows="2" maxlength="500" class="border border-gray-300 rounded-sm p-3 mt-2 text-gray-700 w-full"
                                          placeholder="댓글을 수정하세요">${reply.content}</textarea>
                                <div class="flex items-center justify-end gap-2">
                                    <button type="button" class="cancel-edit-btn text-sm text-red-500">취소</button>
                                    <button type="submit" class="save-edit-btn bg-gray-200 hover:bg-orange-200 px-4 py-2 rounded-md transition">수정하기</button>
                                </div>
                            </form>
                        </div>

                        <span class="text-gray-600 items-center gap-1">
                            <c:if test="${reply.isSecret}">
                                <c:if test="${reply.memberId == loginedMember.id || article.memberId == loginedMember.id}">
                                    <i class="fa-solid fa-lock text-orange-500 mr-1"></i>
                                </c:if>
                                <c:if test="${reply.memberId == loginedMember.id || article.memberId == loginedMember.id}">
                                    ${reply.content}
                                </c:if>
                                <c:if test="${reply.memberId != loginedMember.id && article.memberId != loginedMember.id}">
                                    비밀댓글입니다.
                                </c:if>
                            </c:if>
                            <c:if test="${!reply.isSecret}">
                                ${reply.content}
                            </c:if>
                        </span>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    document.querySelectorAll('.edit-reply-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            var replyId = btn.getAttribute('data-reply-id');
            var replyContent = btn.getAttribute('data-reply-content');
            var form = btn.closest('.flex.flex-col');
            var editForm = form.querySelector('.edit-reply-form');
            var replyText = form.querySelector('span');

            editForm.classList.remove('hidden');
            replyText.classList.add('hidden');

            var editTextArea = editForm.querySelector('textarea');
            editTextArea.value = replyContent;
        });
    });

    document.querySelectorAll('.cancel-edit-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            var form = btn.closest('.flex.flex-col');
            var editForm = form.querySelector('.edit-reply-form');
            var replyText = form.querySelector('span');

            editForm.classList.add('hidden');
            replyText.classList.remove('hidden');
        });
    });

    document.querySelectorAll('.delete-reply-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            var replyId = btn.getAttribute('data-reply-id');
            var confirmation = confirm("정말로 이 댓글을 삭제하시겠습니까?");
            if (confirmation) {
                fetch(`/usr/reply/doDelete?id=${replyId}`, {
                    method: 'POST'
                })
                .then(response => response.text()) 
                .then(data => {
                    alert("댓글이 삭제되었습니다.");

                    var replyElement = btn.closest('.flex.items-center');
                    replyElement.remove(); 

                    fetch(`/usr/article/detail?id=${articleId}`)
                    .then(response => response.text())
                    .then(data => {
                        document.querySelector('#replies-container').innerHTML = data;
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert("댓글 갱신에 실패했습니다.");
                    });
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("댓글 삭제에 실패했습니다.");
                });
            }
        });
    });
});

</script>



