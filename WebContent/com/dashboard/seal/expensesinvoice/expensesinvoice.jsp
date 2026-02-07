<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">    
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript">

$(document).ready(function () {
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	  $("body").prepend("<div id='PleaseWaitSub' style='display: none;position:absolute; z-index: 1;top:230px;left:120px;'><img src='../../../../icons/31load.gif'/></div>");
	  $("#invdate").jqxDateTimeInput({ width: '110px', height: '18px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
	  $("#todate").jqxDateTimeInput({ width: '110px', height: '18px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true});
	  $('#clientsearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	  $('#clientsearch').jqxWindow('close');
	  $('#currinfowindow').jqxWindow({ width: '45%', height: '35%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Currency Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27})
	  $('#currinfowindow').jqxWindow('close');  
	  getCurrency();disable();  
	  $('#currencyid').attr('disabled',true); 
	  $('#txtclient').dblclick(function(){
		   	 $('#clientsearch').jqxWindow('open');
			 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch'));
	  });
	    
	  $('#txtcurr').dblclick(function(){
			 var brhid = $("#cmbbranch").val();
			 var date = $("#todate").val();
		  	 $('#currinfowindow').jqxWindow('open');
		  	 currSearchContent('searchCurrency.jsp?brhid='+brhid+'&date='+date, $('#currinfowindow')); 
	   });
		
	   $("#txtcurr").attr('disabled',true);        
});

function getcurr(){      
	  var brhid = $("#cmbbranch").val();
	  var date = $("#todate").val();
	  $('#currinfowindow').jqxWindow('open');  
	  currSearchContent('searchCurrency.jsp?brhid='+brhid+'&date='+date, $('#currinfowindow')); 
}
function currSearchContent(url) {
	   $.get(url).done(function (data) {  
	       $('#currinfowindow').jqxWindow('setContent', data);
	   });  
}
function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientsearch').jqxWindow('open');
	 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch'));    }
	 else{
		 }
} 
function clientSearchContent(url) {
               $.get(url).done(function (data) {
	           $('#clientsearch').jqxWindow('setContent', data);
    	}); 
 }
function funreload(event){
	  $('#overlay,#PleaseWait').show();
	  var brhid = $("#cmbbranch").val();
	  var todate = $("#todate").val();
	  disable();  
	  $("#invdiv").load("invporcessingGrid.jsp?id="+1+"&brhid="+brhid+"&todate="+todate);   
}
   
function funExportBtn(){
	$("#invdiv").excelexportjs({
		containerid: "invdiv", 
		datatype: 'json', 
		dataset: null, 
		gridId: "jqxinvGrid", 
		columns: getColumns("jqxinvGrid") ,   
		worksheetName:"Expenses Invoice"        
		}); 
}  
 
 function funGenerate(){
	 $("#txtcurr").attr('disabled',false);  
	 var clname = $("#txtclient").val();
	 var clacno = $("#hidacno").val();
	 var tax = $("#hidcltax").val();
	 var curid = $("#hidcurid").val();
	 var rate = $("#txtrate").val();  
	 var invdate = $("#invdate").val();
	 var invno = $("#invno").val();
	 var invdesc = $("#invdesc").val();
	 var todate = $("#todate").val();
	 var payterms = removeSplCharacters($("#payterms").val());   
	 var delterms = removeSplCharacters($("#delterms").val());
	 invdesc = invdesc.replace(/(\r\n|\n|\r)/gm, " ");
	 invdesc = removeSplCharacters(invdesc);   
	 $("#txtcurr").attr('disabled',true);
	 $('#jqxinvGrid').jqxGrid('clearfilters');
	 var selectedrows = $("#jqxinvGrid").jqxGrid('selectedrowindexes');
	 selectedrows = selectedrows.sort(function(a,b){return a - b});

	 if(selectedrows.length==0){
		 $.messager.alert('Warning','Please select a document!');    
		return false;
	}
	 if(clname=="" || clname=="0"){
		 $.messager.alert('Warning','Please select a client!'); 
		 return false;  
	 }
	 if(curid=="" || curid=="0"){
		 $.messager.alert('Warning','Please select a currency!'); 
		 return false;  
	 }
	 if(rate=="" || rate=="0"){
		 $.messager.alert('Warning','Please enter rate!'); 
		 return false;  
	 }
	 if(invno=="" || invno=="0"){
		 $.messager.alert('Warning','Please enter PO NO!');   
		 return false;  
	 }
	 var i=0, j=0, contractno=0, brhid=0, contno = 0, val = 0, cnttrno=0;
	 var netamount = 0.0;
	 for (i = 0; i < selectedrows.length; i++) {    
			netamount += $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "invamt");   
			var linedesc = removeSplCharacters($('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "description"));  
			
			if(i==0){
				contno = $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "costcode");
				var srvdetmtrno= $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "tranid")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "invamt")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "taxper")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "taxamt")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "nettotal")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "type")+"####"+linedesc;
				contractno= $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "costcode");
				cnttrno= $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "cnttrno");
				var brhid= $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "brhid");
				temptrno=srvdetmtrno;   
			}  
			else{  
				var cnt = $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "costcode");
				var srvdetmtrno= $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "tranid")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "invamt")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "taxper")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "taxamt")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "nettotal")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "type")+"####"+linedesc;     
				temptrno=temptrno+","+srvdetmtrno;   
				if(parseInt(contno) != parseInt(cnt)){
					val = 1;
					break;
				}  
			}
			j++; 
	 }  
	 if(val == 1){
		 $.messager.alert('Warning','You have selected different jobs!');   
		 return false;  
	 }
	 var chkinvdt = $("#invdate").jqxDateTimeInput('getDate'); 
	 var datecheck = funDateInPeriodNew(chkinvdt); 
	 if(parseInt(datecheck)!=1){      
		 return false;  
	 }    
	 $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
			if(r==false) {
				return false;  
			} else {
				$("#overlay, #PleaseWait").show();
				saveData(temptrno, invdate, invno, invdesc, todate, netamount, clacno, clname, curid, rate, contractno, brhid, tax, payterms, delterms, cnttrno);       
			}  
      });
 }
