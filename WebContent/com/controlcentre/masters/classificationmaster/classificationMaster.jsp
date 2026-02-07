<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%@page import="com.controlcentre.masters.classificationmaster.ClsclassificationMasterDAO"%>
<%ClsclassificationMasterDAO DAO= new ClsclassificationMasterDAO(); %>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}

#grid{
	width: 100%;
}
</style>
<script type="text/javascript">
      $(document).ready(function () { 
    	  $('#btnSearch').attr('disabled', true);
    	  $("#csmdate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
     
    	  /*   document.getElementById("formdet").innerText="ClassificationMaster(CMT)";
			document.getElementById("formdetail").value="Classification Master";
			document.getElementById("formdetailcode").value="CMT";
			window.parent.formCode.value="CMT";
			window.parent.formName.value="ClassificationMaster"; */
          var data= '<%=DAO.classificationMasterLoad(session)%>';
              
              var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                	  			
                            	{name : 'doc_no' , type: 'int' },
                            	{name : 'csdoc_no' , type: 'int' },
       							{name : 'name', type: 'String'  },
                            	{name : 'date', type: 'date'  },
                            	{name : 'description',type:'String'}
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
      


              $("#jqxCategory").jqxGrid(
                      {
                      	  width: '85%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'singlerow',
                        //  pagermode: 'default',
                          sortable: true,
                          //pageable: true,
                          altrows:true,
                          //Add row method
                          columns: [
          					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '20%' },
          					{ text: 'csDoc No',filtertype: 'number', datafield: 'csdoc_no', width: '20%', hidden:true },          					
          					/* { text: 'Brand ID',columntype: 'textbox', filtertype: 'input', datafield: 'brandid', width: '30%' }, */
          					{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
          					{ text: 'Date',columntype: 'textbox',filtertype: 'input',hidden:true,datafield:'date',width: '15%',cellsformat:'dd.MM.yyyy'},
          					{ text: 'description',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '50%' },

          	              ]
                      });

              $('#jqxCategory').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;
  		            	 $('#frmsubCategory select').attr('disabled', false);
  		                document.getElementById("docno").value= $('#jqxCategory').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		                document.getElementById("csmname").value = $('#jqxCategory').jqxGrid('getcellvalue', rowindex1, "csdoc_no");
  		              	document.getElementById("desc").value=$('#jqxCategory').jqxGrid('getcellvalue', rowindex1,"description");
  		    			$('#csmdate').jqxDateTimeInput({disabled: false});
  		                $("#csmdate").jqxDateTimeInput('val',$("#jqxCategory").jqxGrid('getcellvalue', rowindex1, "date"));
  		                $('#frmsubCategory select').attr('disabled', true);
  		    			$('#csmdate').jqxDateTimeInput({disabled: true});
              		 }); 
              $("#jqxCategory").jqxGrid('hidecolumn', 'brandid'); 
              //$("#jqxModelSearch").jqxGrid('hidecolumn', 'brandid'); 

          });
    
      function funSearchLoad(){
			changeContent('modelSearch.jsp', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmsubCategory input').attr('readonly', true);
		$('#frmsubCategory select').attr('disabled', true);
		$('#csmdate').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		
	}
	function funRemoveReadOnly() {
		$('#frmsubCategory input').attr('readonly', false);
		$('#frmsubCategory select').attr('disabled', false);
		$('#csmdate').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		

	}

	function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
		 
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
							/* console.log(brandidItems[i]);
							console.log(brandItems[i]); */
				}
				$("select#csmname").html(optionsbrand);
				$('#csmname').val($('#hidname').val()); 
				} else {
			}
		}
		x.open("GET", "getClassificationMaster.jsp", true);
		x.send();
	}
	
	function funFocus(){
		document.getElementById("csmname").focus();
	}
	
	 
	 $(function(){
	        $('#frmsubCategory').validate({
	                 rules: {
	                	 		desc: {
	                	 						required:true,
	                	 						maxlength:500
	                 					  }
	                 		},
	                 messages: {
	                	 			desc: {
	                	 						 required:" *",
	                	 						 maxlength:"max 500 characters only"
	                 						 } 
	                 			}
	        });});
	 
	
	     function funNotify(){
	    	/* alert($('#csmname').val()+"=>csmname"); */
	    		return 1;
		} 
	     
	function setValues() {
		if ($('#csdocno').val() != null) {
			$('#csmname').val($('#csdocno').val());
		}
		if ($('#msg').val() != "") {
			$.messager.alert('Message', $('#msg').val());
		}
	}
	
	
</script>
</head>
<body onLoad="getCategory();setValues();"><div id="mainBG" class="homeContent" data-type="background">
<jsp:include page="../../../../header.jsp" /><br/> 
<div id="container">
<div>
<form id="frmsubCategory" action="saveclassificationMasterAction"  autocomplete="off">
<fieldset><legend>Classification Master</legend>
<input type="hidden" id="csdocno" name="csdocno" value='<s:property value="csdocno"/>'>
<table width="100%">
<tr>
  <td></td>
  <td width="14%"><div align="right">Date</div></td>
  <td width="12%"><div id="csmdate" name="csmdate" value='<s:property value="csmdate"/>'></div></td>
  </td>
  <td>
  <td width="23%"><div align="right">Doc No</div></td>
  <td width="51%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly"  tabindex="-1"></td>
 </td>
</tr>
<tr>

</tr>
<tr>
<td>
<td><div align="right">Name</div></td>
<td>
<!-- <option value="">--Select--</option> -->
 <select name="csmname" id="csmname" style="width:100%;">
</select></td>
<td>
<td><div align="right">Description</div></td><td><input type="text" style="width:65%" name="desc" id="desc" value='<s:property value="desc"/>'></td>
</td>
</td>
</tr>

<td>
<input type="hidden" name="hidname" id="hidname" value='<s:property value="csmname"/>' /> 
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
</td>
</table> 
</fieldset>										        
</form>
<br/>
</div>
<div id="grid">
<div id="jqxCategory"></div>
</div>
</div>	
</div>
</body>
</html>