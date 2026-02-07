<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
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
<style>
form label.error {
color:red;
  font-weight:bold;

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

 


 $(document).ready(function () {
	 
   	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});   
   	 
   
 
 $('#sidesearchwndow').jqxWindow({ width: '60%', height: '65%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 250, y: 80 }, keyboardCloseKey: 27});
 $('#sidesearchwndow').jqxWindow('close');   
 
 
 
 $('#branchwindow').jqxWindow({ width: '30%', height: '50%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 700, y:  80 }, keyboardCloseKey: 27});
 $('#branchwindow').jqxWindow('close');   
 
 
 $('#locationwindow').jqxWindow({ width: '30%', height: '50%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 750, y: 80 }, keyboardCloseKey: 27});
 $('#locationwindow').jqxWindow('close');   
  
	

		
	});
         
       
          function SearchContent(url) {
          	 //alert(url);
          		$.get(url).done(function (data) {
          		$('#sidesearchwndow').jqxWindow('open');
          		$('#sidesearchwndow').jqxWindow('setContent', data);
          
          	}); 
          	} 
    
      
          
          function branchSearchContent(url) {
           	 //alert(url);
           		$.get(url).done(function (data) {
           		$('#branchwindow').jqxWindow('open');
           		$('#branchwindow').jqxWindow('setContent', data);
           
           	}); 
           	} 
     
          
          function locationSearchContent(url) {
           	 //alert(url);
           		$.get(url).done(function (data) {
           		$('#locationwindow').jqxWindow('open');
           		$('#locationwindow').jqxWindow('setContent', data);
           
           	}); 
           	} 
     
         
          
    function funReset(){
	 
	}
	function funReadOnly(){
		$('#frmprdopn input').attr('readonly', true );
		$('#frmprdopn textarea').attr('readonly', true );
		$('#frmprdopn select').attr('disabled', true);

		$('#date').jqxDateTimeInput({ disabled: true});
		 
		$("#purchasedetails").jqxGrid({ disabled: true});
		
		 
	
	}
	function funRemoveReadOnly(){
		

		
		
		$('#frmprdopn input').attr('readonly', false );
		$('#frmprdopn textarea').attr('readonly', false );
		$('#frmprdopn select').attr('disabled', false);
	
		$('#date').jqxDateTimeInput({ disabled: false});
	 
		$("#purchasedetails").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		if ($("#mode").val() == "A") {
			$('#date').val(new Date());
 
			 $("#purchasedetails").jqxGrid('clear');
			  $("#purchasedetails").jqxGrid('addrow', null, {});
			    
			     
				 
		
		}
		
		
	}
	 
	
 
	
	
	
	function funNotify(){	
 
		
		
		
 		 var rows = $("#purchasedetails").jqxGrid('getrows');
		    $('#gridlenght').val(rows.length);
		   
		   for(var i=0 ; i < rows.length ; i++){
		 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "reqtest"+i)
		       .attr("name", "reqtest"+i)   
		    .attr("hidden", "true"); 
		    
		 
		    newTextBox.val(rows[i].psrno+"::"+rows[i].qty+" :: "+rows[i].specid+" :: "+rows[i].costprice+" :: "+rows[i].brhid+" :: "+rows[i].locid+" :: "+rows[i].psrno);
		
		   newTextBox.appendTo('form');
		  
		    
		   }   
		
		return 1;
	} 

 
	function funSearchLoad(){

		 changeContent('mainsearch.jsp?'); 
	}
 
		 
	function funFocus(){
		 
	   	$('#date').jqxDateTimeInput('focus'); 	    		
	} 
	 
	function setValues() {
		
		
		 $("#btnEdit").attr('disabled', true );
		 $("#btnDelete").attr('disabled', true ); 
		if($('#hiddate').val()){
			$("#date").jqxDateTimeInput('val', $('#hiddate').val());
		}
		 
   	 	 var docVal1 = document.getElementById("masterdoc_no").value;
  	  
      	if(docVal1>0)
      		{
       
      	
		 var indexVal2 = document.getElementById("masterdoc_no").value;
		 

     	  
         $("#prdgriddiv").load("prdgrid.jsp?reqdoc="+indexVal2);
			 
      		}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
 
	 
      	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
		
		
	}
	
    function funPrintBtn(){
  	    
  	}
    
    


	
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmprdopn" action="savePrdopnData" autocomplete="OFF" >     

<jsp:include page="../../../../header.jsp"></jsp:include><br/>
<br>
<fieldset>

<table width="100%" >                        
  <tr>
    <td width="5%" align="right">Date</td>  
    <td   width="6%"><div id='date' name='date' value='<s:property value="date"/>'></div> 
                     <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
                     
              
    <td width="32%" align="right">Doc No</td>
    <td width="33%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>
    
    <%--  <td   align="right">Description</td>  <td> <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/> </td>
     --%>
  </tr>
  
   
</table>    
     
</fieldset>    
  
<br/>
<fieldset>
<div id="prdgriddiv">  <jsp:include page="prdgrid.jsp"></jsp:include></div>
 </fieldset>
   <input type="hidden" id="refno" name="refno" value='<s:property value="refno"/>'  />
 <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' /> 
 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />

  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
 
 <input type="hidden" name="gridlenght" id="gridlenght" value='<s:property value="gridlenght"/>' />   
 
 
 
 

</form>

	 <div id="sidesearchwndow">
	   <div ></div>
	</div>

 <div id="branchwindow">
   <div ></div>
</div>
<div id="locationwindow">
   <div ></div>
</div>
 

</div>
</body>
</html>