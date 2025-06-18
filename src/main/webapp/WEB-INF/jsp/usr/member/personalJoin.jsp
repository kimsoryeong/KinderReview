<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="개인회원가입" />
<%@ include file="/WEB-INF/jsp/common/header.jsp" %> 

<section class="h-screen flex items-center pt-10 justify-center bg-gray-100">
	<div class="bg-white shadow-xl rounded-xl p-10 mb-30 w-full max-w-md">
		<div class="flex justify-end text-orange-300 hover:text-orange-400 mb-5 items-center">
			<a href="/"><i class="fa-solid fa-house fa-2xl"></i></a>
		</div>	
		<div class="text-center mb-8">
			<h1 class="text-3xl font-bold text-orange-500"><a href="/">KinderReview</a></h1>
			<p class="text-sm text-gray-500 mt-1">회원가입 후 이용하세요</p>
		</div>

		<form action="/usr/member/doPersonalJoin" method="post" onsubmit="return joinFormChk(this);">
			<div class="mb-4">
				<label class="block text-sm font-medium text-gray-700 mb-1">아이디</label>
				<div class="joininput flex items-center border border-gray-300 rounded-md px-3 py-2">
					<svg class="w-5 h-5 text-gray-400 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A4 4 0 018 16h8a4 4 0 012.879 1.804M15 11a3 3 0 10-6 0 3 3 0 006 0z" />
					</svg>
					<input type="text" id="loginId" name="loginId" class="w-full outline-none border-none" placeholder="아이디 입력" autocomplete="off" />
				</div>
				<div id="loginIdChkMsg" class="mt-2 text-sm h-5 text-center"></div>
				<div id="loginIdDupChkMsg" class="mt-1 text-sm h-5 text-center"></div>
			</div>
			<div class="mb-4">
				<label class="block text-sm font-medium text-gray-700 mb-1">비밀번호</label>
				<div class="joininput flex items-center border border-gray-300 rounded-md px-3 py-2">
					<svg class="w-5 h-5 text-gray-400 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c1.104 0 2-.672 2-1.5S13.104 8 12 8s-2 .672-2 1.5.896 1.5 2 1.5zM6 10V8a6 6 0 1112 0v2a2 2 0 012 2v6a2 2 0 01-2 2H6a2 2 0 01-2-2v-6a2 2 0 012-2z" />
					</svg>
					<input type="password" id="loginPw" name="loginPw" class="w-full outline-none border-none" placeholder="비밀번호 입력" autocomplete="new-password" />
				</div>
				<div id="loginPwChkMsg" class="mt-2 text-sm h-5 text-center"></div>
			</div>
			<div class="mb-4">
				<label class="block text-sm font-medium text-gray-700 mb-1">비밀번호 확인</label>
				<div class="joininput flex items-center border border-gray-300 rounded-md px-3 py-2">
					<svg class="w-5 h-5 text-gray-400 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c1.104 0 2-.672 2-1.5S13.104 8 12 8s-2 .672-2 1.5.896 1.5 2 1.5zM6 10V8a6 6 0 1112 0v2a2 2 0 012 2v6a2 2 0 01-2 2H6a2 2 0 01-2-2v-6a2 2 0 012-2z" />
					</svg>
					<input type="password" id="loginPwChk" name="loginPwChk" class="w-full outline-none border-none" placeholder="비밀번호 확인" autocomplete="new-password" />
				</div>
				<div id="loginPwChkMsg2" class="mt-2 text-sm h-5 text-center"></div>
			</div>
			<div class="mb-6">
				<label class="block text-sm font-medium text-gray-700 mb-1">닉네임</label>
				<div class="joininput flex items-center border border-gray-300 rounded-md px-3 py-2">
					<svg class="w-5 h-5 text-gray-400 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A4 4 0 018 16h8a4 4 0 012.879 1.804M15 11a3 3 0 10-6 0 3 3 0 006 0z" />
					</svg>
					<input type="text" id="nickname" name="nickname" class="w-full outline-none border-none" placeholder="닉네임 입력" />
				</div>
				<div id="nicknameChkMsg" class="mt-2 text-sm h-5 text-center"></div>
			</div>
			<button type="submit" class="w-full bg-orange-400 hover:bg-orange-500 text-white font-semibold py-2 rounded-md transition">
				회원가입
			</button>
		</form>
	</div>
