
<%@page import="com.surelution.utop.DeliveryTicket"%>
<%@page import="com.surelution.utop.Payment"%>
<%@page import="com.surelution.utop.Voucher"%>
<%@page import="com.surelution.utop.SaleOrder.SaleOrderStatus"%>
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
			<g:form action="orderDetails" >
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
					<div class="fieldcontain">
						<label for="status">
							订单状态
							
						</label>
						<g:select name="status" from="${SaleOrderStatus.values() }"  keys="${SaleOrderStatus.values()*.name() }" noSelection="['':'']" value="${params.status }"/>
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.search.label', default: '查询')}" />
				</fieldset>
			</g:form>
		</div>
		<div id="list-keyedMessage" class="content scaffold-list" role="main" style="overflow: scroll;height: 500px">
			<table>
				<thead>
					<tr>
					
						<th>创建时间</th>
						<th>客户</th>
						<th>客户指定<br/>提货站</th>
						<th>实际<br/>提货站</th>
						<th>订单金额</th>
						<th>实际支付</th>
						<th>优惠券</th>
						<th>商品</th>
						<th>商品编码</th>
						<th>价格</th>
						<th>包装数量</th>
						<th>数量</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${orders}" status="i" var="order">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<g:set var="subscriber" value="${UserInfo.loadUserInfo(order.subscriber.openId) }"/>
						<g:set var="orderItems" value="${SaleOrderItem.findAllByOrder(order) }"/>
						<g:set var="rows" value="${orderItems?.size() }"/>
						<g:set var="rows" value="${rows==0?1:rows }"/>
						<g:set var="voucher" value="${Voucher.findByOrder(order) }"/>
						<g:set var="payment" value="${0 }"/>
						<g:if test="${order.status == SaleOrderStatus.PAID || order.status == SaleOrderStatus.DELIVERED }">
							<g:set var="payment" value="${Payment.findByOrder(order)?.amount }"/>
						</g:if>
						<td rowspan="${rows }"><g:formatDate date="${order.dateCreated}" format="yyyy-MM-dd HH:mm:ss"/></td>
						<td rowspan="${rows }">${subscriber.nickname}</td>
						<td rowspan="${rows }">${order.station?.name }</td>
						<td rowspan="${rows }">
							<g:if test="${order.status == SaleOrderStatus.DELIVERED }">
								${DeliveryTicket.findBySaleOrder(order)?.operator.username }
							</g:if>
							<g:else>/</g:else>
						</td>
						<td rowspan="${rows }">${order.amount }</td>
						<td rowspan="${rows }">${payment / 100 }</td>
						<td rowspan="${rows }">${voucher?.amount }</td>
						<g:each in="${orderItems }" var="item">
							<td>${item.plan.product.name }</td>
							<td>${item.plan.product.code }</td>
							<td>${item.plan.product.settlementPrice }</td>
							<td>${item.plan.product.packingCount }</td>
							<td>${item.itemCount }</td>
							</tr>
						</g:each>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
