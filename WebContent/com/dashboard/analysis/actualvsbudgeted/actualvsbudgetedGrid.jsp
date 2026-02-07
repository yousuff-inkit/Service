 <%@page import="com.dashboard.analysis.actualvsbudgeted.ClsActualVsBudgetedDAO"%>
 <% ClsActualVsBudgetedDAO DAO = new ClsActualVsBudgetedDAO(); 
	String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
 %> 
 
<script type="text/javascript">

var datas='<%=DAO.actualvsbudgetedList(fromdate,todate,load)%>'; 

$(document).ready(function () {
	var rendererstring1 = function(aggregates) {
	    var value = aggregates['sum1'];
	    return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
	}

	var rendererstring = function(aggregates) {
	    var value = aggregates['sum'];
	    return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	}
      
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'salesman', type: 'String'  },      
						{name : 'mnt', type: 'number'  },
						{name : 'inv', type: 'number'  },
						{name : 'total', type: 'number'  },
						{name : 'budget', type: 'number'  },
						{name : 'balance', type: 'number'  },
						
						],
				    localdata: datas,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
	         }		
    );
    
    $("#actualvsbudgetedList").jqxGrid(
    {
        width: '98%',
        height: 550,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        showfilterrow: true,
        filterable: true,
        sortable:true,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 21,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                    { text: 'Salesman', datafield: 'salesman',  width: '36%' },
                    { text: 'Workshop Invoice', datafield: 'mnt',  width: '12%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
                    { text: 'Invoice', datafield: 'inv',  width: '12%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
                    { text: 'Total', datafield: 'total',  width: '12%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
                    { text: 'Budget', datafield: 'budget',  width: '12%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
                    { text: 'Balance', datafield: 'balance',  width: '12%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
                    
					]
   
    });
    
    $("#overlay, #PleaseWait").hide();
   
});

</script>
<div id="actualvsbudgetedList"></div>