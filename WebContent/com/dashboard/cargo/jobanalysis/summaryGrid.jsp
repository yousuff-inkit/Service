<%@page import="com.dashboard.cargo.jobanalysis.ClsJobAnalysisDAO" %>  
<%
	ClsJobAnalysisDAO DAO=new ClsJobAnalysisDAO();                      
	String id = request.getParameter("id")==null?"0":request.getParameter("id");
	String type = request.getParameter("type")==null?"":request.getParameter("type");   
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
%>
<style>
	.redClass
    {
    	background-color: #FFEBEB;       
    }
</style>
<script type="text/javascript">
var summdata;
var id='<%=id%>';
if(id=="1"){
	summdata='<%=DAO.loadSumData(fromdate, todate, type, id)%>';         
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
						{name : 'refdetails', type: 'String'   },
						{name : 'expense', type: 'number'   },
						{name : 'revenue', type: 'number'   }, 
						{name : 'margin', type: 'number'   }, 
						{name : 'marginper', type: 'number'   },      
		],         
        localdata: summdata,    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
	};
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#jqxSummaryGrid").jqxGrid(
	{
    	width: '100%',
        height: 500,
        source: dataAdapter,
        columnsresize:true,
        filterable: true,
        selectionmode: 'singlerow',
        showfilterrow: true,
        sortable:true,
        enabletooltips: true,
        showaggregates: true,
        showstatusbar:true,
        columns: [
        	{ text: 'SL#', sortable: false, filterable: false, editable: false, 
            	groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '4%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },                          
        	{ text: 'Ref Details', datafield: 'refdetails'}, 
        	{ text: 'Revenue', datafield: 'revenue', width: '8%',cellsalign:'right',align:'right',cellsformat:'d2', aggregates: ['sum'], aggregatesrenderer:rendererstring },   
        	{ text: 'Expense', datafield: 'expense' , width: '8%',cellsalign:'right',align:'right',cellsformat:'d2', aggregates: ['sum'], aggregatesrenderer:rendererstring }, 
        	{ text: 'MARGIN', datafield: 'margin' , width: '8%',cellsalign:'right',align:'right',cellsformat:'d2', aggregates: ['sum'], aggregatesrenderer:rendererstring },
        	{ text: 'MARGIN %', datafield: 'marginper' , width: '8%',cellsalign:'right',align:'right',cellsformat:'d2' },
		]
	});
      
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxSummaryGrid"></div>         