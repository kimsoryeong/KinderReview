<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="면접 리뷰 작성" />
<%@ include file="/WEB-INF/jsp/common/header.jsp" %> 

<section class="flex items-center justify-center bg-gray-100 min-h-screen">
  <div class="bg-white px-3 mx-auto  max-w-2xl shadow-xl rounded-xl">
    <div class="flex justify-end pt-6 pb-3 px-5 items-center">
      <a href="/"><i class="text-orange-300 hover:text-orange-400 fa-solid fa-house fa-2xl"></i></a>
    </div>
    <div>
      <form action="doWrite" method="post" id="reviewForm" autocomplete="off">
        <input type="hidden" name="workType" value="${param.workType}" />
        <input type="hidden" name="city" value="${param.city}" />
        <input type="hidden" name="institutionType" value="${param.institutionType}" />
        <input type="hidden" name="boardName" value="면접 리뷰" />
        <div class="mx-auto text-center w-full max-w-2xl px-4">
          <span class="px-2 items-center text-orange-500 font-bold text-3xl"><a href="/">KinderReview</a></span>
          <c:set var="boardId" value="${param.boardName}" />
          <span class="px-2 items-center font-bold text-2xl">${param.boardName} 작성</span>
        </div>
        
		<div class="rounded-2xl p-5">
          <div class="px-10 pt-8 py-5">
            <span class="font-bold pr-4 text-lg text-orange-400"><i class="fa-solid fa-school pr-4"></i>기관명</span>
            <span><input style="width:73%;" class="input border border-gray-800" name="institutionName" type="text" required /></span>
          </div>
          
			<div class="px-10  py-2">
				<div class="font-bold text-lg text-orange-400">
					<i class="fa-regular fa-star-half-stroke pr-5"></i>면접 총 평점
				</div>
				<div>
					<div class="review-form pt-1" id="overall-star">
						<div class="star">
							<a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a> <input type="hidden" name="interviewScore" value="0" />
						</div>
					</div>
					<div class="error-message text-red-500 text-sm mt-1 hidden">면접 총 평점을 선택해주세요.</div>
				</div>
			</div>
			
			<div class="px-10  py-4 option">
				<div class="font-bold text-lg text-orange-400">
					<i class="fa-solid fa-quote-left pr-5"></i>면접 한 줄 평
				</div>
				<div class="pt-3 pb-4 text-sm">작성하실 면접 리뷰의 제목을 입력해 주세요. (20자	이내)</div>
				<div>
					<input name="interviewComment" maxlength="20"
						placeholder="10자 이상 기관의 면접에 대해 작성해주세요. (필수입력)"
						class="input h-10 resize-none" style="width: 450px;"/>
					<div class="error-message text-red-500 text-sm mt-1 hidden">한 줄 평을 10~20자 이내로 입력해주세요.</div>
				</div>
			</div>
			<div class="px-10  py-3">
				<div class="font-bold text-lg text-orange-400">
					<i class="fa-solid fa-briefcase pr-5"></i>경력사항
				</div>
				<div class="mt-3">
					<label><input class="radio radio-xs mr-2" name="personalHistory" type="radio" value="신입 교사" />신입 교사</label> 
					<label><input class="radio radio-xs mx-2" name="personalHistory" type="radio" value="경력 교사" />경력 교사</label>
				</div>
				<div class="error-message-personalHistory text-red-500 text-sm mt-1 hidden">경력 사항을 선택해주세요.</div>
			</div>
			<div class="px-10  py-3">
				<div class="font-bold text-lg text-orange-400">
					<i class="fa-regular fa-square-check pr-5"></i>면접 결과
				</div>
				<div class="mt-3">
					<label><input class="radio radio-xs mr-2" name="interviewResults" type="radio" value="합격" />합격</label> 
					<label><input class="radio radio-xs mx-2" name="interviewResults" type="radio" value="불합격" />불합격</label>
				</div>
				<div class="error-message-interviewResults text-red-500 text-sm mt-1 hidden">면접결과를 선택해주세요.</div>
			</div>
			<div class="px-10 py-4">
			  <div class="font-bold text-lg text-orange-400">
			    <i class="fa-regular fa-pen-to-square pr-5"></i>기관의 특징
			  </div>
			  <div class="pt-2 pb-2 text-sm">아래 버튼을 클릭하여 작성해주세요</div>
			  <div>
			    <div class="flex gap-4 font-bold cursor-pointer mt-2 justify-center">
			      <div class="tab-title px-4 py-1 rounded-lg border border-black-800 text-gray-500 hover:text-orange-400 transition cursor-pointer" 
			        data-tab="interviewInformation" data-target="#interviewInformation-section">
			        면접정보 <span class="tab-error text-red-500 hidden">*</span>
			      </div>
			      <div class="tab-title px-4 py-1 rounded-lg border border-black-800 text-gray-500 hover:text-orange-400 transition cursor-pointer" 
			        data-tab="interviewQnA" data-target="#interviewQnA-section">
			        질의응답 <span class="tab-error text-red-500 hidden">*</span>
			      </div>
			    </div>
			  </div>
			</div>

			<div id="interviewInformation-section" class="tab-content mt-4 pl-10 pr-10">
			  <div class="shadow-md rounded-lg w-full mb-5 p-6 my-1 bg-yellow-50 min-h-[220px]">
			    <span class="text-lg font-bold pr-3"><i class="fa-solid pr-3 fa-circle-info"></i>면접정보</span>
			    <div class="py-3">
			      <div class="font-bold pb-1 text-m">면접 준비</div>
			      <div class="pt-1 pb-2 text-sm">면접을 위한 준비물 등 자유롭게 작성해주세요.</div>
			      <textarea name="interviewMaterial" cols=60 rows=2
			        placeholder="10~100자 이내로 기관 면접 진행 과정에 대해 작성해주세요."
			        style="overflow-x: hidden; width:450px;"
			        class="p-2 bg-white text-sm border-gray-300 rounded-sm w-full"></textarea>  
			      <div class="error-message text-red-500 text-sm mt-1 hidden">면접 준비 과정을 10~100자 이내로 입력해주세요.</div>
			    </div>
			    <div class="py-1">
			      <div class="font-bold pb-1 text-m">면접 진행</div>
			      <div class="pt-1 pb-2 text-sm">면접관 및 면접 방식(1:1, 그룹), 면접 분위기 등 자유롭게 작성해주세요.</div>
			      <textarea name="interviewProgress" cols=60 rows=2
			        placeholder="10~100자 이내로 기관 면접 진행 과정에 대해 작성해주세요."
			        style="overflow-x: hidden; width:450px;"
			        class="p-2 bg-white text-sm border-gray-300 rounded-sm w-full"></textarea>
			      <div class="error-message text-red-500 textarea-sm mt-1 hidden">면접 진행 과정을 10~100자 이내로 입력해주세요.</div>
			    </div>
			    <div class="py-1">
			      <div class="font-bold pb-1 text-m">면접 마무리</div>
			      <div class="pt-1 pb-2 text-sm">결과 통보 기간, 면접관의 피드백 등 자유롭게 작성해주세요.</div>
			      <textarea name="interviewCompleted" cols=60 rows=2
			        placeholder="10~100자 이내로 기관 면접 마무리 과정에 대해 작성해주세요."
			        style="overflow-x: hidden; width:450px;"
			        class="p-2 bg-white text-sm border-gray-300 rounded-sm w-full"></textarea>
			      <div class="error-message text-red-500 text-sm mt-1 hidden">면접 마무리 과정을 10~100자 이내로 입력해주세요.</div>
			    </div>
			  </div>
			</div>
			
			<div id="interviewQnA-section" class="tab-content mt-4 pl-10 pr-10 hidden">
			  <div class="shadow-md rounded-lg w-full mb-5 p-6 my-1 bg-green-50 min-h-[220px]">
			    <span class="text-lg font-bold pr-3"><i class="pr-3 fa-solid fa-circle-question"></i>질의응답 및 조언</span>
			    <div class="font-bold pt-3 pb-1 text-m">질의응답</div>
			    <div class="pt-1 pb-2 text-sm">기억에 남는 면접 질문과 본인의 답변을 작성해주세요.</div>
			    <textarea name="interviewQnA" cols=60 rows=2
			      placeholder="10~100자 이내로 기관의 면접 질의응답에 대해 작성해주세요."
			      style="overflow-x: hidden; width:450px;"
			      class="p-2 bg-white text-sm border-gray-800 rounded-sm w-full"></textarea>
			    <div class="error-message text-red-500 textarea-sm mt-1 hidden">질의응답을 10~100자 이내로 입력해주세요.</div>
			    <div class="py-1">
			      <div class="font-bold pb-1 text-m">조언</div>
			      <div class="text-sm pt-1 pb-2">면접 소감 및 조언 등 자유롭게 작성해주세요.</div>
			      <textarea name="interviewTip" cols=60 rows=2
			        placeholder="10~100자 이내로 기관의 면접 조언에 대해 작성해주세요."
			        style="overflow-x: hidden; width:450px;"
			        class="p-2 bg-white text-sm border-gray-800 rounded-sm w-full"></textarea>
			      <div class="comment-error-message text-red-500 text-sm mt-1 hidden">면접 조언을 10~100자 이내로 입력해주세요.</div>
			    </div>
			  </div>
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
			</form>
		</div>
	</div>
