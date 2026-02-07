<%@page import="com.dashboard.cargo.operationmanagement.ClsOperationManagementDAO"%>
<%
    ClsOperationManagementDAO DAO=new ClsOperationManagementDAO();     
	String id = request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id"); 
	String docno = request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim();
%>
<style>
	.redClass    
    {
    	background-color: #FFEBEB;
    }
</style>
<script type="text/javascript">
var swdata;
var id='<%=id%>';
if(id=="1"){  
	swdata='<%=DAO.sWiseData(id)%>';                                             
}     
$(document).ready(function () {     
	var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	if(typeof(value) == "undefined"){
    		value=0.00;
    	}
    	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
    }
	var rendererstring1=function (aggregates){
        var value1=aggregates['sum1'];
        return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
       }
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
						{name : 'own', type: 'string'  },
						{name : 'vendor', type: 'string'   },
						{name : 'user', type: 'string'   },
						{name : 'status', type: 'string'   },
		],         
        localdata: swdata,             
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.   
        }
	};
   
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#jqxSWiseGrid").jqxGrid(  
	{
    	width: '100%',
        height: 300,
        source: dataAdapter,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        showaggregates: true,
     	showstatusbar:true,
     	statusbarheight:25,
        selectionmode: 'singlerow',
        showfilterrow: true,
        sortable:true,
        enabletooltips: true,
        columns: [
        	{ text: 'SL#', sortable: false, filterable: false, editable: false,
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '2%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },                          
			{ text: '', datafield: 'status',width: '54%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },  
			{ text: 'Own', datafield: 'own',width: '15%',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
			{ text: 'Vendor', datafield: 'vendor',width: '14%',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
			{ text: 'User', datafield: 'user',width: '14%',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
		]     
	});
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxSWiseGrid"></div>        