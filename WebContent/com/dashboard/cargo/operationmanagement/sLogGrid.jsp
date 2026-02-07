<%@page import="com.dashboard.cargo.operationmanagement.ClsOperationManagementDAO"%>
<%
    ClsOperationManagementDAO DAO=new ClsOperationManagementDAO();     
	String id = request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id"); 
	String docno = request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim();
	String brhid = request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").trim();
%>
<style>
	.redClass    
    {
    	background-color: #FFEBEB;
    }
</style>
<script type="text/javascript">
var sldata;
var id='<%=id%>';
if(id=="1"){
	sldata='<%=DAO.sLogData(docno, id, brhid)%>';                                    
}     
$(document).ready(function () {     
	
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
						{name : 'date', type: 'Date'   },
						{name : 'user', type: 'string'  },
						{name : 'status', type: 'string'   },        
		],         
        localdata: sldata,             
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.   
        }
	};
   
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#jqxSLogGrid").jqxGrid(
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
			{ text: 'Date', datafield: 'date',width: '15%',cellsformat:'dd.MM.yyyy HH:mm:ss'},  
			{ text: 'User', datafield: 'user'},
			{ text: 'Remarks', datafield: 'status',width: '40%' },
		]     
	});
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxSLogGrid"></div>        