<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 
<style type="text/css">
 
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.bicon {
    background-color: #ECF8E0;
	width: 1em;
	height: 1em;
	border: none;
}
#contractdetlbl{
   color: #2b45ed;
    font-weight: bold;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	  $("#confirmdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy"});  
	  $("#dodate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy"});  
	  $('#contractDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Contract Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#contractDetailsWindow').jqxWindow('close');
	  $('#txtcontract').dblclick(function(){     
		  contractSearchContent('contractSeacrh.jsp');     
	  });
	  $("#txtqty").val(1);  
});
function contractSearchContent(url) {
 	$('#contractDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#contractDetailsWindow').jqxWindow('setContent', data);
		$('#contractDetailsWindow').jqxWindow('bringToFront');
    });    
}
function getContract(event){    
    var x= event.keyCode;
    if(x==114){
		    contractSearchContent('contractSeacrh.jsp');      
    }
    else{}
}
function funExportBtn(){  
	$("#tippingdiv").excelexportjs({
		containerid: "tippingdiv", 
		datatype: 'json', 
		dataset: null, 
		gridId: "jqxtippingGrid", 
		columns: getColumns("jqxtippingGrid") ,    
		worksheetName:"TippingDetailsImport"
		}); 
 } 


function funreload(event){
	 var barchval = document.getElementById("cmbbranch").value; 
	 $("#overlay, #PleaseWait").show();  
	 $("#tippingdiv").load("tippingGrid.jsp?barchval="+barchval+"&id="+1);  
 }   
function upload(){
	$.messager.confirm('Message', 'Do you want to import?', function(r){
		if(r==false) {
			return false; 
		} else {
			getAttachDocumentNo(); 
		}
	});
 } 

function getAttachDocumentNo(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items>0){
					var path=document.getElementById("fileexcelimport").value;
					var fsize = $('#fileexcelimport')[0].files[0].size;
					var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
					if((extn=='xls') || (extn=='csv') || (extn=='xlsx')){ 
				        	ajaxFileUpload(items);	
				     }else{
				        	 $.messager.show({title:'Message',msg: 'File of xlsx Format is not Supported.',showType:'show',
		                         style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		                     }); 
					            return;
				     } 
				}
				
		  }
		}
			
	x.open("GET","getAttachDocumentNo.jsp?mode=TDIM",true);      
	x.send();
	}
function ajaxFileUpload(docNo) {    
	  $("#overlay, #PleaseWait").show();
	    if (window.File && window.FileReader && window.FileList && window.Blob)
	    {
	        var fsize = $('#fileexcelimport')[0].files[0].size;
	        
	        if(fsize>10485060) {
	            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 10 MB.',showType:'show',
               style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
           }); 
	            return;
	        }
	    }else{
	    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                 }); 
	        return;
	    }
	
	console.log("IN AJAX 1");    
   $.ajaxFileUpload  
   (  
     {  
        url:'fileAttachAction.action?formCode=TDIM&doc_no='+docNo+'&descpt=Excel Import' ,  
        secureuri:false,  
        fileElementId:'fileexcelimport',    
        dataType: 'json', 
        success: function (data, status)   
        {  
           
           if(status=='success'){
        	   console.log("IN AJAX 2");
               saveExcelDataData(docNo);
//                $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
//                   style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
             // }); 
            }
           
            if(typeof(data.error) != 'undefined')  
            {  
                if(data.error != '')  
                {  
                    $.messager.show({title:'Message',msg: data.error,showType:'show',
                          style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                      }); 
                }else  
                {  
                    $.messager.show({title:'Message',msg: data.message,showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	              	          }); 
                }  
            }  
        },  
        error: function (data, status, e){  
            $.messager.alert('Message',e);
        }  
    });  
return false;  
}
function saveExcelDataData(docNo){ 
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		var items=x.responseText.trim(); 
			if(parseInt(items)==1){   
				$("#overlay, #PleaseWait").hide(); 
				funreload(event);  
				$.messager.alert('Message', ' Successfully Imported.', function(r){});
			}
			
	  }
	}
		
x.open("GET","exsaveData.jsp?docNo="+docNo+'&rdocno='+1,true);  
x.send();
} 
function funClear(){
	 $("#jqxtippingGrid").jqxGrid('clear'); 
	 document.getElementById("jqxcontract").value="";
	 document.getElementById("contrno").value="";  
	 $('#dodate').val(new Date());
	 $('#txtdno').val('');
	 $('#jqxwastetype').val('');  
	 $('#wastename').val('');    
	 $('#txtqty').val('');
	 $('#txtweight').val('');
	 $('#txtprice').val('');  
	 $('#confirmdate').val(new Date());
	 $('#jqxcontract').attr('placeholder', 'Enter Contract No');
	 $('#jqxwastetype').attr('placeholder', 'Enter Wastetype');
	 $('#txtdno').attr('placeholder', 'Enter DO No');
	 $('#txtweight').attr('placeholder', 'Enter Weight');   
	 $('#txtprice').attr('placeholder', 'Enter Price'); 
	 $('#txtqty').attr('placeholder', 'Enter Qty'); 
	 document.getElementById("contractdetlbl").innerHTML=""; 
	 $("#txtqty").val(1); 
 }