</section>
<script>
	let validLoginId = null;
	let validNickname = null;

	function validateLoginId(loginId) {
		return /^[a-z0-9]{5,20}$/.test(loginId);
	}
	function validateLoginPw(loginPw) {
		return /^[A-Za-z]{5,20}$/.test(loginPw);
	}
	function validateNickname(nickname) {
		return /^[가-힣a-zA-Z0-9]{2,10}$/.test(nickname);
	}

	$('#loginId').on('input blur', function() {
		const val = $(this).val().trim();
		const msgEl = $('#loginIdChkMsg');
		const dupMsgEl = $('#loginIdDupChkMsg');
		if (val.length === 0) {
			msgEl.text('아이디는 필수 입력 정보입니다').removeClass('text-green-500').addClass('text-red-500');
			dupMsgEl.text('');
			validLoginId = null;
			return;
		}
		if (!validateLoginId(val)) {
			msgEl.text('아이디는 5~20자의 영문 소문자, 숫자만 가능합니다').removeClass('text-green-500').addClass('text-red-500');
			dupMsgEl.text('');
			validLoginId = null;
			return;
		}
		msgEl.text('');
		$.ajax({
			url : '/usr/member/loginIdDupChk',
			type : 'GET',
			data : { loginId : val },
			dataType : 'json',
			success : function (data) {
				if (data.success) {
					dupMsgEl.removeClass('text-red-500').addClass('text-green-500').text(data.rsMsg);
					validLoginId = val;
				} else {
					dupMsgEl.removeClass('text-green-500').addClass('text-red-500').text(data.rsMsg);
					validLoginId = null;
				}
			},
			error : function (xhr, status, error) {
				console.log(error);
			}
		});
	});

	$('#loginPw').on('input blur', function() {
		const val = $(this).val().trim();
		const msgEl = $('#loginPwChkMsg');
		if (val.length === 0) {
			msgEl.text('비밀번호는 필수 입력 정보입니다').removeClass('text-green-500').addClass('text-red-500');
		} else if (!validateLoginPw(val)) {
			msgEl.text('비밀번호는 5~20자의 영문 대/소문자만 가능합니다').removeClass('text-green-500').addClass('text-red-500');
		} else {
			msgEl.text('');
		}
	});

	$('#loginPwChk, #loginPw').on('input blur', function() {
		const pw = $('#loginPw').val().trim();
		const pwChk = $('#loginPwChk').val().trim();
		const msgEl = $('#loginPwChkMsg2');
		if (pwChk.length === 0) {
			msgEl.text('');
			return;
		}
		if (pw !== pwChk) {
			msgEl.text('비밀번호가 일치하지 않습니다').removeClass('text-green-500').addClass('text-red-500');
		} else {
			msgEl.text('');
		}
	});

	$('#nickname').on('input blur', function() {
		const val = $(this).val().trim();
		const msgEl = $('#nicknameChkMsg');
		if (val.length === 0) {
			msgEl.text('닉네임은 필수 입력 정보입니다').removeClass('text-green-500').addClass('text-red-500');
			validNickname = null;
			return;
		}
		if (!validateNickname(val)) {
			msgEl.text('닉네임은 2~10자의 한글, 영문, 숫자만 가능합니다').removeClass('text-green-500').addClass('text-red-500');
			validNickname = null;
			return;
		}
		$.ajax({
			url : '/usr/member/nicknameDupChk',
			type : 'GET',
			data : { nickname : val },
			dataType : 'json',
			success : function (data) {
				if (data.success) {
					msgEl.removeClass('text-red-500').addClass('text-green-500').text(data.rsMsg);
					validNickname = val;
				} else {
					msgEl.removeClass('text-green-500').addClass('text-red-500').text(data.rsMsg);
					validNickname = null;
				}
			},
			error : function (xhr, status, error) {
				console.log(error);
			}
		});
	});

	const joinFormChk = function (form) {
		form.loginId.value = form.loginId.value.trim();
		form.loginPw.value = form.loginPw.value.trim();
		form.loginPwChk.value = form.loginPwChk.value.trim();
		form.nickname.value = form.nickname.value.trim();

		if (form.loginId.value.length == 0) {
			alert('아이디는 필수 입력 정보입니다');
			form.loginId.focus();
			return false;
		}
		if (!validateLoginId(form.loginId.value)) {
			alert('아이디는 5~20자의 영문 소문자, 숫자만 가능합니다');
			form.loginId.focus();
			return false;
		}
		if (form.loginId.value != validLoginId) {
			alert('[ ' + form.loginId.value + ' ] 은(는) 사용할 수 없는 아이디입니다.');
			form.loginId.value = '';
			form.loginId.focus();
			return false;
		}
		if (form.loginPw.value.length == 0) {
			alert('비밀번호는 필수 입력 정보입니다');
			form.loginPw.focus();
			return false;
		}
		if (!validateLoginPw(form.loginPw.value)) {
			alert('비밀번호는 5~20자의 영문 대/소문자만 가능합니다');
			form.loginPw.focus();
			return false;
		}
		if (form.loginPw.value != form.loginPwChk.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.value = '';
			form.loginPwChk.value = '';
			form.loginPw.focus();
			return false;
		}
		if (form.nickname.value.length == 0) {
			alert('닉네임은 필수 입력 정보입니다');
			form.nickname.focus();
			return false;
		}
		if (!validateNickname(form.nickname.value)) {
			alert('닉네임은 2~10자의 한글, 영문, 숫자만 가능합니다');
			form.nickname.focus();
			return false;
		}
		if (form.nickname.value != validNickname) {
			alert('[ ' + form.nickname.value + ' ] 은(는) 사용할 수 없는 닉네임입니다.');
			form.nickname.value = '';
			form.nickname.focus();
			return false;
		}
		return true;
	}

	$(function() {
	    $('.joininput')
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
</script>
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>
</body>
</html>