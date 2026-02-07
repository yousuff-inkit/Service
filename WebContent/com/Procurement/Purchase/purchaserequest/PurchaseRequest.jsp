<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<%
	String mod = request.getParameter("mod") == null ? "view" : request
			.getParameter("mod").toString();
 String purchasearray = request.getParameter("purchasearray") == null? "0": request.getParameter("purchasearray").toString() ;
 System.out.println("purchasearray==="+purchasearray);

%>
<html>
<%--   <% 
  
String dtype=  session.getAttribute("Code").toString();
  System.out.println("sss    "+dtype);
  %>  --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include> 
 
 <%
	String contextPath=request.getContextPath();
	//For PurchaseMgmt Bi View
	String bimod = request.getParameter("mod") == null ? "view" : request.getParameter("mod").toString();
	String brch = request.getParameter("brch") == null ? "" : request.getParameter("brch").toString();
	String chck1 = request.getParameter("chk1") == null ? "" : request.getParameter("chk1").toString();
	String  docnotemp = request.getParameter("docno") == null? "0": request.getParameter("docno").toString() ;

 %>
 
<style>
form label.error {
color:red;
  font-weight:bold;

}
 #psearch {
 
background:#FAEBD7;
 
}
.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 10px;
  padding: 4px 15px 6px 17px;
  text-decoration: none;
}
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>
<script type="text/javascript">
<%-- var text1='<%=dtype%>'; --%>
var mod1='<%=mod%>';
var prcharray='<%=purchasearray%>';

