<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<%@page import="com.operations.clientrelations.clientsubcategory.ClsClientSubCategoryDAO"%>
<% ClsClientSubCategoryDAO DAO= new ClsClientSubCategoryDAO(); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
    
	/* Grid */
	 var data= '<%= DAO.category() %>'; 
	 $(document).ready(function () {
		 getCategory();
		
		 
	     var source =
	     {
	         datatype: "json",
	         datafields: [
	        	       
					    {name : 'category', type: 'String'  },
	                   	{name : 'subcategory', type: 'String'  },
	                	{name : 'catid', type: 'String'  },
	                	{name : 'subcatid', type: 'String'  }
	                	
	          ],
	        localdata: data, 
	         
	         pager: function (pagenum, pagesize, oldpagenum) {
	             // callback called when a page or page size is changed.
	         }
	     };
	     var dataAdapter = new $.jqx.dataAdapter(source,
	     		 {
	         		loadError: function (xhr, status, error) {
	                 alert(error);    
	                 }
		            }		
	     );
	     
	     $("#jqxCategorySearch1").jqxGrid(
	             {
	             	 width: '70%',
	                 height: 375,
	                 source: dataAdapter,
	                 showfilterrow: true,
	                 filterable: true,
	                 selectionmode: 'singlerow',
	                 
	                 columns: [  
	                	     { text: 'Doc No', datafield: 'subcatid', width: '10%' },
	 						 { text: 'Category', datafield: 'category', width: '45%' },
	 						 { text: 'Sub Category', datafield: 'subcategory', width: '45%' },
	 						 { text: 'Catid', datafield: 'catid', hidden: true, width: '10%' },
	 						 
	 						
	 	              ]
	             });
	     $('#jqxCategorySearch1').on('rowdoubleclick', function (event) {
	         var rowindex1=event.args.rowindex;
	         document.getElementById("cmbcategory").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "catid");
	         document.getElementById("cmbsubcategory").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "subcategory");
	         document.getElementById("docno").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "subcatid");
	        
	     }); 
	});
 
    
  function funReadOnly() {
		 $('#frmClientSubCategory input').attr('readonly', true); 
		 $('#frmClientSubCategory select').attr('disabled', false); 
		
	} 
	
	function funRemoveReadOnly() {
		$('#frmClientSubCategory input').attr('readonly', false);
		$('#frmClientSubCategory select').attr('disabled', false);
		 $('#docno').attr('readonly', true); 
	} 
	
	 function funNotify(){
		 
		 var category=document.getElementById("cmbcategory").value;
		 if(category==""){
			 document.getElementById("errormsg").innerText="Please Select Category!!!";
			 return 0;
		 }
		 
		 var subcategory=document.getElementById("cmbsubcategory").value;
		 if(subcategory==""){
			 document.getElementById("errormsg").innerText="Please Select Sub Category!!!";
			 return 0;
		 }
		   return 1;
	} 
	 
	
	 function funSearchLoad(){
	   changeContent('categoryMainSearchGrid.jsp');  
	}
	  function funFocus()
	 {
		document.getElementById("cmbcategory").focus();
	 }  
	
 function setValues(){
		if($('#hidcmbcategory').val()!=""){
			document.getElementById("cmbcategory").value=document.getElementById("hidcmbcategory").value;
		}
		
		/* document.getElementById("docno").value=""; */
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 
	} 
	
	function getCategory() {
		 
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var categoryItems = items[0].split(",");
				var categoryIdItems = items[1].split(",");
				var optionscategory = '<option value="">--Select--</option>';
				for (var i = 0; i < categoryItems.length; i++) {
					optionscategory += '<option value="' + categoryIdItems[i] + '">'
							+ categoryItems[i] + '</option>';
				}
				$("select#cmbcategory").html(optionscategory);
				if ($('#hidcmbcategory').val() != null) {
					$('#cmbcategory').val($('#hidcmbcategory').val());
					 
				}
			} else {
			}
			 
			
		}
		x.open("GET", "getCategory.jsp", true);
		x.send();
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
<form id="frmClientSubCategory" action="saveClientSubCategory" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset> 
<legend>Category Master</legend>
<table width="100%">   
  <tr>                
  <td width="4%" align="right">Category</td>
    <td  width="10%"><select id="cmbcategory" name="cmbcategory" style="width:100%;"   value='<s:property value="cmbcategory"/>'>
    <option value="">--Select--</option>
    </select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td>
      
     <td width="5%" align="right">Sub Category</td>
    <td width="20%"><input type="text" id="cmbsubcategory" name="cmbsubcategory" style="width:95%;" value='<s:property value="cmbsubcategory"/>'></td>
     <td width="5%" align="right">Doc No.</td>
    <td width="14%"><input type="text" id="docno" readonly name="docno" style="width:65%;" tabindex="-1" value='<s:property value="docno"/>'/></td>
       <td>&nbsp;</td>
    </tr>
</table>
</fieldset><br/>
<div id="jqxCategorySearch1"></div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

</div>
</form>
</div>
</body>
</html>