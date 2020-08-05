<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
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
		<div id="divTop"><jsp:include page="../header.jsp" /></div>
		<div id="divCenter">
			<div id="divMenu"><jsp:include page="../menu.jsp" /></div>
			<div id="divContent">
				<!-- 여기에 내용 등록 시작 ------------------------------------------------->
				<div id="divHeader">
					<h2>PROFESSOR INFORMATION</h2>
				</div>
				<form name="frm" action="update" method="post">
					<table>
						<tr>
							<td width=100 class="title" width=150>교수번호</td>
							<td width=100><input type="text" name="pcode" size=12 value="${ vo.pcode }" readonly></td>
							<td width=100 class="title" width=150>교수학과</td>
							<td width=100>
								<select name="dept">
									<option value="전산" <c:out value="${ vo.dept=='전산'?'selected':''}"/> >전산</option>
									<option value="전자" <c:out value="${ vo.dept=='전자'?'selected':''}"/> >전자</option>
									<option value="건축" <c:out value="${ vo.dept=='건축'?'selected':''}"/> >건축</option>
								</select>
							</td>
							<td width=100 class="title" width=150>임용일자</td>
							<td>
								<input type="text" name="yy" maxlength=4 size=2 value="${ fn:substring(vo.hiredate,0,4) }">년
								<input type="text" name="mm" maxlength=4 size=1 value="${ fn:substring(vo.hiredate,5,7) }">월
								<input type="text" name="dd" maxlength=4 size=1 value="${ fn:substring(vo.hiredate,8,10) }">일
							</td>
						</tr>
						<tr>
							<td width=100 class="title" width=150>교수이름</td>
							<td width=100><input type="text" name="pname" size=12 value="${ vo.pname }"></td>
							<td width=100 class="title" width=150>교수급여</td>
							<td><input type="text" name="salary" value="${ vo.salary }" size=12></td>
							<td width=100 class="title" width=150>교수직급</td>
							<td>
								<input type="radio" name="title" value="정교수" <c:out value="${ vo.title=='정교수'?'checked':''}"/> >정교수
								<input type="radio" name="title" value="부교수" <c:out value="${ vo.title=='부교수'?'checked':''}"/> >부교수
								<input type="radio" name="title" value="조교수" <c:out value="${ vo.title=='조교수'?'checked':''}"/> >조교수
							</td>
						</tr>
					</table>
					<div id="pagination">
						<input type="submit" value="수정" id="btnUpdate">
						<input type="reset" value="취소">
						<input type="button" value="삭제" id="btnDelete">
					</div>
				</form>
				<h3>--------------------------------------------------------------------------------------------------------</h3>
				<div id="divHeader"><h2>SUBJECT IN CHARGE</h2></div>
				<table id="tbl"></table>
				<script id="temp" type="text/x-handlebars-template">
				<tr class="title">
					<td width=100>강좌번호</td>
					<td>강좌이름</td>
					<td width=100>강의실</td>
					<td width=60>강의시수</td>
					<td width=100>최대수강인원</td>
					<td width=100>수강신청인원</td>
					<td width=100>강좌정보</td>
				</tr>
				{{#each cArray}}
				<tr class="row">
					<td class=lcode>{{lcode}}</td>
					<td class=lname>{{lname}}</td>
					<td class=room>{{room}}</td>
					<td class=hours>{{hours}}</td>
					<td class=capacity>{{capacity}}</td>
					<td class=persons>{{persons}}</td>
					<td class=btnDel><button>보기</button></td>
				</tr>
				{{/each}}
				</script>
				<div id="divHeader"><h2>STUDENT IN CHARGE</h2></div>
				<table id="tbl1"></table>
				<script id="temp1" type="text/x-handlebars-template">
				<tr class="title">
					<td width=150>학생번호</td>
					<td width=150>학생이름</td>
					<td width=125>학과</td>
					<td width=125>학년</td>
					<td width=150>생년월일</td>
					<td width=100>학생정보</td>
				</tr>
				{{#each sArray}}
				<tr class="row">
					<td class=scode>{{scode}}</td>
					<td class=sname>{{sname}}</td>
					<td class=dept>{{dept}}</td>
					<td class=year>{{year}}</td>
					<td class=birthday>{{birthday}}</td>
					<td class=btnDel><button>보기</button></td>
				</tr>
				{{/each}}
				</script>
				<!-- 여기에 내용 등록 종료 ------------------------------------------------->
			</div>
		</div>
		<div id="divBottom"><jsp:include page="../footer.jsp" /></div>
	</div>
</body>
<script>
	var pcode="${vo.pcode}";
	var pname="${vo.pname}";
	getList();

	// 특정 과목 페이지로 이동하기
	$("#tbl").on("click", ".row button", function(){
		var lcode=$(this).parent().parent().find(".lcode").html();
		location.href="../cou/read?lcode=" + lcode;
	});
	
	// 특정 학생 페이지로 이동하기
	$("#tbl1").on("click", ".row button", function(){
		var scode=$(this).parent().parent().find(".scode").html();
		location.href="../stu/read?scode=" + scode;
	});
	
	// 특정교수가 담당하는 과목, 학생목록 출력
	function getList() {
		$.ajax({
			type:"get",
			url:"cslist",
			data:{"pcode":pcode},
			dataType:"json",
			success:function(data) {
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				var temp=Handlebars.compile($("#temp1").html());
				$("#tbl1").html(temp(data));
			}
		});
	}
	
	// 삭제 버튼을 클릭했을때
	$("#btnDelete").on("click", function(){
		if(!confirm(pname + " 교수를 삭제하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"delete",
			data:{"pcode":pcode},
			dataType:"json",
			success:function(data) {
				if(data.scount==0 && data.ccount==0) {
					alert("삭제되었습니다 !");
					location.href="list.jsp";
				}else {
					alert("지도학생 : " + data.scount + "담당과목 : " + data.ccount + " \n삭제 할 수 없습니다 !");
				}
			}
		});
	});
	
	// 수정 버튼을 클릭했을때
	$(frm).submit(function(e){
		e.preventDefault();
		if(!confirm(pname + " 교수 정보를 수정하시겠습니까 ?")) return;
		frm.submit();
	});	
</script>
</html>