<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
form label.error {
color:red;

  font-weight:bold;

}
.hidden-scrollbar {
    overflow: auto;
    
    height: 550px;
}
</style>
 
<jsp:include page="../../../includes.jsp"></jsp:include>
<script type="text/javascript">
 
$(document).ready(function() {
	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $("#stdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $("#enddate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	  $('#clientsearch').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	  $('#clientsearch').jqxWindow('close');
	  $('#cpinfowindow').jqxWindow({ width: '35%', height: '62%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contact Person Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27})
	  $('#cpinfowindow').jqxWindow('close');
	  $('#printWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#printWindow').jqxWindow('close');
	  $('#currinfowindow').jqxWindow({ width: '45%', height: '35%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Currency Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27})
	  $('#currinfowindow').jqxWindow('close');  
	  var endDates=new Date($('#enddate').jqxDateTimeInput('getDate'));  
	     var onemonth=new Date(new Date(endDates).setFullYear(endDates.getFullYear()+1));    
	     $('#enddate').jqxDateTimeInput('setDate', new Date(onemonth));	      
	    
	  getCurrency();
	  $('#txtclient').dblclick(function(){
		   	if($('#mode').val()!= "view")
		   		{
		   	 $('#clientsearch').jqxWindow('open');
			 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch'));
		   		}
		 });
	  $('#txtcontact').dblclick(function(){
		   	if($('#mode').val()!= "view")
		   		{
		   		var clientid=document.getElementById("clientid").value;
		  		if(clientid==""){
		  			document.getElementById("errormsg").innerText="Please select client";
		  			return 0;
		  		}
		  		 var type=1;
		  		 var rowBoundIndex=0;
	  	 	  $('#cpinfowindow').jqxWindow('open');
	  	       cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid+'&rowindex='+rowBoundIndex+'&type='+type); 
		   		}
		 });
});
function getCurrency(){
	var brhid = $("#brchName").val();
	var date = $("#date").val();
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
	        	if($('#txtrate1').val()==""){  
	        		getRates();	
	        	} 
			}
		else
			{
			}
		
		if($('#hidcmbcurrencyid').val()){
   			$("#currencyid").val($('#hidcmbcurrencyid').val());
   		}
	}
	x.open("GET","getCurrency.jsp?brhid="+brhid+"&date="+date,true);
	x.send();
}
function getRates(){
	var curid = $("#currencyid").val(); 
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
				items = x.responseText;
		        $("#txtrate1").val(items); 
		 } else {
		 }
	}
	x.open("GET","getRate.jsp?curid="+curid,true);      
	x.send();
}
 function getcurr(rowBoundIndex,type){  
	  var brhid = $("#brchName").val();
	  var date = $("#date").val();
	  $('#currinfowindow').jqxWindow('open');  
	  currSearchContent('searchCurrency.jsp?rowBoundIndex='+rowBoundIndex+'&brhid='+brhid+'&date='+date+'&type='+type);
 }
 function currSearchContent(url) {
	   $.get(url).done(function (data) {  
	       $('#currinfowindow').jqxWindow('setContent', data);
	   });  
 }
