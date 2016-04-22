<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.png')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
		<g:layoutHead/>
		<r:layoutResources />
	</head>
	<body>
	    <div id="container">
	    	<div id="header">
	    		<div class="header_box">
		    			<a href="${createLink(uri: '/')}" title="微信营销平台后台"><img style="border: 0 none;float:left;" src="${resource(dir:'images',file:'title.png')}" width="600px" height="60px"/></a>
					<div style='float: right;font-size:12px;padding-top:50px;'>
					当前用户：<sec:username />&nbsp;&nbsp;<g:link controller="user" action="showChangePw" style="color:black;font-weight:normal;">更改密码</g:link>&nbsp;&nbsp;<g:link controller="logout" style="color:black;font-weight:normal;">退出</g:link>
					</div>
		    	</div>
		    	</div>
			<div id="leftcol">
				<sec:ifAnyGranted roles="ROLE_STATION">
				<p>
					<g:link url="${resource(dir:'pos')}" >提货</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'qrUserLogin/dashboard')}" >微信登录</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'reports/deliveryDetails')}" >提货报表</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'reports/dailySaleSummaryWithProductOfStation')}" >提货汇总报表</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'orderForm/limitedList')}" >误锁定代金券</g:link>
				</p>
				</sec:ifAnyGranted>
				<sec:ifAnyGranted roles="ROLE_SALINGMNG">
				<p>
					<g:link url="${resource(dir:'subscriberChannel/report')}" >推广报表</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'productPricePlan')}" >价格审批</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'reports/deliverySummary')}" >团购价格审批单</g:link>
				</p>
				
				</sec:ifAnyGranted>
				<sec:ifAnyGranted roles="ROLE_FINANCIAL">
				<p>
					<g:link url="${resource(dir:'imprest/waitingForConfirm')}" >保证金审批</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'reports/allDeliveryDetails')}" >提货总报表</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'reports/dailySaleSummaryWithProduct')}" >商品分站总表</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'reports/dailySaleSummary')}" >日销售汇总</g:link>
				</p>
				</sec:ifAnyGranted>
				<sec:ifAnyGranted roles="ROLE_ADMIN">
				<p>
					<g:link url="${resource(dir:'orderForm')}" >误锁定代金券</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'imprest')}" >新增保证金</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'reports/orderDetails')}" >订单明细报表</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'bankrollDashboard')}" >保证金安全</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'optimizing')}" >技术优化</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'productPricePlan/productPosition')}" >商品顺序</g:link>
				</p>
				<p>
					<g:link url="${resource(dir:'user')}" >用户管理</g:link>
				</p>
				</sec:ifAnyGranted>
				
			</div>

			<div id="main_content"><g:layoutBody /></div>
			<div id="footer">
			<p>
			___________________________________________________________________________________________
			</p>
				&copy;<a href="http://www.sh-hansi.com"  style="text-decoration:none;color:white;">上海悍思企业管理咨询有限公司</a>&nbsp;&nbsp;&nbsp;&nbsp;技术支持
			</div>
	    </div>
	
		<g:javascript library="application"/>
		<r:layoutResources />
	</body>
</html>
