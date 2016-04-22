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
	<link href="${resource(dir:'css', file:'youmi.css') }?v=1234" rel="stylesheet" type="text/css" />
	<link href="${resource(dir:'css', file:'list.css') }" rel="stylesheet" type="text/css" />
	<link href="${resource(dir:'css', file:'scrollbar.css') }" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${resource(dir:'js', file:'jquery-1.11.0.min.js') }"></script>
</head>
<body>

	<div class="wap_top">
		<p class="top_back2" name="topback">
			<a href="javascript:;"><img src="${resource(dir:'images', file:'top_back.png') }" width="24" height="41"></a>
		</p>
	</div>
	
	<div id="wrapper" class="ind_content" style="float:left;margin:80px 0px 0px 0px;position:absolute;overflow:auto;">
		<div id="scroller" id="productListDiv" class="list_sku" style="margin:0px 0px 0px 0px;">
			<ul id="productListUL">
			
			<g:each in="${ppps }" var="pricePlan">
			<li id="pdList_product_${pricePlan.id }">
				<div id="sku_pic_${pricePlan.id }" class="sku_pic">
						<a href="${createLink(controller:'shop', action:'product', id:pricePlan.id) }"><img alt="" src="${Holders.config.alioss.images.rootUrl }${pricePlan.productPicId }"></a>
	            </div>
	            <div id="sku_name_${pricePlan.id }" class="sku_name">
	            	<a href="${createLink(controller:'shop', action:'product', id:pricePlan.id) }" target="_self">
							<div class="word01">${pricePlan.product.nameWithCount }</div>
				            <p class="price" style="margin:20px 0px 0px 0px">
								￥${pricePlan.price } <g:if test="${pricePlan.price < pricePlan.retailPrice}"><span>￥${pricePlan.retailPrice }</span></g:if>
				            </p>
					</a>
	            </div>
	            <div class="btn" onclick="addProductToCart(${pricePlan.id })">
	            	<a href="javascript:;"><img src="${resource(dir:'images', file:'buy01.png') }"></a>
	            </div>
			</li>
			</g:each>
			
			</ul>
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

<div id="myPage">
<div id="wap_menu_show_btn" class="buy_ben">
		<div class="digital" id="cartCount" name="digital" data-val="0">${newOrder?.itemCount }</div>
		<a class="buy_ico" href="${createLink(controller:'shop', action:'cart') }"></a>
	</div>
</div>
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
	function addProductToCart(pricePlanId) {
		$.ajax({
			  url: "${createLink(controller:'shop', action:'addCart')}/" + pricePlanId
			}).done(function(data) {
				if(data.succeed == true) {
					$('#cartCount').html(data.itemCount);
				}
			});
		
	}
</script>
</body>
</html>