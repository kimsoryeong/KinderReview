<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>관리자 페이지</title>
  <link href="/resources/css/tailwind.css" rel="stylesheet" />
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-gray-100 min-h-screen">
  <header class="bg-orange-400 p-4 text-white flex justify-between items-center">
    <h1 class="text-2xl font-bold">관리자 대시보드</h1>
    <nav>
      <a href="/adm/review/list" class="mr-4 hover:underline">근무 리뷰 관리</a>
      <a href="/adm/institution/list" class="mr-4 hover:underline">기관 가입 관리</a>
      <a href="/usr/logout" class="hover:underline">로그아웃</a>
    </nav>
  </header>
  <main class="p-6">
