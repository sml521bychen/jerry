<%@page import="util.Pagination"%>
<%@ page language="java" import="java.util.*,entity.*"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<style>
* {
	margin: 0;
	padding: 0;
}

#SubModal {
	width: 450px;
	margin: 0px auto;
}

#SubModal ul {
	clear: both;
	overflow: hidden;
	height: 150px;
	border: 1px solid #ccc;
	padding: 10px;
	overflow: hidden;
	width: 450px;
	margin-bottom: 0px;
}

#SubModal ul li {
	float: left;
	width: 80px;
	height: 30px;
	background: #337ab7;
	list-style: none;
	margin: 0px 20px 20px 0;
	text-align: center;
	line-height: 30px;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
}

#SubModal .selected {
	background: #d9534f
}

#SubModal .btnGroup {
	clear: both;
	float: left;
	width: 200px;
	margin: 5px;
}

#SubModal .btn-group button {
	margin-right: 10px;
}

#SubModal #mesSub {
	float: left;
	width: 150px;
	height: 36px;
	line-height: 30px;
	letter-spacing: 3px;
	color: red;
}

#SubModal #bj {
	width: 120px;
	height: 30px;
	margin-bottom: 10px;
	font-size: 20px;
	font-weight: bold;
	font-size: 20px;
}
</style>

<script>
	$(document)
			.ready(
					function() {
						//jquery动态生成的元素，事件不能用的解决办法
						$(document).on("click", "li", function() {
							$(this).toggleClass("selected");
						})

						$("#addSub")
								.click(
										function() {
											var subIds = new Array();
											$("#noSub li")
													.each(
															function(index,
																	element) {
																if ($(this)
																		.attr(
																				"class") == "selected") {
																	subIds
																			.push($(
																					this)
																					.data(
																							"subid"));
																}
															})

											if (subIds.length > 0) {
												$
														.ajax({
															url : "bj",
															data : "type=addSub&bjId="
																	+ $("#bj")
																			.val()
																	+ "&subIds="
																	+ subIds,
															type : "get",
															dataType : "text",
															success : function(
																	data) {

																var strs = data
																		.split("-|-");

																var subs = JSON
																		.parse(strs[0]);
																var noSubs = JSON
																		.parse(strs[1]);
																var subsStr = "";
																for (var i = 0; i < subs.length; i++) {

																	subsStr += "<li data-subid="+subs[i].id+">"
																			+ subs[i].name
																			+ "</li>"

																}
																$("#sub")
																		.html(
																				subsStr);
																var noSubsStr = "";
																for (var i = 0; i < noSubs.length; i++) {

																	noSubsStr += "<li data-subid="+noSubs[i].id+">"
																			+ noSubs[i].name
																			+ "</li>"

																}
																$("#noSub")
																		.html(
																				noSubsStr);

															}
														})

											} else {

												showMes("请选中一条数据");
											}

										})

						$("#deleteSub")
								.click(
										function() {
											var subIds = new Array();
											$("#sub li")
													.each(
															function(index,
																	element) {
																if ($(this)
																		.attr(
																				"class") == "selected") {
																	subIds
																			.push($(
																					this)
																					.data(
																							"subid"));
																}
															})

											if (subIds.length > 0) {
												$
														.ajax({
															url : "bj",
															data : "type=deleteSub&bjId="
																	+ $("#bj")
																			.val()
																	+ "&subIds="
																	+ subIds,
															type : "get",
															dataType : "text",
															success : function(
																	data) {

																var strs = data
																		.split("-|-");

																var subs = JSON
																		.parse(strs[0]);
																var noSubs = JSON
																		.parse(strs[1]);
																var subsStr = "";
																for (var i = 0; i < subs.length; i++) {

																	subsStr += "<li data-subid="+subs[i].id+">"
																			+ subs[i].name
																			+ "</li>"

																}
																$("#sub")
																		.html(
																				subsStr);
																var noSubsStr = "";
																for (var i = 0; i < noSubs.length; i++) {

																	noSubsStr += "<li data-subid="+noSubs[i].id+">"
																			+ noSubs[i].name
																			+ "</li>"

																}
																$("#noSub")
																		.html(
																				noSubsStr);

															}
														})

											} else {

												showMes("请选中一条数据");
											}

										})
						$("#bj")
								.change(
										function() {

											$
													.ajax({
														url : "bj",
														data : "type=searchSub&bjId="
																+ $("#bj")
																		.val(),
														type : "get",
														dataType : "text",
														success : function(data) {

															var strs = data
																	.split("-|-");

															var subs = JSON
																	.parse(strs[0]);
															var noSubs = JSON
																	.parse(strs[1]);
															var subsStr = "";
															for (var i = 0; i < subs.length; i++) {

																subsStr += "<li data-subid="+subs[i].id+">"
																		+ subs[i].name
																		+ "</li>"

															}
															$("#sub").html(
																	subsStr);
															var noSubsStr = "";
															for (var i = 0; i < noSubs.length; i++) {

																noSubsStr += "<li data-subid="+noSubs[i].id+">"
																		+ noSubs[i].name
																		+ "</li>"

															}
															$("#noSub").html(
																	noSubsStr);

														}
													})

										})

						function showMes(mes) {
							$("#mesSub").html(mes);
							setTimeout(function() {
								$("#mesSub").html("");
							}, 1000);
						}
					})
</script>

<div id="SubModal">

	<select id="bj"><c:forEach items="${bjs}" var="banji">
			<option <c:if test="${banji.id==bj.id}" >selected</c:if>
				data-bjid="${banji.id}" value="${banji.id}">${banji.name }</option>
		</c:forEach>
	</select>


	<ul id="sub">
		<c:forEach items="${bj.subs}" var="sub">
			<li data-subid="${sub.id}">${sub.name }</li>
		</c:forEach>
	</ul>
	<div class="btnGroup">
		<button id="addSub" type="button" class="btn btn-danger">↑</button>
		<button id="deleteSub" type="button" class="btn btn-danger">↓</button>

	</div>
	<div id="mesSub"></div>

	<ul id="noSub">
		<c:forEach items="${noSubs}" var="sub">
			<li data-subid="${sub.id}">${sub.name }</li>
		</c:forEach>
	</ul>




</div>

