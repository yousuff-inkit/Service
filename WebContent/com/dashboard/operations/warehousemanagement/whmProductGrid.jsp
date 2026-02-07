<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.operations.warehousemanagement.ClsWarehouseManagementDAO"%>
<%
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    ClsWarehouseManagementDAO DAO= new ClsWarehouseManagementDAO();   
%>
<script type="text/javascript">  
       var data5;
       data5='<%=DAO.getProductData(id)%>';                                       

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'rack', type: 'String'  },
						{name : 'rackid', type: 'String'  },   
                        {name : 'bin', type: 'String'  },   
                        {name : 'floor', type: 'String'  }, 
                        {name : 'productid', type: 'String'  }, 
                        {name : 'productname', type: 'String'  }, 
                        {name : 'qty', type: 'number'  }, 
                        {name : 'jdeno', type: 'String'  }, 
				        {name : 'bhno', type: 'String'  },
						],
				    localdata: data5,

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
    
    $("#jqxwhmProductGrid").jqxGrid(
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
				   { text: 'rackid', datafield: 'rackid', width: '6%',hidden:true},
				   { text: 'Floor', datafield: 'floor', width: '6%'},     
				   { text: 'Rack', datafield: 'rack', width: '6%'},
				   { text: 'Bin', datafield: 'bin', width: '6%'},  
				   { text: 'JDE', datafield: 'jdeno', width: '6%'},  
				   { text: 'BH No', datafield: 'bhno', width: '6%'},  
				   { text: 'Product ID', datafield: 'productid', width: '10%'},   
				   { text: 'Product', datafield: 'productname'},
				   { text: 'Qty', datafield: 'qty', width: '6%',cellsformat:'d2'},      
	         ]    
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxwhmProductGrid').on('rowdoubleclick', function (event) {                            
        var rowindex2 = event.args.rowindex;    
        $('.comments-container').html('');     
    }); 
});
</script>
<div id="jqxwhmProductGrid"></div>        