
<%@page import="com.surelution.whistle.push.UserInfo"%>
<%@ page import="com.surelution.utop.QrUserLogin" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'qrUserLogin.label', default: 'QrUserLogin')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<script type="text/javascript" src="${resource(file:'js/jquery-1.9.1.min.js') }"></script>
		<script type="text/javascript">
		var qrKey
		function loadQr() {
			$.ajax({
				  url: "${createLink(controller:'qrUserLogin', action:'fetchQr')}"
				}).done(function( data ) {
				    var code = data.returnCode
				    if(code == "1") {
					    qrKey = data.qrKey
						$('#qrImg').attr("src","${createLink(controller:'qrUserLogin', action:'qr')}/" + data.qrKey);
						$('#loginId').val(data.id);
					}
				  });
		}
		</script>
	</head>
	<body>
		<a href="#show-qrUserLogin" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="show-qrUserLogin" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
		<g:if test="${currLogin?.subscriber }">
			<g:set var="ui" value="${UserInfo.loadUserInfo(currLogin.subscriber.openId)}"/>
			当前登录用户:${ui.nickname }<br/>
			头像：<img src="${ui.headImgUrl }" width="64" height="64"><br/>
			登录时间：<g:formatDate date="${currLogin.dateConfirmed }" format="yyyy-MM-dd HH:mm:ss"/><br/>
			<a href="${createLink(action:'confirmLogout', id:currLogin.id) }">退出该用户</a>
		</g:if>
		<g:else>
			<img id="qrImg" width="320" height="320"/><br/>
			<input type="button" value="刷新二维码" onclick="loadQr()"><br/>
			<g:form action="confirmLogin">
				<g:hiddenField name="loginId"/><br/>
				验证码：<g:textField name="validateCode"/><br/>
				<g:submitButton name="login" value="许可登录"/>
			</g:form>
		</g:else>
		</div>
	</body>
</html>