function saveData(temptrno, invdate, invno, invdesc, todate, netamount, clacno, clname, curid, rate, contractno, brhid, tax, payterms, delterms, cnttrno){        
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){  
			var items = x.responseText.split('####');
			 $("#overlay, #PleaseWait").hide();
			 funreload(event);
			 $("#invdate").val(new Date());
			 $("#payterms").val('');
			 $("#invno").val('');
			 $("#invdesc").val(''); 
			 $("#txtclient").val(''); 
			 $("#hidacno").val(''); 
			 $("#txtcurr").val(''); 
			 $("#hidcurid").val(''); 
			 $("#txtrate").val(''); 
			 $("#delterms").val('');  
			 if(parseInt(items[0])>0){ 
			      $.messager.alert('Message','PINV - '+items[1]+' Successfully Generated','success');
			}else{
				  $.messager.alert('Message','Not Generated','warning');             
			}    
		}  
	}  
	x.open("GET","saveData.jsp?trno="+encodeURIComponent(temptrno)+"&netamount="+netamount+"&todate="+todate+"&tax="+tax
			+"&invdate="+invdate+"&invno="+invno+"&invdesc="+encodeURIComponent(invdesc)+"&clacno="+clacno+"&cnttrno="+cnttrno   
			+"&clname="+encodeURIComponent(clname)+"&curid="+curid+"&rate="+rate+"&contractno="+contractno+"&brhid="+brhid+"&payterms="+encodeURIComponent(payterms)+"&delterms="+encodeURIComponent(delterms),true);                            
	x.send();       
}
function getCurrency(){
	var x=new XMLHttpRequest();
	var items,currIdItems,mcloseItems,currCodeItems;
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				items = x.responseText;
		        items = items.split('####');
		        currIdItems = items[0].split(",");
		        currCodeItems = items[1].split(",");
		            
		        var optionscurr = '';  
	            for ( var i = 0; i < currCodeItems.length; i++) {
			    	   optionscurr += '<option value="' + currIdItems[i] + '">' + currCodeItems[i] + '</option>';
			        }
	            $("select#currencyid").html(optionscurr);
	        	window.parent.monthclosed.value=mcloseItems;
	        	
			}
		else
			{
			}
		
		if($('#hidcurid').val()){
   			$("#currencyid").val($('#hidcurid').val());
   		}
	}
	x.open("GET","getCurrency.jsp",true);
	x.send();
}

