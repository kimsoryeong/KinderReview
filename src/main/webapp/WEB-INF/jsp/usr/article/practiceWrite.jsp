<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="근무후기 작성" />

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

<section class="flex items-center justify-center bg-gray-100 min-h-screen">
  <div class="bg-white mx-auto w-full max-w-2xl shadow-xl rounded-xl">
    <div class="flex justify-end pt-6 pl-6 pr-5 items-center">
      <a href="/"><i class="text-orange-300 hover:text-orange-400 fa-solid fa-house fa-2xl"></i></a>
    </div>
    <div>
      <form action="doWrite" method="post" id="reviewForm" autocomplete="off">
        <input type="hidden" name="workType" value="${param.workType}" />
        <input type="hidden" name="city" value="${param.city}" />
        <input type="hidden" name="institutionType" value="${param.institutionType}" />
        <input type="hidden" name="boardName" value="근무 리뷰" />
        <div class="mx-auto text-center w-full max-w-2xl px-4">
          <span class="px-2 items-center text-orange-500 font-bold text-3xl"><a href="/">KinderReview</a></span>
          <c:set var="boardId" value="${param.boardId}" />
          <span class="px-2 items-center font-bold text-2xl">${param.boardId} 작성</span>
        </div>

        <div class="rounded-2xl p-5">
          <div class="px-10 mx-10 pt-8 py-5">
            <span class="font-bold pr-4 text-lg text-orange-400"><i class="fa-solid fa-school pr-5"></i>기관명</span>
            <span><input style="width:70%;" class="input input-neutral" name="institutionName" type="text" required /></span>
          </div>

          <div class="px-10 mx-10 py-2">
            <div class="font-bold text-lg text-orange-400"><i class="fa-regular fa-star-half-stroke pr-5"></i>기관 총 평점</div>
            <div>
              <div class="review-form pt-1" id="overall-star">
                <div class="star">
                  <a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a>
                  <input type="hidden" name="overallScore" value="0" />
                </div>
              </div>
              <div class="error-message text-red-500 text-sm mt-1 hidden">총 평점 별점을 선택해주세요.</div>
            </div>
          </div>

          <div class="px-10 mx-10 py-4 option">
            <div class="font-bold text-lg text-orange-400"><i class="fa-regular fa-pen-to-square pr-5"></i>기관 한 줄 평</div>
            <div class="pt-3 pb-4 text-sm">작성하실 리뷰의 제목을 입력해 주세요. (20자 이내)</div>
            <div>
              <input name="institutionComment" maxlength="20" 
                placeholder="10자 이상 기관에 대해 작성해주세요. (필수입력)"
                class="input h-10 resize-none" style="width:100%;"></>
              <div class="error-message text-red-500 text-sm mt-1 hidden">한 줄 평을 10~20자 이내로 입력해주세요.</div>
            </div>
          </div>

          <div class="px-10 mx-10 py-4">
		  <div class="font-bold text-lg text-orange-400"><i class="fa-regular fa-square-check pr-5"></i>기관의 특징</div>
		  <div class="pt-2 pb-2 text-sm">아래 버튼을 클릭하여 작성해주세요</div>
		  <div>
		    <div class="flex gap-4 font-bold cursor-pointer mt-2 justify-center">
		      <div class="tab-title px-4 py-1 rounded-lg border border-black-800 text-gray-500 hover:text-orange-400 transition cursor-pointer" data-target="#salary-section">
		        급여 <span class="tab-error text-red-500 hidden">*</span>
		      </div>
		      <div class="tab-title px-4 py-1 rounded-lg border border-black-800 text-gray-500 hover:text-orange-400 transition cursor-pointer" data-target="#welfare-section">
		        복지 <span class="tab-error text-red-500 hidden">*</span>
		      </div>
		      <div class="tab-title px-4 py-1 rounded-lg border border-black-800 text-gray-500 hover:text-orange-400 transition cursor-pointer" data-target="#work-section">
		        근무환경 <span class="tab-error text-red-500 hidden">*</span>
		      </div>
		    </div>
		  </div>
		</div>


          <div id="salary-section" class="tab-content mt-4 pl-10 pr-10">
            <div class="shadow-md rounded-lg p-6 mx-7 my-1 bg-yellow-500 min-h-[220px]">
              <span class="text-lg font-bold pr-3">급여</span>
              <span class="review-form">
                <span class="star">
                  <a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a>
                  <input type="hidden" name="salaryScore" value="0" />
                </span>
              </span>
              <span class="error-message text-red-500 text-sm mt-1 hidden">급여 별점을 선택해주세요.</span>
              <div class="pt-2">
                <div class="pt-2 pb-4 text-sm">원에서 제공하는 특징에 체크해주세요</div>
                <label><input class="checkbox-xs" name="salaryOptions" type="checkbox" value="시간 외 수당" /> 시간 외 수당</label>&nbsp;
                <label><input class="checkbox-xs" name="salaryOptions" type="checkbox" value="퇴직금" /> 퇴직금</label>&nbsp;
                <label><input class="checkbox-xs" name="salaryOptions" type="checkbox" value="상여금" /> 상여금</label>&nbsp;
                <label><input class="checkbox-xs" name="salaryOptions" type="checkbox" value="식비" /> 식비</label>
              </div>
              <div class="pt-4">
                <input type="text" name="salaryComment" placeholder="급여 관련 하고싶은 말을 작성해 주세요." style="width:100%;" class="input input-neutral" />
                <div class="comment-error-message text-red-500 text-sm mt-1 hidden">급여 관련 한줄평을 5~50자로 작성해주세요.</div>
              </div>
            </div>
          </div>

          <div id="welfare-section" class="tab-content mt-4 pl-10 pr-10 hidden">
            <div class="shadow-md rounded-lg p-6 mx-7 my-1 bg-green-500 min-h-[220px]">
              <span class="text-lg font-bold pr-3">복지</span>
              <span class="review-form">
                <span class="star">
                  <a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a>
                  <input type="hidden" name="welfareScore" value="0" />
                </span>
              </span>
              <span class="error-message text-red-500 text-sm mt-1 hidden">복지 별점을 선택해주세요.</span>
              <div class="pt-2">
                <div class="pt-2 pb-4 text-sm">원에서 제공하는 특징에 체크해주세요</div>
                <label><input class="checkbox-xs" name="welfareOptions" type="checkbox" value="연반차 사용" /> 연반차 사용</label>&nbsp;
                <label><input class="checkbox-xs" name="welfareOptions" type="checkbox" value="병가" /> 병가</label>&nbsp;
                <label><input class="checkbox-xs" name="welfareOptions" type="checkbox" value="방학" /> 방학</label>&nbsp;
                <label><input class="checkbox-xs" name="welfareOptions" type="checkbox" value="육아휴직" /> 육아휴직</label>&nbsp;
                <label><input class="checkbox-xs" name="welfareOptions" type="checkbox" value="휴게시간" /> 휴게시간</label>
              </div>
              <div class="pt-4">
                <input type="text" name="welfareComment" placeholder="복지 관련 하고싶은 말을 작성해 주세요." style="width:100%;" class="input input-neutral" />
                <div class="comment-error-message text-red-500 text-sm mt-1 hidden">복지 관련 한줄평을 5~50자로 작성해주세요.</div>
              </div>
            </div>
          </div>

          <div id="work-section" class="tab-content mt-4 pl-10 pr-10 hidden">
            <div class="shadow-md rounded-lg p-6 mx-7 my-1 bg-blue-500 min-h-[220px]">
            <span class="text-lg font-bold pr-3">근무환경</span>
              <span class="review-form">
                <span class="star">
                  <a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a>
                  <input type="hidden" name="environmentScore" value="0" />
                </span>
              </span>
                <div class="error-message text-red-500 text-sm mt-1 hidden">근무환경 별점을 선택해주세요.</div>
              <div class="pt-4">
                <div class="font-bold pb-2 text-m">출퇴근 시간</div>
                <input type="text" name="commuteTimeComment" id="CommuteTime" placeholder="기관의 출퇴근 시간을 작성해주세요." style="width:100%;" class="input input-neutral" />
                <div class="comment-error-message text-red-500 text-sm mt-1 hidden">출퇴근 시간 관련 한줄평을 5~50자로 작성해주세요.</div>
              </div>
              <div class="pt-2">
                <div class="font-bold pb-2 text-m">기타</div>
                <div class="text-xs pb-2">기관 내 분위기, 행사 빈도수, 특성화 활동, 원내 문화, 평가제, 교사 대 아동 비율 등&nbsp; 자유롭게 작성해주세요.</div>
                <input type="text" name="environmentComment" id="environment" placeholder="기관의 근무환경에 대해 자유롭게 작성해주세요." style="width:100%;" class="input input-neutral" />
                <div class="comment-error-message text-red-500 text-sm mt-1 hidden">근무환경 관련 한줄평을 5~50자로 작성해주세요.</div>
              </div>
            </div>
          </div>

          <div class="pt-2 flex justify-between items-center">
            <button class="tab-title px-4 py-1 rounded-lg text-3xl text-orange-400 hover:text-orange-500 transition cursor-pointer" onclick="history.back();" type="button"><i class="fa-solid fa-arrow-left"></i></button>
            <button type="submit" class="btn-wide btn-m text-black bg-[#ffbf73] border-none hover:bg-[#f79614df] hover:border-[#ff9d23] rounded-lg" style="width:150px; height:40px;">
              작성
            </button>
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
  .tab-content > div {
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
  var isStarClicked = { overall: false, salary: false, welfare: false, env: false };

  // 별점 클릭 시
  $(".review-form .star a").click(function (e) {
    e.preventDefault();
    const wasOn = $(this).hasClass("on");
    $(this).parent().children("a").removeClass("on");
    $(this).addClass("on").prevAll("a").addClass("on");
    if (wasOn) $(this).removeClass("on");
    $(this).closest(".review-form").find("input[type='hidden']").val($(this).closest(".review-form").find(".on").length);
    // 에러 메시지 숨기기 (모든 경우에 대응)
    var $reviewForm = $(this).closest(".review-form");
    if ($reviewForm.attr("id") === "overall-star") {
      $reviewForm.parent().find(".error-message").addClass("hidden");
      isStarClicked.overall = true;
    } else {
      $reviewForm.next(".error-message").addClass("hidden");
      var $section = $(this).closest(".shadow-md").parent();
      var sectionId = $section.attr("id");
      if (sectionId === "salary-section") isStarClicked.salary = true;
      else if (sectionId === "welfare-section") isStarClicked.welfare = true;
      else if (sectionId === "work-section") isStarClicked.env = true;
    }
    checkTabErrors();
  });

  // 한줄평 입력 시 실시간 검증
  $("input[name='institutionComment'], input[name='salaryComment'], input[name='welfareComment'], input[name='environmentComment'], input[name='commuteTimeComment']").on("input", function(){
    var comment = $(this).val();
    var minLen = $(this).attr("name") === "institutionComment" ? 10 : 5;
    var maxLen = $(this).attr("name") === "institutionComment" ? 20 : 50;
    if(!comment || comment.trim().length < minLen || comment.trim().length > maxLen){
      $(this).siblings(".comment-error-message, .error-message").removeClass("hidden");
    }else{
      $(this).siblings(".comment-error-message, .error-message").addClass("hidden");
    }
    checkTabErrors();
  });

  // 탭 클릭
  $(".tab-title").click(function () {
    if ($(this).text().trim() === "뒤로가기") return;
    $(".tab-content").hide();
    $( $(this).data("target") ).slideDown();
    $(".tab-title").removeClass("border-orange-400 text-orange-400 bg-gray-100 bg-white");
    $(this).addClass("border-orange-400 text-orange-400 bg-gray-100");
  });

  // 에러 여부 체크 함수 (탭 별표 표시)
  function checkTabErrors() {
    // 급여 탭 에러 체크
    var salaryError = $("#salary-section .error-message:not(.hidden), #salary-section .comment-error-message:not(.hidden)").length > 0;
    $(".tab-title:contains('급여')").find(".tab-error").toggleClass("hidden", !salaryError);

    // 복지 탭 에러 체크
    var welfareError = $("#welfare-section .error-message:not(.hidden), #welfare-section .comment-error-message:not(.hidden)").length > 0;
    $(".tab-title:contains('복지')").find(".tab-error").toggleClass("hidden", !welfareError);

    // 근무환경 탭 에러 체크
    var workError = $("#work-section .error-message:not(.hidden), #work-section .comment-error-message:not(.hidden)").length > 0;
    $(".tab-title:contains('근무환경')").find(".tab-error").toggleClass("hidden", !workError);
  }

  // 폼 제출 시 최종 검증
  $("#reviewForm").on("submit", function(e){
    let valid = true;
    var $firstError = null;

    // 기관 총 평점
    if( $("#overall-star .star .on").length === 0 || !isStarClicked.overall ){
      $("#overall-star").parent().find(".error-message").removeClass("hidden");
      valid = false;
      $firstError = $firstError || $("#overall-star").parent().find(".error-message").first();
    }

    // 기관 한줄평
    var comment = $("input[name='institutionComment']").val();
    if(!comment || comment.trim().length < 10 || comment.trim().length > 20){
      $("input[name='institutionComment']").siblings(".error-message").removeClass("hidden");
      valid = false;
      $firstError = $firstError || $("input[name='institutionComment']").siblings(".error-message").first();
    }

    // 급여 별점
    if( $("#salary-section .star .on").length === 0 || !isStarClicked.salary ){
      $("#salary-section .error-message").first().removeClass("hidden");
      valid = false;
      $firstError = $firstError || $("#salary-section .error-message").first();
    }

    // 급여 한줄평
    var salaryComment = $("input[name='salaryComment']").val();
    if(!salaryComment || salaryComment.trim().length < 5 || salaryComment.trim().length > 50){
      $("input[name='salaryComment']").siblings(".comment-error-message").removeClass("hidden");
      valid = false;
      $firstError = $firstError || $("input[name='salaryComment']").siblings(".comment-error-message").first();
    }

    // 복지 별점
    if( $("#welfare-section .star .on").length === 0 || !isStarClicked.welfare ){
      $("#welfare-section .error-message").first().removeClass("hidden");
      valid = false;
      $firstError = $firstError || $("#welfare-section .error-message").first();
    }

    // 복지 한줄평
    var welfareComment = $("input[name='welfareComment']").val();
    if(!welfareComment || welfareComment.trim().length < 5 || welfareComment.trim().length > 50){
      $("input[name='welfareComment']").siblings(".comment-error-message").removeClass("hidden");
      valid = false;
      $firstError = $firstError || $("input[name='welfareComment']").siblings(".comment-error-message").first();
    }

    // 근무환경 별점
    if( $("#work-section .star .on").length === 0 || !isStarClicked.env ){
      $("#work-section .error-message").first().removeClass("hidden");
      valid = false;
      $firstError = $firstError || $("#work-section .error-message").first();
    }

    // 근무환경 한줄평
    var envComment = $("input[name='environmentComment']").val();
    if(!envComment || envComment.trim().length < 5 || envComment.trim().length > 50){
      $("input[name='environmentComment']").siblings(".comment-error-message").removeClass("hidden");
      valid = false;
      $firstError = $firstError || $("input[name='environmentComment']").siblings(".comment-error-message").first();
    }

    // 출퇴근 시간 한줄평
    var commuteComment = $("input[name='commuteTimeComment']").val();
    if(!commuteComment || commuteComment.trim().length < 5 || commuteComment.trim().length > 50){
      $("input[name='commuteTimeComment']").siblings(".comment-error-message").removeClass("hidden");
      valid = false;
      $firstError = $firstError || $("input[name='commuteTimeComment']").siblings(".comment-error-message").first();
    }

    checkTabErrors();
    if(!valid){
      $('html, body').animate({ scrollTop: ($firstError.offset().top - 100) }, 300);
      e.preventDefault();
    }
  });
});
</script>



<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>

