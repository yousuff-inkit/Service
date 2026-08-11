<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<%@page import="com.controlcentre.settings.productsettings.productmaster.ClsProductMasterDAO"%>
<%ClsProductMasterDAO DAO= new ClsProductMasterDAO(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    $('#btnSearch').attr('disabled', true);
	    document.getElementById("formdet").innerText="Brand(BRD)";
		document.getElementById("formdetail").value="Brand";
		document.getElementById("formdetailcode").value="BRD";
		window.parent.formCode.value="BRD";
		window.parent.formName.value="Brand";
 		var databrand= '<%=DAO.prdbrandLoad(session)%>';
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'brandname', type: 'String'  },
     						{name : 'desc1', type: 'String'  },
                          	{name : 'date', type: 'date'  }
                 ],
               localdata: databrand,
                //url: "/searchDetails",
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#jqxBrandSearch1").jqxGrid(
                    {
                    	width: 850,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'multiplecellsextended',
                        //Add row method
                        columns: [
        					{ text: 'DOC NO', datafield: 'doc_no', width: '8%' },
        					{ text: 'BRAND',columntype: 'textbox', filtertype: 'input', datafield: 'brandname', width: '28%' },
        					{ text: 'BRAND DESCRIPTION',columntype: 'textbox', filtertype: 'input', datafield: 'desc1', width: '45%' },
        					{ text: 'DATE',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '19%',cellsformat:'dd.MM.yyyy' }
        	              ]
                    });
            $('#jqxBrandSearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxBrandSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("brand").value = $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "brandname");
                document.getElementById("branddesc").value = $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "desc1");
                $("#date").jqxDateTimeInput('val', $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
                //document.getElementById("search").style.display="none";
               // $('#window').jqxWindow('hide');
            }); 
        });
	function funSearchLoad(){
		changeContent('brandSearch.jsp', $('#window')); 
	 }
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmBrand').trigger("reset");
		//document.getElementById("frmBrand").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	function funReadOnly() {
		$('#frmBrand input').attr('readonly', true);
		$('#date').jqxDateTimeInput({
			readonly : true
		});
		
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmBrand input').attr('readonly', false);
		$('#date').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
	}
/* 	function show_image(src, width, height, alt,position,norepeat) {
	    var img = document.createElement("img");
	    img.src = src;
	    img.width = width;
	    img.height = height;
	    img.alt = alt;
	    img.position=position;
	    img.repeat=norepeat;

	    // This next line will just add it to the <body> tag
	    document.body.appendChild(img);
	} */
	function setValues() {
		if($('#datehidden').val()){
			$("#date").jqxDateTimeInput('val', $('#date').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	 $(function(){
	        $('#frmBrand').validate({
	                 rules: {
	                 brand: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                  brand: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("brand").focus();
	     }
	  
</script>  
 
</head>
<style>
/* =========================================================
   SCOPED UI: Modern Layout Adapted for Table Structure
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

#frmBrand input[type="text"],
#frmBrand select,
.textbox { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    font-family: Arial, sans-serif;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    box-shadow: none !important;
    outline: none;
    width: 100%;
}

#frmBrand input[type="text"]:focus,
#frmBrand select:focus,
.textbox:focus { 
    border-color: #007bff; 
}

#frmBrand input[readonly],
#frmBrand input:disabled,
#frmBrand select:disabled,
.textbox[readonly] { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    font-family: Arial, sans-serif;
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
    overflow-x: hidden;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* CSS-only JQX Overrides for Alignment */
.jqx-datetimeinput-input { 
    height: 24px !important; 
    line-height: 24px !important; 
    margin-top: 0px !important; 
    padding-top: 0px !important;
    box-sizing: border-box !important;
    font-size: 12px !important;
    font-family: Arial, sans-serif !important;
    padding: 0 6px !important;
}
.jqx-action-button {
    height: 24px !important;
    top: 0px !important;
}
.jqx-widget-content {
    box-sizing: border-box !important;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: nowrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
    flex-shrink: 0; 
}

/* Grid Containers */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}
</style>

<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp" />
    <br/> 
    
    <div class='modern-ui hidden-scrollbar'>
        
        <form id="frmBrand" action="savepbmAction" method="get" autocomplete="off">
            <div class="middle-panel" style="background: #fdfdfd;">
                <span class="middle-panel-title">Product Brand Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px; flex-shrink:0;">Date</label>
                    <div style="width: 125px; flex-shrink:0;">
                        <div id="date" name="date"></div>
                    </div>
                    
                    <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: auto;">Doc No.</label>
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1" style="width:150px; flex-shrink:0;">
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px; flex-shrink:0;">Brand</label>
                    <input type="text" name="brand" id="brand" value='<s:property value="brand"/>' style="width: 250px; flex-shrink:0;">
                    
                    <label class="lbl-right" style="width:80px; flex-shrink:0; margin-left: 15px;">Description</label>
                    <input type="text" id="branddesc" name="branddesc" value='<s:property value="branddesc"/>' style="flex:1; min-width:0;">
                </div>
                
                <!-- Hidden Inputs -->
                <div style="display:none;">
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
                    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
                    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
                    <!-- Hidden field to support the JS val() fetch for 'date' if used dynamically -->
                    <input type="hidden" id="datehidden" value="<s:property value='datehidden'/>" />
                </div>
            </div>
        </form>

        <div class="middle-panel" style="margin-top: 25px;">
            <span class="middle-panel-title">Brand Search</span>
            <div class="grid-container">
                <div id="jqxBrandSearch1"></div>  
            </div>
        </div>

    </div>
</div>
</body>
</html>