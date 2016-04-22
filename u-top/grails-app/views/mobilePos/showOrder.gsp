<!DOCTYPE html>
<%@page import="grails.util.Holders"%>
<%@page import="com.surelution.utop.Station"%>
<html>
<head>
	<meta charset="UTF-8" />	
	<meta content="yes" name="apple-mobile-web-app-capable" />
	<meta content="black" name="apple-mobile-web-app-status-bar-style" />
	<meta content="telephone=no" name="format-detection" />
	<meta name="viewport" content="minimal-ui, width=640, initial-scale=1, maximum-scale=0.5, minimum-scale=0.5, user-scalable=no, target-densitydpi=320"/>
	<title>优米</title>
	<link href="${resource(dir:'css', file:'youmi.css') }?v=4245" rel="stylesheet" type="text/css" />
	<link href="${resource(dir:'css', file:'list.css') }" rel="stylesheet" type="text/css" />
	<link href="${resource(dir:'css', file:'scrollbar.css') }" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${resource(dir:'js', file:'jquery-1.11.0.min.js') }"></script>
</head>
<body>
<div id="divBody">
	<div class="wap_top">
		<p class="top_back" name="topback"><a href="javascript:;"><img src="${resource(dir:'images', file:'top_back.png') }" height="41" width="24"></a></p>
	  	<p class="top_tit">提货列表</p>
	</div>
	<div class="ind_content" id="ind_content">
	<g:if test="${saleOrder && orderItems}">
	<g:each in="${orderItems }" var="item">
	<div class="cart_list">
		<dl class="b0">
			<dd>
				<div class="check">
					<a href="javascript:;" target="_self">
						<img id="chooseProduct_${item.plan.id }" data-val="1" data-pid="${item.plan.id }" src="${resource(dir:'images', file:'choice04.png') }" height="31" width="31">
					</a>
				</div>
				<div class="sku_pic">
						<a href="javascript:;" target="_self"><img src="${Holders.config.alioss.images.rootUrl }${item.plan.product.defaultPictureId}"></a>
				</div>
				<div class="cart_word" id="productWord_${item.plan.id }">
                       <p class="cart_name">
                        	${item.plan.product.nameWithCount }
                       </p>
                       <p class="cart_name2">
                       	货号：${item.plan.product.code }；件数：${item.itemCount }
                       </p>
                       <p class="cart_price">
							现价：￥${item.plan.price }&nbsp;<g:if test="${item.plan.price < item.plan.retailPrice }"><s style="color: gray">￥${item.plan.retailPrice }</s></g:if>
					</p>
                </div>
			</dd>
		</dl>
	</div>
	</g:each>
	<div class="cart_list">
		<dl class="b0">
			<dd>
				<div class="cart_word">
                       <p class="cart_name">
                       <a href="javascript:deliveryOrder()" style="font-size: 40px">确认发货</a>
					</p>
                </div>
			</dd>
		</dl>
	</div>
	
</g:if>
<g:else>
没有任何商品或已经发货
</g:else>
</div>
</div>

<script type="text/javascript">

	function deliveryOrder() {
		if(confirm("确定发货？")) {
			var url = "${createLink(controller:'mobilePos', action:'delivery', id:qrDelivery?.id)}";
			document.location.href = url;
		}
	}

</script>

</body>
</html>