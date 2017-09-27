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

#subManage3 {
	width: 450px;
	margin: 0px auto;
}

#subManage3 ul {
	clear: both;
	overflow: hidden;
	height: 150px;
	border: 1px solid #ccc;
	padding: 10px;
	overflow: hidden;
}

#subManage3 ul li {
	float: left;
	width: 77px;
	height: 26px;
	background: #337ab7;
	list-style: none;
	margin: 0px 8px 6px 0;
	text-align: center;
	line-height: 26px;
	color: #fff;
	font-size: 14px;
	cursor: pointer;
}

#subManage3 .sselected {
	background: #d9534f
}

#subManage3 .btnGroup {
	clear: both;
	float: left;
	width: 200px;
	margin: 10px;
}

#subManage3 .btn-group button {
	margin-right: 20px;
}

#subManage3 #mes {
	float: left;
	width: 150px;
	height: 36px;
	line-height: 30px;
	letter-spacing: 3px;
	color: red;
}

#subManage3 #bj {
	width: 120px;
	height: 30px;
	margin-bottom: 10px;
	font-size: 20px;
	font-weight: bold;
	font-size: 20px;
	font-size: 20px
}
</style>

<script>
	$(document)
			.ready(
					function() {
	
						$("#subManage3 #add")
								.click(
										function() {
											var subIds = new Array();
											$("#subManage3 #noSub li")
													.each(
															function(index,
																	element) {
																if ($(this)
																		.attr(
																				"class") == "sselected") {
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
																$(
																		"#subManage3 #noSub")
																		.html(
																				noSubsStr);

															}
														})

											} else {

												showMes("请选中一条数据");
											}

										})

						$("#subManage3 #delete")
								.click(
										function() {
											var subIds = new Array();
											$("#sub li")
													.each(
															function(index,
																	element) {
																if ($(this)
																		.attr(
																				"class") == "sselected") {
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
												$("#myModal").modal('hide');

											}

										})
						$("#subManage3 #bj")
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
							$("#subManage3 #mes").html(mes);
							setTimeout(function() {
								$("#subManage3 #mes").html("");
							}, 1000);
						}
					})
</script>

<div id="subManage3">

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
		<button id="add" type="button" class="btn btn-danger">↑</button>
		<button id="delete" type="button" class="btn btn-danger">↓</button>

	</div>
	<div id="mes"></div>

	<ul id="noSub">
		<c:forEach items="${noSubs}" var="sub">
			<li data-subid="${sub.id}">${sub.name }</li>
		</c:forEach>
	</ul>




</div>


