
<%@ page import="com.surelution.wxmp.jx.GasStation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'gasStation.label', default: 'GasStation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-gasStation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="list-gasStation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="name" title="${message(code: 'gasStation.name.label', default: 'Name')}" />
						
						<th><g:message code="gasStation.branch.label" default="Branch" /></th>
					
						<g:sortableColumn property="linkMan" title="${message(code: 'gasStation.linkMan.label', default: 'Link Man')}" />
					
						<g:sortableColumn property="tel" title="${message(code: 'gasStation.tel.label', default: 'Tel')}" />
					
						<g:sortableColumn property="address" title="${message(code: 'gasStation.address.label', default: 'Address')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${gasStationInstanceList}" status="i" var="gasStationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td style="width:100px;"><g:link action="show" id="${gasStationInstance.id}">${fieldValue(bean: gasStationInstance, field: "name")}</g:link></td>
						
						<td>${fieldValue(bean: gasStationInstance, field: "district.name")}</td>
					
						<td>${fieldValue(bean: gasStationInstance, field: "linkMan")}</td>
						
						<td>${fieldValue(bean: gasStationInstance, field: "tel")}</td>
					
						<td>${fieldValue(bean: gasStationInstance, field: "address")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${gasStationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
