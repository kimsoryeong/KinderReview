<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원가입 선택" />
<%@ include file="/WEB-INF/jsp/common/header.jsp" %> 

<section class="h-screen flex items-center pt-10 justify-center bg-gray-100">
    <div class="bg-white shadow-xl rounded-xl p-10 mb-30 w-full max-w-md text-center">
        <div class="text-center mb-8">
            <h1 class="text-3xl font-bold text-orange-500"><a href="/">KinderReview</a></h1>
            <p class="text-sm text-gray-500 mt-1">회원 유형을 선택하세요</p>
        </div>

        <div class="flex justify-around mb-8 space-x-4">
            <button id="btnPersonal" class="w-1/2 pb-10 bg-orange-400 hover:bg-orange-500 text-white font-semibold py-4 rounded-md transition">
                <i class="fa-solid fa-user text-4xl pt-10"></i>
                <br><br>
                개인회원 가입
            </button>
            <button id="btnInstitution" class="w-1/2 pb-10 bg-orange-400 hover:bg-orange-500 text-white font-semibold py-4 rounded-md transition">
                <i class="fa-solid fa-school text-4xl pt-10"></i>
                <br><br>
                기업회원 가입
            </button>
        </div>
    </div>
</section>

<script>
    document.getElementById('btnPersonal').addEventListener('click', function() {
        location.href = '/usr/member/personalJoin';  
    });

    document.getElementById('btnInstitution').addEventListener('click', function() {
        location.href = '/usr/member/institutionJoin';  
    });
</script>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
</body>
</html>