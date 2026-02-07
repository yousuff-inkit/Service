<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
  	<%@page import="com.controlcentre.masters.dumpmaster.skipmaster.ClsSkipmasterDAO"%>
   		<%ClsSkipmasterDAO ClsSkipmasterDAO= new ClsSkipmasterDAO();%>
<script type="text/javascript">

$(document).ready(function ()

		{     
	
	
	    document.getElementById("formdet").innerText="Skip Master(SKM)";
		document.getElementById("formdetail").value="Skip Master";
		document.getElementById("formdetailcode").value="SKM";
		window.parent.formCode.value="SKM";
		window.parent.formName.value="Skip Master";

      		

		var data='<%=ClsSkipmasterDAO.searchDetails()%>';
		var source =
         {
             datatype: "json",
             datafields: [
                       	{name : 'doc_no' , type: 'int' },
  						{name : 'name', type: 'String'  },
                       	{name : 'code', type: 'String'  },
                       	{name : 'cmbtype',type:'string'},
                       	{name : 'typeid',type:'string'},

                       	
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
         $("#jqxSkipmasterSearch1").jqxGrid(
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
     					{ text: 'Type', filtertype: 'input', datafield: 'cmbtype', width: '30%' },
     					{ text: 'Code', filtertype: 'input', datafield: 'code', width: '30%' },
     					{ text: 'Name', filtertype: 'input', datafield: 'name', width: '30%' },
     					{ text: 'TypeId', filtertype: 'input', datafield: 'typeid', width: '30%',hidden:'true' },

     					
     	              ]
                 });

         $('#jqxSkipmasterSearch1').on('rowdoubleclick', function (event) 
         		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		                document.getElementById("docno").value= $('#jqxSkipmasterSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("txtcode").value = $("#jqxSkipmasterSearch1").jqxGrid('getcellvalue', rowindex1, "code");
		                document.getElementById("txtname").value = $("#jqxSkipmasterSearch1").jqxGrid('getcellvalue', rowindex1, "name");
		              $('#cmbtype').val($("#jqxSkipmasterSearch1").jqxGrid('getcellvalue', rowindex1, "typeid")) ;

		          }); 
      		
      		
      });
    

    function funFocus()
     {
	  document.getElementById("txtcode").focus();
     }

	
	function funReadOnly() {
		$('#frmSkipmaster input').attr('readonly', true);
		$('#docno').attr('readonly', true);
		$('#txtcode').attr('readonly', true);
		$('#txtname').attr('readonly', true);
		$('#frmSkipmaster select').attr('disabled', true);

	}
	
	function funRemoveReadOnly() {
		$('#frmSkipmaster input').attr('readonly', false);
		$('#docno').attr('readonly', true);
		$('#txtcode').attr('readonly', false);
		$('#txtname').attr('readonly', false);
		$('#frmSkipmaster select').attr('disabled', false);


	}
	
	function setValues()
	     {
			if($('#msg').val()!="")
			     {
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	      }
	
	$(function(){
	    $('#frmSkipmaster').validate({
	             rules: {
	             txtcode: {required:true,maxlength:10},
	             txtname: {required:true,maxlength:200},
	             cmbtype:{required:true},
	            
	             },
	             messages: {
	              txtcode:{required:" *",maxlength:"Max 10 Chars."},
	              txtname:{required:" *",maxlength:"Max 200 Chars."},
	              cmbtype:{required:" *"},
	             
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
		changeContent('skipmasterSearch.jsp'); 
	 }*/
	function funExcelBtn(){
		 $("#jqxSkipmasterSearch1").excelexportjs({
				containerid: "jqxSkipmasterSearch1",
				datatype: 'json',
				dataset: null,
				gridId: "jqxSkipmasterSearch1",
				columns: getColumns("jqxSkipmasterSearch1") ,
				worksheetName:"Skip Master Details"
			}); 
	 }
	 function getSkiptype()
	 {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
			 	items=items.split('***');
		        var typeItems=items[0].split(",");
		        var typeidItems=items[1].split(",");
		        	var optionstype = '<option value="">--Select--</option>';
		        for ( var i = 0; i < typeItems.length; i++) {
		    	   optionstype += '<option value="' + typeidItems[i] + '">' + typeItems[i] + '</option>';
		        }
		         $("select#cmbtype").html(optionstype);
		         //alert($('#hidcmbcurr').val());
			     $('#cmbtype').val($('#hidcmbtype').val()) ;
				   // alert($('#cmbcurr').val());
			   

			    }
		       else
			  {
			  }
	     }
	      x.open("GET","getSkiptype.jsp",true);
	     x.send();
	    
       }
 
</script>
</head>
<body onLoad="setValues();getSkiptype();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSkipmaster" action="saveSkipmaster" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Skip Master Details</legend>
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
    <td width="11%" align="right">Skip Size</td>
    <td width="33%"><select name="cmbtype" id="cmbtype"  value='<s:property value="cmbtype"/>' style="width:97%;" ><option></option></select></td>
    <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
    
  </tr>
 
</table>
</fieldset>

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
</div>
<br/>
	<div id="jqxSkipmasterSearch1"></div>
			
	  
	
</body>
</html>