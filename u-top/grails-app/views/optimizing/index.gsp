
<%@ page import="com.surelution.utop.ProductPricePlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'productPricePlan.label', default: 'ProductPricePlan')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-productPricePlan" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="show-productPricePlan" class="content scaffold-show" role="main">
			<a href='${g.createLink(controller:'optimizing', action:'cacheDefaultPicture') }'>缓存商品默认图片</a>
		</div>
	</body>
</html>
