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
		<div id="divTop"><jsp:include page="../header.jsp" /></div>
		<div id="divCenter">
			<div id="divMenu"><jsp:include page="../menu.jsp" /></div>
			<div id="divContent">
				<!-- 여기에 내용 등록 시작 ------------------------------------------------->
				<div id="divHeader">
					<h2>COURSES INFORMATION</h2>
				</div>
				<form name="frm" action="update" method="post">
					<table>
						<tr>
							<td class="title">강좌번호</td>
							<td><input type="text" size=10 name="lcode" value="${ vo.lcode }" readonly></td>
							<td class="title" width=150>강의실</td>
							<td><input type="text" size=5 name="room" value="${ vo.room }"></td>
							<td class="title" width=150>강의시수</td>
							<td><input type="text" size=5 name="hours" value="${ vo.hours }"></td>
						</tr>
						<tr>
							<td class="title">강좌이름</td>
							<td colspan=3><input type="text" size=60 name="lname" value="${ vo.lname }"></td>
							<td class="title">최대수강인원</td>
							<td><input type="text" size=5 name="capacity" value="${ vo.capacity }"></td>
						</tr>
						<tr>
							<td width=90 class="title">담당교수</td>
							<td width=400 colspan=3>
								<input type="text" size=5 name="pcode" value="${ vo.instructor }"> 
								<input type="text" size=10 name="pname" value="${ vo.pname }">
							</td>
							<td class="title">수강신청인원</td>
							<td><input type="text" size=5 name="persons" value="${ vo.persons }"></td>
						</tr>
					</table>
					<div id="pagination">
						<input type="submit" value="수정" id="btnInsert"> 
						<input type="reset" value="취소">
						<input type="button" value="삭제" id="btnDelete">
					</div>
				</form>
				<h3>--------------------------------------------------------------------------------------------------------</h3>
				<div id="divHeader"><h2>A LIST OF STUDENTS</h2></div>
				<div id="divBtnUpdate">
					<button id="btnUpdate">선택저장</button>
				</div>
				<table id="tbl"></table>
				<script id="temp" type="text/x-handlebars-template">
					<tr class="title"> 
						<td width=58><input type="checkbox" id="chkAll"></td> 
						<td width=100>번호</td> 
						<td width=100>이름</td> 
						<td>학과</td> 
						<td width=100>지도교수</td> 
						<td width=70>학년</td> 
						<td width=100>수강신청일</td> 
						<td width=95>점수</td> 
					</tr> 
					{{#each array}} 
					<tr class="row"> 
						<td class="chkbox"><input type="checkbox" class="chk"></td> 
						<td class="scode">{{scode}}</td> 
						<td class="sname">{{sname}}</td> 
						<td class="dept">{{dept}}</td> 
						<td class="pname">{{pname}}</td> 
						<td class="year">{{year}}</td>
						<td class="edate">{{edate}}</td>  
						<td>
							<input type="text" size=2 class="grade" value="{{grade}}">
							<button>수정</button>
						</td> 
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
	var lname="${ vo.lname }";
	var lcode="${ vo.lcode }";
	getList();
	
	// 점수를 잘못 입력했을때
	var preGrade;
	$("#tbl").on("focus", ".row .grade", function(){
		preGrade=$(this).val();
	});
	$("#tbl").on("change", ".row .grade", function(e){
		var row=$(this).parent().parent();
		var grade=row.find(".grade").val();
		if(grade<0 || grade>100) {
			alert("점수를 0~100 사이의 값을 입력하세요 !");
			$(this).val(preGrade);
			$(this).focus();
		}
	});
	
	// 점수 수정 버튼을 눌렀을때
	$("#tbl").on("click", ".row button", function(){
		var scode=$(this).parent().parent().find(".scode").html();
		var grade=$(this).parent().find(".grade").val();
		if(!confirm(scode + " 의 점수를 " + grade + "점 으로 수정하시겠습니까 ?")) return;
		$.ajax({
			type:"post",
			url:"/haksa/enrstu/update",
			data:{"lcode":lcode, "scode":scode, "grade":grade},
			success:function() {
				alert("수정되었습니다 !");
				getList();
			}
		});
	});
	
	// 선택저장 버튼을 클릭한 경우
	$("#btnUpdate").on("click", function(){
		if(!confirm("선택한 학생의 점수를 수정하시겠습니까 ?")) return;
		$("#tbl .row .chk:checked").each(function(){
			var row=$(this).parent().parent();
			var scode=row.find(".scode").html();
			var grade=row.find(".grade").val();
			$.ajax({
				type:"post",
				url:"/haksa/enrstu/update",
				data:{"lcode":lcode, "scode":scode, "grade":grade},
				success:function() {}
			});
		});
		alert("점수가 수정되었습니다 !");
		getList();
	});
	
	// 전체 체크버튼을 클릭했을때
	$("#tbl").on("click", "#chkAll",function(){
		if($(this).is(":checked")) {
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked", true);
			});
		}else {
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked", false);
			});
		}
	});
	
	// 각 행에 있는 체크 버튼을 눌렀을때
	$("#tbl").on("click", ".row .chk", function(){
		var isChkAll=true;
		$("#tbl .row .chk").each(function(){
			if(!$(this).is(":checked"))
				isChkAll=false;
		});
		if(isChkAll) {
			$("#tbl #chkAll").prop("checked", true);
		}else {
			$("#tbl #chkAll").prop("checked", false);
		}
	});
	
	// 특정 강좌를 수강신청한 학생 목록
	function getList() {
		$.ajax({
			type:"get",
			url:"/haksa/enrstu",
			data:{"lcode":lcode},
			dataType:"json",
			success:function(data) {
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
			}
		});
	}
	
	// 삭제버튼을 클릭했을때
	$("#btnDelete").on("click", function(){
		if(!confirm(lname + " 강좌를 삭제하시겠습니까 ?")) return;
		$.ajax({
			type:"get",
			url:"delete",
			data:{"lcode":lcode},
			dataType:"json",
			success:function(data) {
				if(data.count==0) {
					alert("삭제되었습니다 !");
					location.href="list.jsp";
				}else {
					alert("이 강좌를 신청한 학생이 있어 삭제 할 수 없습니다 !");
				}
			}
		});
	});
	
	$(frm).submit(function(e){
		e.preventDefault();
		if(!confirm("강좌를 수정하시겠습니까 ?")) return;
		frm.submit();
	});

	// 교수번호 input 상자를 클릭했을때
	$(frm.pcode).on("click", function(){
		window.open("/haksa/pro/listAll.jsp", "advisor", "width=320, height=350, top=300, left=50");
	});
</script>
</html>