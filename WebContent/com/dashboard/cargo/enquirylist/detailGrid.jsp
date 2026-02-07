<%@page import="com.dashboard.cargo.enquirylist.ClsEnquiryListDAO" %>              
<%
    ClsEnquiryListDAO DAO=new ClsEnquiryListDAO();         
	String id = request.getParameter("id")==null?"0":request.getParameter("id");
	String type = request.getParameter("type")==null?"":request.getParameter("type");
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
%>
<script type="text/javascript">  
var griddata;
var id='<%=id%>';
if(id=="1"){
	griddata='<%=DAO.loadDetData(fromdate, todate, type, id)%>';                 
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
							{name : 'mode', type: 'string'  },
							{name : 'modeid', type: 'int'   },
     						{name : 'submode', type: 'string'  },
     						{name : 'smodeid', type: 'int'   },
     						{name : 'shipment', type: 'string'  },
     						{name : 'shipmentid', type: 'int'   },
     						{name : 'terms', type: 'string'   },
     						{name : 'termid', type: 'int'   },
     						{name : 'orgin', type: 'string'  },
     						{name : 'pol', type: 'string'   },
     						{name : 'pod', type: 'string'   },
     						{name : 'polid', type: 'string'   },
     						{name : 'podid', type: 'string'   },
     						{name : 'comodity', type: 'string'   },
     						{name : 'weight', type: 'string'   },
     						{name : 'noofpacks', type: 'number'  },
     						{name: 'dimension', type: 'string' },
     						{name : 'volume', type: 'string' },
     						{name: 'remarks', type: 'string' },
     						{name: 'chkmode', type: 'string' },
     						{name : 'qty', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name: 'voc_no', type: 'string' },
     						{name : 'refname', type: 'String'   },
		],         
        localdata: griddata,    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
	};
    var dataAdapter = new $.jqx.dataAdapter(source);
            
    $("#jqxDetailGrid").jqxGrid(
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
        showaggregates: true,
        showstatusbar:true,
        editable: false,
        columns: [
        	             { text: 'SL#', sortable: false, filterable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '3%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
                            },	
                            { text: 'Doc No', datafield: 'voc_no', width: '6%'  },
                            { text: 'Client', datafield: 'refname', width: '18%' },
                            { text: 'Mode', datafield: 'mode', width: '6%'  },	
                            { text: 'Modeid', datafield: 'modeid', width: '2%' ,hidden:true },
							{ text: 'Submode', datafield: 'submode', width: '8%' , coloumnresizable:true},	
							{ text: 'Submodeid', datafield: 'smodeid', width: '2%',hidden:true },
							{ text: 'Shipment', datafield: 'shipment', width: '8%' },
							{ text: 'Shipmentid', datafield: 'shipmentid', width: '2%' ,hidden:true },
							{ text: 'Terms', datafield: 'terms', width: '7%' },	
							{ text: 'Termid', datafield: 'termid', width: '2%',hidden:true },
							{ text: 'Orgin', datafield: 'orgin', width: '6%' },	
							{ text: 'Pol', datafield: 'pol', width: '6%'},
							{ text: 'PoD', datafield: 'pod', width: '6%'},	
							{ text: 'Commodity', datafield: 'comodity', width: '9%'},
							{ text: 'Weight', datafield: 'weight', width: '6%'},
							{ text: 'No of Packs', datafield: 'noofpacks', width: '6%' },	  
							{ text: 'Dimension', datafield: 'dimension', width: '6%' },
							{ text: 'Volume', datafield: 'volume', width: '6%' },	
							{ text: 'Remarks', datafield: 'remarks', width: '6%' },	
							{ text: 'Qty', datafield: 'qty', width: '5%'},
							{ text: 'srno', datafield: 'sr_no', width: '9%',hidden:true},
							{ text: 'polid', datafield: 'polid', width: '9%',hidden:true},
							{ text: 'chkmode', datafield: 'chkmode', width: '9%',hidden:true},   
							{ text: 'podid', datafield: 'podid', width: '9%',hidden:true}
		]
	});
    
    $('#jqxDetailGrid').on('rowdoubleclick', function (event) {        
    	/* var rowindex= event.args.rowindex;
    	$('#hidreftype').val($('#jqxDetailGrid').jqxGrid('getcellvalue',rowindex,'reftype'));
		$('#hiddocno').val($('#jqxDetailGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
		$('#hidvocno').val($('#jqxDetailGrid').jqxGrid('getcellvalue',rowindex,'invno'));
		$('#hidbrhid').val($('#jqxDetailGrid').jqxGrid('getcellvalue',rowindex,'brhid'));
		var invno=$('#jqxDetailGrid').jqxGrid('getcellvalue',rowindex,'invno');
		var propname=$('#jqxDetailGrid').jqxGrid('getcellvalue',rowindex,'propname');     
		$('.textpanel p').text(invno+' - '+propname);  
		$('.comments-container').html(""); */           
	}); 
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxDetailGrid"></div>            