function funConfirm(){
	 var rows=$('#jqxtippingGrid').jqxGrid('getrows');
	 var val=0,valid=0,valid1=0;
	 for(var i=0;i<rows.length;i++){
	    var v=$('#jqxtippingGrid').jqxGrid('getcellvalue',i,'valid'); 
	    var v1=$('#jqxtippingGrid').jqxGrid('getcellvalue',i,'valid1');
	    var contno=$('#jqxtippingGrid').jqxGrid('getcellvalue',i,'contno');  
		if(typeof(contno)!="undefined" && typeof(contno)!="NaN" && contno!="" && contno!="0" && contno!=null){
			val++; 
		}
		if(v>0){
			valid++;
		}
		if(v1>0){
			valid1++;
		}
	}
	if(val==0){
		    $.messager.alert('Message','Please import documents first!!','warning');
	        return false;
	}
	if(valid>0){ 
	    $.messager.alert('Message','Some wastetypes are not correct!!','warning');
        return false;
    }
	if(valid1>0){ 
	    $.messager.alert('Message','Some skip sizes are not correct!!','warning');     
        return false;
    }
	var date= $("#confirmdate").val();
	$.messager.confirm('Message', 'Do you want to confirm?', function(r){
		if(r==false) {
			return false; 
		} else {
			$("#overlay, #PleaseWait").show();  
			saveConfirm(date);   
		}
	});
 } 
function saveConfirm(date){  
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		var items=x.responseText.trim(); 
		if(parseInt(items)>0){
			$("#overlay, #PleaseWait").hide();  
			funreload(event);
	 		$.messager.alert('Message','Successfully Confirmed','success');   
	 	}
	 	else{
	 		$("#overlay, #PleaseWait").hide();  
	 		$.messager.alert('Message','Not Confirmed','warning');  
	 	}
	  }
	}
		
  x.open("GET","saveconfirm.jsp?date="+date,true);   
  x.send();
} 
function funUpdate(){  
	var contrno=document.getElementById("contrno").value;
	var dodate =  $('#dodate').val();
	var dno = $('#txtdno').val();
	var wastetype = $('#wastename').val(); 
	var jqxwastetype = $('#jqxwastetype').val(); 
	var qty= $('#txtqty').val();
	var manualdate =  $('#confirmdate').val();
	var tipping= $('#cmbtipping').val();  
	var weight= $('#txtweight').val();
	var price= $('#txtprice').val();   
	if(contrno==''){
		$.messager.alert('Message','Please select a contract.','warning'); 
		    return false;  
	 }
	if(jqxwastetype==''){  
		$.messager.alert('Message','Please Enter Waste Type.','warning');  
		    return false;  
	 }
	if(dno==''){
		$.messager.alert('Message','Please Enter DO No.','warning'); 
		    return false;    
	 }
	if(qty==''){
		$.messager.alert('Message','Please Enter qty.','warning'); 
		    return false;  
	 }
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		var items=x.responseText.trim();   
		if(parseInt(items)>0){
	 		$.messager.alert('Warning','DO No already exists. Please use a different number.','warning');
	 		 $("#txtdno").focus();
	 		 return false; 
	 	}
	 	else{  
	 		$.messager.confirm('Message', 'Do you want to update?', function(r){
	 			if(r==false) {
	 				return false; 
	 			} else {
	 				saveTippingDetails(contrno, dodate, dno, wastetype, qty, tipping, manualdate, weight, price);        
	 			}
	 		});
	 	}
	  }
	}
  x.open("GET","validateDNO.jsp?dno="+dno,true);     
  x.send();
}
function saveTippingDetails(contrno, dodate, dno, wastetype, qty, tipping, manualdate, weight, price){               
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){  
			var items=x.responseText;
				 if(parseInt(items)>0){  
					 $.messager.alert('Message','Successfully Updated','success');
					 funClear();
					 $("#jqxcontract").focus();
					}else{
						$.messager.alert('Message','Not Updated','warning');  
					} 
			}  
	}  
