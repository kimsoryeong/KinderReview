<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

	<section class="mt-8">
		<div class="container mx-auto max-w-5xl">
			<!-- <span>유아교육기관 찾기</span>
			<input type="text" name="keyword" id="keyword">
			<button class="btn btn-neutral btn-outline btn-sm" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button> -->
			<label class="input">
			  <svg class="h-[1em] opacity-50" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
			    <g
			      stroke-linejoin="round"
			      stroke-linecap="round"
			      stroke-width="2.5"
			      fill="none"
			      stroke="currentColor"
			    >
			      <circle cx="11" cy="11" r="8"></circle>
			      <path d="m21 21-4.3-4.3"></path>
			    </g>
			  </svg>
			  <input type="search" class="grow" placeholder="주변 유아교육기관 찾기" />
			</label>
		</div>
	</section>


	
<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>