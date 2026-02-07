
 <% String contextPath=request.getContextPath();%>
 <%@page import="creditinvlogin.ClsCreditInvLoginDAO"%>
 <%ClsCreditInvLoginDAO DAO= new ClsCreditInvLoginDAO(); %>
<!DOCTYPE html>
<jsp:include page="temp.jsp"></jsp:include>

<html lang="en">
<head>
    <title>Credit Invoice</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>

body {
	background-color: #ecf0f1;
	font-family: "Comic Sans MS", cursive, sans-serif;
	color: #686868;
}
h1,
h2,
h3,
h4,
h5,
h6 {
	font-size: 5vw;
}
h1,
.sub-heading {
	
	border: 1px solid #ccc;
	box-shadow: 1px 1px 2px #fff inset, -1px -1px 2px #fff inset;
	border-radius: 8px/6px;
	background-color: #2980b9;
	color: white;
	text-align: center;
	margin: .5rem 0 1rem;
}
.sub-heading {
	font-size: .75em;
	font-weight: 300;
}
/**
 * @section: utilities;
 * @see: Justify Grid [http://justifygrid.com/]
 */

._grid {
	text-align: justify !important;
	text-justify: distribute-all-lines;
	font-size: 3vw;
	text-rendering: optimizespeed;
}
._grid:after {
	content: "";
	display: inline-block;
	
}
._column {
	display: inline-block;
	vertical-align: top;
	font-size: 3vw;
	text-align: left;
	text-rendering: optimizeLegibility;
}
._btn {
	display: inline-block;
	background-color: #bdc3c7;
	border: none;
	padding: .1em .75em;
	text-align: center;
	font-weight: 300;
}
._btn:hover,
.cart-totals:hover ._btn {
	background-color: #3498db;
	color: #ecf0f1;
}
/**
 * @section: shopping-cart;
 */


.cart-totalsfot {
	/* border-top: 1px solid #bdc3c7; */
	max-width: 100%;
	margin-left:5rem;
	margin-bottom: 3rem;
}
.cart-totalsfot ._column {
	width: 30%;
	/* padding:.5rem;
	line-height: 1.2; */
}

.cart-totalsfot-key {
    width:20%;
	font-size:3vw;
	color: green;
}
.cart-totalsfot-value {
	font-size: 3vw;
	color: red;
}
/**
 * Animations
 */

.cart-totalsfot * {
	transition: all .2s ease;
}
#filterlist li {
	cursor: pointer;
}
.room-outer-container {
	max-width: 100%"
    border: none;
	outline: none;
}
.client-container {
font-family: "Comic Sans MS", cursive, sans-serif;
	transition: all .2s ease;
}
.document-container {
	
	letter-spacing: -.035em;
}
/* @media (max-width: 767px) {
	.custom-tabs.nav-pills > li {
		float: none;
		display: inline-block;
	}
} */
.productcalc {
	text-align: center;
	max-width: 100%"

}
.productcalc > * {
	vertical-align: middle;
}
.productcalc > input {
	max-width: 2.6em;
}
input {
	border: 0.3em solid #bbc3c6;
	padding: 0.5em 0.3em;
	font-size: 3vw;
	color: #8a8a8a;
	text-align: center;
}
qty {
	width: 3em;
	line-height: 0.5em;
	border-radius: 2em;
	font-size: medium;
	font-weight: bold;
	text-align: center;
	background: #43ace3;
	color: #fff;
}
qty:hover {
	background: #3b9ac6;
}
.button {
	font-family: "Comic Sans MS", cursive, sans-serif;
	background-color: #3b9ac6;
	/* Green */
	line-height: 0.5em;
    border-radius: 2em;
	color: white;
	padding: 10px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 3vw;
	margin: 2px 2px;
	cursor: pointer;
	-webkit-transition-duration: 0.4s;
	/* Safari */
	transition-duration: 0.4s;
}
.button2:hover {
	  border: none;
	outline: none;
	background:green;
	color: white;
}
.center {
	margin: auto;
	position: absolute;
	margin-top: 20px;
	left: 50%;
	-ms-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
}
</style>


</head>

