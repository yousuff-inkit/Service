<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
  		<%@page import="com.controlcentre.masters.dumpmaster.waste.ClsWasteDAO"%>
   		<%ClsWasteDAO ClsWasteDAO= new ClsWasteDAO();%> 
<script type="text/javascript">

$(document).ready(function ()

		{     
	
	
	    document.getElementById("formdet").innerText="Waste Type(WST)";
		document.getElementById("formdetail").value="Waste Type";
		document.getElementById("formdetailcode").value="WST";
		window.parent.formCode.value="WST";
		window.parent.formName.value="Waste Type";

      		

		var data='<%=ClsWasteDAO.searchDetails()%>'; 
		var source =
         {
             datatype: "json",
             datafields: [
                       	{name : 'doc_no' , type: 'int' },
  						{name : 'name', type: 'String'  },
                       	{name : 'code', type: 'String'  },
                       	{name : 'desc1',type:'string'},

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
         $("#jqxWasteSearch1").jqxGrid(
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
     					{ text: 'Description', filtertype: 'input', datafield: 'desc1', width: '30%' },

     	              ]
                 });

         $('#jqxWasteSearch1').on('rowdoubleclick', function (event) 
         		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		              var docno=  document.getElementById("docno").value= $('#jqxWasteSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("txtcode").value = $("#jqxWasteSearch1").jqxGrid('getcellvalue', rowindex1, "code");
		                document.getElementById("txtname").value = $("#jqxWasteSearch1").jqxGrid('getcellvalue', rowindex1, "name");
		                document.getElementById("txtdesc").value = $("#jqxWasteSearch1").jqxGrid('getcellvalue', rowindex1, "desc1");
		   	         $("#wastedetdiv").load("wastedetails.jsp?docno="+docno);  

		          }); 
      		
      		
      });
    

    function funFocus()
     {
	  document.getElementById("txtcode").focus();
     }

	
	function funReadOnly() {
		$('#frmWaste input').attr('readonly', true);
		$("#wastedetGrid").jqxGrid({ disabled: true});

	}
	
	function funRemoveReadOnly() {
		$('#frmWaste input').attr('readonly', false);
		$("#wastedetGrid").jqxGrid({ disabled: false});
		if ($("#mode").val() == "A") {
			$("#wastedetGrid").jqxGrid('clear');
			$("#wastedetGrid").jqxGrid('addrow', null, {});
		
		}
		if ($("#mode").val() == "E") {
			$("#wastedetGrid").jqxGrid('addrow', null, {});

		}
	}
	
	function setValues()
	     {
			if($('#msg').val()!="")
			     {
				   $.messager.alert('Message',$('#msg').val());
				  }
			var docno=$('#docno').val();
  	         $("#wastedetdiv").load("wastedetails.jsp?docno="+docno);  

	      }
	
	$(function(){
	    $('#frmWaste').validate({
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
		 var rows1 = $("#wastedetGrid").jqxGrid('getrows');
		 $('#wastelen').val(rows1.length);
		 for(var i=0 ; i < rows1.length ; i++){
			   
			   newTextBox = $(document.createElement("input"))
			      .attr("type", "dil")
			      .attr("id", "wasteg"+i)
			      .attr("name", "wasteg"+i)
			      .attr("hidden", "true");
			   
			  newTextBox.val(rows1[i].srno+" :: "+rows1[i].wastename+" :: "+rows1[i].typeid+" :: ");
			  
			  newTextBox.appendTo('form');
			  }
	
		
		
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
		changeContent('wasteSearch.jsp'); 
	 }*/
	function funExcelBtn(){
		 $("#jqxWasteSearch1").excelexportjs({
				containerid: "jqxWasteSearch1",
				datatype: 'json',
				dataset: null,
				gridId: "jqxWasteSearch1",
				columns: getColumns("jqxWasteSearch1") ,
				worksheetName:"Waste Details"
			}); 	
	 }
 
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmWaste" action="saveWaste" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Waste Type Details</legend>
<table width="100%">
  <tr>
   <td align="right">Code</td>
    <td><input type="text" name="txtcode" id="txtcode" placeholder="Code" value='<s:property value="txtcode"/>' >
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
      Doc No.
    <input type="text" id="docno" name="docno"  value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  <td rowspan="24">
  
  <fieldset>
    
<div id="wastedetdiv">
  <jsp:include page="wastedetails.jsp"></jsp:include></div>   
 
</fieldset>
  </td>
  </tr>
  <tr>
    <td width="4%" align="right">Name</td>
    <td width="40%"><input type="text" name="txtname" id="txtname" placeholder="Name" style="width:99%;" value='<s:property value="txtname"/>' ></td>
    </tr>
    <tr>
    <td  align="right">Description</td>
    <td width="40%"><input type="text" name="txtdesc" id="txtdesc"  placeholder="Description" style="width:99%;" value='<s:property value="txtdesc"/>' ></td>
  </tr>
 <tr>
 <td >
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td >
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td >
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td >
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td >
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td >
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr><tr>
 <td >
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
 <tr>
 <td width="4%">
 </td>
 </tr>
</table>
</fieldset>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="wastelen" name="wastelen"  value='<s:property value="msg"/>'/>

</form>
</div>
<br/>
	<div id="jqxWasteSearch1"></div>
			
	  
	
</body>
</html>