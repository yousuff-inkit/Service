<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.operations.warehousemanagement.ClsWarehouseManagementDAO"%>  
<%
    String binid = request.getParameter("binid")==null?"0":request.getParameter("binid").trim();
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    ClsWarehouseManagementDAO DAO= new ClsWarehouseManagementDAO();    
%>
<script type="text/javascript">  
       var data6;
       data6='<%=DAO.getBinDetails(binid,id)%>';                                  

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
				    localdata: data6,  

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
    
    $("#jqxbindetailsGrid").jqxGrid(
    {
        width: '100%',
        height: 250,
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
        columns: [   
					    { text: 'SL#', sortable: false, filterable: false,            
					      groupable: false, draggable: false, resizable: false,
					      datafield: 'sl', columntype: 'number', width: '4%',
					      cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					      }  
					     }, 
					     { text: 'JDE', datafield: 'jdeno', width: '6%'},  
					     { text: 'BH No', datafield: 'bhno', width: '6%'},  
						 { text: 'Product ID', datafield: 'productid', width: '6%'},   
						 { text: 'Product', datafield: 'productname'},
						 { text: 'Qty', datafield: 'qty', width: '6%',cellsformat:'d2'},     
	         ]      
    });
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="jqxbindetailsGrid"></div>          