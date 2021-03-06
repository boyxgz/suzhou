
<%@page import="com.surelution.utop.Role"%>
<%@page import="com.surelution.utop.UserRole"%>
<%@page import="com.surelution.utop.SaleOrderItem"%>
<%@page import="com.surelution.whistle.push.UserInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.surelution.utop.KeyedMessage" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>提货报表</title>
		
		<script type="text/javascript" src="${resource(file:'js/jquery-1.9.1.min.js') }"></script>
		<link href="${resource(dir:'css/jquery.datetimepicker.css')}" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${resource(file:'js/jquery.datetimepicker.js') }"></script>
		<script type="text/javascript">
			$( document ).ready(function() {
				$('#dateFrom').datetimepicker({
					dayOfWeekStart : 1,
					lang:'ch',
					format:'Y-m-d H:i'
					});
				$('#dateFrom').datetimepicker({step:10});
			});
			$( document ).ready(function() {
				$('#dateTo').datetimepicker({
					dayOfWeekStart : 1,
					lang:'ch',
					format:'Y-m-d H:i'
					});
				$('#dateTo').datetimepicker({step:10});
			});
		</script>
	</head>
	<body>
		<a href="#list-keyedMessage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="create-voucher">
			<h1>提货报表</h1>
			<g:form action="dailySaleSummary" >
				<fieldset class="form">
					<div class="fieldcontain">
						<label for="dateFrom">
							<g:message code="voucher.paidAt.dateFrom.label" default="开始时间" />
							
						</label>
						<%
							def df = params.dateFrom
							def sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm")
							if(!df) {
								def f = new Date().clearTime()
								f.setDate(f.getDate() - 1)
								f.setHours(16)
								df = sdf.format(f)
							}
							def dt = params.dateTo
							if(!dt) {
								def t = new Date().clearTime()
								t.setHours(16)
								dt = sdf.format(t)
							}
						 %>
						 <g:textField name="dateFrom" value="${df}"/>
					</div>
					<div class="fieldcontain">
						<label for="dateTo">
							<g:message code="voucher.paidAt.dateTo.label" default="结束时间" />
							
						</label>
						<g:textField name="dateTo" value="${dt}"/>
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.search.label', default: '查询')}" />
				</fieldset>
			</g:form>
		</div>
		<div id="list-keyedMessage" class="content scaffold-list" role="main" style="overflow: auto;">
			<table>
				<thead>
					<tr>
					
						<th rowspan="2">日期</th>
					
						<g:each in="${users }" var="user">
						<th colspan="2">${user.username }</th>
						</g:each>
						<th colspan="2">汇总</th>
					</tr>
					<tr>
					
						<g:each in="${users }" var="user">
						<th>营业额</th>
						<th>订单数</th>
						</g:each>
						<th>营业额</th>
						<th>订单数</th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${items}" status="i" var="item">
				<g:set var="totalAmount" value="${0 }"/>
				<g:set var="totalCount" value="${0 }"/>
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td>${item[0] }</td>
					
						<g:each in="${users }" var="user" status="j">
						<td>${item[2*j + 1] }</td>
						<td>${item[2*j + 2] }</td>
						<g:set var="totalAmount" value="${totalAmount + item[2*j + 1]  }"/>
						<g:set var="totalCount" value="${totalCount + item[2*j + 2]  }"/>
						</g:each>
						<td>${totalAmount }</td>
						<td>${totalCount }</td>
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
