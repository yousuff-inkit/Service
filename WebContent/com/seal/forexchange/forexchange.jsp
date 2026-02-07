<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 

<script type="text/javascript">
      $(document).ready(function () {
    	  $('#btnEdit').attr({'disabled':true});
    	  $('#btnDelete').attr({'disabled':true});  
    	  /* Date */
    	  $("#forexDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  $("#forexAdjstDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  $("#forexAdjstDate").on('valueChanged', function (event) {
   		   $("#jqxForExchange").jqxGrid('clear');
   		});
      }); 
	 function funReadOnly(){
			$('#forexExchangeMaster input').attr('readonly', true );
			$('#forexExchangeMaster select').attr('disabled', true);
			$('#forexDate').jqxDateTimeInput({disabled: true});
			$('#forexAdjstDate').jqxDateTimeInput({disabled: true});
			$("#jqxForExchange").jqxGrid({disabled: true}); 
			$('#btnreload').attr({'disabled':true}); 
	 }
	 
	 function funRemoveReadOnly(){      
			$('#forexExchangeMaster input').attr('readonly', false );   
			$('#forexExchangeMaster select').attr('disabled', false);
			$('#forexDate').jqxDateTimeInput({disabled: false});
			$('#forexAdjstDate').jqxDateTimeInput({disabled: false});
			$("#jqxForExchange").jqxGrid({disabled: false}); 
			$('#docno').attr('readonly', true);  
			
			if ($("#mode").val() == "A") {
					 $('#forexDate').val(new Date());
					 $('#forexAdjstDate').val(new Date());
					 funReload();
					 $('#btnreload').attr({'disabled':false});  
			}
			
	 }
	 function funNotify(){	
		 $('#jqxForExchange').jqxGrid('clearfilters');
		 var selectedrows = $("#jqxForExchange").jqxGrid('selectedrowindexes');
		 selectedrows = selectedrows.sort(function(a,b){return a - b});

		 if(selectedrows.length==0){
			 document.getElementById("errormsg").innerText="Please select a document!";         
			 return 0;  
		 }else{
			 document.getElementById("errormsg").innerText="";  
		 }
		 var chk="";
		 var len=0;
		 for (var i = 0; i < selectedrows.length; i++) {    
			 chk = $('#jqxForExchange').jqxGrid('getcellvalue', selectedrows[i], "doc_no"); 
			 if(typeof(chk)!="undefined" && typeof(chk)!="NaN" && chk!="" && chk!="0"  && chk!=null){        
				 newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "det"+len)
			       .attr("name", "det"+len)  
			       .attr("hidden", "true");  
				 
				 newTextBox.val($('#jqxForExchange').jqxGrid('getcellvalue', selectedrows[i], "doc_no")+" :: "+$('#jqxForExchange').jqxGrid('getcellvalue', selectedrows[i], "difference")+" :: ");     
				 newTextBox.appendTo('form');  
				 len++;  
			 }  
		 } 
		 $('#gridlength').val(len);  
console.log("IN NOTIFY");		 
	     return 1;	
		} 
	 
	 function funReload(){
         $("#forexDiv").load("forexchangeGrid.jsp?id=1");   
	 }
	 
	 function loadGrid(){  
		 var adjdate = $('#forexAdjstDate').val();   
		 $("#forexDiv").load("forexchangeGrid.jsp?adjdate="+adjdate+"&id=2");       
	 }
	 
	 function funSearchLoad(){
		 changeContent('masterSearch.jsp');   
     }
	 
	 function funFocus(){
	    	$('#forexDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		 
			 if($('#hidfrxDate').val()){
				 $("#forexDate").jqxDateTimeInput('val', $('#hidfrxDate').val());
			  }
			 if($('#hidAdjDate').val()){   
				 $("#forexAdjstDate").jqxDateTimeInput('val', $('#hidAdjDate').val());
			  }
			 
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			 var docno = $("#docno").val();
			 if(parseInt(docno)>0){
				   var masterdocno = $("#masterdoc_no").val();  
				   $("#forexDiv").load("forexchangeGrid.jsp?docno="+masterdocno+"&id=1");             
			 }
			  
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			 funSetlabel();
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
	 
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="forexExchangeMaster" action="saveFrExchngeMaster" method="post" autocomplete="off">
<jsp:include page="../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar'>
<fieldset style="background: #E8DEF7;">
<table width="99%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="15%"><div id="forexDate" name="forexDate" value='<s:property value="forexDate"/>'></div>
    <input type="hidden" id="hidfrxDate" name="hidfrxDate" value='<s:property value="hidfrxDate"/>'/></td>
    <td width="13%" align="right">Adjust Date</td>
    <td width="17%"><div id="forexAdjstDate" name="forexAdjstDate" value='<s:property value="forexAdjstDate"/>'></div>     
        <input type="hidden" id="hidAdjDate" name="hidAdjDate" value='<s:property value="hidAdjDate"/>'/></td>
    <td width="15%" align="right">Doc No </td>
    <td width="7%"><input type="text" id="docno" name="docno" style="width:77%;" tabindex="-1" value='<s:property value="docno"/>'/></td>  
  </tr>

  <tr>
    <td width="5%" align="right">Remarks</td>      
    <td width="15%" colspan="4"><input type="text" id="txtremarks" name="txtremarks" style="width:93.3%;" value='<s:property value="txtremarks"/>'/></td>
      <td align="center"><input type="button" name="btnreload" id="btnreload" class="myButton" value="Submit" onclick="loadGrid();"></td>
  </tr>
</table>
</fieldset>
<table width="100%" >
<tr>
<td><div id="forexDiv"><jsp:include page="forexchangeGrid.jsp"></jsp:include></div></td>
</tr>
</table>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>  
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>  
<input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>     
</div>
</form>
<div id="accountDetailsWindow">
   <div></div>
</div>

</div>
</body>
</html>
