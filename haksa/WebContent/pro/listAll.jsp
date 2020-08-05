<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<meta charset="UTF-8">
<title>교수 목록</title>
<style>
td {
	border: 1px solid black;
	height: 30px;
	font-size: 12px;
	padding: 0px 5px 0px 5px;
}
table .title {
	background:#4D5147;
	text-align: center;
	color:white;
}
table {
	border-collapse: collapse;
}
.row:hover {
	background:#DDE8E3;
	cursor: pointer;
}
#pagination, h2 {
	text-align: center;
	padding-top: 5px;
}
</style>
</head>
<body>
	<h2>PROFESSORS</h2>
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=100>교수번호</td>
		<td width=100>교수이름</td>	
		<td width=100>교수학과</td>	
	</<tr>
	{{#each array}}
	<tr class="row">
		<td class="pcode">{{pcode}}</td>
		<td class="pname">{{pname}}</td>
		<td class="dept">{{dept}}</td>
	</tr>
	{{/each}}
	</script>
	<br>
	<div id="pagination">
		<button id="btnPre">◀</button>
		<button id="btnNext">▶</button>
	</div>
</body>
<script>
	var url="/haksa/pro/list";
	
	// row를 클릭했을때
	$("#tbl").on("click", ".row", function(){
		var pcode=$(this).find(".pcode").html();
		var pname=$(this).find(".pname").html();
		$(opener.frm.pcode).val(pcode);
		$(opener.frm.pname).val(pname);
		window.close();
	});
</script>
<script src="../home.js"></script>
</html>