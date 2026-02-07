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
var vwdata;
var id='<%=id%>';
if(id=="1"){  
	 vwdata='<%=DAO.vWiseData(id)%>';                                             
}     
$(document).ready(function () {     
	
	// prepare the data
    var source =
    {
    	datatype: "json",
        datafields: [
					{name : 'pol', type: 'String'  },
					{name : 'pod', type: 'String'  },
					{name : 'mode', type: 'String'  },
					{name : 'smode', type: 'String'  },
					{name : 'shipment', type: 'String'  },
					{name : 'status', type: 'string'   },
					{name : 'substatus', type: 'string'   },
					{name : 'vehicle', type: 'string'   },
		],         
        localdata: vwdata,             
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.   
        }
	};
   
    var dataAdapter = new $.jqx.dataAdapter(source);  
            
    $("#jqxVWiseGrid").jqxGrid(  
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
             { text: 'Vehicle', datafield: 'vehicle',width: '18%'},       
             { text: 'Status', datafield: 'status',width: '10%' },
			 { text: 'Sub Status', datafield: 'substatus',width: '10%' },   
			 { text: 'POL', datafield: 'pol',  width: '15%'  },
             { text: 'POD', datafield: 'pod',  width: '15%'  },
	         { text: 'Mode', datafield: 'mode',  width: '10%' }, 
	         { text: 'Sub Mode', datafield: 'smode',  width: '10%' },
	         { text: 'Shipment', datafield: 'shipment',  width: '10%' },   
		]     
	});
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxVWiseGrid"></div>        