//For purchaseMgmt Bi View
var bimode='<%=bimod%>';
var temp_doc='<%=docnotemp%>'; 
var chck1='<%=chck1%>';
var bibranch='<%=brch%>';
 $(document).ready(function () {
	 
   	 $("#reqmasterdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});   
   	 
  
  /*  	$('#brandsearchwndow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Brand Search',position: { x: 250, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#brandsearchwndow').jqxWindow('close'); */
/*     
 	 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 350, y: 60 }, keyboardCloseKey: 27});
     $('#brandsearchwndow').jqxWindow('close'); 

     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#modelsearchwndow').jqxWindow('close');
     $('#colorsearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: {x: 600, y: 60  }, keyboardCloseKey: 27});
     $('#colorsearchwndow').jqxWindow('close');
 */
     
 
 

 
     $('#sidesearchwndow').jqxWindow({ width: '55%', height: '95%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Product Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
     $('#sidesearchwndow').jqxWindow('close');   
     $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
     $('#searchwindow').jqxWindow('close');
	   $('#itemdocno').dblclick(function(){

			  if($("#mode").val() == "A" || $("#mode").val() == "E")
				  {
		 
			 
	  	    $('#searchwindow').jqxWindow('open');
	  	
			if(document.getElementById("itemtype").value=="1") 
				{
			 
				refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
				}
			else if(document.getElementById("itemtype").value=="6")
			{
			 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
			}
		
			else
				{
				 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
				}
			
			 
				  }
		  }); 
	   
	   
	   $("#sqotprdname").change(function(){
			var dl=$("#sqotprdts")[0];
			 var el=$("#sqotprdname")[0];
			 if(el.value.trim() != ''){
			
			var prdid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-prdid');
			var unit = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unit');
			var brand = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-brand');
			var psrno = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-psrno')
			var specid = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-specid');
			var unitdoc = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-unitdoc');
	       // var qty = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-qty');
	        var docno = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-doc_no');
	        var method = $("#sqotprdts option[value='" + $('#sqotprdname').val() + "']").attr('data-method');

			
			//alert("allw=="+allw);
			//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
			document.getElementById("sqotprdid").value=prdid;
			document.getElementById("unit").value=unit;
			document.getElementById("brand").value=brand;
			document.getElementById("psrno").value=psrno;
			document.getElementById("unitdocno").value=unitdoc;
			document.getElementById("specid").value=specid;
			document.getElementById("doc_no").value=docno;
			document.getElementById("method").value=method;
			//document.getElementById("quantity").value=qty;
	         
	         /* funRoundAmt(qty,"quantity");
	         funRoundAmt(uprice,"uprice");
	         funRoundAmt(tax,"taxpers");
	         funRoundAmt(total,"totamt");
	         funRoundAmt(nettotal,"amounts");
	         funRoundAmt(taxperamt,"taxamounts");
	         funRoundAmt(taxamountstotal,"taxamountstotal");
	         funRoundAmt(disper,"dispers");
	         funRoundAmt(discount,"dict"); */
	         
	         getunit(psrno);
	         
			 /*document.getElementById("hidunitprice").value=uprice;
			document.getElementById("sqotunitprice").value=uprice; */
			 }
			 
			});
	 	
		$("#sqotprdid").change(function(){
			var dl=$("#sqotproductid")[0];
			 var el=$("#sqotprdid")[0];
			// alert(el.value.trim());
			 if(el.value.trim() != ''){
			
			var prdname = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-prdname');
			var unit = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unit');
			var brand = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-brand');
			var psrno = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-psrno')
			var specid = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-specid');
			var unitdoc = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-unitdoc');
		    //var qty = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-qty');
		    var docno = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-doc_no');
		    var method = $("#sqotproductid option[value='" + $('#sqotprdid').val() + "']").attr('data-method');

	           
			
			//alert("prdid==="+prdid+"===tax==="+tax+"==unit=="+unit+"==brand=="+brand+"==psrno=="+psrno+"==specid=="+specid+"==unitdoc=="+unitdoc+"==uprice=="+uprice+"==taxdoc=="+taxdoc);
			document.getElementById("sqotprdname").value=prdname;
			document.getElementById("unit").value=unit;
			document.getElementById("brand").value=brand;
			//document.getElementById("sqotunit").value=unit;
			document.getElementById("psrno").value=psrno;
			document.getElementById("unitdocno").value=unitdoc;
			document.getElementById("specid").value=specid;
			document.getElementById("doc_no").value=docno;
			document.getElementById("method").value=method;
			//document.getElementById("quantity").value=qty;
		         
		        /*  funRoundAmt(qty,"quantity");
		         funRoundAmt(uprice,"uprice");
		         funRoundAmt(tax,"taxpers");
		         funRoundAmt(total,"totamt");
		         funRoundAmt(nettotal,"amounts");
		         funRoundAmt(taxamount,"taxamounts");
		         funRoundAmt(taxamountstotal,"taxamountstotal");
		         funRoundAmt(disper,"dispers");
		         funRoundAmt(discount,"dict"); */
		         
		         getunit(psrno);
		         
			 /*document.getElementById("hidunitprice").value=uprice;
			document.getElementById("sqotunitprice").value=uprice; */
			 }
			 
			});
	   
	   
		
	});
 
 
 function getProduct() {
	 	var dates=document.getElementById("reqmasterdate").value;
		var dtype='PR';
		var presulttype='1';
		var optionsyear = "";
		var optionsyearnw = "";
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				var prddatas=JSON.parse(items.trim());          
					
						$.each(prddatas, function( index, value ) {
							 optionsyearnw += '<option value="' + value.part_no + '" data-prdname="' + value.productname + '" data-unit="' + value.unit + '" data-brand="' + value.brandname + '" data-psrno="' + value.psrno + '" data-specid="' + value.specid + '" data-unitdoc="' + value.munit + '"data-doc_no="' + value.doc_no + '"data-method="' + value.method + '"></option>';
			                
			                
			                optionsyear += '<option value="' + value.productname + '" data-prdid="' + value.part_no + '" data-unit="' + value.unit + '" data-brand="' + value.brandname + '" data-psrno="' + value.psrno + '" data-specid="' + value.specid + '" data-unitdoc="' + value.munit +  '"data-doc_no="' + value.doc_no + '"data-method="' + value.method + '"></option>';		
			                });
						console.log(optionsyear)
						console.log(optionsyearnw) 
						$("datalist#sqotprdts").html(optionsyear);
					$("datalist#sqotproductid").html(optionsyearnw);			
			} else {
			}
		}
		x.open("GET", '../getProduct.jsp?&dates=' + dates +'&dtype='+dtype+'&presulttype='+presulttype, true);
		x.send();
	}
 
/*  function setgrid(){
	 var temppsrno=document.getElementById("psrno").value; 
	 if(!$.isNumeric(temppsrno)){
			$.messager.alert('Message','Product Not Available');
			return 0;
		 }
	 if($('#quantity').val()==0 || $('#quantity').val()==null || $('#quantity').val()==''){
		 document.getElementById("errormsg").innerText="Quantity Cannot be Zero ";
		  return 0;
	 }
	
	var rows = $('#serviecGrid').jqxGrid('getrows');
    var rowlength= rows.length;
    var proid=$('#sqotprdid').val();
    for(var i=0;i<rowlength;i++){
    	if(rows.productid==proid){
			  document.getElementById("errormsg").innerText="Product Already Added ";
			  return 0;
    	}else{
    		 var partno=$('#sqotprdid').val();
 		    var pname=$('#sqotprdname').val();
 		    var unit=$('#unit').val();
 		    var brand=$('#brand').val();
 		    var psrno=$('#psrno').val();
 		    var unitdocno=$('#unitdocno').val();
 		    var specid=$('#specid').val();
 		    var qty=$('#quantity').val();
 		    var docno=$('#docno').val();
 		    var method=$('#method').val();
 		    
            $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "proid" ,partno);
            $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "proname" ,pname);
            
            
            $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "productid" ,partno);
            $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "productname" ,pname);
            $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "prodoc" ,docno);
            $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "unit" ,unit);
            $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,unitdocno);
            $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "psrno" ,psrno);
            
            
            
            $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "specid" ,specid);
            
            
            $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "brandname" ,brand);
 			   
 			     $('#sqotprdid').val('');
	 		     $('#sqotprdname').val('');
	 		     $('#unit').val('');
	 		     $('#brand').val('');
	 		     $('#psrno').val('');
	 		     $('#unitdocno').val('');
	 		     $('#specid').val('');
	 		     $('#quantity').val('');
	 		     $('#method').val('');
	 		     $('#docno').val('');
    	}
    }
} */
 
 function getitem(event){
  	 var x= event.keyCode;
  	 if(x==114){

  		  $('#searchwindow').jqxWindow('open');
  			
  		if(document.getElementById("itemtype").value=="1") //com/search/costunit/costCodeSearchGrid.jsp
		{
		refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costCodeSearchGrid.jsp?docno='+document.getElementById("itemtype").value); 	
		}
  		
		else if(document.getElementById("itemtype").value=="6")
		{
		 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/fleetGrid.jsp?'); 	
		}
	
  		
	else
		{
		 refsearchContent('<%=contextPath%>/com/Procurement/Purchase/costcodesearch/costunitsearch.jsp?docno='+document.getElementById("itemtype").value); 	
		}
	

  		 
  		  
  	 
  	 }
  	 else{
  		 }
  	 }  
  	  function refsearchContent(url) {
       //alert(url);
          $.get(url).done(function (data) {
  //alert(data);
        $('#searchwindow').jqxWindow('setContent', data);

  	}); 
    	}
 
 
       
          function productSearchContent(url) {
          	 //alert(url);
          		 $.get(url).done(function (data) {
          			 
          			 $('#sidesearchwndow').jqxWindow('open');
          		$('#sidesearchwndow').jqxWindow('setContent', data);
          
          	}); 
          	} 
    
         
          
    function funReset(){
		//$('#frmpurReq')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmpurReq input').attr('readonly', true );
		$('#frmpurReq textarea').attr('readonly', true );
		$('#frmpurReq select').attr('disabled', true);
		 $('#psearch').attr('disabled', true );
		 $('#setbtn').attr('disabled', true ); 
		$('#reqmasterdate').jqxDateTimeInput({ disabled: true});
		 
		$("#purchasedetails").jqxGrid({ disabled: true});
		
		 if(document.getElementById("status").value.trim()=="0" )
			{
			mod1="view";
			}
			if(mod1=="A")
				{
				
				 document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
				document.getElementById("formdetail").value=window.parent.formName.value;
				document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
				funCreateBtn();
				}
			if(bimode=="viewBI"){
				 if(temp_doc>0){
					 <%
					 if(chck1.equalsIgnoreCase("1")){
							session.setAttribute("BRANCHID", brch);
						}

					 %>

					 document.getElementById("docno").value=temp_doc;
						document.getElementById("mode").value="view";
						//document.getElementById("brchName").value=bibranch;
						//$('#brchName').val(bibranch);
						window.parent.branchid.value=bibranch;
						bimode="";
						<%bimod="";%>
						document.getElementById("frmpurReq").submit();
				 }
					
					
				}
	
	}
	function funRemoveReadOnly(){
		 chkmultiqty();
		$('#frmpurReq input').attr('readonly', false );
		$('#frmpurReq textarea').attr('readonly', false );
		$('#frmpurReq select').attr('disabled', false);
	
		$('#reqmasterdate').jqxDateTimeInput({ disabled: false});
	 
		$("#purchasedetails").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		if ($("#mode").val() == "A") {
			getProduct();
			$('#reqmasterdate').val(new Date());

		  
			 $("#purchasedetails").jqxGrid('clear');
			    $("#purchasedetails").jqxGrid('addrow', null, {});
		   }
		
		
		 if(mod1=="A")
			{
		    	
		    	$("#vehpurcgasereq").load("purreqDetails.jsp?prcharray="+'<%=purchasearray.replaceAll("\\s","a@b@c")%>'+"&modebprf=a1");
		     	}
		
		 chkcostcode();
		 
		 $('#itemdocno').attr('readonly', true);
		 $('#itemname').attr('readonly', true);
		 
		  
		 
		 chkproductconfig();
			$('#psearch').attr('disabled', false );
			   $('#setbtn').attr('disabled', false );
		 
	}
	 
	
 
	
	
	
	function funNotify(){	
 
		
		
		
 		 var rows = $("#purchasedetails").jqxGrid('getrows');
		    $('#reqgridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "reqtest"+i)
		       .attr("name", "reqtest"+i)  
		    .attr("hidden", "true"); 
		    
		 
		    newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "+rows[i].specid+" :: ");
		
		   newTextBox.appendTo('form');
		  
		    
		   }   
		
		return 1;
	} 

	function funChkButton() {
		
		frmpurReq.submit();
	}

	function funSearchLoad(){

		 changeContent('mainsearch.jsp?'); 
	}
   $(function(){
        $('#frmpurReq').validate({
                rules: { 
              
                
           
                	purdesc:{maxlength:100}
             
                 },
                 messages: {
                	 purdesc: {maxlength:" Max 100 chars"}
               
                
               
              
                 }
        });});
    
		 
	function funFocus(){
		 
	   	$('#reqmasterdate').jqxDateTimeInput('focus'); 	    		
	} 
	 
	function setValues() {
		if($('#hidreqmasterdate').val()){
			$("#reqmasterdate").jqxDateTimeInput('val', $('#hidreqmasterdate').val());
		}
		 
   	  var docVal1 = document.getElementById("masterdoc_no").value;
  	  
      	if(docVal1>0)
      		{
      	//	funchkforedit();
      	
      	
		 var indexVal2 = document.getElementById("masterdoc_no").value;
		 

     	  
         $("#vehpurcgasereq").load("purreqDetails.jsp?reqdoc="+indexVal2);
			funchkforedit(); 
      		}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
	 
      	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
      	//document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		
	}
	
    function funPrintBtn(){
  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
  	  
  	   var url=document.URL;

         var reurl=url.split("savepurreqdata");
         
        // $("#docno").prop("disabled", false);                
         
   
  var brhid=<%=session.getAttribute("BRANCHID").toString()%>
        	 var dtype=$('#formdetailcode').val();
  
   var win= window.open(reurl[0]+"printPurchaseReqLd?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
 win.focus();
  	   } 
  	  
  	   else {
 	    	      $.messager.alert('Message','Select a Document....!','warning');
 	    	      return false;
 	    	     }
 	    	
  	}
    
    

	function funchkforedit()
    {
	

	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0)
					{
					
					 $("#btnEdit").attr('disabled', true );
					 $("#btnDelete").attr('disabled', true ); 
					 
					 
					 
					}
				else
					{
					 
					}
			  
				
				
				
			} else {
			}
		}
		x.open("GET", "reqlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
		x.send();
	
	
	}
	
	 
	 function getitemtype(){ 
		 
			
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		       
		      items=items.split('####');
		           var docno=items[0].split(",");
		           var type=items[1].split(",");
		        
		           var optionstype = '';

		
		           for ( var i = 0; i < type.length; i++) {
		        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
			        }
		            
		            $("select#itemtype").html(optionstype); 	
		            
		        
		            if($('#hideitemtype').val()!="")
					  {
					  
					  
					  $('#itemtype').val($('#hideitemtype').val());   
					  
					  }
				 
		  
		    }
		       }
		   x.open("GET","getitem.jsp?",true);
			x.send();
		        
		      
		        }
	 
     
     function chkcostcode()
     {
      
        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
         {
           var items= x.responseText.trim();
          
           if(parseInt(items)>0)
            {
        	   
        	   document.getElementById("costcheck").value=1;
        	   
        	   $('#hcostcodes').show();
        	    
        	   
         	  
             }
               else
           { 
            	   document.getElementById("costcheck").value=0;
            	   $('#hcostcodes').hide();
           }
           
            }}
        x.open("GET","<%=contextPath%>/com/Procurement/Purchase/costcodesearch/checkcostcode.jsp?",true);
     	x.send();
      
           
             
     	
     } 
     
	 function cleardata()
	 {
		 document.getElementById("itemdocno").value="";
		 document.getElementById("itemname").value="";
	/* 	 document.getElementById("clientname").value="";
	 
		 document.getElementById("cldocno").value="";
		 document.getElementById("siteid").value="";
		 document.getElementById("site").value=""; */
		 
	 
	 }
	 function getunit(val){ 
		 
			
		   var x=new XMLHttpRequest();
		   x.onreadystatechange=function(){
		   if (x.readyState==4 && x.status==200)
		    {
		      items= x.responseText;
		       
		      items=items.split('####');
		           var docno=items[0].split(",");
		           var type=items[1].split(",");
		        
		           var optionstype;

		
		           for ( var i = 0; i < type.length; i++) {
		        	   optionstype += '<option value="' + docno[i] + '">' + type[i] + '</option>';
			        }
		            
		            $("select#unit").html(optionstype); 	
		            
		            
		         
		  
		    }
		       }
		   x.open("GET","getunit.jsp?psrno="+val,true);
			x.send();
		        
		      
		        }	
		function setgrid()
		 {
			
			   
			 
			 var temppsrno=document.getElementById("psrno").value; 
			 var unit=document.getElementById("unit").value; 
			 
			 
	 
      	  
  		var rows1 = $("#purchasedetails").jqxGrid('getrows');
	    var aa=0;
	    for(var i=0;i<rows1.length;i++){
	 
	    	
	    	 
		   if(parseInt(rows1[i].prodoc)==parseInt(temppsrno))
			   {
		  
				 if((parseInt(document.getElementById("multimethod").value)==1))
				{	
					   
  			   if(parseInt(rows1[i].unitdocno)==parseInt(unit))
  			   {
  				   
  				   aa=1;
      			   break;
  			   }
				}
				 else
					 {
			   
			   aa=1;
			   break;
					 }
			   }
		   else{
			   
			   aa=0;
		       } 
	    }
			 
	   if(parseInt(aa)==1)
		   {
		   
			document.getElementById("errormsg").innerText="You have already select this product";
			  

				 
		     document.getElementById("sqotprdid").focus();
			 
		   return 0;
		   
		   
		   
		   }
	   else
		   {
		   document.getElementById("errormsg").innerText="";
		   }
	    
	   if(!$.isNumeric(temppsrno)){
			$.messager.alert('Message','Product Not Available');
			return 0;
		 }
	 if($('#quantity').val()==0 || $('#quantity').val()==null || $('#quantity').val()==''){
		 document.getElementById("errormsg").innerText="Quantity Cannot be Zero ";
		  return 0;
	 }
			
			
			 var rows = $('#purchasedetails').jqxGrid('getrows');
			  
		 	 
		     var rowlength= rows.length;
		     
		     var partno=$('#sqotprdid').val();
	 		    var pname=$('#sqotprdname').val();
	 		    var unit=$('#unit').val();
	 		    var brand=$('#brand').val();
	 		    var psrno=$('#psrno').val();
	 		    var unitdocno=$('#unitdocno').val();
	 		    var specid=$('#specid').val();
	 		    var qty=$('#quantity').val();
	 		    var docno=$('#doc_no').val();
	 		    var method=$('#method').val();
	 		    
	            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "proid" ,partno);
	            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "proname" ,pname);
	            
	            
	            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "productid" ,partno);
	            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "productname" ,pname);
	            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "prodoc" ,docno);
	            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "unit" ,unit);
	            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "unitdocno" ,unitdocno);
	            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "psrno" ,psrno);
	            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "qty" ,qty);
	            
	            if(unit>0){
	   		     $('#purchasedetails').jqxGrid('setcellvalue',  rowlength-1, "unit", $("#unit option:selected").text());

	            }
	            
	            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "specid" ,specid);
	            
	            
	            $('#purchasedetails').jqxGrid('setcellvalue', rowlength-1, "brandname" ,brand);
	 			   
	 			     $('#sqotprdid').val('');
		 		     $('#sqotprdname').val('');
		 		     $('#unit').val('');
		 		     $('#brand').val('');
		 		     $('#psrno').val('');
		 		     $('#unitdocno').val('');
		 		     $('#specid').val('');
		 		     $('#quantity').val('');
		 		     $('#method').val('');
		 		     $('#doc_no').val('');
    								
			 		 $("#purchasedetails").jqxGrid('addrow', null, {});
		    		 document.getElementById("sqotprdid").focus();
		 
		 }
		
		function prosrch(){
			var dates=document.getElementById("reqmasterdate").value;
			var dtype='PR';
			var presulttype='1';
	   	    productSearchContent('productSearch.jsp?dates='+dates+'&dtype='+dtype);
			
		}
	 
