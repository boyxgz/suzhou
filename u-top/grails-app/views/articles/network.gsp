
<!DOCTYPE html>
<%@page import="com.surelution.utop.District"%>
<%@page import="com.surelution.utop.GasStation"%>
<html>
<head>
<title>中国石油苏州分公司</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${resource(dir:'css/jquery.mobile-1.3.2.min.css')}" />
<script type="text/javascript"
	src="${resource(dir:'js/jquery-1.9.1.min.js')}"></script>
<script src="${resource(dir:'js/jquery.mobile-1.3.2.min.js')}"></script>
</head>
<body>
	<div data-role="page" id="page-network">
		<div data-role="content">
			<div data-theme="b" data-role="header" data-position="fixed">加油站网点</div>
			<div data-role="collapsible-set" data-content-theme="d" id="set">
				<g:each in="${District.list() }" var="district" status="i">
					<div data-role="collapsible" id="set${i}" data-collapsed="true">
						<h3>${district.name}</h3>
						<table data-role="table" id="my-table"
							class="ui-responsive table-stroke">
							<thead>
								<tr>
									<th>网点名称</th>
									<th>地址</th>
									<th>联系电话</th>
								</tr>
							</thead>
							<tbody>
							<g:each in="${GasStation.findAllByDistrictAndActive(district, true) }" var="station">
								<tr>
									<th>
									<g:if test="${latitude && longitude }">
									<a href="${resource(dir:'/navigation')}/go?orig=${latitude},${longitude}&dest=${station.id}" rel="external">${station.name }</a>
									</g:if>
									<g:else>
									${station.name }
									</g:else>
									</th>
									<td>${station.address }</td>
									<td>${station.tel }</td>
								</tr>
							</g:each>
							</tbody>
						</table>
					</div>
				</g:each>
			</div>
		</div>
	</div>
</body>
</html>