<body >
  <div class="container-fluid">
	<div class="tab-content">
		<div class="tab-pane fade active in">
			<h1>Credit Invoice</h1>
			<div class="_grid client-container">
				
				<div id="slm" >
					<select id="cldet" name="cldet" onchange="setClient();" style="background: #F2F2F2;font-size:medium;width:50%; resize: both;overflow: auto;" value='<s:property value="cldet"/>'>
					<option value="" selected disabled hidden>Choose here</option> </select>
					<input type="hidden" id="cldocno" name="cldocno" />
					<input type="hidden" id="cltax" name="cltax" />
					<input type="hidden" id="clacno" name="clacno" />
				</div>
				<div class="_column clientname" id="clientname" style="color:#2980b9;text-align:left;font-size:medium;">Client :</div>
				<div class="_column subtotal" id="subtotalCtr">
					<div class="cart-totals-key" style="font-size:medium;color:green;text-align:center;border:1px;position:fixed;z-index:1000;right:130px;top:30px;">Product Total</div>
					<div class="cart-totals-value" style="font-size:medium;color:red;text-align:center;border:1px;position:fixed;z-index:1000;right:130px;top:45px;">0.00</div>
				</div>
				<div class="_column total" id="totalCtr">
					<div class="cart-totals-key" style="font-size:medium;color:green;text-align:center;border:1px;position:fixed;z-index:1000;right:25px;top:30px;">Grand Total</div>
					<div class="cart-totals-value" style="font-size:medium;color:red;text-align:center;border:1px;position:fixed;z-index:1000;right:25px;top:45px;">0.00</div>
				</div>
			</div>
			<div class="document-container">
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="search-container">
							<ul class="list-group checkbox-list-group" id="filterlist" style="list-style-type: none;margin: auto;left: 50%;right:70%;font-size:medium;"></ul>
						</div>
					</div>
				</div>
			</div>
			<!-- <div class="document-selected">
				<div class="input-group">
					<input type="hidden" class="form-control" name="selecteddoc" id="selecteddoc">
				</div>
			</div> -->
			<div class="room-outer-container" >
			<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="product-container" style="max-width:100%;"></div>
			</div>
			</div>
			
				<footer class="_grid cart-totalsfot">
					<div class="_column subtotal" id="subtotalCtrfot">
						<div class="cart-totalsfot-key" style="width:15%;">Product Total</div>
						<div class="cart-totalsfot-value">0.00</div>
					</div>
					<div class="_column taxes" id="taxesCtr">
						<div class="cart-totalsfot-key" style="width:15%;" >Taxes(5%)</div>
						<div class="cart-totalsfot-value">0.00</div>
					</div>
					<div class="_column total" id="totalCtrfot">
						<div class="cart-totalsfot-key" style="width:15%;" >Grand Total</div>
						<div class="cart-totalsfot-value">0.00</div>
					</div>
				</footer>
				
			</div>
			<div class="center">
				<button class="button button2" onclick="createinvoice();">Create Invoice</button>
			</div>
		</div>
	</div>
