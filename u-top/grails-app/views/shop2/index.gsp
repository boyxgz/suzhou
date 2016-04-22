<!doctype html>
<%@page import="grails.util.Holders"%>
<html>
<head>
<meta name="layout" content="mobileShop">
<title>优米商城</title>
</head>

<body>
<!-- 
<div class="block_home_slider">
  <div id="home_slider" class="flexslider">
    <ul class="slides">
      <li>
        <div class="slide">
           <img src="${resource(file:'images/banner1.jpg') }"/>
         </div>
      </li>
      <li>
        <div class="slide">
           <img src="${resource(file:'images/banner2.jpg') }"/>
         </div>
      </li>
      <li>
        <div class="slide">
           <img src="${resource(file:'images/banner3.jpg') }"/>
         </div>
      </li>
    </ul>
  </div>                          
<script type="text/javascript">
 $(function () {
 $('#home_slider').flexslider({
 animation : 'slide',
 controlNav : true,
 directionNav : true,
 animationLoop : true,
 slideshow : false,
 useCSS : false
 });
 });
</script>
</div>
 -->
<!--推荐商品-->
<g:if test="${recommend}">
<div class="s_pro">
<div class=" s_pro_title">推荐商品</div>
<g:each in="${recommend}" var="pricePlan">
  <dl>
    <dt><a href="${createLink(controller:'shop2', action:'product', id:pricePlan.id) }"><img src="${Holders.config.alioss.images.rootUrl }${pricePlan.productPicId }"></a></dt>
    <dd class="d2">${pricePlan.product.name }</dd>
    <dd class="d1">价格：￥${pricePlan.price }元</dd>
    <dd class="d1"><span>市场价：￥${pricePlan.retailPrice }元</span></dd>
    <dd class="d3">规格：${pricePlan.product.spec }</dd>
    <dd class="d3"><span>数量：${pricePlan.product.packingCount }</span></dd>
    <a href="javascript:addProductToCart(${pricePlan.id })"><img src="${resource(file:'images/Car_pic.png')}" width="20" class="dw"></a>
  </dl>
</g:each>
</div>
</g:if>

<!--购物车-->
<div class="car"><a href="${createLink(controller:'shop2', action:'cart') }"><img src="${resource(file:'/images/Car.png')}"><span id="cartCount">${newOrder?.itemCount }</span></a></div>


<!--商品展示-->
<div class="s_sp">
<div class=" s_sp_title">商品展示</div>
  <div class="s_sp_wid">
<g:each in="${products}" var="pricePlan">
  <dl>
    <dt><a href="${createLink(controller:'shop2', action:'product', id:pricePlan.id) }"><img src="${Holders.config.alioss.images.rootUrl }${pricePlan.productPicId }"></a></dt>
    <dd class="d2">${pricePlan.product.name }</dd>
    <dd class="d1">价格：￥${pricePlan.price }元</dd>
    <dd class="d1"><span>市场价：￥${pricePlan.retailPrice }元</span></dd>
    <dd class="d3">规格：${pricePlan.product.spec }</dd>
    <dd class="d3"><span>数量：${pricePlan.product.packingCount }</span></dd>
    <a href="javascript:addProductToCart(${pricePlan.id })"><img src="${resource(file:'images/Car_pic.png')}" width="20" class="dw"></a>
  </dl>
</g:each>
  </div>
</div>

<script type="text/javascript">
	function addProductToCart(pricePlanId) {
		$.ajax({
			  url: "${createLink(controller:'shop2', action:'addCart')}/" + pricePlanId
			}).done(function(data) {
				if(data.succeed == true) {
					$('#cartCount').html(data.itemCount);
				}
			});
		
	}
</script>
</body>
</html>
