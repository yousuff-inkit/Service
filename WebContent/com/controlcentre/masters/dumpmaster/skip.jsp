<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
  		<%@page import="com.controlcentre.masters.dumpmaster.skip.ClsSkipDAO"%>
   		<%ClsSkipDAO ClsSkipDAO= new ClsSkipDAO();%>
<script type="text/javascript">

$(document).ready(function ()

		{     
	
	
	    document.getElementById("formdet").innerText="Skip Size(SKT)";
		document.getElementById("formdetail").value="Skip Size";
		document.getElementById("formdetailcode").value="SKT";
		window.parent.formCode.value="SKT";
		window.parent.formName.value="Skip Size";
      		

		var data='<%=ClsSkipDAO.searchDetails()%>';
		var source =
         {
             datatype: "json",
             datafields: [
                       	{name : 'doc_no' , type: 'int' },
  						{name : 'name', type: 'String'  },
                       	{name : 'code', type: 'String'  },
                       	{name : 'techspec',type:'string'},
                       	
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
         $("#jqxSkipSearch1").jqxGrid(
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
     					{ text: 'code', filtertype: 'input', datafield: 'code', width: '30%' },
     					{ text: 'name', filtertype: 'input', datafield: 'name', width: '30%' ,},
     					{ text: 'Technical Specification', filtertype: 'input', datafield: 'techspec', width: '30%' },
     					
     	              ]
                 });

         $('#jqxSkipSearch1').on('rowdoubleclick', function (event) 
         		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		                document.getElementById("docno").value= $('#jqxSkipSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("txtcode").value = $("#jqxSkipSearch1").jqxGrid('getcellvalue', rowindex1, "code");
		                document.getElementById("txtname").value = $("#jqxSkipSearch1").jqxGrid('getcellvalue', rowindex1, "name");
		                document.getElementById("txttechspec").value = $("#jqxSkipSearch1").jqxGrid('getcellvalue', rowindex1, "techspec");
		          }); 
      		
      		
      });
    

    function funFocus()
     {
	  document.getElementById("txtcode").focus();
     }

	
	function funReadOnly() {
		$('#frmSkip input').attr('readonly', true);
		

	}
	
	function funRemoveReadOnly() {
		$('#frmSkip input').attr('readonly', false);
		

	}
	
	function setValues()
	     {
			if($('#msg').val()!="")
			     {
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	      }
	
	$(function(){
	    $('#frmSkip').validate({
	             rules: {
	             txtcode: {required:true,maxlength:10},
	             txtname: {required:true,maxlength:200},
	             txttechspec:{required:true},
	            
	             },
	             messages: {
	              txtcode:{required:" *",maxlength:"Max 10 Chars."},
	              txtname:{required:" *",maxlength:"Max 200 Chars."},
	              txttechspec:{required:" *"},
	             
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
		changeContent('skipSearch.jsp'); 
	 }*/
	function funExcelBtn(){
		 $("#jqxSkipSearch1").excelexportjs({
				containerid: "jqxSkipSearch1",
				datatype: 'json',
				dataset: null,
				gridId: "jqxSkipSearch1",
				columns: getColumns("jqxSkipSearch1") ,
				worksheetName:"Skip Details"
			}); 
	   }
 
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSkip" action="saveSkip" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Skip Size Details</legend>
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
    <td width="11%" align="right">Technical Specification</td>
    <td width="33%"><input type="text" name="txttechspec" id="txttechspec"  placeholder="Technical Specification" style="width:80%;" value='<s:property value="txttechspec"/>'  ></td>
  </tr>
 
</table>
</fieldset>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
</div>
<br/>
	<div id="jqxSkipSearch1"></div>
			
	  
	
</body>
</html>