
<%@ page import="com.surelution.utop.Imprest" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'imprest.label', default: 'Imprest')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-imprest" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="show-imprest" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:set var="imprest" value="${imprests.sum{it.amount} }"/>
			<g:if test="${paymets }">
				<g:set var="payment" value="${payments?.sum{it?.amount}/100 }"/>
			</g:if>
			<g:set var="order" value="${orders.sum{it.amount} }"/>
			<g:set var="voucher" value="${vouchers.sum{it.writeOff} }"/>
			<ol class="property-list imprest">
			
				<li class="fieldcontain">
					<span id="transactionNo-label" class="property-label">当前是否允许支付</span>
					
					<span class="property-value" aria-labelledby="transactionNo-label"><g:formatBoolean boolean="${payPermit == '1' }"/> </span>
					
				</li>
			
				<li class="fieldcontain">
					<span id="transactionNo-label" class="property-label">总入账保证金金额</span>
					
					<span class="property-value" aria-labelledby="transactionNo-label">${imprest?imprest:0 }</span>
					
				</li>
			
				<li class="fieldcontain">
					<span id="amount-label" class="property-label">客户总付款金额</span>
					
					<span class="property-value" aria-labelledby="amount-label">${payment }</span>
					
				</li>
			
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label">总提货金额</span>
					
					<span class="property-value" aria-labelledby="dateCreated-label">${order }</span>
					
				</li>
			
				<li class="fieldcontain">
					<span id="transferDate-label" class="property-label">抵用券抵用金额</span>
					
					<span class="property-value" aria-labelledby="transferDate-label">${voucher }</span>
					
				</li>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:if test="${payPermit == '1' }">
						<g:actionSubmit action="turnOff" value="关闭下单" onclick="return confirm('确定要关闭下单吗？如果关闭，客户将无法通过手机下订单');" />
					</g:if>
					<g:else>
						<g:actionSubmit action="turnOn" value="开启下单" onclick="return confirm('确定要开启下单吗？如果开启，客户将可以通过手机下订单');" />
					</g:else>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
