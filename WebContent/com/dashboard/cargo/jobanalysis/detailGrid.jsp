<%@page import="com.dashboard.cargo.jobanalysis.ClsJobAnalysisDAO" %>              
<%
	ClsJobAnalysisDAO DAO=new ClsJobAnalysisDAO();                  
	String id = request.getParameter("id")==null?"0":request.getParameter("id");
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String chkinv = request.getParameter("chkinv")==null?"0":request.getParameter("chkinv").trim();
%>
<script type="text/javascript">  
var griddata;
var id='<%=id%>';      
if(id=="1"){
	griddata='<%=DAO.loadDetData(fromdate, todate, id,chkinv)%>';                      
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
                        {name : 'voc_no', type: 'String'  },
						{name : 'enqno', type: 'String'  },
						{name : 'client', type: 'String'  },
						{name : 'confrmno', type: 'String'  },
						{name : 'pol', type: 'String'  },
						{name : 'pod', type: 'String'  },
						{name : 'mode', type: 'String'  },
						{name : 'smode', type: 'String'  },
						{name : 'shipment', type: 'String'  },
						{name : 'confrefno', type: 'String'  },
						{name : 'salesman', type: 'String'  },
						{name : 'jobdate', type: 'date'  },
						{name : 'qvocno', type: 'String'  },   
						{name : 'expense', type: 'number'   },
						{name : 'revenue', type: 'number'   },  
						{name : 'margin', type: 'number'   }, 
						{name : 'marginper', type: 'number'   },      
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
                            { text: 'ENQ NO',datafield: 'enqno', width: '4%' },
                            { text: 'QUOTE NO', datafield: 'qvocno', width: '4%'},
                            { text: 'JOBNO',datafield: 'confrmno', width: '4%' },
                            { text: 'SUB JOB NO', datafield: 'voc_no', width: '4%'},    
               			    { text: 'SUB JOB DATE',datafield: 'jobdate', width: '5%' ,cellsformat:'dd.MM.yyyy' },  
               			    { text: 'CLIENT',datafield: 'client'},     
               			    { text: 'MODE', datafield: 'mode',  width: '6%' }, 
                	        { text: 'SUB MODE', datafield: 'smode',  width: '6%' },
                	        { text: 'SHIPMENT', datafield: 'shipment',  width: '6%' },   
                	        { text: 'POL', datafield: 'pol',  width: '6%'  },
                            { text: 'POD', datafield: 'pod',  width: '6%'  },
                            { text: 'JOB REF NO',datafield: 'confrefno', width: '4%' },   
                            { text: 'JOB DATE',datafield: 'confrmdate', width: '5%',cellsformat:'dd.MM.yyyy' },
                			{ text: 'SALESMAN',datafield: 'salesman', width: '8%'},
                			{ text: 'REVENUE', datafield: 'revenue', width: '6%',cellsalign:'right',align:'right',cellsformat:'d2', aggregates: ['sum'], aggregatesrenderer:rendererstring },
                        	{ text: 'EXPENSE', datafield: 'expense' , width: '6%',cellsalign:'right',align:'right',cellsformat:'d2', aggregates: ['sum'], aggregatesrenderer:rendererstring },
                        	{ text: 'MARGIN', datafield: 'margin' , width: '6%',cellsalign:'right',align:'right',cellsformat:'d2', aggregates: ['sum'], aggregatesrenderer:rendererstring },
                        	{ text: 'MARGIN %', datafield: 'marginper' , width: '6%',cellsalign:'right',align:'right',cellsformat:'d2' },
                			  
		]
	});
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxDetailGrid"></div>            