</script>
</head>
<body onload="setValues();chkcostcode();getitemtype();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpurReq" action="savepurreqdata" autocomplete="OFF" >     

<jsp:include page="../../../../header.jsp"></jsp:include>
<jsp:include page="multiqty.jsp"></jsp:include><br/>
<br>
<fieldset>

<table width="100%" >                        
  <tr>
    <td width="4.5%" align="right">Date</td> 
    <td colspan="2"  width="6%"><div id='reqmasterdate' name='reqmasterdate' value='<s:property value="reqmasterdate"/>'></div> 
                     <input type="hidden" id="hidreqmasterdate" name="hidreqmasterdate" value='<s:property value="hidreqmasterdate"/>'/></td>
                     
                 <td width="20%" align="right">Ref No</td><td><input type="text" id="refno" name="refno" value='<s:property value="refno"/>'  /></td>
                 
                <td width="50%" align="right">&nbsp;<div id="hcostcodes" hidden="true"> Group&nbsp; <select  id="itemtype"  name="itemtype" style="width:15%;" onchange="cleardata()"> 
    <option>
     </option>   
                             
    </select> &nbsp;  &nbsp;
    Job No&nbsp;<input type="text" id="itemdocno" placeholder="Press F3 to Search"    name="itemdocno"  onkeydown="getitem(event);" value='<s:property value="itemdocno"/>' >
    
    <input type="text" id="itemname" name="itemname" style="width:43%;"   value='<s:property value="itemname"/>' > </div></td>
                 
                 
    <td width="5%" align="right">Doc No</td>
    <td width="33%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>
  </tr>
  
   