function disable(){
	$("#txtclient").attr('disabled',true);
	$("#txtrate").attr('disabled',true);
	$("#invdate").attr('disabled',true);
	$("#invno").attr('disabled',true);
	$("#invdesc").attr('disabled',true);
	$("#btngenerate").attr('disabled',true);
	$("#payterms").attr('disabled',true);
	$("#delterms").attr('disabled',true);
	$("#btnremove").attr('disabled',true);
}

function enable(){
	$("#txtclient").attr('disabled',false);
	$("#txtrate").attr('disabled',false);
	$("#invdate").attr('disabled',false);
	$("#invno").attr('disabled',false);
	$("#invdesc").attr('disabled',false);
	$("#btngenerate").attr('disabled',false);   
	$("#payterms").attr('disabled',false);  
	$("#delterms").attr('disabled',false); 
	$("#btnremove").attr('disabled',false);   
}

function setGrid(curid){
	 var selectedrows = $("#jqxinvGrid").jqxGrid('selectedrowindexes');
	 selectedrows = selectedrows.sort(function(a,b){return a - b});
	 var i=0, j=0, contractno=0, brhid=0, contno = 0, val = 0;
	 var netamount = 0.0;   
	 for (i = 0; i < selectedrows.length; i++) {
		    netamount = 0.0;   
			if(i==0){
				netamount = $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "amount");   
				$('#jqxinvGrid').jqxGrid('setcellvalue', selectedrows[i], "invamt", parseFloat(netamount)/parseFloat(curid));
			}  
			else{  
				netamount = $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "amount");   
				$('#jqxinvGrid').jqxGrid('setcellvalue', selectedrows[i], "invamt", parseFloat(netamount)/parseFloat(curid));
			}   
	 }
}

function funRemove(){
	 $('#jqxinvGrid').jqxGrid('clearfilters');
	 var selectedrows = $("#jqxinvGrid").jqxGrid('selectedrowindexes');
	 selectedrows = selectedrows.sort(function(a,b){return a - b});

	 if(selectedrows.length==0){
		 $.messager.alert('Warning','Please select a document!');    
		return false;
	}
	 
	 var i=0, j=0, contractno=0, brhid=0, contno = 0, val = 0;
	 var linedesc="";
	 for (i = 0; i < selectedrows.length; i++) {    
		   if(i==0){
				contno = $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "costcode");
				var srvdetmtrno= $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "tranid")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "invamt")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "taxper")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "taxamt")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "nettotal")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "type")+"####"+linedesc;
				var contractno= $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "costcode");
				var brhid= $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "brhid");
				temptrno=srvdetmtrno;   
			}  
			else{  
				var cnt = $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "costcode");
				var srvdetmtrno= $('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "tranid")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "invamt")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "taxper")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "taxamt")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "nettotal")+"####"+$('#jqxinvGrid').jqxGrid('getcellvalue', selectedrows[i], "type")+"####"+linedesc;     
				temptrno=temptrno+","+srvdetmtrno;   
			}
			j++; 
	 }    
	    
	 $.messager.confirm('Confirm', 'Do you want to mark as invoiced?', function(r){
			if(r==false) {
				return false;  
			} else {
				$("#overlay, #PleaseWait").show();
				removeData(temptrno, contractno);       
			}  
     });
}

