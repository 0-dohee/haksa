<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<meta charset="UTF-8">
	<title>학사관리시스템</title>
	<link rel="stylesheet" href="../style.css">
</head>
<body>
	<div id="divPage">
		<div id="divTop"><jsp:include page="../header.jsp"/></div>
		<div id="divCenter">
			<div id="divMenu"><jsp:include page="../menu.jsp"/></div>
			<div id="divContent">
			<!-- 여기에 내용 등록 시작 ------------------------------------------------->
			<div id="divHeader"><h2>STUDENTS LIST</h2></div>
			<div id="divCondition">
				<div id="divSearch">
					<select id="selKey">
						<option value="scode">번호</option>
						<option value="sname">이름</option>
						<option value="dept">학과</option>
					</select>
					<input type="text" id="txtWord">
					<select id="selPerPage"> 
						<option value="3">3행</option>
						<option value="5" selected>5행</option>
						<option value="10">10행</option>
					</select>
					<input type="button" id="btnSearch" value="검색"> 
					<span style="font-size:12px;">검색수: <b id="count"></b>건</span>
				</div>
				<div id="divSort">
				<select id="selOrder"> 
					<option value="scode">번호</option> 
					<option value="sname">이름</option> 
					<option value="dept">학과</option> 
				</select> 
				<select id="selDesc"> 
					<option value="">오름차순</option> 
					<option value="desc">내림차순</option> 
				</select>
				</div>
			</div>
			<table id="tbl"></table> 
			<script id="temp" type="text/x-handlebars-template">
			<tr class="title"> 
				<td width=130>학생번호</td> 
				<td width=130>학생이름</td> 
				<td width=130>학생학과</td>
				<td width=130>학생학년</td>	 
				<td width=130>생년월일</td> 
				<td width=130>지도교수</td> 
				<td width=130>교수번호</td>
				<td width=60>학생정보</td>
			</tr> 
			{{#each array}} 
			<tr class="row"> 
				<td class="scode">{{scode}}</td> 
				<td class="sname">{{sname}}</td> 
				<td class="dept">{{dept}}</td> 
				<td class="year">{{year}}</td> 
				<td class="birthday">{{birthday}}</td> 
				<td class="pname">{{pname}}</td> 
				<td class="advisor">{{advisor}}</td> 
				<td><button>정보</button></td>
			</tr> 
			{{/each}}
			</script>
			<div id="pagination"> 
				<button id="btnPre">◀</button> 
				[<span id="curPage"></span>/<span id="totPage"></span>]
				<button id="btnNext">▶</button> 
			</div>
			<!-- 여기에 내용 등록 종료 ------------------------------------------------->
			</div>
		</div>
		<div id="divBottom"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>
	var url="/haksa/stu/list";
	
	// 정보 버튼을 클릭했을때
	$("#tbl").on("click", ".row button", function(){
		var scode=$(this).parent().parent().find(".scode").html();
		location.href="read?scode=" + scode;
	});
</script>
<script src="../home.js"></script>
</html>