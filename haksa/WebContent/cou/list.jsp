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
			<div id="divHeader"><h2>COURSES LIST</h2></div>
			<div id="divCondition">
				<div id="divSearch">
					<select id="selKey">
						<option value="lcode">강좌번호</option>
						<option value="lname">강좌이름</option>
						<option value="room">강의실</option>
						<option value="pname">담당교수</option>
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
					<option value="lcode">강좌번호</option> 
					<option value="lname">강좌이름</option> 
					<option value="room">강의실</option> 
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
				<td width=60>강좌번호</td> 
				<td>강좌이름</td> 
				<td width=70>강의시간수</td> 
				<td width=50>강의실</td> 
				<td width=50>지도교수</td> 
				<td width=100>지도교수번호</td> 
				<td width=100>최대수강인원</td> 
				<td width=100>수강신청인원</td> 
				<td width=50>강좌정보</td> 
			</tr> 
			{{#each array}} 
			<tr class="row"> 
				<td class="lcode">{{lcode}}</td> 
				<td class="lname">{{lname}}</td> 
				<td class="hours">{{hours}}</td> 
				<td class="room">{{room}}</td> 
				<td class="pname">{{pname}}</td> 
				<td class="instructor">{{instructor}}</td>
				<td class="capacity">{{capacity}}</td>  
				<td class="persons">{{persons}}</td> 
				<td class="btnDel"><button>보기</button></td> 
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
	var url="/haksa/cou/list";
	
	// 보기버튼을 클릭했을 때
	$("#tbl").on("click", ".row button", function(){
		var lcode=$(this).parent().parent().find(".lcode").html();
		location.href="read?lcode=" + lcode;
	});
</script>
<script src="../home.js"></script>
</html>