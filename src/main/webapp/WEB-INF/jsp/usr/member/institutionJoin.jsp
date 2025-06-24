<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="기업 회원가입" />
<%@ include file="/WEB-INF/jsp/common/header.jsp" %> 
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<section class="h-screen flex items-center pt-10 justify-center bg-gray-100">
  <div class="bg-white shadow-xl rounded-xl p-10 mb-30 w-full max-w-md">
    <div class="flex justify-end text-orange-300 hover:text-orange-400 mb-5 items-center">
      <a href="/"><i class="fa-solid fa-house fa-2xl"></i></a>
    </div>  
    <div class="text-center mb-8">
      <h1 class="text-3xl font-bold text-orange-500"><a href="/">KinderReview</a></h1>
      <p class="text-sm text-gray-500 mt-1">기업 회원가입 후 이용하세요</p>
    </div>

    <form id="institutionJoinForm" action="doInstitutionJoin" method="post" enctype="multipart/form-data" onsubmit="return institutionJoinFormChk(this);">

      <div id="step1">
	      <p class="text-sm text-orange-700">1단계 개인정보 입력</p>
	      <br />
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

        <button type="button" id="nextStepBtn" class="w-full bg-orange-400 hover:bg-orange-500 text-white font-semibold py-2 rounded-md transition">
          다음 단계
        </button>
      </div>

      <div id="step2" class="hidden">
    <div class="mb-4">
      <label class="block text-sm font-medium text-gray-700 mb-1">기업명</label>
      <div class="joininput flex items-center border border-gray-300 rounded-md px-3 py-2">
        <input required type="text" id="institutionName" name="institutionName" class="w-full outline-none border-none" placeholder="기업명 입력" />
      </div>
    </div>

    <div class="mb-4">
      <label class="block text-sm font-medium text-gray-700 mb-1">우편번호</label>
      <div class="flex">
        <input required type="text" id="zipCode" name="zipCode" class="w-1/3 border border-gray-300 rounded-md px-3 py-2 mr-2" placeholder="우편번호" readonly />
        <button type="button" id="searchZipBtn" class="bg-orange-400 hover:bg-orange-500 text-white px-4 rounded-md">우편번호 찾기</button>
      </div>
    </div>

    <div class="mb-4">
      <label class="block text-sm font-medium text-gray-700 mb-1">주소</label>
      <input required type="text" id="address" name="address" class="w-full border border-gray-300 rounded-md px-3 py-2" placeholder="주소" readonly />
    </div>

    <div class="mb-4">
      <label class="block text-sm font-medium text-gray-700 mb-1">상세 주소</label>
      <input type="text" id="addressDetail" name="addressDetail" class="w-full border border-gray-300 rounded-md px-3 py-2" placeholder="상세 주소 입력" />
    </div>

    <div class="flex justify-between">
      <button type="button" id="prevStepBtn2" class="px-6 py-2 rounded-md bg-gray-300 hover:bg-gray-400 text-gray-700 font-semibold transition">
        이전 단계
      </button>
      <button type="button" id="nextStepBtn2" class="px-6 py-2 rounded-md bg-orange-400 hover:bg-orange-500 text-white font-semibold transition">
        다음 단계
      </button>
    </div>
  </div>

  <div id="step3" class="hidden">
    <div class="mb-4">
      <label class="block text-sm font-medium text-gray-700 mb-1">사업자등록증 첨부</label>
      <input required type="file" name="bizFile" accept=".pdf,.jpg,.jpeg,.png" class="block w-full text-sm text-gray-500
          file:mr-4 file:py-2 file:px-4 file:border-0 file:text-sm file:font-semibold
          file:bg-orange-100 file:text-orange-700 hover:file:bg-orange-200
        " />
      <div class="text-xs text-gray-400 mt-1">PDF, JPG, PNG 파일만 업로드 가능합니다.</div>
    </div>

    <div class="mb-4">
      <label class="block text-sm font-medium text-gray-700 mb-1">사업자등록번호</label>
      <div class="joininput flex items-center border border-gray-300 rounded-md px-3 py-2">
        <input type="text" id="institutionNumber" name="institutionNumber" required class="w-full outline-none border-none" placeholder="사업자등록번호 입력 (숫자만)" />
      </div>
    </div>

    <div class="mb-6">
      <label class="block text-sm font-medium text-gray-700 mb-1">대표자명</label>
      <div class="joininput flex items-center border border-gray-300 rounded-md px-3 py-2">
        <input required type="text" id="ceoName" name="ceoName" class="w-full outline-none border-none" placeholder="대표자명 입력" />
      </div>
    </div>

    <div class="flex justify-between">
      <button type="button" id="prevStepBtn3" class="px-6 py-2 rounded-md bg-gray-300 hover:bg-gray-400 text-gray-700 font-semibold transition">
        이전 단계
      </button>
      <button type="submit" class="px-6 py-2 rounded-md bg-orange-400 hover:bg-orange-500 text-white font-semibold transition">
        회원가입 완료
      </button>
   	 </div>
 	 </div>
	</form>
  </div>
</section>
<script>
$('#searchZipBtn').click(function() {
  new daum.Postcode({
    oncomplete: function(data) {
      $('#zipCode').val(data.zonecode);
      $('#address').val(data.address);
      $('#addressDetail').focus();
    }
  }).open();
});

