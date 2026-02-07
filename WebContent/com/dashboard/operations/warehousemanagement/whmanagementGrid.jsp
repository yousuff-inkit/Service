<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.operations.warehousemanagement.ClsWarehouseManagementDAO"%>
<%
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    ClsWarehouseManagementDAO DAO= new ClsWarehouseManagementDAO();   
%>
<script type="text/javascript">  
       var data;
       data='<%=DAO.getRentalData(id)%>';                                

$(document).ready(function () {  
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'refname', type: 'String'  },
                        {name : 'totalval', type: 'number'  },
                        {name : 'fromdate', type: 'Date'  },
                        {name : 'todate', type: 'Date'  },
                        {name : 'remarks', type: 'String'  },   
                        {name : 'docno', type: 'String'  }, 
                        {name : 'propertyid', type: 'String'  }, 
                        {name : 'propertysub', type: 'String'  }, 
                        {name : 'name', type: 'String'  }, 
                        {name : 'pvocno', type: 'String'  }, 
                        {name : 'brhid', type: 'String'  }, 
                        {name : 'sub', type: 'String'  }, 
                        {name : 'voc_no', type: 'String'  },
                        {name : 'cldocno', type: 'String'  }, 
                        {name : 'rowno', type: 'String'  },   
						],
				    localdata: data,

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
    
    $("#jqxWHMGrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlerow',                 
       	showfilterrow: true,
        sortable:true,                                
        pagermode: 'default',
        enabletooltips:true,
        editable:true,
        columns: [   
					{ text: 'SL#', sortable: false, filterable: false, editable: false,            
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '4%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },  
				   { text: '', datafield: 'rowno', width: '6%', editable: false,hidden:true},
				   { text: '', datafield: 'cldocno', width: '6%', editable: false,hidden:true},
				   { text: '', datafield: 'docno', width: '6%', editable: false,hidden:true},
				   { text: '', datafield: 'brhid', width: '6%', editable: false,hidden:true},
				   { text: '', datafield: 'pvocno', width: '6%', editable: false,hidden:true},      
				   { text: '', datafield: 'propertyid', width: '6%', editable: false,hidden:true},
				   { text: '', datafield: 'propertysub', width: '6%', editable: false,hidden:true},
				   { text: '', datafield: 'voc_no', editable: false, width: '6%'},          
				   { text: '', datafield: 'name', editable: false, width: '24%'},  
				   { text: '', datafield: 'sub', editable: false, width: '9%'},
	               { text: '', datafield: 'refname', editable: false},       
	               { text: '', datafield: 'fromdate', width: '8%',cellsformat:'dd.MM.yyyy', editable: false},
	               { text: '', datafield: 'todate', width: '8%',cellsformat:'dd.MM.yyyy', editable: false},
	               { text: '', datafield: 'totalval', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right', editable: false},  
	               { text: '', datafield: 'remarks', width: '30%', editable: false},
	         ]    
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxWHMGrid').on('rowdoubleclick', function (event) {                            
        var rowindex2 = event.args.rowindex;    
        $('.comments-container').html('');     
    }); 
});
</script>
<div id="jqxWHMGrid"></div>      