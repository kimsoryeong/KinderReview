<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="근무 리뷰 작성" />
<%@ include file="/WEB-INF/jsp/common/header.jsp" %> 

<section class="flex items-center justify-center bg-gray-100 min-h-screen">
  <div class="bg-white px-3 mx-auto  max-w-2xl shadow-xl rounded-xl">
    <div class="flex justify-end pt-6 pb-3 px-5 items-center">
      <a href="/"><i class="text-orange-300 hover:text-orange-400 fa-solid fa-house fa-2xl"></i></a>
    </div>
    <div>
    
      <form action="doWrite" method="post" id="reviewForm" enctype="multipart/form-data" autocomplete="off">
        <input type="hidden" name="workType" value="${param.workType}" />
        <input type="hidden" name="city" value="${param.city}" />
        <input type="hidden" name="institutionType" value="${param.institutionType}" />
        <input type="hidden" name="boardName" value="근무 리뷰" />
        <div class="mx-auto text-center w-full max-w-2xl px-4">
          <span class="px-2 items-center text-orange-500 font-bold text-3xl"><a href="/">KinderReview</a></span>
          <c:set var="boardId" value="${param.boardName}" />
          <span class="px-2 items-center font-bold text-2xl">${param.boardName} 작성</span>
   		  <p class="text-sm pt-6 text-center text-gray-500 mb-4">작성하신 리뷰는 관리자 승인 후 게시판에 공개됩니다.</p>
        </div>

        <div class="rounded-2xl p-5">
          <div class="px-10 pt-2 pb-4">
            <span class="font-bold pr-4 text-lg text-orange-400"><i class="fa-solid fa-school pr-4"></i>기관명</span>
            <span><input style="width:75%;" class="input border border-gray-800" name="institutionName" type="text" required /></span>
          </div>

          <div class="px-10 py-4 option">
            <div class="font-bold text-lg text-orange-400"><i class="fa-solid fa-quote-left pr-5"></i>기관 한 줄 평</div>
            <div class="pt-3 pb-4 text-sm">작성하실 리뷰의 제목을 입력해 주세요. (20자 이내)</div>
            <div>
              <input name="institutionComment" maxlength="20" 
                placeholder="10자 이상 기관에 대해 작성해주세요. (필수입력)"
                class="input h-10 resize-none" style="width:100%;"/>
              <div class="error-message text-red-500 text-sm mt-1 hidden">한 줄 평을 10~20자 이내로 입력해주세요.</div>
            </div>
          </div>
          
          <div class="px-10 py-4 option">
		  <div class="font-bold text-lg text-orange-400">
		    <i class="fa-solid fa-file-image pr-2"></i>재직 증빙 자료
		  </div>
		  <div class="pt-3 pb-2 text-sm text-gray-700">
		    재직을 증명할 수 있는 자료를 첨부해 주세요. (경력증명서, 급여명세서 등)
		  </div>
		
		  <label for="workCertFile" class="inline-block cursor-pointer bg-orange-100 text-orange-700 font-semibold py-2 px-4 rounded hover:bg-orange-200 text-sm">
		    파일 선택
		  </label>
		  <span id="fileName" class="ml-2 text-sm text-gray-600">선택된 파일 없음</span>
		
		  <input type="file" name="workCertFile" id="workCertFile" accept=".pdf,.jpg,.jpeg,.png" class="hidden" />
		
		  <div class="text-xs text-gray-400 mt-1">PDF, JPG, PNG 파일만 업로드 가능합니다.</div>
		  <div class="error-message text-red-500 text-sm hidden mt-2">재직 증빙 자료를 첨부해 주세요.</div>
		</div>


          <div class="px-10  py-4">
		  <div class="font-bold text-lg text-orange-400"><i class="fa-regular fa-pen-to-square pr-5"></i>기관의 특징</div>
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


          <div id="salary-section" class="tab-content mt-4 pl-10 pr-10 hidden">
             <div class="shadow-md rounded-lg w-full mb-5 p-6 my-1 bg-yellow-50 min-h-[220px]">
              <span class="text-lg font-bold pr-3"><i class="fa-solid fa-sack-dollar pr-5 "></i>급여</span>
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
                <input type="text" name="salaryComment" placeholder="급여 관련 하고싶은 말을 작성해 주세요." style="width:450px;" class="input input-neutral" />
                <div class="comment-error-message text-red-500 text-sm mt-1 hidden">급여 관련 한줄평을 5~50자로 작성해주세요.</div>
              </div>
            </div>
          </div>

          <div id="welfare-section" class="tab-content mt-4 pl-10 pr-10 hidden">
            <div class="shadow-md rounded-lg w-full mb-5 p-6 my-1 bg-green-50 min-h-[220px]">
              <span class="text-lg font-bold pr-3"><i class="fa-solid fa-hand-holding-heart pr-5"></i>복지</span>
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
                <input type="text" name="welfareComment" placeholder="복지 관련 하고싶은 말을 작성해 주세요." style="width:450px;" class="input input-neutral" />
                <div class="comment-error-message text-red-500 text-sm mt-1 hidden">복지 관련 한줄평을 5~50자로 작성해주세요.</div>
              </div>
            </div>
          </div>

          <div id="work-section" class="tab-content mt-4 pl-10 pr-10 hidden">
            <div class="shadow-md rounded-lg w-full mb-5 p-6 my-1 bg-blue-50 min-h-[220px]">
            <span class="text-lg font-bold pr-3"><i class="fa-solid fa-users pr-5"></i>근무환경</span>
              <span class="review-form">
                <span class="star">
                  <a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a><a href="#">★</a>
                  <input type="hidden" name="environmentScore" value="0" />
                </span>
              </span>
                <div class="error-message text-red-500 text-sm mt-1 hidden">근무환경 별점을 선택해주세요.</div>
              <div class="pt-4">
                <div class="font-bold pb-2 text-m">출퇴근 시간</div>
                <input type="text" name="commuteTimeComment" id="CommuteTime" placeholder="기관의 출퇴근 시간을 작성해주세요." style="width:450px;" class="input input-neutral" />
                <div class="comment-error-message text-red-500 text-sm mt-1 hidden">출퇴근 시간 관련 한줄평을 5~50자로 작성해주세요.</div>
              </div>
              <div class="pt-2">
                <div class="font-bold pb-2 text-m">기타</div>
                <div class="text-xs pb-2">기관 내 분위기, 행사 빈도수, 특성화 활동, 원내 문화, 평가제,<br>교사 대 아동 비율 등 자유롭게 작성해주세요.</div>
                <input type="text" name="environmentComment" id="environment" placeholder="기관의 근무환경에 대해 자유롭게 작성해주세요." style="width:100%;" class="input input-neutral" />
                <div class="comment-error-message text-red-500 text-sm mt-1 hidden">근무환경 관련 한줄평을 5~50자로 작성해주세요.</div>
              </div>
            </div>
          </div>

          <div class="pt-2 flex justify-between items-center">
            <button class="tab-title px-4 py-1 rounded-lg text-3xl " onclick="history.back();" type="button"><i class="text-orange-300 transition cursor-pointer hover:text-orange-400 fa-solid fa-arrow-left"></i></button>
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
  const isStarClicked = { overall: false, salary: false, welfare: false, env: false };

  $(".review-form .star a").click(function (e) {
    e.preventDefault();

    const wasOn = $(this).hasClass("on");
    $(this).siblings("a").removeClass("on");
    $(this).removeClass("on");

    if (!wasOn) {
      $(this).addClass("on");
      $(this).prevAll("a").addClass("on");
    }

    const $form = $(this).closest(".review-form");
    const count = $form.find(".on").length;
    $form.find("input[type='hidden']").val(count);

    if ($form.attr("id") === "overall-star") {
      $form.parent().find(".error-message").addClass("hidden");
      isStarClicked.overall = true;
    } else {
      $form.next(".error-message").addClass("hidden");
      const sectionId = $form.closest(".shadow-md").parent().attr("id");
      if (sectionId === "salary-section") isStarClicked.salary = true;
      else if (sectionId === "welfare-section") isStarClicked.welfare = true;
      else if (sectionId === "work-section") isStarClicked.env = true;
    }

    checkTabErrors();
  });

  $("input[name$='Comment']").on("input", function () {
    const name = $(this).attr("name");
    const len = $(this).val().trim().length;
    const isInstitution = name === "institutionComment";
    const min = isInstitution ? 10 : 5;
    const max = isInstitution ? 20 : 50;
    const hasError = len < min || len > max;

    $(this).closest("div").find(".comment-error-message, .error-message")
           .toggleClass("hidden", !hasError);

    checkTabErrors();
  });

  $(".tab-title").click(function () {
    if ($(this).text().trim() === "뒤로가기") return;
    $(".tab-content").hide();
    $($(this).data("target")).slideDown();
    $(".tab-title").removeClass("border-orange-400 text-orange-400 bg-white");
    $(this).addClass("border-orange-400 text-orange-400 ");
  });

  function checkTabErrors() {
    [
      {section: "#salary-section", tab: "급여"},
      {section: "#welfare-section", tab: "복지"},
      {section: "#work-section", tab: "근무환경"}
    ].forEach(({section, tab}) => {
      const hasError = $(`${section} .error-message:not(.hidden), ${section} .comment-error-message:not(.hidden)`).length > 0;
      $(`.tab-title:contains('${tab}') .tab-error`).toggleClass("hidden", !hasError);
    });
  }

 

  const checkComment = (selector, min, max) => {
    const val = $(selector).val().trim();
    const $error = $(selector).closest("div").find(".comment-error-message");
    if (val.length < min || val.length > max) {
      $error.removeClass("hidden");
    } else {
      $error.addClass("hidden");
    }
  };

  $("#reviewForm").on("submit", function(e) {
    if ($("#overall-star .star .on").length === 0) {
      $("#overall-star").parent().find(".error-message").removeClass("hidden");
    }
    if ($("#salary-section .star .on").length === 0) {
      $("#salary-section .error-message").first().removeClass("hidden");
    }
    if ($("#welfare-section .star .on").length === 0) {
      $("#welfare-section .error-message").first().removeClass("hidden");
    }
    if ($("#work-section .star .on").length === 0) {
      $("#work-section .error-message").first().removeClass("hidden");
    }

    checkComment("input[name='salaryComment']", 5, 50);
    checkComment("input[name='welfareComment']", 5, 50);
    checkComment("input[name='commuteTimeComment']", 5, 50);
    checkComment("input[name='environmentComment']", 5, 50);

    checkTabErrors();

    const fileInput = $("#workCertFile")[0];
    const fileAttached = fileInput && fileInput.files && fileInput.files.length > 0;
    const $fileError = $("#workCertFile").siblings(".error-message");

    if (!fileAttached) {
      $fileError.removeClass("hidden");
    } else {
      $fileError.addClass("hidden");
    }

    const $firstError = $(".error-message:not(.hidden), .comment-error-message:not(.hidden)").first();
    if ($firstError.length > 0) {
      $("html, body").animate({ scrollTop: ($firstError.offset().top - 100) }, 300);
      e.preventDefault();
    }
  });

  $("#workCertFile").on("change", function () {
    const fileName = this.files.length > 0 ? this.files[0].name : "선택된 파일 없음";
    $("#fileName").text(fileName);
  });
});
</script>



<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>