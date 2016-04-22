<!doctype html>
<%@page import="grails.util.Holders"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=0"  charset="utf-8"/>  
<title>优米商城</title>
<link href="${resource(file:'css/style2.css')}" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/reset.css')}">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/reboot.css')}">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/main2.css')}">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/media.css')}">
<script src="${resource(file:'js/map.js')}"></script>
<script src="${resource(file:'js/jquery.min.js')}"></script>
<script src="${resource(file:'js/jquery-ui.min.js')}"></script>
<script src="${resource(file:'js/jquery.simplesidebar.js')}"></script>
<script type="text/javascript" src="${resource(file:'js/jquery.flexslider-min.js')}"></script>
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
</div>

<div class="pro">
  <dl>
      <dt><a href="#"><img src="${Holders.config.alioss.images.rootUrl }${pricePlan.productPicId }"></a></dt>
      <dd class="d2">${pricePlan.product.name }</dd>
      <dd class="d1">价格：￥${pricePlan.price }<span>市场价：￥${pricePlan.retailPrice }</span></dd>
      <dd class="d1">规格：${pricePlan.product.spec }</dd>
      <dd class="d1" style="color:#333; overflow:hidden;"><b style=" float:left; padding-right:10px;">数量:</b><a href="javascript:updateQty(1)">+</a><input name="qty" id="qty" type="number" value="${itemCount }"><a href="javascript:updateQty(-1)">-</a></dd>
    </dl>
</div>

<br><br>

<div class="pro_car"><a href="javascript:addProductToCart()"><input type="button" value="加入购物车"></a></div>

</body>
<script type="text/javascript">
	function updateQty(qty) {
		var oQty = $('#qty').val();
		if(oQty == "") {
			oQty = "0";
		}
		var v = parseInt(oQty) + qty;
		if(v < 0) {
			v = 0;
		}
		$('#qty').val(v);
	}

	function addProductToCart() {
		var url = "${createLink(controller:'shop2', action:'addProductToCart', id:pricePlan.id)}?qty=" + $('#qty').val();
		document.location.href = url;
	}
</script>
</html>
