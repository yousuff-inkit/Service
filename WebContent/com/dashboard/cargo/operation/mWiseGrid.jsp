<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%>
<%
    ClsOperationDAO DAO=new ClsOperationDAO();      
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
var mwdata;
var id='<%=id%>';
if(id=="1"){  
	mwdata='<%=DAO.mWiseData(id)%>';                                                 
}     
$(document).ready(function () {     
	
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
						{name : 'val', type: 'number'   },
						{name : 'mode', type: 'string'   },
		],         
        localdata: mwdata,             
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.   
        }
	};
   
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#jqxMWiseGrid").jqxGrid(  
	{
    	width: '100%',
        height: 300,
        source: dataAdapter,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
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
			{ text: '', datafield: 'mode',width: '83%' },  
			{ text: '', datafield: 'val',width: '14%' },    
		]     
	});
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxMWiseGrid"></div>        