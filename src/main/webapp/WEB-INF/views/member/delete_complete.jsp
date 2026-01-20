<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림</title>
<script type="text/javascript">
    window.onload = function() {
        alert("${message}");
        location.href = "${url}";
    };
</script>
</head>
<body>
</body>
</html>