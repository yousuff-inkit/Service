<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
  		<%@page import="com.controlcentre.masters.dumpmaster.groups.ClsGroupsDAO"%>
   		<%
   		ClsGroupsDAO ClsGroupDAO= new ClsGroupsDAO();
   		%>    
<script type="text/javascript">

$(document).ready(function ()

		{     
	
	
	    document.getElementById("formdet").innerText="Group(GRP)";
		document.getElementById("formdetail").value="Group";
		document.getElementById("formdetailcode").value="GRP";
		window.parent.formCode.value="GRP";
		window.parent.formName.value="Group";

      		

		var data='<%=ClsGroupDAO.searchDetails()%>';  
		var source =
         {
             datatype: "json",
             datafields: [
                       	{name : 'docno' , type: 'int' },
  						{name : 'name', type: 'String'  },
                      	
                         ],
                         localdata: data,
             
             
             pager: function (pagenum, pagesize, oldpagenum) 
             {
                 // callback called when a page or page size is changed.
             }
         };
         
         var dataAdapter = new $.jqx.dataAdapter(source,
         		 {
             		loadError: function (xhr, status, error) 
             		{
	                   // alert(error);    
	                 }
		         }		
         ); 
         $("#jqxGroupSearch1").jqxGrid(
                 {
                 	width: '100%',
                 	height:310,
                     source: dataAdapter,
                     showfilterrow: true,
                     filterable: true,
                     selectionmode: 'singlerow',
                     sortable: true,
                     altrows:true,
                     //Add row method
                     columns: [
     					{ text: 'Doc No',filtertype: 'number', datafield: 'docno', width: '30%' },
     					{ text: 'Group Company', filtertype: 'input', datafield: 'name', width: '70%' },
     					
     	              ]
                 });

         $('#jqxGroupSearch1').on('rowdoubleclick', function (event) 
         		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		                document.getElementById("docno").value= $('#jqxGroupSearch1').jqxGrid('getcellvalue', rowindex1, "docno"); 
		                document.getElementById("txtname").value = $("#jqxGroupSearch1").jqxGrid('getcellvalue', rowindex1, "name");

		          });  
      		
      		
      });
    

    function funFocus()
     {
	  document.getElementById("txtname").focus();
     }

	
	function funReadOnly() {
		$('#txtname').attr('readonly', true);
		
	}
	
	function funRemoveReadOnly() {
		$('#txtname').attr('readonly', false);
		
	}
	
	function setValues()
	     {
			if($('#msg').val()!="")
			     {
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	      }
	
	$(function(){
	    $('#frmGroup').validate({
	             rules: {
	             txtname: {required:true,maxlength:200},
	            
	             },
	             messages: {
	              txtname:{required:" *",maxlength:"Max 200 Chars."},
	             
	             }
	    });});
	    
	function funNotify(){
		if(document.getElementById("txtname").value==''){
			document.getElementById("errormsg").innerText="Code is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		return 1;
	}
	
	function funChkButton() {
		  /* funReset(); */
		  }
		  
	/*function funSearchLoad(){
		changeContent('GroupSearch.jsp'); 
	 }*/
	function funExcelBtn(){
		 $("#jqxGroupSearch1").excelexportjs({
				containerid: "jqxGroupSearch1",
				datatype: 'json',
				dataset: null,
				gridId: "jqxGroupSearch1",
				columns: getColumns("jqxGroupSearch1") ,
				worksheetName:"Group Details"
			}); 	   }
 
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmGroup" action="saveGroup" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Group Details</legend>
<table width="100%">
  <tr>
   <td align="right">Group Company</td>
    <td><input type="text" name="txtname" id="txtname" placeholder="Group Company"   style="width:80%;" value='<s:property value="txtname"/>' ></td>
    <td width="11%" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  
 
</table>
</fieldset>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
</div>
<br/>
	<div id="jqxGroupSearch1"></div>
			
	  
	
</body>
</html>