function getcontact(event,rowindex){
		var clientid=document.getElementById("clientid").value;
		if(clientid==""){
			document.getElementById("errormsg").innerText="Please select client";
			return 0;
		}
		var x= event.keyCode;
		 if(x==114){
			 var type=1;
	 	  $('#cpinfowindow').jqxWindow('open');
	       cpSearchContent('contactpersonsearch.jsp?clientdocno='+clientid+'&rowindex='+rowindex+'&type='+type); 
	        	 }
		 else{
			 }
		 }
	        	 
	function cpSearchContent(url) {
		 //alert(url);
	 	 $.get(url).done(function (data) {
				 //alert(data);
		$('#cpinfowindow').jqxWindow('setContent', data);

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
     
function funFocus(){ 
	document.getElementById("date").focus();
}

function funReadOnly(){
	 $('#frmservicecontract input').attr('readonly', true);
	 $('#frmservicecontract input').attr('disabled', true);
	 $('#frmservicecontract select').attr('disabled', true);
	 $('#date').jqxDateTimeInput({ disabled: true});
 
	 $("#jqxServiceOneGrid").jqxGrid({ disabled: true});
	 $("#jqxServiceYearlyGrid").jqxGrid({ disabled: true});  
	 //document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
     //document.getElementById("formdetail").value=window.parent.formName.value;
	 //document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
}

function funRemoveReadOnly(){  
	 $('#frmservicecontract input').attr('disabled', false);
	 $('#frmservicecontract input').attr('readonly', false);
	 $('#frmservicecontract select').attr('disabled', false);
	 $('#txtclient').attr('readonly', true);
	 $('#txtclientdet').attr('readonly', true);
	 $('#txtmob1').attr('readonly', true);
	 $('#txtmob2').attr('readonly', true);
	 $('#txtemail').attr('readonly', true);
	 $('#txtcontact').attr('readonly', true);
	 $('#docno').attr('readonly', true);
	 $('#currencyid').attr('disabled', true);  
	 $('#date').jqxDateTimeInput({ disabled: false});
	 $('#stdate').jqxDateTimeInput({ disabled: false});
	 $('#enddate').jqxDateTimeInput({ disabled: false});
	 $("#jqxServiceOneGrid").jqxGrid({ disabled: false});
	 $("#jqxServiceYearlyGrid").jqxGrid({ disabled: false});  
	 if($("#mode").val()=="A"){
			$('#date').jqxDateTimeInput('setDate', new Date());
			$('#stdate').jqxDateTimeInput('setDate', new Date());
			$('#enddate').jqxDateTimeInput('setDate', new Date());
			var endDates=new Date($('#enddate').jqxDateTimeInput('getDate'));  
		    var onemonth=new Date(new Date(endDates).setFullYear(endDates.getFullYear()+1));    
		    $('#enddate').jqxDateTimeInput('setDate', new Date(onemonth));	      
			$("#jqxServiceOneGrid").jqxGrid('clear');
			$("#jqxServiceOneGrid").jqxGrid('addrow', null, {});
			$("#jqxServiceYearlyGrid").jqxGrid('clear');
			$("#jqxServiceYearlyGrid").jqxGrid('addrow', null, {});
			reload();    
	 }else if($("#mode").val()=="E"){
	 }
	 getCurrency();
} 

 
function funNotify(){
	$('#currencyid').attr('disabled', false); 
	if($('#txtclient').val()== ""){
		document.getElementById("errormsg").innerText="Please select a Client!";
		return 0;
	}else{
		document.getElementById("errormsg").innerText="";
	} 
	//One time service Grid
	var rows1 = $("#jqxServiceOneGrid").jqxGrid('getrows');   
	var onelen=0, yearlen=0, val1=0, val2=0;     
	for (var i = 0; i < rows1.length; i++) { 
		 var chk = rows1[i].amountlc;
		 var chk1 = rows1[i].servid;   
		 if(typeof(chk1)!="undefined" && typeof(chk1)!="NaN" && chk1!="" && chk1!="0" && chk1!=null){  
			 if((typeof(chk)!="undefined" && typeof(chk)!="NaN" && chk!="" && chk!="0"  && chk!=null && $("#mode").val()=="A") || $("#mode").val()=="E"){     
				 newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "serone"+onelen)
			       .attr("name", "serone"+onelen)
			       .attr("hidden", "true");  
				 
				 newTextBox.val(rows1[i].servid+" :: "+rows1[i].acno+" :: "+$("#currencyid").val()+" :: "+$("#txtrate1").val()+" :: "+rows1[i].amounttr+" :: "+rows1[i].amountlc+" :: "+rows1[i].description+" :: "+rows1[i].doc_no+" :: "+rows1[i].billmethod+" :: "); 
				 newTextBox.appendTo('form');
				 onelen++;
				 val1++;
			 }  
		 }
	 }
	//Yearly service Grid 
	var rows2 = $("#jqxServiceYearlyGrid").jqxGrid('getrows');     
	rows2 = rows2.sort(function(a,b){return a - b});   
	for (var i = 0; i < rows2.length; i++) { 
		 var chk = rows2[i].amountlc;
		 var chk1 = rows2[i].servid;     
		 if(typeof(chk1)!="undefined" && typeof(chk1)!="NaN" && chk1!="" && chk1!="0" && chk1!=null){  
			 if((typeof(chk)!="undefined" && typeof(chk)!=null && chk!="" && chk!="0" && chk!=null && $("#mode").val()=="A") || $("#mode").val()=="E"){     
				 newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "seryear"+yearlen)
			       .attr("name", "seryear"+yearlen)    
			       .attr("hidden", "true");
				 
				 newTextBox.val(rows2[i].servid+" :: "+rows2[i].acno+" :: "+$("#currencyid").val()+" :: "+$("#txtrate1").val()+" :: "+rows2[i].amounttr+" :: "+rows2[i].amountlc+" :: "+rows2[i].description+" :: "+rows2[i].doc_no+" :: "+rows2[i].billmethod+" :: "); 
				 newTextBox.appendTo('form');
				 yearlen++; 
				 val2++;
			 }
		 }      
	 }
	if(val1==0 && val2==0){      
		 document.getElementById("errormsg").innerText="Please enter amount in service details";     
  		 return 0;
  	 }else{
 		document.getElementById("errormsg").innerText="";
 	 }
	 $('#seronelen').val(onelen);
	 $('#seryearlen').val(yearlen);      
	 
	 var retval  = getEditStat();    
   	 if(retval==0){
   		document.getElementById("errormsg").innerText="You cannot change invoice generated document!";    
   	 }else{
 		document.getElementById("errormsg").innerText="";
 	 }   
   	 return retval;
}  
	function setValues(){
		  document.getElementById("formdetail").value="Service Contract";  
	   	  document.getElementById("formdetailcode").value="AMC";

	 	  if(!($('#hidcmbvattype').val()=="")){
	 			$("#cmbvattype").val($('#hidcmbvattype').val());  
	 	  }
	 	 if(!($('#hidcmbcurrencyid').val()=="")){
	 			$("#currencyid").val($('#hidcmbcurrencyid').val());
	 	  }
	 	  if($('#hiddate').val()!=""){
				 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
			  } 
	      if($('#hidstdate').val()!=""){
				 $("#stdate").jqxDateTimeInput('val', $('#hidstdate').val());
			  } 
          if($('#hidenddate').val()!=""){
				 $("#enddate").jqxDateTimeInput('val', $('#hidenddate').val());
			  }   
		  if($('#msg').val()!=""){  
			   $.messager.alert('Message',$('#msg').val());
		  }
		  var docno = $("#docno").val();
		  if(parseInt(docno)>0){
			  var masterdocno = $("#masterdoc_no").val();  
			  $("#seryeardiv").load("serviceyearlyGrid.jsp?id="+1+"&trno="+masterdocno);         
 			  $("#seronediv").load("serviceonetimeGrid.jsp?id="+2+"&trno="+masterdocno);    
		  }
		  funSetlabel(); 
	}
	
	function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	}   
	 
 function funPrintBtn() {
			 
  }
  function PrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
	}); 
	} 
	function reload(){
		  $("#seryeardiv").load("serviceyearlyGrid.jsp?id=1");
		  $("#seronediv").load("serviceonetimeGrid.jsp?id=2");     
	}
	function getEditStat(){
		var retval = 1; 
		if($("#mode").val()=="E" || $("#mode").val()=="D"){
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					if(parseInt(items)>0){
						retval = 0;
					} else {
						retval = 1; 
					}
				} else {  
				}
			}
			x.open("GET", "getEditStatus.jsp?docno="+document.getElementById("masterdoc_no").value, false);
			x.send();  
		}
		return retval;   
	}  
	
	function funCalc(){   
		 var rows1 = $("#jqxServiceOneGrid").jqxGrid('getrows');
		 var rows2 = $("#jqxServiceYearlyGrid").jqxGrid('getrows');
		 var rate = $("#txtrate1").val();   
		 for(var i=0;i<rows1.length;i++){
			 var amttr = $("#jqxServiceOneGrid").jqxGrid('getcellvalue',i,'amounttr');
		     if(typeof(amttr)!="undefined" && typeof(amttr)!="NaN" && amttr!="" && amttr!="0" && amttr!="0.00" && amttr!=null){
		    	 if(rate == "" || rate == null || rate == "NaN"){
		    		  rate = "0";
		    	  }
		    	  if(amttr == "" || amttr == null || amttr == "NaN"){
		    		  amttr = "0";   
		    	  }
		    	 $("#jqxServiceOneGrid").jqxGrid('setcellvalue',i,'amountlc',parseFloat(rate)*parseFloat(amttr));  
		     }  
		 }
		 
		 for(var i=0;i<rows2.length;i++){    
			 var amttr = $("#jqxServiceYearlyGrid").jqxGrid('getcellvalue',i,'amounttr');
		     if(typeof(amttr)!="undefined" && typeof(amttr)!="NaN" && amttr!="" && amttr!="0" && amttr!="0.00" && amttr!=null){
		    	 if(rate == "" || rate == null || rate == "NaN"){
		    		  rate = "0";
		    	  }
		    	  if(amttr == "" || amttr == null || amttr == "NaN"){
		    		  amttr = "0";   
		    	  }
		    	 $("#jqxServiceYearlyGrid").jqxGrid('setcellvalue',i,'amountlc',parseFloat(rate)*parseFloat(amttr));  
		     }  
		 }
	}
	
