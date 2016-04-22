
<%@page import="com.surelution.utop.SaleOrderItem"%>
<%@page import="com.surelution.whistle.push.UserInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.surelution.utop.KeyedMessage" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>误锁定代金券（支付失败）</title>
		
		<script type="text/javascript" src="${resource(file:'js/jquery-1.9.1.min.js') }"></script>
	</head>
	<body>
		<a href="#list-keyedMessage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="create-voucher">
			<h1>误锁定代金券（支付失败）</h1>
		</div>
		<div id="list-keyedMessage" class="content scaffold-list" role="main">
		<g:form controller='orderForm' action='limitedActive'>
			<table>
				<thead>
					<tr>
						<th>&nbsp;</th>
					
						<th>支付时间</th>
					
						<th>客户</th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${vouchers}" status="i" var="voucher">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:radio name="voucherId" value="${voucher.id }" checked="true"/></td>

						<td><g:formatDate date="${voucher.order.dateCreated}" format="yyyy-MM-dd"/></td>

						<g:set var="ui" value="${UserInfo.loadUserInfo(voucher.order.subscriber.openId) }"/>
						<td>
							<img src="${ui.headImgUrl }" width="64" height="64"/><br/>
						${ui.nickname}</td>

					</tr>
				</g:each>
				</tbody>
			</table>
			<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="再次激活" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
