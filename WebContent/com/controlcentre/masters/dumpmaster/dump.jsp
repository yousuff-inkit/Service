<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
  	<%@page import="com.controlcentre.masters.dumpmaster.dump.ClsDumpDAO"%>
   		<%ClsDumpDAO ClsDumpDAO= new ClsDumpDAO();%>
<script type="text/javascript">
 
$(document).ready(function ()

		{     
	
	
	    document.getElementById("formdet").innerText="Dump Site(DST)";
		document.getElementById("formdetail").value="Dump Site";
		document.getElementById("formdetailcode").value="DST";
		window.parent.formCode.value="DST";
		window.parent.formName.value="Dump Site";
			

		var data='<%=ClsDumpDAO.searchDetails()%>';
		var source =
         {
             datatype: "json",
             datafields: [
                       	{name : 'doc_no' , type: 'int' },
  						{name : 'name', type: 'String'  },
                       	{name : 'code', type: 'String'  },
                       	{name : 'cmbtype',type:'string'},
                        {name : 'typeid', type: 'String'  },

                       	
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
         $("#jqxDumpSearch1").jqxGrid(
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
     					{ text: 'code', filtertype: 'input', datafield: 'code', width: '30%' },
     					{ text: 'name', filtertype: 'input', datafield: 'name', width: '30%' ,},
     					{ text: 'Typeid', filtertype: 'input', datafield: 'typeid', width: '30%',hidden:'true' },

     					
     	              ]
                 });

         $('#jqxDumpSearch1').on('rowdoubleclick', function (event) 
         		{ 
		            	var rowindex1=event.args.rowindex;
		            	
		                document.getElementById("docno").value= $('#jqxDumpSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("txtcode").value = $("#jqxDumpSearch1").jqxGrid('getcellvalue', rowindex1, "code");
		                document.getElementById("txtname").value = $("#jqxDumpSearch1").jqxGrid('getcellvalue', rowindex1, "name");
			            $('#cmbtype').val($("#jqxDumpSearch1").jqxGrid('getcellvalue', rowindex1, "typeid")) ;

		          }); 
      		
      		
      });
    

    function funFocus()
     {
	  document.getElementById("txtcode").focus();
     }

	
	function funReadOnly() {
		$('#frmDump input').attr('readonly', true);
		$('#frmDump select').attr('disabled', true);

	}
	
	function funRemoveReadOnly() {
		$('#frmDump input').attr('readonly', false);
		$('#frmDump select').attr('disabled', false);

	}
	
	function setValues()
	     {
			if($('#msg').val()!="")
			     {
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	      }
	
	$(function(){
	    $('#frmDump').validate({
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
		changeContent('dumpSearch.jsp'); 
	 }*/
	function funExcelBtn(){
		 $("#jqxDumpSearch1").excelexportjs({
				containerid: "jqxDumpSearch1",
				datatype: 'json',
				dataset: null,
				gridId: "jqxDumpSearch1",
				columns: getColumns("jqxDumpSearch1") ,
				worksheetName:"Dump Details"
			}); 	   }
	 function getDumptype()
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
	      x.open("GET","getDumptype.jsp",true);
	     x.send();
	    
       }
 
</script>
</head>
<body onLoad="setValues();getDumptype();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmDump" action="saveDump" method="post" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>Dump Site Details</legend>
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
    <td width="11%" align="right">Dump Type</td>
    <td width="33%"><select name="cmbtype" id="cmbtype" style="width:97%;" value='<s:property value="cmbtype"/>' ><option></option></select></td>
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
	<div id="jqxDumpSearch1"></div>
			
	  
	
</body>
</html>