</script>
</head>
<body onLoad="setValues();">
   <br/> 
   <div id="mainBG" class="homeContent" data-type="background">
      <form id="frmservicecontract" action="saveServiceContractSeal" method="post" autocomplete="off">
         <jsp:include page="../../../header.jsp" />
         <br>
         <div class='hidden-scrollbar'>
            <table width="100%">
               <tr>
                  <td width="5%" align="right">Date</td>
                  <td width="8%">
                     <div id="date" name="date" value='<s:property value="date" />'></div>
                     <input type="hidden" id="hiddate" name="hiddate"  value='<s:property value="hiddate"/>'/>
                  </td>
                  <td width="5%" align="right">Currency</td>
                  <td width="8%">
                     <select id="currencyid" name="currencyid" onchange="getRates();" value='<s:property value="currencyid"/>'>
                        <option value="">--Select--</option>
                     </select>
                     <input type="hidden" id="hidcmbcurrencyid" name="hidcmbcurrencyid" value='<s:property value="hidcmbcurrencyid"/>'/>
                  </td>
                  <td width="5%" align="right">Rate</td>  
                  <td width="8%">
                     <input type="text" id="txtrate1" name="txtrate1" onchange="funCalc()" style="text-align:right" value='<s:property value="txtrate1"/>'/>
                  </td>
                  <td width="5%" align="right">Type</td>  
                  <td width="8%">
                     <select id="cmbvattype" name="cmbvattype">
                        <option value="LOCAL">LOCAL</option>
                        <option value="EXPORT">EXPORT</option>
                     </select>
                     <input type="hidden" id="hidcmbvattype" name="hidcmbvattype" value='<s:property value="hidcmbvattype"/>'>
                  </td>
                  <td width="5%" align="right">Start Date</td>
                  <td width="8%">
                     <div id="stdate" name="stdate" value='<s:property value="stdate" />'></div>
                     <input type="hidden" id="hidstdate" name="hidstdate"  value='<s:property value="hidstdate"/>'/>
                  </td>
                  <td width="5%" align="right">End Date</td>
                  <td width="8%">
                     <div id="enddate" name="enddate" value='<s:property value="enddate" />'></div>
                     <input type="hidden" id="hidenddate" name="hidenddate"  value='<s:property value="hidenddate"/>'/>
                  </td>
                  <td width="5%" align="right">Doc No</td>
                  <td width="10%"><input type="text" name="docno" value='<s:property value="docno" />' id="docno" tabindex="-1" readonly></td>
               </tr>
            </table>
            <table width="100%">
               <tr>
                  <td colspan="6">
                     <fieldset>
                        <legend>Client Details</legend>
                        <table width="100%" >
                           <tr>
                              <td width="5%" align="right">Client</td>
                              <td width="15%"><input type="text" name="txtclient" id="txtclient" style="width:97%;" placeholder="Press F3 for Search" onKeyDown="getclinfo(event);" value='<s:property value="txtclient" />'></td>
                              <td width="5%" align="right">Client Details</td>
                              <td width="25%"><input type="text" name="txtclientdet" id="txtclientdet" style="width:97%;" value='<s:property value="txtclientdet" />'></td>
                              <td width="5%" align="right">Tele.</td>
                              <td width="15%"><input type="text" name="txtmob1" id="txtmob1" style="width:97%;" value='<s:property value="txtmob1" />'></td>
                              <td width="5%" align="right">Mobile</td>
                              <td width="15%"><input type="text" name="txtmob2" id="txtmob2" style="width:97%;" value='<s:property value="txtmob2" />'>
                           </tr>
                           <tr>
                              <td width="5%" align="right">Sales Man</td>  
                              <td width="15%"><input type="text" name="txtsalman" id="txtsalman" style="width:97%;" value='<s:property value="txtsalman" />'></td>
                              <td width="5%"align="right">Mail</td>
                              <td width="15%"><input type="text" name="txtemail" id="txtemail" style="width:97%;"  value='<s:property value="txtemail" />'></td>
                              <td width="5%" align="right">Contact Person</td>
                              <td width="15%"><input type="text" name="txtcontact" id="txtcontact" placeholder="Press F3 for Search" style="width:97%;" onKeyDown="getcontact(event,0);" value='<s:property value="txtcontact" />'></td>
                           </tr>  
                        </table>
                     </fieldset>
                  </td>
               </tr>
            </table>
            <table width="100%">
               <tr>
                  <td>
                     <fieldset>
                        <legend>Services</legend>
                        <div id="seryeardiv">
                           <jsp:include page="serviceyearlyGrid.jsp"></jsp:include>
                        </div>
                     </fieldset>
                  </td>
               </tr>
               <tr>
                  <td>
                     <fieldset>
                        <legend>Service One time</legend>
                        <div id="seronediv">
                           <jsp:include page="serviceonetimeGrid.jsp"></jsp:include>
                        </div>
                     </fieldset>
                  </td>
               </tr>
               <tr>
                  <td>  
                     <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
                     <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
                     <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
                     <input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
                     <input type="hidden" id="cpersonid" name="cpersonid"  value='<s:property value="cpersonid"/>'/>
                     <input type="hidden" id="clientid" name="clientid"  value='<s:property value="clientid"/>'/>
                     <input type="hidden" id="salid" name="salid"  value='<s:property value="salid"/>'/>
                     <input type="hidden" id="seronelen" name="seronelen"  value='<s:property value="seronelen"/>'/>
                     <input type="hidden" id="seryearlen" name="seryearlen"  value='<s:property value="seryearlen"/>'/>
               </tr>
            </table>
         </div>
         <div id="currinfowindow">
            <div ></div>
         </div>
         <div id="clientsearch">
            <div ></div>
         </div>
         <div id="cpinfowindow">
            <div ></div>
         </div>
         <div id="printWindow">
            <div></div>
            <div></div>
         </div>
      </form>
   </div>
</body>
</html>