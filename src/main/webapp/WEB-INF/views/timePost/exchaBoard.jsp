<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->	
<html>
<head>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {
});

//목록
function getList(keyword, currentPage, queGubun) {
	let queGubunTemp = "";
	if(queGubun != null) {
		queGubunTemp = queGubun;
	}
	
	// JSON 오브젝트
	let data = {
		"keyword":keyword,
		"currentPage":currentPage,
		"queGubun":queGubunTemp //구분 추가
	};
	
	console.log("data : " , data);
	
	//아작나써유..(피)씨다타써...
	$.ajax({
		url: "/timePost/exchaBoardAjax", //ajax용 url 변경
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
		success:function(result){
			console.log("result.content : ", result.content);
			
			let str = "";
			
			if(result.content.length == 0) {
				str += `<tr>`;
				str += `<td colspan="6" style="text-align:center;">검색 결과가 없습니다.</td>`;
				str += `</tr>`;
			}
			
			$.each(result.content, function(idx, CommonNoticeVO){
// 				str += `<tr name="trHref" onclick="location.href='/commonNotice/detail?menuId=annNotIce&comNotNo=\${CommonNoticeVO.comNotNo}'" style="cursor:pointer">
// 				<td class="textCenter">\${CommonNoticeVO.rn}</td>
// 				<td class="textCenter">\${CommonNoticeVO.comGubun}</td>
// 				<td>\${CommonNoticeVO.comNotName}</td>
// 				<td class="textCenter">\${CommonNoticeVO.userInfoVOList.userName}</td>
// 				<td class="textCenter">\${CommonNoticeVO.comFirstDate}</td>
// 				<td class="textCenter">\${CommonNoticeVO.comNotViews}</td>`;
			});
			
			$(".clsPagingArea").html(result.pagingArea);
			
			$("#trShow").html(str);
		}
	});
}	
	
function lectureTransfer() {
	let today = new Date();   

	let year = today.getFullYear(); // 년도
	let month = today.getMonth() + 1;  // 월
	let date = today.getDate();  // 날짜
	let day = today.getDay();  // 요일

	let todayDate = year + '/' + month + '/' + date;
	console.log("todayDate : ", todayDate);
	
	if((date <= 31) && (month <= 7)) { // 7월 19일까지 수강신청 거래 가능
		location.href="/stuLecture/exchange?menuId=couRegChk";
	}
}
</script>
<style type="text/css">
h3 {
	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 165px;
} 

.wkrtjdBut {
    display: inline-block;
    width: 105px;
    margin-bottom: 20px;
}
   
.trBackground {
    background-color: #ebf1e9;
}

#btnSearch {
	border: 1px solid #D1D3E2;
	background-color: #F8F9FA;
}

.selectSearch{
    width: 130px;
    height: 30px;
    float: left;
    margin: 0px 5px 0px 0px;
    font-size: 0.8rem;
}

.clsPagingArea {
	margin-top:  20px;
	justify-content: flex-end;
}

.textCenter {
    text-align:center;
}

.expBox {
    background-color: white;
    border: 1px solid #ced4da;
    width: 80%;
    margin-left: 160px;
    margin-bottom: 30px;
    padding: 40px 40px 30px 40px;
}

.rkddmlrjfoBut {
	margin-top: -10px;
    margin-left: 1040px;
    display: inline-block;
    margin-right: 20px;
    width: 105px;
}
</style>