</table>    
<table width="100%" >                                                                 
<tr>
  

 <td width="3%" align="right">Description</td>
    <td colspan="2"  width="70%">  <input type="text" id="purdesc" name="purdesc"  style="width:70%;" value='<s:property value="purdesc"/>'/></td>
     <td></td> <td></td>          
</tr>

</table>    
</fieldset>    
  
<br/>
 <fieldset id="psearch">
<legend>Item Details</legend>
   <table width="100% "  >   
   <tr> 
       <td align="center"> &nbsp;</td>
	   <td align="center">Product ID</td>
	   <td align="center">Product Name</td>
	   <td align="center">Brand</td>
	    <td align="center">Unit</td>
	   <td  width="6%" align="center">Qty</td>
	   	   <td align="center"> &nbsp;</td>
	   
	
   </tr>
   <tr>
   
       <td align="center" ><input type="hidden" id="cleardata">&nbsp; <input type="button" id="setbtn"  class="btn" onclick="prosrch()" value="PS" ></td>
	   <td width="15% " ><input type="text" class="form-control" id="sqotprdid" list="sqotproductid"  style="text-align: left;width:96%"><datalist id="sqotproductid" style="visibility:none;"></datalist></td>
       <td width="40% " ><input type="text" class="form-control" id="sqotprdname" list="sqotprdts" style="text-align: left;width:96%"><datalist id="sqotprdts" style="visibility:none;"></datalist></td>
	  
	   <td width="6%" align="center"> <input type="text" id="brand"> </td>  
	   
	    <td align="center"> <select    id="unit"   >   </select>      </td>  
	    <td><input type="text" id="quantity"   onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);" style="text-align: left;" onchange="calculatedata(this.id);"  ></td>
	    <td align="center"><input type="hidden" id="cleardata">&nbsp; <input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" ></td>
	   <td align="center"> &nbsp;</td>
  </tr>

 </table> 
