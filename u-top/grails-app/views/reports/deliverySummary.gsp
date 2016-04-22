
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
			<g:form action="deliverySummary" >
				<fieldset class="form">
					<div class="fieldcontain">
						<label for="userId">
							发货人
						</label>
						<g:select name="userId" from="${UserRole.findAllByRole(Role.findByAuthority('ROLE_STATION')).collect(){it.user} }" optionKey="id" optionValue="username" value="${params.userId }"/>
					</div>
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
		<div id="list-keyedMessage" class="content scaffold-list" role="main">
			<table>
				<thead>
					<tr>
					
						<th>序号</th>
					
						<th>编码</th>
					
						<th>团购商品名称</th>
					
						<th>数量</th>
					
						<th>折算组数</th>
					
						<th>单瓶/组进价</th>
					
						<th>售价</th>
					
						<th>金额</th>
					
						<th>毛利率</th>
					
						<th>优惠后售价</th>
					
						<th>优惠后金额</th>
					
						<th>毛利</th>
					
						<th>优惠后毛利率</th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${items}" status="i" var="item">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<g:set var="product" value="${item[0].product }"/>
						<td>${i + 1 }</td>
					
						<td>${product.code }</td>
					
						<td>${product.name }&nbsp;&nbsp;&nbsp;1 * ${product.packingCount }</td>
					
						<td>${item[1] * product.packingCount }</td>
					
						<td>${item[1] }</td>
					
						<td>${item[0].costPrice }</td>
					
						<td>${item[0].retailPrice }</td>
					
						<td>${item[0].retailPrice * item[1] }</td>
					
						<td><g:formatNumber number="${(item[0].retailPrice - item[0].costPrice) / item[0].retailPrice  * 100}" format="##.##" />%</td>
					
						<td>${item[0].price }</td>
					
						<td>${item[0].price * item[1] }</td>
					
						<td>${(item[0].price - item[0].costPrice) * item[1] }</td>
					
						<td><g:formatNumber number="${(item[0].price - item[0].costPrice) / item[0].price * 100 }" format="###.##"/>% </td>
						
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