</head>
<body>
<p style="display:none;"><sec:authentication property="principal"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO.userName"/></p>
<p style="display:none;"><sec:authentication property="principal.username"   var="merong"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO.authorityVOList"  var="myAuths"/></p>
	<h3>강의 양도</h3>
	<br>
	<div class="expBox" style="color:black;">
		<strong>
			<p>
				※강의양도는 학생들의 필요한 강의들을 찾을 수 있는 게시판입니다.
			</p>
			<br>
			<p>
				양도 혹은 구함 글을 검색하여 필요한 강의를 찾아 양도를 진행하시면 됩니다.
				이를 통한 금전적인 거래는 전면 금지 되어 있으니 그와 관련된 문의는 받지 않습니다.
			</p>
			<br>
			<p>
				상업성 광고, 정치적 목적 게시물, 특정단체 개인의 명예훼손 게시물,
				음란물 등 미풍양속에 어긋나는 게시물 게시자는 민형사상 불이익을 받을 수 있으며 
				관리자의 권한으로 삭제 될 수 있으니 게시판 성격에 맞는 내용만 게시하시기 바랍니다.
			</p>
		</strong>
	</div>
	
	<p><input type="hidden" name="authority" value="${myAuths[0].authority}"></p>
	
	<table style="margin-left: 160px;">
		<tr>
			<td colspan="2">
				<button type="button" class="btn btn-block btn-outline-success rkddmlrjfoBut" onclick="lectureTransfer()">강의 전송</button>
				<button type="button" name="authorityBtn" class="btn btn-block btn-outline-primary wkrtjdBut" id="newwrite" onclick="location.href='/timePost/excBoaAdd?menuId=injLecDea'">작성</button>
			</td>
		</tr>
		<tr>
			<td style="width: 650px;">
				<div style="margin-right: 30px;">
					<div class="card">
						<div class="card-header" style="background-color: #fff;">
							<h4 style="color:black; display: inline-block;">양도 게시글</h4>
							<div class="brd-search">
								<select title="검색 조건 선택" id="searchCnd1" class="selectSearch form-control">
									<option value="1">제목</option>
									<option value="2">작성자</option>
									<option value="3">작성일자</option>
								</select>
				
								<div class="input-group input-group-sm"
									style="width: 280px; float: left;">
									<input type="text" name="table_search"
										class="form-control float-left" placeholder="검색어를 입력하세요">
									<div class="input-group-append">
										<button type="button" class="btn btn-default" id="btnSearch1">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
							</div>
						</div>
				
						<div class="card-body table-responsive p-0">
							<table class="table table-hover text-nowrap">
								<thead>
									<tr class="trBackground textCenter" style="color:black;">
										<th style="width: 5%;">번호</th>
										<th>제목</th>
										<th style="width: 10%;">작성자</th>
										<th style="width: 15%;">작성일자</th>
										<th style="width: 10%;">양도상태</th>
									</tr>
								</thead>
								<tbody id="trShow">
									<c:forEach var="tEBAssVO" items="${articlePageAss.content}" varStatus="stat">
									<tr name="trHref" onclick="location.href='/timePost/excBoaDetail?menuId=injLecDea&timeExBNo=${tEBAssVO.timeExBNo}'" style="cursor:pointer">
										<td class="textCenter">${tEBAssVO.rn}</td>
										<td>${tEBAssVO.timeExName}</td>
										<td class="textCenter">${tEBAssVO.userInfoVOList.userName}</td>
										<td class="textCenter">${tEBAssVO.timeExDate} <br> ${tEBAssVO.timeExDateTime}</td>
				                        <c:choose>
				                            <c:when test="${tEBAssVO.timeExStat == '대기'}">
				                                <td class="textCenter" style="color: red;">대기</td>
				                            </c:when>
				                            <c:when test="${tEBAssVO.timeExStat == '완료'}">
				                                <td class="textCenter" style="color: blue;">완료</td>
				                            </c:when>
				                        </c:choose>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				
					<div class="row clsPagingArea">
						${articlePageAss.pagingArea}
					</div>

				</div>
			</td>
			<td style="width: 650px;">
				<div>
					<div class="card">
						<div class="card-header" style="background-color: #fff;">
							<h4 style="color:black; display: inline-block;">구함 게시글</h4>
							<div class="brd-search">
								<select title="검색 조건 선택" id="searchCnd2" class="selectSearch form-control" style="color:black;">
									<option value="3">제목</option>
									<option value="4">작성자</option>
									<option value="5">작성일자</option>
								</select>
				
								<div class="input-group input-group-sm" style="width: 280px; float: left;">
									<input type="text" name="table_search"
										class="form-control float-left" placeholder="검색어를 입력하세요">
									<div class="input-group-append">
										<button type="button" class="btn btn-default" id="btnSearch2">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
							</div>
						</div>
				
						<div class="card-body table-responsive p-0">
							<table class="table table-hover text-nowrap">
								<thead>
									<tr class="trBackground textCenter" style="color:black;">
										<th style="width: 5%;">번호</th>
										<th>제목</th>
										<th style="width: 10%;">작성자</th>
										<th style="width: 15%;">작성일자</th>
										<th style="width: 10%;">양도상태</th>
									</tr>
								</thead>
								<tbody id="trShow">
									<c:forEach var="tEBWanVO" items="${articlePageWan.content}" varStatus="stat">
									<tr name="trHref" onclick="location.href='/timePost/excBoaDetail?menuId=injLecDea&timeExBNo=${tEBAssVO.timeExBNo}'" style="cursor:pointer">
										<td class="textCenter">${tEBWanVO.rn}</td>
										<td>${tEBWanVO.timeExName}</td>
										<td class="textCenter">${tEBWanVO.userInfoVOList.userName}</td>
										<td class="textCenter">${tEBWanVO.timeExDate} <br> ${tEBWanVO.timeExDateTime}</td>
				                        <c:choose>
				                            <c:when test="${tEBWanVO.timeExStat == '대기'}">
				                                <td class="textCenter" style="color: red;">대기</td>
				                            </c:when>
				                            <c:when test="${tEBWanVO.timeExStat == '완료'}">
				                                <td class="textCenter" style="color: blue;">완료</td>
				                            </c:when>
				                        </c:choose>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				
					<div class="row clsPagingArea">
						${articlePageWan.pagingArea}
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>