function removeData(temptrno, contractno){          
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){  
			var items = x.responseText;
			 $("#overlay, #PleaseWait").hide();
			 funreload(event);
			 if(parseInt(items[0])>0){ 
			      $.messager.alert('Message',' Successfully Updated','success');
			}else{
				  $.messager.alert('Message','Not Updated','warning');             
			}    
		}  
	}          
	x.open("GET","removeData.jsp?trno="+encodeURIComponent(temptrno)+"&contractno="+contractno,true);                            
	x.send();       
}
</script>
</head>
<body onload="getBranch();">
   <form>
      <div id="mainBG" class="homeContent" data-type="background">
         <div class='hidden-scrollbar'>
            <table width="100%" >
               <tr>
                  <td width="20%" >
                     <fieldset style="background: #ECF8E0;">
                        <table width="100%"  >
                           <jsp:include page="../../heading.jsp"></jsp:include>
                           <tr>
                              <td>&nbsp;</td>
                           </tr>
                           <tr>
                              <td width="35%" align="right"><label class="branch">Upto Date</label></td>
                              <td width="25%" align="left">
                                 <div id="todate" name="todate"></div>
                              </td>
                           </tr>
                           <tr>
                              <td>&nbsp;</td>
                           </tr>
                           <tr>
                              <td>&nbsp;</td>
                           </tr>
                           <tr>
                              <td colspan="2">
                                 <fieldset>
                                    <table width="100%">
                                       <tr>
                                          <td width="5%" align="right"><label class="branch">Client</label></td>
                                          <td width="25%" align="left"><input type="text" name="txtclient" id="txtclient"  placeholder="Press F3 for Search" onKeyDown="getclinfo(event);" style="width:99.7%;height:20px">
                                             <input type="hidden" id="hidcldocno" name="hidcldocno">
                                             <input type="hidden" id="hidacno" name="hidacno">
                                             <input type="hidden" id="hidcltax" name="hidcltax">
                                          </td>
                                       </tr>
                                       <tr>
                                          <td width="5%" align="right"><label class="branch">Currency</label></td>
                                          <td width="25%" align="left">
                                             <select id="currencyid" name="currencyid"  value='<s:property value="currencyid"/>'>
                                                <option value="">--Select--</option>
                                             </select>
                                             <input type="hidden" id="hidcurid" name="hidcurid">
                                          </td>
                                       </tr>
                                       <tr>
                                          <td width="5%" align="right"><label class="branch">Rate</label></td>
                                          <td width="25%" align="left"><input type="text" id="txtrate" name="txtrate" style="width:99.7%;height:20px"></td>
                                       </tr>
                                       <tr>
                                          <td width="5%" align="right"><label class="branch">Date</label></td>
                                          <td width="25%" align="left">
                                             <div id="invdate" name="invdate"></div>
                                          </td>
                                       </tr>
                                       <tr>
                                          <td width="5%" align="right"><label class="branch">PO NO</label></td>
                                          <td width="25%" align="left"><input type="text" id="invno" name="invno" style="width:99.7%;height:20px"></td>
                                       </tr>
                                         <tr>
										    <td width="5%" align="right"><label class="branch">Pay Terms</label></td>    
										    <td width="25%" align="left"><input type="text" id="payterms" name="payterms" style="width:99.7%;height:20px;"></td>
									    </tr>  
									     <tr>
										    <td width="5%" align="right"><label class="branch">Del Terms</label></td>      
										    <td width="25%" align="left"><input type="text" id="delterms" name="delterms" style="width:99.7%;height:20px;"></td>
									    </tr>      
                                       <tr>
                                          <td width="5%" align="right"><label class="branch">Description</label></td>
                                          <td width="25%" align="left"><textarea id="invdesc" name="invdesc" rows="4"></textarea></td>
                                       </tr>
                                       <tr>
                                            <td align="center"><input type="button" id="btnremove" name="btnremove" class="myButton" onclick="funRemove();" value="Remove"></td>  
                                            <td align="center"><input type="button" id="btngenerate" name="btngenerate" class="myButton" onclick="funGenerate();" value="Generate"></td>
                                        </tr>
                                    </table>
                                 </fieldset>
                           <tr>
                              <td><input type="hidden" id="hidtrno" name="hidtrno">  
                              <input type="hidden" id="detaildesc" name="detaildesc">
                              <input type="hidden" id="hidpayterms" name="hidpayterms">        
							  <input type="hidden" id="hiddelterms" name="hiddelterms"> </td>
                           </tr>
                           <tr>
                              <td rowspan="3">&nbsp;</td>  
                           </tr>
                            
                        </table>
                     </fieldset>
                  </td>
                  <td width="80%">
                     <table width="100%">
                        <tr>
                           <td>
                              <div id="invdiv">
                                 <jsp:include page="invporcessingGrid.jsp"></jsp:include>
                              </div>
                           </td>
                        </tr>
                     </table>
                  </td>
               </tr>
            </table>
         </div>
      </div>
   </form>
   <div id="currinfowindow">
      <div ></div>
   </div>
   <div id="clientsearch">
      <div ></div>
   </div>
</body>
</html>