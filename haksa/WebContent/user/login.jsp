<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<meta charset="UTF-8">
	<title>학사관리시스템</title>
	<link rel="stylesheet" href="../style.css">
</head>
<body>
	<div id="divPage">
		<div id="divTop"><jsp:include page="../header.jsp" /></div>
		<div id="divCenter">
			<div id="divMenu"><jsp:include page="../menu.jsp" /></div>
			<div id="divContent">
				<!--여기에 내용출력 시작---------------------------- -->
				<form name="frm" action="login" method="post">
					<br>
					<div id="logH2"><h2>LOGIN</h2></div>
					<div id="logTxt">
						<input type="text" name="id" id="logId" placeholder="아이디"> <br>
						<input type="password" name="pass" id="logPass" placeholder="비밀번호"><br>
					</div>
					<div id="logBtn"><input type="submit" value="로그인"></div>
				</form>
				<br><br>
				<!--여기에 내용출력 종료---------------------------- -->
			</div>
		</div>
		<div id="divBottom"><jsp:include page="../footer.jsp" /></div>
	</div>
</body>
<script>
	$(frm).submit(function(e) {
		var id = $(frm.id).val();
		var pass = $(frm.pass).val();
		e.preventDefault();
		$.ajax({
			type : "post",
			url : "login",
			data : {
				"id" : id,
				"pass" : pass
			},
			dataType : "json",
			success : function(data) {
				if (data.check == 0) {
					alert("아이디가 없습니다 !");
				} else if (data.check == 1) {
					alert("아이디/패스워드가 일치하지 않습니다 !");
				} else {
					location.href = "/haksa/index.jsp";
				}
			}
		});
	});
</script>
</html>