<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
  		<%@page import="com.controlcentre.masters.dumpmaster.spec.ClsSpecDAO"%>
   		<%ClsSpecDAO ClsSpecDAO= new ClsSpecDAO();%>    
<script type="text/javascript">

$(document).ready(function ()

		{     
	
	
	    document.getElementById("formdet").innerText="Spec(SPC)";
		document.getElementById("formdetail").value="Spec";
		document.getElementById("formdetailcode").value="SPC";
		window.parent.formCode.value="SPC";
		window.parent.formName.value="Spec";

      		

		var data='<%=ClsSpecDAO.searchDetails()%>'; 
		var source =
         {
             datatype: "json",
             datafields: [
                       	{name : 'doc_no' , type: 'int' },
  						{name : 'name', type: 'String'  },
                       	{name : 'code', type: 'String'  },
                       	{name : 'description',type:'string'},
                       	
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
         $("#jqxSpecSearch1").jqxGrid(
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
     					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
     					{ text: 'Code', filtertype: 'input', datafield: 'code', width: '30%' },
     					{ text: 'Name', filtertype: 'input', datafield: 'name', width: '30%' },
     					{ text: 'Description', filtertype: 'input', datafield: 'description', width: '30%' },
     					
     	              ]
                 });

         $('#jqxSpecSearch1').on('rowdoubleclick', function (event) 
         		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		                document.getElementById("docno").value= $('#jqxSpecSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("txtcode").value = $("#jqxSpecSearch1").jqxGrid('getcellvalue', rowindex1, "code");
		                document.getElementById("txtname").value = $("#jqxSpecSearch1").jqxGrid('getcellvalue', rowindex1, "name");
		                document.getElementById("txtdesc").value = $("#jqxSpecSearch1").jqxGrid('getcellvalue', rowindex1, "description");

		          }); 
      		
      		
      });
    

    function funFocus()
     {
	  document.getElementById("txtcode").focus();
     }

	
	function funReadOnly() {
		$('#frmSpec input').attr('readonly', true);
		
	}
	
	function funRemoveReadOnly() {
		$('#frmSpec input').attr('readonly', false);
		
	}
	
	function setValues()
	     {
			if($('#msg').val()!="")
			     {
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	      }
	
	$(function(){
	    $('#frmSpec').validate({
	             rules: {
	             txtcode: {required:true,maxlength:10},
	             txtname: {required:true,maxlength:200},
	             txtdesc:{required:true},
	            
	             },
	             messages: {
	              txtcode:{required:" *",maxlength:"Max 10 Chars."},
	              txtname:{required:" *",maxlength:"Max 200 Chars."},
	              txtdesc:{required:" *"},
	             
	             }
	    });});
	    
	function funNotify(){
		if(document.getElementById("txtcode").value==''){
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
		changeContent('specSearch.jsp'); 
	 }*/
	function funExcelBtn(){
		 $("#jqxSpecSearch1").excelexportjs({
				containerid: "jqxSpecSearch1",
				datatype: 'json',
				dataset: null,
				gridId: "jqxSpecSearch1",
				columns: getColumns("jqxSpecSearch1") ,
				worksheetName:"Spec Details"
			}); 	   }
 
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSpec" action="saveSpec" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Spec Details</legend>
<table width="100%">
  <tr>
   <td align="right">Code</td>
    <td><input type="text" name="txtcode" id="txtcode" placeholder="Code" value='<s:property value="txtcode"/>' ></td>
    <td width="11%" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td width="11%" align="right">Name</td>
    <td width="33%"><input type="text" name="txtname" id="txtname" placeholder="Name" style="width:80%;" value='<s:property value="txtname"/>' ></td>
    <td width="11%" align="right">Description</td>
    <td width="33%"><input type="text" name="txtdesc" id="txtdesc"  placeholder="Description" style="width:80%;" value='<s:property value="txtdesc"/>' ></td>
  </tr>
 
</table>
</fieldset>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
</div>
<br/>
	<div id="jqxSpecSearch1"></div>
			
	  
	
</body>
</html>