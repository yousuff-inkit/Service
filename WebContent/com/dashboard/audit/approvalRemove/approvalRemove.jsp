
<jsp:include page="../../../../includes.jsp"></jsp:include>     
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

 
<script type="text/javascript">

$(document).ready(function () {
	
	   
	   $('#docwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'DocNo Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#docwindow').jqxWindow('close');
	   $('#dtypewindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'DocType Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#dtypewindow').jqxWindow('close');
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	   
	   
	   
	   $('#doctype').dblclick(function(){
	  	    $('#dtypewindow').jqxWindow('open');
	   
	  	  dtypeSearchContent('dtypesearch.jsp?', $('#dtypewindow')); 
       }); 
	   
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
});
function funExportBtn(){
	   $("#detailsgrid").jqxGrid('exportdata', 'xls', 'Rental List');
	 }
function getdtype(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#dtypewindow').jqxWindow('open');
	dtypeSearchContent('dtypesearch.jsp?', $('#dtypewindow'));    }
	 else{
		 }
	 } 
function dtypeSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#dtypewindow').jqxWindow('open');
		$('#dtypewindow').jqxWindow('setContent', data);

	}); 
	} 
function getdocno(event){
	
	var dtype=$("#doctype").val();
	if(dtype==""){
		$.messager.alert('Message','Select a Document Type To Continue  ','warning');
		return 0;
	}
	
	
	 var x= event.keyCode;
	 if(x==114){
	  $('#docwindow').jqxWindow('open');
	docnoSearchContent('docsearch.jsp?dtype='+dtype, $('#docwindow'));    }
	 else{
		 }
	 } 
function docnoSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#docwindow').jqxWindow('open');
		$('#docwindow').jqxWindow('setContent', data);

	}); 
	}  
function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
	 var barchval = document.getElementById("brhid").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val(); 
	   $("#overlay, #PleaseWait").show();
	  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&doc_no="+document.getElementById("doc_no").value+"&dtype="+$("#doctype").val());
	
		   }
	}




function  funcleardata()
{
	
	document.getElementById("doc_no").value="";
	document.getElementById("doctype").value="";
	document.getElementById("brhid").value="";
	document.getElementById("reason").value="";
	
	 if (document.getElementById("doc_no").value == "") {
			
		 
	        $('#doc_no').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("doctype").value == "") {
			
		 
	        $('#doctype').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("brhid").value == "") {
			
		 
	        $('#brhid').attr('placeholder', 'Press F3 TO Search'); 
	    }
	
	}
	
	
function saveApprremove()  
{  

	if($("#doc_no").val()=="" || $("#doctype").val()=="" || $("#brhid").val()==""){
		
		 $.messager.alert('Message','Select an Approval to Remove  ','warning');
		
		//alert('Select an Approval to Remove');
		
		return 0;
		
	}
/*  var reftypid=document.getElementById("reftypid").value; */     
	/* alert("===docno==="+$("#hidocno").val()+"===&dtype="+$("#hidtype").val()+"&userid===="+$("#hiuserid").val()+"==&brchid="+$("#hibrchid").val()+"===&desc="+$("#txtdesc").val()); */
    $.ajaxFileUpload  
    (  
        {  
            url:'removeApprove.action?docno='+$("#doc_no").val()+'&dtype='+$("#doctype").val()+'&brchid='+$("#brhid").val()+'&reason='+$("#reason").val(),
            secureuri:false,//false  
            fileElementId:'file',//id  <input type="file" id="file" name="file" />  
            dataType: 'String',// json  
            success: function (data, status)  //  
            {  
                //alert(data.message);//jsonmessage,messagestruts2
           	
         //       $('#refreshdiv').load();
                <%-- var data='<%= com.common.ClsAttach.reload(docNo) %>';
                alert("============="+data); --%>
               if(status=='success'){
              	 
            		  $("#detlist").load("detailsGrid.jsp?barchval="+$("#brhid").val()+"&fromdate="+$("#fromdate").val()+"&todate="+$("#todate").val()+"&doc_no="+$("#doc_no").val()+"&dtype="+$("#doctype").val());
            	   
            	   
                   $.messager.show({title:'Message',msg:'Approval Removed Successfully',showType:'show',
                      style:{left:15,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                  }); 
                }
               
                if(typeof(data.error) != 'undefined')  
                {  
                    if(data.error != '')  
                    {  
                        //$.messager.alert('Message',data.error);
                        $.messager.show({title:'Message',msg: data.error,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                    }else  
                    {  
                        //$.messager.alert('Message',data.message);
                        $.messager.show({title:'Message',msg: data.message,showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
                    }  
                }  
            },  
            error: function (data, status, e)//  
            {  
                //alert(e);  
                $.messager.alert('Message',e);
            }  
        }  
    )  
    return false;  
}

	


</script>
<style>

/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}

/* Page height fix */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
input[type="text"],
select {
    width: 100%;
    height: 28px !important;   /* Slightly smaller */
    padding: 6px 10px;
    font-size: 13px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    box-sizing: border-box;
    background-color: #ffffff;
}

</style>


<script>

</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%">
    <div class="master-container">
        <div class="sidebar-filters">

            <!-- Fixed Heading -->
            <div class="sidebar-fixed-top">
                <div class="filter-card">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <!-- Scrollable Content -->
            <div class="sidebar-scroll-content">

                <!-- Date Section -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">From</td>
                            <td>
                                <div id="fromdate"
                                     value='<s:property value="fromdate"/>'>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">To</td>
                            <td>
                                <div id="todate"
                                     value='<s:property value="todate"/>'>
                                </div>
                            </td>
                        </tr>

                    </table>
                </div>


                <!-- Document Section -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">DocType</td>
                            <td>
                                <input type="text"
                                       name="doctype"
                                       id="doctype"
                                       placeholder="Press F3 To Search"
                                       readonly
                                       onkeydown="getdtype(event);"
                                       value='<s:property value="doctype"/>' />
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">DocNo</td>
                            <td>
                                <input type="text"
                                       name="doc_no"
                                       id="doc_no"
                                       placeholder="Press F3 To Search"
                                       readonly
                                       onkeydown="getdocno(event);"
                                       value='<s:property value="doc_no"/>' />
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Reason</td>
                            <td>
                                <textarea name="reason"
                                          id="reason"
                                          rows="4"
                                          style="resize:none;width:100%;">
                                    <s:property value="reason"/>
                                </textarea>
                            </td>
                        </tr>

                    </table>
                </div>

                <!-- Buttons -->
                <button class="btn-submit"
                        type="button"
                        onclick="funcleardata();">
                    Clear
                </button>

                <button class="btn-submit"
                        type="button"
                        onclick="saveApprremove();">
                    Remove Approval
                </button>

                <!-- Extra Div -->
                <div id="paychaaaaa"
                     style="width:100%; height:100px;">
                </div>

                <!-- Hidden Field -->
                <input type="hidden"
                       name="brhid"
                       id="brhid"
                       value='<s:property value="brhid"/>' />

            </div>
        </div>
    </div>
</td>


<!-- ================= RIGHT GRID AREA ================= -->
<td width="80%">
    <table width="100%">
        <tr>
            <td>
                <div id="detlist">
                    <jsp:include page="detailsGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</td>

</tr>
</table>

</div>

<!-- Windows -->
<div id="clientwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
<div id="groupwindow"><div></div></div>
<div id="docwindow"><div></div></div>
<div id="dtypewindow"><div></div></div>

</div>
</body>
</html>
	 