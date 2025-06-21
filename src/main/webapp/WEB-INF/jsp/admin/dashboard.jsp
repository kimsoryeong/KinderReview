<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/common/topbar.jsp" %>

<section class="bg-gray-100 min-h-screen py-8">
  <div class="container mx-auto max-w-4xl">
    <div class="bg-white rounded-t-lg shadow p-6 mb-8 border-b-4 border-orange-400 flex justify-between items-center">
      <h1 class="text-2xl font-extrabold text-orange-500">관리자 페이지</h1>
    </div>

    <div class="bg-white rounded-lg shadow px-10 pt-20 pb-15 ">
    <div class="flex gap-6 mb-10">
      <a href="/admin/review/list" 
         class="flex-1 bg-gray-100 shadow rounded-lg px-6 py-8 text-gray-700 font-semibold
                flex flex-col items-center space-y-3
                transition-colors duration-300 hover:bg-orange-100 hover:text-orange-600">
        <i class="fas fa-pen-to-square text-orange-400 text-4xl"></i>
        <span class="text-lg">근무 리뷰 관리</span>
        <span class="text-sm text-gray-500 text-center">대기 중인 근무 리뷰를 승인하거나 반려할 수 있습니다.</span>
      </a>

      <a href="/admin/institution/list" 
         class="flex-1 bg-gray-100 shadow rounded-lg px-6 py-8 text-gray-700 font-semibold
                flex flex-col items-center space-y-3
                transition-colors duration-300 hover:bg-orange-100 hover:text-orange-600">
        <i class="fas fa-school text-orange-400 text-4xl"></i>
        <span class="text-lg">기관 가입 관리</span>
        <span class="text-sm text-gray-500 text-center">가입 신청 대기 기관을 승인하거나 반려할 수 있습니다.</span>
      </a>

      <a href="/usr/article/list?boardId=10" 
         class="flex-1 bg-gray-100 shadow rounded-lg px-6 py-8 text-gray-700 font-semibold
                flex flex-col items-center space-y-3
                transition-colors duration-300 hover:bg-orange-100 hover:text-orange-600">
        <i class="fas fa-bullhorn text-orange-400 text-4xl"></i>
        <span class="text-lg">공지사항 관리</span>
        <span class="text-sm text-gray-500 text-center">공지사항 글을 작성, 수정 및 삭제 할 수 있습니다.</span>
      </a>
   	 </div>
    </div>
  </div>
</section>

