<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
<body>

	<div class="container h-20 flex justify-items-center mx-auto max-w-5xl text-l">
		<ul class="flex">
			<li><a class="flex h-full text-xl font-bold text-orange-500 px-3 items-center" href="/">KinderReview</a></li>
			<li class="relative group ">
			  <a class="flex h-full px-3 items-center hover:underline underline-offset-8" href="/usr/article/list?boardId=1">기관 정보</a>
			  <ul class="absolute hidden group-hover:block bg-white rounded-box w-56 shadow-xl ">
			    <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=7">유치원 정보</a></li>
			    <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=8">어린이집 정보</a></li>
			  </ul>
			</li>
			<li class="relative group">
			  <a class="flex h-full px-3 items-center hover:underline underline-offset-8" href="/usr/article/list?boardId=2">기관 리뷰</a>
			  <ul class="absolute hidden group-hover:block bg-white rounded-box w-56 shadow-lg z-10">
			    <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=4">근무 리뷰</a></li>
			    <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=5">면접 리뷰</a></li>
			    <li><a class="block px-4 py-2 hover:bg-orange-100 rounded-box" href="/usr/article/list?boardId=6">실습 및 봉사 리뷰</a></li>
			  </ul>
			</li>
			<li class="hover:underline underline-offset-8"><a class="flex h-full px-3 items-center" href="/usr/article/list?boardId=3">지역별 커뮤니티</a></li>
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