x.open("GET","saveData.jsp?wastetype="+encodeURIComponent(wastetype)+"&contrno="+contrno+"&dodate="+dodate+"&dno="+encodeURIComponent(dno)+"&manualdate="+manualdate+"&qty="+qty+"&tipping="+encodeURIComponent(tipping)+"&weight="+weight+"&price="+price,true);       
x.send();    
}
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
        return false;
    return true;
}
</script>
</head>
<body onload="getBranch();">
<form autocomplete="off">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"> 
	<jsp:include page="../../heading.jsp"></jsp:include>   
	 <tr><td colspan="2">&nbsp;</td></tr>
       <tr> <td align="center" colspan="2"><input type="file" id="fileexcelimport" name="file"/></td></tr> 
       <tr> <td align="center" colspan="2"><button  class="icon" id="btnsearch" name="btnsearch" title="Import Excel" type="button" onclick="return upload();">
							<img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png"> 
						</button></td></tr>                

<!--<tr><td colspan="2"><center><input type="button" name="btnimport" id="btnimport" class="myButton" value="Import" onclick="funImport();"></center></td></tr>  -->  
 	 <tr><td colspan="2">&nbsp;</td></tr>  
   <tr><td  align="right" width="25%"><label class="branch">Date</label></td><td align="left"><div id='confirmdate' name='confirmdate' value='<s:property value="confirmdate"/>'></div> </td></tr>
  <tr><td colspan="2"><center><input type="button" name="btnconfirm" id="btnconfirm" class="myButton" value="Confirm" onclick="funConfirm();"></center></td></tr> 
   
    <tr><td colspan="2"><label class="branch" id="contractdetlbl"></label></td></tr>    
    <tr><td align="right"><label class="branch">Contract No</label></td>  
	<td align="left"><div id="contractno" onkeydown="return (event.keyCode!=13);"><jsp:include page="contractSearch.jsp"></jsp:include></div>
    <input type="hidden" id="contrno" name="contrno" value='<s:property value="contrno"/>'/></td></tr>    
     <tr><td align="right"><label class="branch">DO Date</label></td>  
	<td align="left"><div id='dodate'></div></td></tr>    
     <tr><td align="right"><label class="branch">DO No</label></td>  
	<td align="left"><input type="text" id="txtdno" name="txtdno" style="width:100%;height:20px;" placeHolder="Enter DO No" onkeypress="return isNumberKey(event)" value='<s:property value="txtdno"/>'/></td></tr> 
	 <tr><td align="right"><label class="branch">Waste Type</label></td>    
		<td align="left"><div id="wastetype" onkeydown="return (event.keyCode!=13);"><jsp:include page="wastetypeSearch.jsp"></jsp:include></div>
    <input type="hidden" id="wastename" name="wastename" value='<s:property value="wastename"/>'/></td></tr>           
	 <tr><td align="right"><label class="branch">Qty</label></td>  
	<td align="left"><input type="text" id="txtqty" name="txtqty" style="width:100%;height:20px;" placeHolder="Enter Qty" onkeypress="return isNumberKey(event)" value='<s:property value="txtqty"/>'/></td></tr>      
	 <tr><td align="right"><label class="branch">Tipping</label></td>    
	<td align="left"><select id="cmbtipping" name="cmbtipping"><option value="YES">YES</option><option value="NO">NO</option></select></td></tr>   
	 <tr><td align="right"><label class="branch">Weight</label></td>  
	<td align="left"><input type="text" id="txtweight" name="txtweight" style="width:100%;height:20px;" placeHolder="Enter Weight" onkeypress="return isNumberKey(event)" value='<s:property value="txtweight"/>'/></td></tr> 
	 <tr><td align="right"><label class="branch">Price</label></td>  
	<td align="left"><input type="text" id="txtprice" name="txtprice" style="width:100%;height:20px;text-align:right" placeHolder="Enter Price" onkeypress="return isNumberKey(event)" onblur="funRoundAmt(this.value,this.id)" value='<s:property value="txtprice"/>'/></td></tr> 
	<tr><td colspan="2" align="center"> <input type="button" name="btnupdate" id="btnupdate" class="myButton" value="Update" onclick="funUpdate();"> </td></tr> 
	 <tr> <td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClear();"></td> </tr>  
	</table>
	</fieldset>
	<input type="hidden" id="cldocno" style="height:20px;width:70%;"  name="cldocno">
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="tippingdiv"><jsp:include page="tippingGrid.jsp"></jsp:include></div></td> 
		</tr>
	</table>
</tr>
</table>

</div>
<div id="clinfowindow">
   <div ></div>
</div> 
<div id="contractDetailsWindow">
	<div></div><div></div>
</div>
</div>
</form>
</body>
</html>