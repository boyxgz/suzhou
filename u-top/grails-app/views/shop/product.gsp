<!DOCTYPE html>
<%@page import="grails.util.Holders"%>
<html>
<head>
	<meta charset="UTF-8" />	
	<meta content="yes" name="apple-mobile-web-app-capable" />
	<meta content="black" name="apple-mobile-web-app-status-bar-style" />
	<meta content="telephone=no" name="format-detection" />
	<meta name="viewport" content="minimal-ui, width=640, initial-scale=1, maximum-scale=0.5, minimum-scale=0.5, user-scalable=no, target-densitydpi=320"/>
	<title>优米</title>
	<link href="${resource(dir:'css', file:'youmi.css') }" rel="stylesheet" type="text/css" />
	<link href="${resource(dir:'css', file:'list.css') }" rel="stylesheet" type="text/css" />
	<link href="${resource(dir:'css', file:'scrollbar.css') }" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${resource(dir:'js', file:'jquery-1.11.0.min.js') }"></script>
</head>
<body>
<div id="divBody">

	<div id="wapTop" data-pageName="productDetail">
	<!-- 
	<div class="wap_top_n01" name="topback"><img src="http://image3.benlailife.com/wap/images/top/top_ico04.png" width="49" height="49"  alt=""/></div>
		<input type="hidden" id="productSysNo" name="productSysNo" value="13626" />
		<input type="hidden" id="wishStatus" value="0" />
		<div class="wap_top_n03">
			<a id="wishBtn" href="javascript:;">
				<img id="wishImg" src="http://image3.benlailife.com/wap/images/top/top_ico02.png" width="49" height="49"  alt=""/>
			</a>
		</div>
			<div class="wap_top_n02">
				<a id="openShareBtn" href="javascript:;" onclick="openShare('新疆库尔勒香梨1kg','我在 @本来生活 发现了一个非常不错的商品：新疆库尔勒香梨1kg，优惠价：￥25.8。感觉不错，分享一下','');">
				<img src="http://image6.benlailife.com/wap/images/top/top_ico01.png" width="49" height="49"  alt=""/>
				</a>
			</div>
 	-->
</div>
<div class="ind_content" style="margin-bottom:80px;">
		<div class="goods_buy">
			<div class="goods_dtl">
				<a name="decQty" onclick="updateQty(-1)">
					<img src="${resource(dir:'images', file:'goods_dl01.png') }" width="34" height="34">
				</a>
				<div class="fl">
					<input type="number" name="qty" id="qty" class="textgt" value="1" maxlength="3" data-cart="0" data-source="0"/>
				</div>
				<a name="addQty" onclick="updateQty(1)">
					<img src="${resource(dir:'images', file:'goods_dl02.png') }" width="34" height="34">
				</a>
			</div>
				<div class="goods_btn" onclick="addProductToCart()">
					<a class="goods_btn_1" href="javascript:;">加入购物车</a>
				</div>
		</div>
		<div class="goods_sku">
      		<!-- 产品图片 -->
            <div class="goods_pic" id="benlai_banner">
	            <div data-module="content" class="wap_pic">
	            	<g:each in="${pictures }" var="pic">
	            		<a><img src="${Holders.config.alioss.images.rootUrl }${pic.file.id }"/></a>
	            	</g:each>
	            </div>
	            <ul data-module="nav">
	            	<g:each in="${pictures }"><li><a></a></li></g:each>
	            </ul>
			</div>
			<!-- 产品信息 -->
            <div class="goods_infor">
				<dl class="name">${product.nameWithCount }</dl>
				<dl class="name_s">
						${product.description }
				</dl>
				<!-- 产品价格 -->
				<dl class="price">
					￥${pricePlan.price } <g:if test="${pricePlan.price < pricePlan.retailPrice }"><span>￥${pricePlan.retailPrice }</span></g:if>
				</dl>
				<div class="clear"></div>
			</div>
		</div>
		
		<!-- 规格 -->
		<div class="goods_xx">
			<dl>
				<span>规格：</span>${product.spec }
			</dl>
		</div>
		
		<!-- 赠品 -->
		
		
		<!-- 产品提示 -->
		
		<!-- 优惠信息 -->
		
		<!-- 产品链接
		<div class="goods_link">
			<dl><a href="http://m.benlai.com/sh/productDetail/13626" target="_self">图文详情<span>(建议在wifi环境下浏览）</span></a></dl>
		</div>
		 -->
</div>
<br/>
<br/>
<br/>
</div>
<!--<div id="fullScreen" class="wap_fullScreen" style="display:none;"></div>-->
<div id="fullScreen" class="wap_fullScreen" style="display: none; position: fixed; top: 0%; left: 0%; background-color: black; z-index: 9000; opacity: 0.5;width:100%;height:100%"></div>
<div id="msgArea" class="wap_pop" style="display:none;z-index:9001; position:fixed; left:50%;top:50%;margin-left:-270px;margin-top:-100px;">
	<div id="msgCloseBtn" class="close" onclick="closeMsg()">
		<a href="javascript:;"><s></s></a>
	</div>
	<div id="msgTitleArea" class="tit"></div>
	<div id="msgContentArea" class="word2"></div>
	<div id="msgBtnArea" class="btn" style="display:none;">
		<a id="msgBtn1" href="javascript:;" target="_self" class="buy_btn09 mr35">确定</a>
		<a id="msgBtn2" href="javascript:;" target="_self" class="buy_btn09">取消</a>
	</div>
</div>

<div id="sharePop" class="share_pop" ><!-- style="display:none" -->
	<div class="share_tit"><a id="closeShareBtn" href="javascript:;" onclick="closeShare();"><s></s></a></div>
	<dl>
		<a id="sLink_Sina" href="javascript:;">
			<dt><s class="ico01"></s></dt>
			<dd>分享到新浪微博</dd>
		</a>
	</dl>
	<dl>
		<a id="sLink_Qzone" href="javascript:;">
			<dt><s class="ico02"></s></dt>
			<dd>分享到腾讯微博</dd>
		</a>
	</dl>
	<!--<dl>
		<a href="javascript:;">
			<dt><s class="ico03"></s></dt>
			<dd>分享到微信好友</dd>
		</a>
	</dl>
	<dl class="b0">
		<a href="javascript:;">
			<dt><s class="ico04"></s></dt>
			<dd>分享到朋友圈</dd>
		</a>
	</dl>-->
</div>

<script type="text/javascript">
	function updateQty(qty) {
		var oQty = $('#qty').val();
		var v = parseInt(oQty) + qty;
		if(v < 0) {
			v = 0;
		}
		$('#qty').val(v);
	}

	function addProductToCart() {
		var url = "${createLink(controller:'shop', action:'addProductToCart', id:pricePlan.id)}?qty=" + $('#qty').val();
		document.location.href = url;
	}
</script>

</body>
</html>