<%@page import="com.dashboard.cargo.enquirylist.ClsEnquiryListDAO" %>  
<%
    ClsEnquiryListDAO DAO=new ClsEnquiryListDAO();                      
	String id = request.getParameter("id")==null?"0":request.getParameter("id"); 
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
	summdata='<%=DAO.loadSumData(fromdate, todate, id)%>';   
}          
$(document).ready(function () {  
	
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [    
						{name : 'doc_no', type: 'String'   },
						{name : 'voc_no', type: 'String'   },
						{name : 'team', type: 'String'   },
						{name : 'refname', type: 'String'   },
						{name : 'mob', type: 'String'   },
						{name : 'email', type: 'String'   },
						{name : 'date', type: 'date'   },
						{name : 'remarks', type: 'String'   },   
		],         
        localdata: summdata,    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
	};
    var cellclassname = function (row, column, value, data) {
		 if (parseInt(data.jvtrno)>0) {                 
           return "redClass";
       }
   };
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#jqxSummaryGrid").jqxGrid(
	{
    	width: '100%',
        height: 500,
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
                datafield: 'sl', columntype: 'number', width: '4%',
                cellsrenderer: function (row, column, value) {
                	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
            },                          
        	{ text: 'Doc No', datafield: 'voc_no', width: '5%'}, 
        	{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyyy'},  
        	{ text: 'Client', datafield: 'refname', width: '25%' },
        	{ text: 'Mobile', datafield: 'mob' , width: '12%'},          
        	{ text: 'Email', datafield: 'email', width: '12%'},
        	{ text: 'Remarks', datafield: 'remarks'},     
        	{ text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true},
        	{ text: 'brhid', datafield: 'brhid', width: '6%',hidden:true},    
		]
	});
    
    $('#jqxSummaryGrid').on('rowdoubleclick', function (event) {           
    	var rowindex= event.args.rowindex;
    	/* $('#hidreftype').val($('#jqxAgentGrid').jqxGrid('getcellvalue',rowindex,'reftype'));
		$('#hiddocno').val($('#jqxSummaryGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
		$('#hidvocno').val($('#jqxSummaryGrid').jqxGrid('getcellvalue',rowindex,'invno'));
		$('#hidbrhid').val($('#jqxSummaryGrid').jqxGrid('getcellvalue',rowindex,'brhid'));  
		var invno=$('#jqxSummaryGrid').jqxGrid('getcellvalue',rowindex,'invno');   
		var propname=$('#jqxSummaryGrid').jqxGrid('getcellvalue',rowindex,'propname');       
		$('.textpanel p').text(invno+' - '+propname);     
		 $('.comments-container').html("");    */
	}); 
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxSummaryGrid"></div>         