</fieldset> 
<br>
<fieldset>
<div id="vehpurcgasereq">  <jsp:include page="purreqDetails.jsp"></jsp:include></div>
 </fieldset>
 
 
  
 <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' /> 
 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />

  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
 
 <input type="hidden" name="reqgridlenght" id="reqgridlenght" value='<s:property value="reqgridlenght"/>' />   
 
 
  <input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext"/>'  />   
  
    <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />   
    
 
 
 <input type="hidden" id="costtr_no" name="costtr_no"  value='<s:property value="costtr_no"/>'/> 
 <input type="hidden" id="costcheck" name="costcheck"  value='<s:property value="costcheck"/>'/> 
 <input type="hidden" id="hideitemtype" name="hideitemtype"  value='<s:property value="hideitemtype"/>'/> 
 <input type="hidden" id="hidetype" name="hidetype"  value='<s:property value="hidetype"/>'/>
 <input type="hidden" id="productchk" name="productchk"  value='<s:property value="productchk"/>' />
   <input type="hidden" id="temppsrno" >  
        <input type="hidden" id="tempspecid" > 
        <input type="hidden" id="psrno" > 
        <input type="hidden" id="specid" > 
        <input type="hidden" id="doc_no" > 
        <input type="hidden" id="unitdocno" > 
        <input type="hidden" id="method" > 

</form>

	 <div id="sidesearchwndow">
	   <div ></div>
	</div>
 <div id="searchwindow">
   <div ></div>
</div>
<!-- <div id="colorsearchwndow">
   <div ></div>
</div>
<div id="modelsearchwndow">
   <div ></div>
</div>
<div id="brandsearchwndow">
   <div ></div>
</div> -->

</div>
</body>
</html>