</section>

<style>
.review-form .star a {
	text-decoration: none;
	font-size: 2rem;
	color: #ccc;
	cursor: pointer;
}

.review-form .star a.on {
	color: #f2cb61;
}

.tab-content>div {
	min-height: 220px;
}

textarea.input {
	resize: none;
	min-height: 2.5rem;
	max-height: 2.5rem;
	line-height: 2.2rem;
	padding-top: 0.2rem;
	padding-bottom: 0.2rem;
}
</style>

<script>
$(function () {
  $(".review-form .star a").click(function (e) {
    e.preventDefault();
    const $star = $(this);
    $star.siblings("a").removeClass("on");
    $star.removeClass("on");
    if (!$star.hasClass("on")) {
      $star.addClass("on").prevAll("a").addClass("on");
    }
    $star.closest(".review-form").find("input[type='hidden']").val($star.closest(".review-form").find(".on").length);
    $("#overall-star").parent().find(".error-message").addClass("hidden");
    checkTabErrors();
  });

  $(".tab-title").click(function () {
    if ($(this).text().trim() === "뒤로가기") return;
    $(".tab-content").hide();
    $($(this).data("target")).slideDown();
    $(".tab-title").removeClass("border-orange-400 text-orange-400 bg-white");
    $(this).addClass("border-orange-400 text-orange-400 ");
  });

  $(document).on("input", "input[name^='interview'], textarea[name^='interview']", function () {
    const len = ($(this).val() || "").trim().length;
    const hasError = len < 10 || len > 100;
    $(this).siblings(".error-message, .comment-error-message").toggleClass("hidden", !hasError);
    checkTabErrors();
  });

  $("input[name='personalHistory']").on("change", function() {
    $(".error-message-personalHistory").addClass("hidden");
  });

  $("input[name='interviewResults']").on("change", function() {
    $(".error-message-interviewResults").addClass("hidden");
  });


  function checkTabErrors() {
    [
    	{section: "#interviewInformation-section", tab: "interviewInformation"},
	    {section: "#interviewQnA-section", tab: "interviewQnA"}
    ].forEach(({section, tab}) => {
      const hasError = $(`${section} .error-message:not(.hidden), ${section} .comment-error-message:not(.hidden)`).length > 0;
      $(`.tab-title:contains('${tab}') .tab-error`).toggleClass("hidden", !hasError);
    });
  }

  $("#reviewForm").on("submit", function(e){
    if ($("#overall-star .star .on").length === 0) {
      $("#overall-star").parent().find(".error-message").removeClass("hidden");
    }
    if ($("input[name='personalHistory']:checked").length === 0) {
      $(".error-message-personalHistory").removeClass("hidden");
    }
    if ($("input[name='interviewResults']:checked").length === 0) {
      $(".error-message-interviewResults").removeClass("hidden");
    }
    $("input[name^='interview'], textarea[name^='interview']").each(function() {
      const len = ($(this).val() || "").trim().length;
      const hasError = len < 10 || len > 100;
      $(this).siblings(".error-message, .comment-error-message").toggleClass("hidden", !hasError);
    });
    checkTabErrors();
    var $firstError = $(".error-message:not(.hidden), .comment-error-message:not(.hidden), .error-message-personalHistory:not(.hidden), .error-message-interviewResults:not(.hidden)").first();
    if($firstError.length > 0){
      $('html, body').animate({ scrollTop: ($firstError.offset().top - 100) }, 300);
      e.preventDefault();
    }
  });

  checkTabErrors();
});
</script>






<%@ include file="/WEB-INF/jsp/common/footer.jsp"%>