$(function() {
  $('.joininput')
    .css({'border-color': 'gray', 'border-width': '1px', 'border-style': 'solid'})
    .on('focusin', function () {
      $(this).css({'border-color': '#ff9d23', 'border-width': '2px', 'border-style': 'solid'});
    })
    .on('focusout', function () {
      $(this).css({'border-color': 'gray', 'border-width': '1px', 'border-style': 'solid'});
    });

  const loginIdInput = $('#loginId');
  const msgEl = $('#loginIdChkMsg');
  const dupMsgEl = $('#loginIdDupChkMsg');
  let validLoginId = null;

  function validateLoginId(loginId) {
    return /^[a-z0-9]{5,20}$/.test(loginId);
  }

  function setErrorMessage(element, message) {
    element.text(message).removeClass('text-green-500').addClass('text-red-500');
  }

  function clearErrorMessage(element) {
    element.text('').removeClass('text-red-500 text-green-500');
  }

  function setSuccessMessage(element, message) {
    element.text(message).removeClass('text-red-500').addClass('text-green-500');
  }

  async function checkLoginIdDuplication(val) {
    try {
      const data = await $.ajax({
        url: '/usr/member/loginIdDupChk',
        type: 'GET',
        data: { loginId: val },
        dataType: 'json'
      });
      return data;
    } catch (error) {
      console.log(error);
      return null;
    }
  }

  loginIdInput.on('input', async function() {
    const val = $(this).val().trim();

    if (val.length === 0) {
      setErrorMessage(msgEl, '아이디는 필수 입력 정보입니다');
      dupMsgEl.text('');
      validLoginId = null;
      return;
    }

    if (!validateLoginId(val)) {
      setErrorMessage(msgEl, '아이디는 5~20자의 영문 소문자, 숫자만 가능합니다');
      dupMsgEl.text('');
      validLoginId = null;
      return;
    }

    clearErrorMessage(msgEl);

    const data = await checkLoginIdDuplication(val);
    if (data === null) {
      dupMsgEl.text('');
      validLoginId = null;
      return;
    }

    if (data.success) {
      setSuccessMessage(dupMsgEl, data.rsMsg);
      validLoginId = val;
    } else {
      setErrorMessage(dupMsgEl, data.rsMsg);
      validLoginId = null;
    }
  });

  function getPasswordValues() {
    return {
      pw: $('#loginPw').val(),
      pwChk: $('#loginPwChk').val()
    };
  }

  function validateStep1() {
    const val = loginIdInput.val().trim();
    const { pw, pwChk } = getPasswordValues();

    if (val.length === 0) {
      alert('아이디를 입력해주세요');
      loginIdInput.focus();
      return false;
    }

    if (!validateLoginId(val)) {
      alert('아이디는 5~20자의 영문 소문자, 숫자만 가능합니다');
      loginIdInput.focus();
      return false;
    }

    if (val !== validLoginId) {
      alert('사용할 수 없는 아이디입니다');
      loginIdInput.focus();
      return false;
    }

    if (pw.length === 0) {
      alert('비밀번호를 입력해주세요');
      $('#loginPw').focus();
      return false;
    }

    if (pw.length < 5) {
      alert('비밀번호는 5자 이상이어야 합니다');
      $('#loginPw').focus();
      return false;
    }

    if (pw !== pwChk) {
      alert('비밀번호와 비밀번호 확인이 일치하지 않습니다');
      $('#loginPwChk').focus();
      return false;
    }

    return true;
  }

  function validateStep2() {
    const institutionName = $('#institutionName').val().trim();
    const zipCode = $('#zipCode').val().trim();
    const address = $('#address').val().trim();
    const addressDetail = $('#addressDetail').val().trim();

    if (institutionName.length === 0) {
      alert('기업명을 입력해주세요.');
      $('#institutionName').focus();
      return false;
    }

    if (zipCode.length === 0) {
      alert('우편번호를 입력해주세요.');
      $('#zipCode').focus();
      return false;
    }

    if (address.length === 0) {
      alert('주소를 입력해주세요.');
      $('#address').focus();
      return false;
    }

    if (addressDetail.length === 0) {
      alert('상세 주소를 입력해주세요.');
      $('#addressDetail').focus();
      return false;
    }

    return true;
  }

  function validateStep3() {
    const bizFileCount = $('input[name="bizFile"]')[0].files.length;
    const businessNumber = $('#institutionNumber').val().trim();
    const ceoName = $('#ceoName').val().trim();

    if (bizFileCount === 0) {
      alert('사업자등록증 첨부 파일을 선택해주세요.');
      $('input[name="bizFile"]').focus();
      return false;
    }

    if (businessNumber.length === 0) {
      alert('사업자등록번호를 입력해주세요.');
      $('#institutionNumber').focus();
      return false;
    }

    if (!/^\d+$/.test(businessNumber)) {
      alert('사업자등록번호는 숫자만 입력해야 합니다.');
      $('#institutionNumber').focus();
      return false;
    }

    if (ceoName.length === 0) {
      alert('대표자명을 입력해주세요.');
      $('#ceoName').focus();
      return false;
    }

    return true;
  }

  $('#nextStepBtn').click(function() {
	  if ($('#step1').is(':visible')) {
	    if (!validateStep1()) return;
	    $('#step1').hide();
	    $('#step2').show();
	  }
	});

	$('#prevStepBtn2').click(function() {
	  if ($('#step2').is(':visible')) {
	    $('#step2').hide();
	    $('#step1').show();
	  }
	});
	
	$('#nextStepBtn2').click(function() {
	  if ($('#step2').is(':visible')) {
	    if (!validateStep2()) return;
	    $('#step2').hide();
	    $('#step3').show();
	  }
	});

	$('#prevStepBtn3').click(function() {
	  if ($('#step3').is(':visible')) {
	    $('#step3').hide();
	    $('#step2').show();
	  }
	});

  $('#institutionJoinForm').on('submit', function(e) {
    if (!validateStep3()) {
      e.preventDefault();
    }
  });
});
</script>





<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>