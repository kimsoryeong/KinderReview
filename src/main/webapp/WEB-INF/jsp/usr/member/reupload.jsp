<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<h2>사업자 등록증 재업로드</h2>

<form method="post" action="/usr/member/reupload" enctype="multipart/form-data">
    <div>
        <label>사업자 등록증 파일 선택</label><br>
        <input type="file" name="workCertFile" accept=".pdf,.jpg,.png" required />
    </div>
    <div style="margin-top: 10px;">
        <button type="submit">재업로드</button>
    </div>
</form>

<%@ include file="/WEB-INF/jsp/common/footer.jsp" %>