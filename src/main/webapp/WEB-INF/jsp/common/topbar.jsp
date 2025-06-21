<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdn.tailwindcss.com"></script>

<div class="container h-20 flex justify-items-center mx-auto max-w-4xl text-l">
  <ul class="flex">
    <li><a class="flex h-full text-xl font-bold text-orange-500 px-3 items-center" href="/">KinderReview</a></li>
    <li class="relative group">
      <a class="flex h-full px-3 items-center hover:underline underline-offset-8" href="/usr/article/list?boardId=1">기관 정보</a>
      <ul class="absolute left-0 top-full z-20 hidden group-hover:block bg-white rounded-box w-56 shadow-xl">
        <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=7">유치원 정보</a></li>
        <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=8">어린이집 정보</a></li>
      </ul>
    </li>
    <li class="relative group">
      <a class="flex h-full px-3 items-center hover:underline underline-offset-8" href="/usr/article/list?boardId=2">기관 리뷰</a>
      <ul class="absolute left-0 top-full z-20 hidden group-hover:block bg-white rounded-box w-56 shadow-lg">
        <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=4">근무 리뷰</a></li>
        <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=5">면접 리뷰</a></li>
        <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=6">실습 및 봉사 리뷰</a></li>
      </ul>
    </li>
    <li class="hover:underline underline-offset-8"><a class="flex h-full px-3 items-center" href="/usr/article/list?boardId=9">채용공고</a></li>
    <li class="relative group">
      <a class="flex h-full px-3 items-center hover:underline underline-offset-8" href="/usr/article/list?boardId=3">커뮤니티</a>
      <ul class="absolute left-0 top-full z-20 hidden group-hover:block bg-white rounded-box w-56 shadow-lg">
        <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=10">공지사항</a></li>
        <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=11">자유게시판</a></li>
        <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=12">질문게시판</a></li>
      </ul>
    </li>
    <c:if test="${req.getLoginedMember() != null and req.getLoginedMember().getId() != 0 and req.getLoginedMember().getAuthLevel() == 0}">
    <li class="hover:underline underline-offset-8">
        <a class="flex h-full px-3 items-center" href="/admin/dashboard">관리자 Page</a>
    </li>
	</c:if>
    <c:if test="${req.getLoginedMember() != null and req.getLoginedMember().getAuthLevel() == 1 or req.getLoginedMember().getAuthLevel() == 2}">
    <li class="hover:underline underline-offset-8">
        <a class="flex h-full px-3 items-center" href="/usr/member/myPage">My Page</a>
    </li>
	</c:if>

  </ul>
  <div class="grow"></div>
  <ul class="flex">
    <c:if test="${req.getLoginedMember().getId() == 0 }">
      <li class="hover:underline underline-offset-8"><a class="flex h-full px-3 items-center" href="/usr/member/join">회원가입</a></li>
      <li class="hover:underline underline-offset-8"><a class="flex h-full px-3 items-center" href="/usr/member/login">로그인</a></li>
    </c:if>
    <c:if test="${req.getLoginedMember().getId() != 0 }">
      <li class="hover:underline underline-offset-8"><a class="flex h-full px-3 items-center" href="/usr/member/logout">로그아웃</a></li>
    </c:if>
  </ul>
</div>

	
	