</div>
  
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>  
<script>
$(document).ready(function () {
	getClientDets();
  	getInitData();
  
  });
  var qtyoprn = 0;
  var totindex = 0;
  function createinvoice(){
	  //alert("in save invoice");
	  var netaxtotal=$("#totalCtr").find(".cart-totals-value").html();
	  if(parseInt(netaxtotal)>0){
	  	var products = $(".list-group-product");
	  	var productArray=new Array();
	  for (var i = 0; i < products.length; i += 1) {
		     var prodoc=0;
		     var unitdocno=0;
		     var qty=0;
		     var unitprice=0;
		     var total=0;
		     var nettotal=0;
		     var specid=0;
		     var taxper=0;
		     var taxamount=0;
		     var taxperamount=0;
		unitprice = parseFloat($(products[i]).attr("data-price"));    
  		total = parseFloat($(products[i]).find(".product-totprice").html());
  		unitdocno = parseFloat($(products[i]).attr("data-unitdocno"));
  		specid = parseFloat($(products[i]).attr("data-specid"));
  		taxper = parseFloat($(products[i]).attr("data-taxper"));
  		prodoc = parseFloat($(products[i]).attr("data-psrno"));
  		var $input = $(products[i]).closest('div').find('input');
  	  	qty= parseInt($input.val());
  		if(parseInt(taxper)>0){
  	  taxperamount=(parseFloat(total)*(parseFloat(taxper)/100)).to_$();
  	  	taxamount=(parseFloat(total)+parseFloat(taxperamount)).to_$();
  		}
  	  	//alert("qty===="+value);
  	  	//break;
  		//alert("==unitprice=="+unitprice+"==total=="+total+"==unitdocno=="+unitdocno+"==specid=="+specid+"==taxper=="+taxper+"==prodoc=="+prodoc);
  	if(parseInt(qty)>0){
  		productArray.push(prodoc+"::"+unitdocno+"::"+qty+"::"+0+"::"+0+"::"+
  				 unitprice+"::"+total+"::"+0+"::"+0+"::"+total+"::"+specid+"::"+
  				 0+"::"+0+"::"+0+"::"+0+"::"+0+"::"+taxper+"::"
  				 +taxamount+"::"+0+"::"+000+"::"+0+"::"+0+"::"+taxperamount+"::"+"0000"+"::"); 
  	}
  		
	  }
	 // alert("productArray==="+productArray);
	  
	  save(productArray);
	  }
	  else{
		  Swal.fire({
				icon: 'error',
			  	title: 'Warning',
			  	text:'Choose Products'
			});
	  }
	  
		
	  
  }
  function save(productArray){
	  var clientid= document.getElementById("cldocno").value;
	  var clntacno= document.getElementById("clacno").value;
	  var netotal=$("#subtotalCtr").find(".cart-totals-value").html();
	  var taxtotal=	$("#taxesCtr").find(".cart-totalsfot-value").html();
	  var netaxtotal=$("#totalCtr").find(".cart-totals-value").html();
	  //alert("clientid=="+clientid+"==netotal=="+netotal+"==taxtotal=="+taxtotal+"==netaxtotal=="+netaxtotal);
	    var x=new XMLHttpRequest();
	  	x.onreadystatechange=function(){
	  	if (x.readyState==4 && x.status==200)
	  	 {
	  	   var items= x.responseText;
	  		var val = items.split("###");
	  		var chkval=val[0];
	  		var docval=val[1];
           // alert("val====="+val);
	  		if(parseInt(chkval)>0){
	  			
	  			Swal.fire({
					icon: 'success',
				  	title: 'Success',
				  	text:'Credit Invoice '+docval+' Successfully Created'
				});
	  			setTimeout(function(){  window.location.reload(); }, 3000);
	  			
	  		}
	  		else{
					Swal.fire({
					icon: 'error',
				  	title: 'Warning',
				  	text:' Not Created'
				});
				}
	  		setTimeout(function(){  window.location.reload(); }, 3000);
	  	   }}
	  	x.open("POST","saveData.jsp?products="+productArray+"&clientid="+clientid+"&netotal="+netotal+"&taxtotal="+taxtotal+"&netaxtotal="+netaxtotal+"&clntacno="+clntacno,true);
	  	x.send();  
  }
  function setClient(){
	  var clientdet=$('#cldet').val();
	  var value = $("#cldet option:selected"); 
     /*  alert(value.text());  */
	  clientdet=clientdet.split("####");
	 // alert("===in change==="+clname);
	 document.getElementById("clientname").innerText="Client :"+value.text();
	  document.getElementById("cldocno").value=clientdet[0];
	  document.getElementById("cltax").value=clientdet[1];
	  document.getElementById("clacno").value=clientdet[2];
	
  }
  function getClientDets(){ 
		
		
		
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		     
		      items=items.split('####');
		           var  clientid=items[0].split(",");
		           var clientname=items[1].split(",");
		           var clientTax=items[2].split(",");
		           var clntacno=items[3].split(",");
		          // var multiItems=items[3];
		         // alert("clientname====="+clientname);
		           var optionscurr = '<option value="" selected disabled hidden>Choose Client</option>';
		           // clientid=clientid.split(",");
		        	 //  clientname=clientname.split(",");
		        	 //  clientTax=clientTax.split(","); 
		           /*  currateItems.split(","); */
		            for ( var i = 0; i < clientid.length; i++) {
		           optionscurr += '<option value="' + clientid[i] + '####' + clientTax[i] + '####' + clntacno[i] + '">' + clientname[i] + '</option>';
		           }
		            $("select#cldet").html(optionscurr);
		            
		        
		   
		    
		    }
		       }
		   x.open("GET","getClient.jsp",true);
			x.send();
		        
		      
		        }

  function getInitData() {
  	$('.room-outer-container').hide();
  	var x = new XMLHttpRequest();
  	x.onreadystatechange = function () {
  		if (x.readyState == 4 && x.status == 200) {
  			var items = x.responseText.trim();
  			items = JSON.parse(items);
  			var dochtml = '',
  				ulhtml = '';
  			$.each(items.docdata, function (index, value) {
  				totindex++;
  				//alert("index==="+index);
  				dochtml += '<div class="cat' + index + '" style="color:#2980b9; text-align:center;margin:auto;margin-top: 5px;margin-right: 35px;height: auto;background: #F2F2F2;border: 1px solid #ccc;border-radius: 3px/6px;">';
  				dochtml += '<li class="list-group-item" data-catdocno="' + value.doc_no + '" data-index="' + index + '">';
  				dochtml += '<div class="row">';
  				dochtml += '<div class="col-xs-9">' + value.catname + '</div>';
  				dochtml += '</div>';
  				dochtml += '</li>';
  				dochtml += '</div>';
  				ulhtml += '<div class="row">';
  				ulhtml += '<ul class="productul" id="category' + value.doc_no + '"  style="list-style-type: none;text-align: center;display: inline-block;padding:0;"></ul';
  				ulhtml += '</div>';
  			});
  			$('#filterlist').html($.parseHTML(dochtml));
  			$($.parseHTML(ulhtml)).appendTo('.product-container');
  			$.each(items.docdata, function (index, value) {
  				//alert("in hide ul");
  				$('#category' + value.doc_no + '').hide();
  			});
  			//alert("totindex======="+totindex);	
  			$('.document-container').show();
  			const filterlist = document.querySelectorAll("#filterlist li");
  			for (const filteritem of filterlist) {
  				var hide = 0,
  					k = 0;
  				filteritem.addEventListener('click', function (event) {
  					//var propid=$(this).find('.row').eq(0).find('div').eq(1).text();
  					var cldoc= document.getElementById("cldocno").value;
  					if(parseInt(cldoc)>0){
  						
  					
  					var catdocno = $(this).attr('data-catdocno');
  					var catindex = $(this).attr('data-index');
  					$('#selecteddoc').attr('data-catdocno', catdocno);
  					$('.room-outer-container').show()
  					//alert("catdoc======"+catdocno+"====hide===="+hide+"====index===="+catindex);
  					if (hide == 0) {
  						var x = 'cat' + catindex;
  						var y = 'cat' + (parseFloat(catindex) + 1);
  						var list = document.getElementById("filterlist").lastElementChild.innerHTML;
  						//alert("classname==first==="+x+"=====clasname222===="+y);
  						if (parseFloat(catindex) == parseFloat(totindex) - 1) {
  							if (qtyoprn == catdocno) {
  								$('.' + x + '').after($('#category' + catdocno + '').show());
  							} else {
  								getproductdata(catdocno);
  								$('.' + x + '').after($('#category' + catdocno + '').show());
  							}
  							qtyoprn = catdocno;
  							hide = catdocno;
  						} else {
  							if (qtyoprn == catdocno) {
  								$('.' + x + ' + .' + y + '').before($('#category' + catdocno + '').show());
  							} else {
  								getproductdata(catdocno);
  								$('.' + x + ' + .' + y + '').before($('#category' + catdocno + '').show());
  							}
  							qtyoprn = catdocno;
  							hide = catdocno;
  						}
  					} else {
  						$('#category' + catdocno + '').hide();
  						$('.room-outer-container').hide();
  						hide = 0;
  					}
  					//app.attachEvents();
  					//getRoomData(propdocno);
  					}
  		  			else{
  		  				Swal.fire({
  							icon: 'error',
  						  	title: 'Warning',
  						  	text:' Choose a Client'
  						});
  		  			}
  				});
  			
  			}
  		}
  	}
  	x.open("GET", "getInitData.jsp", true);
  	x.send();
  }

  function getproductdata(catdocno) {
  	var x = new XMLHttpRequest();
  	x.onreadystatechange = function () {
  		if (x.readyState == 4 && x.status == 200) {
  			var items = x.responseText.trim();
  			items = JSON.parse(items);
  			var dochtml = '';
  			var totindex = 0;
  			$.each(items, function (index, value) {
  				totindex++;
  				//alert("index==="+index);
  			    dochtml += '<div class="_grid prd' + index + '" style="witdh:100%;color:#2980b9;height: auto;background: #F2F2F2;border: 1px solid #ccc;border-radius: 3px/6px;margin-top: 5px; resize: both;overflow: auto;">';
  				dochtml += '<li class="list-group-product" data-price="' + value.price + '" data-psrno="' + value.psrno + '" data-index="' + index + '" data-unitdocno="' + value.unitdocno + '" data-specid="' + value.specid + '" data-taxper="' + value.taxper + '">';
  				dochtml += '<div class="row">';
  				dochtml += '<div class="_column" style="width:40%">' + value.name + '</div>';
  				dochtml += '<div class="_column" style="width:15%">' + value.price + '</div>';
  				dochtml += '<div class="_column productcalc" data-price="' + value.price + '" style="width:40%"><button class="_btn _column qty-minus" onclick="qtyminus(this);" >-</button><input type="numeric"  style="width:15%"  value="0" /><button class="_btn _column qty-plus" onclick="qtyplus(this);">+</button><div class="_column product-totprice" style="width:20%;text-align:right;">0.00</div></div>';
  				dochtml += '</div>';
  				dochtml += '</li>';
  				dochtml += '</div>';
  				
  			});
  			$('#category' + catdocno + '').append($.parseHTML(dochtml));
  			$('.document-container').show();
  		}
  	}
  	x.open("GET", "productSearch.jsp?catid=" + catdocno, true);
  	x.send();
  }
   // SHOPPING CART PLUS OR MINUS
  function qtyplus(event) {
  	//alert("in plus");
  	var $this = $(event);
  	var $input = $(event).closest('div').find('input');
  	var value = parseInt($input.val());
  	//alert("value====="+value);
  	// alert($(this).attr('class'));
  	if (value < 100) {
  		value = value + 1;
  	} else {
  		value = 100;
  	}
  	$input.val(value);
  	updateProductSubtotal($this, value);
  };

  function qtyminus(event) {
  	//alert("in minus");
  	var $this = $(event);
  	var $input = $(event).closest('div').find('input');
  	var value = parseInt($input.val());
  	//alert("value====="+value);
  	if (value > 1) {
  		value = value - 1;
  	} else {
  		value = 0;
  	}
  	$input.val(value);
  	updateProductSubtotal($this, value);
  };

  function updateProductSubtotal(event, value) {
  	/* alert("quantity===="+quantity); */
  	//var propid=$(this).find('.row').eq(0).find('div').eq(1).text();
  	var productPrice = parseFloat($(event).closest('div').attr('data-price'));
  	//alert("price===="+productPrice);
  	subtotalCtr = $(event).closest('div').find('.product-totprice');
  	//alert("totprice===="+totprice);
  	subtotalPrice = value * productPrice;
  	//alert("subtotalPrice======"+subtotalPrice);
  	subtotalCtr.html(subtotalPrice.to_$());
  	updateTotals();
  }

  function updateTotals() {
	var tax=document.getElementById("cltax").value;
	var taxchk=0;
	var taxchk2=0;
	if(parseInt(tax)>0){
		taxchk=0.05;
		taxchk2=1.05;
	}
  	var products = $(".list-group-product"),
  		subtotal = 0,
  		shipping;
  	for (var i = 0; i < products.length; i += 1) {
  		subtotal += parseFloat($(products[i]).find(".product-totprice").html());
  	}
  	//alert("subtotal======" + subtotal);
  	//shipping = (subtotal > 0 && subtotal < (100 / 1.06)) ? app.shipping : 0;
  	$("#subtotalCtr").find(".cart-totals-value").html(subtotal.to_$());
  	$("#subtotalCtrfot").find(".cart-totalsfot-value").html(subtotal.to_$());
  	$("#taxesCtr").find(".cart-totalsfot-value").html((subtotal * parseFloat(taxchk)).to_$());
  	$("#totalCtr").find(".cart-totals-value").html((subtotal * parseFloat(taxchk2)).to_$());
  	$("#totalCtrfot").find(".cart-totalsfot-value").html((subtotal * parseFloat(taxchk2)).to_$());
  }
  Number.prototype.to_$ = function () {
  	return parseFloat(this).toFixed(2);
  };
  String.prototype.strip$ = function () {
  	return this.split("$")[1];
  };
	
</script>

</body>
</html>