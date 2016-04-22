
<%@ page import="com.surelution.wxmp.jx.MultiNewsMessageItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'multiNewsMessageItem.label', default: 'MultiNewsMessageItem')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-multiNewsMessageItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-multiNewsMessageItem" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="title" title="${message(code: 'multiNewsMessageItem.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="firstNews" title="${message(code: 'multiNewsMessageItem.firstNews.label', default: 'First News')}" />
					
						<th><g:message code="multiNewsMessageItem.message.label" default="Message" /></th>
					
						<g:sortableColumn property="pictureUrl" title="${message(code: 'multiNewsMessageItem.pictureUrl.label', default: 'Picture Url')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'multiNewsMessageItem.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="url" title="操作" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${multiNewsMessageItemInstanceList}" status="i" var="multiNewsMessageItemInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td style="width:150px;"><g:link action="show" id="${multiNewsMessageItemInstance.id}">${fieldValue(bean: multiNewsMessageItemInstance, field: "title")}</g:link></td>
					
						<td><g:formatBoolean boolean="${multiNewsMessageItemInstance.firstNews}" /></td>
					
						<td style="width:100px;">${multiNewsMessageItemInstance.message.description?multiNewsMessageItemInstance.message.description:multiNewsMessageItemInstance.message.menuKey}</td>
					
						<td><img src='${multiNewsMessageItemInstance.pictureUrl}' style="width:200px;"/></td>
					
						<td >${fieldValue(bean: multiNewsMessageItemInstance, field: "description")}</td>
					
						<td><a href='${multiNewsMessageItemInstance.url}' target="_blank">查看内容</a></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${multiNewsMessageItemInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
