<!doctype html>
<%@page import="com.surelution.utop.SaleOrderItem"%>
<%@page import="com.surelution.utop.DeliveryTicket"%>
<%@page import="com.surelution.utop.SaleOrder.SaleOrderStatus"%>
<%@page import="com.surelution.utop.ProductLabel"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=0"  charset="utf-8"/>  
<title>优米商城<g:if test="${extroInfo }">——${extroInfo }</g:if></title>
<link href="${resource(file:'css/style2.css')}" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/reset.css')}">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/reboot.css')}">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/main2.css')}">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/media.css')}">
<link href="${resource(file:'SpryAssets/SpryTabbedPanels.css')}" rel="stylesheet" type="text/css">
<script src="${resource(file:'js/map.js')}"></script>
<script src="${resource(file:'js/jquery.min.js')}"></script>
<script src="${resource(file:'js/jquery-ui.min.js')}"></script>
<script src="${resource(file:'js/jquery.simplesidebar.js')}"></script>
<script type="text/javascript" src="${resource(file:'js/jquery.flexslider-min.js')}"></script>
<script src="${resource(file:'SpryAssets/SpryTabbedPanels.js')}" type="text/javascript"></script>
<script type="text/javascript">
	function search() {
		var baseUrl = '${createLink(controller:'shop2', action:'search')}' + "/";
		document.location.href = baseUrl + $('#prodName').val();
	}
</script>
</head>

<body>

<div class="wrapper">
	<div class="toolbar">
      <div class="logo"><a href="${createLink(controller:'shop2', action:'index') }"><img src="${resource(file:'images/logo.jpg') }" width="80%"></a></div>
      <div class="top_btn"><input name="prodName" id='prodName' type="text" class="btn110" placeholder="请输入您需要搜索产品"><input name="" type="button" class="btn119" onclick="search()"></div>
	 
	</div>
	<section class="sidebar">
		<nav>
			<ul>
			<g:each in="${ProductLabel.findAllByAvailableAndListInMenu(true, true) }" var="l">
				<li><a href="${createLink(controller:'shop2',action:'index', id:l.id) }">${l.name }</a></li>
			</g:each>
			</ul>
		</nav>
	</section>
</div>
<script>
$( document ).ready(function() {
	$.ajaxSetup({
		cache: false
	});
	$( '.sidebar' ).simpleSidebar({
		settings: {
			opener: '#open-sb',
			wrapper: '.wrapper',
			animation: {
				duration: 500,
				easing: 'easeOutQuint'
			}
		},
		sidebar: {
			align: 'right',
			width: 200,
			closingLinks: 'a',
		}
	});
});
</script>
<g:layoutBody />


<div class="bottom_menu"><a href="${createLink(controller:'shop2', action:'index') }"><img src="${resource(file:'images/index.png')}">首页</a><a href="#" id="open-sb"><img src="${resource(file:'images/pro.png')}">商品分类</a><a href="${createLink(controller:'shop2', action:'cart') }"><img src="${resource(file:'images/car1.png')}">购物车</a><a href="${createLink(controller:'shop2', action:'member') }"><img src="${resource(file:'images/vip.png')}">个人中心</a><!--<a href="about.html"> <img src="${resource(file:'images/about.png')}">公司介绍</a> --></li></div>
<br><br><br><br><br>
<script type="text/javascript">
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
</script>
</body>
</html>
