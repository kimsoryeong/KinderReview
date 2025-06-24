<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>유치원 시설 정보</title>
</head>
<body>
<h2>유치원 시설 API 결과 (JSON)</h2>

<pre><c:out value="${apiResult}" /></pre>
</body>
</html>