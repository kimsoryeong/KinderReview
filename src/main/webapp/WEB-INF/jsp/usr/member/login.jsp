<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="로그인" />

<!DOCTYPE html>
<html>
<head>
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- 테일윈드, 데이지UI -->
<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
<link href="https://cdn.jsdelivr.net/npm/daisyui@5" rel="stylesheet" type="text/css" />
<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- 공용 CSS -->
<link rel="stylesheet" href="/resource/common.css" />
<meta charset="UTF-8">
<title>${pageTitle }</title>
<link rel="shortcut icon" href="/resource/images/favicon.ico" />
</head>

<section class="flex items-center justify-center pb-20 h-screen bg-gray-100">
	<div class="bg-white shadow-xl rounded-xl p-10 w-full max-w-md">
		<div class="text-center mb-8">
		<div class="flex justify-end text-orange-300 hover:text-orange-400 mb-10 items-center">
			<a href="/"><i class="fa-solid fa-house fa-2xl"></i></a>
		</div>	
			<h1 class="text-3xl font-bold text-orange-500">KinderReview</h1>
			<p class="text-sm text-gray-500 mt-1">로그인 후 이용하세요</p>
		</div>

		<form action="doLogin" method="post" onsubmit="return loginFormChk(this);">
			<div class="mb-4">
				<label class="block text-sm font-medium text-gray-700 mb-1">아이디</label>
				<div class="logininput flex items-center border border-gray-300 rounded-md px-3 py-2">
					<svg class="w-5 h-5 text-gray-400 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A4 4 0 018 16h8a4 4 0 012.879 1.804M15 11a3 3 0 10-6 0 3 3 0 006 0z" />
					</svg>
					<input type="text" name="loginId" class="w-full outline-none border-none" placeholder="아이디 입력" />
				</div>
			</div>

			<div class="mb-6">
				<label class="block text-sm font-medium text-gray-700 mb-1">비밀번호</label>
				<div  class="logininput flex items-center border border-gray-300 rounded-md px-3 py-2">
					<svg class="w-5 h-5 text-gray-400 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c1.104 0 2-.672 2-1.5S13.104 8 12 8s-2 .672-2 1.5.896 1.5 2 1.5zM6 10V8a6 6 0 1112 0v2a2 2 0 012 2v6a2 2 0 01-2 2H6a2 2 0 01-2-2v-6a2 2 0 012-2z" />
					</svg>
					<input type="password" name="loginPw" class="w-full outline-none border-none" placeholder="비밀번호 입력" />
				</div>
			</div>
			<button type="submit" class="w-full bg-orange-400 hover:bg-orange-500 text-white font-semibold py-2 rounded-md transition">
				로그인
			</button>
		</form>
	</div>
</section>
	<script>
	$(function() {
	    $('.logininput')
	        .css({
	            'border-color': 'gray',
	            'border-width': '1px',
	            'border-style': 'solid'
	        })
	        .on('focusin', function () {
	            $(this).css({
	                'border-color': '#ff9d23',
	                'border-width': '2px',
	                'border-style': 'solid'
	            });
	        })
	        .on('focusout', function () {
	            $(this).css({
	                'border-color': 'gray',
	                'border-width': '1px',
	                'border-style': 'solid'
	            });
	        });
	});
	
	const loginFormChk = function (form) {
		form.loginId.value = form.loginId.value.trim();
		form.loginPw.value = form.loginPw.value.trim();
		
		if (form.loginId.value.length == 0) {
			alert('아이디는 필수 입력 정보입니다');
			form.loginId.focus();
			return false;
		}
		
		if (form.loginPw.value.length == 0) {
			alert('비밀번호는 필수 입력 정보입니다');
			form.loginPw.focus();
			return false;
		}
		
		return true;
	}
	</script>
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>