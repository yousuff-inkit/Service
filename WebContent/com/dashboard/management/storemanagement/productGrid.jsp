
 
 <%@page import="com.dashboard.management.storemanagement.ClsStoremanagementDAO"%>
 <% ClsStoremanagementDAO DAO = new ClsStoremanagementDAO(); 
 String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();%> 
      
 
<script type="text/javascript">

  

     $(document).ready(function () {

      
         datas11='<%=DAO.productdetlist(load)%>'; 
         
              var source =
                  {
                   datatype: "json",
                   datafields: [   
                    	{name : 'productid', type: 'string'  },
                        {name : 'productname', type: 'string'  },
                        {name : 'doc_no', type: 'string'  },
                        {name : 'unit', type: 'string'  },
                        {name : 'psrno', type: 'string'  },
                        {name : 'specid', type: 'string'  },
                        {name : 'method', type: 'string'  },
                        {name : 'quantity', type: 'number'  },
                        {name : 'outqty', type: 'number'  },
                        {name : 'balqty', type: 'number'  },
                        {name : 'totqty', type: 'number'  },
                        {name : 'stkid', type: 'number'  },
                        {name : 'unitprice', type: 'number'  },
                        {name : 'brandname', type: 'string'  },
                        {name : 'remarks', type: 'String'  },
                        {name : 'unitid', type: 'number'  },
						{name : 'branch', type: 'number'  },
						{name : 'location', type: 'number'  },
						
                        
                   
						
						],
				    localdata: datas11,
        
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
    
  
    $("#productgriddet").jqxGrid(
    {
        width: '99.5%',
        height: 220,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow:true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        enabletooltips: true,
        handlekeyboardnavigation: function (event) {
        	
        },
        columns: [   
                  	 { text: 'Sr.No.', sortable: false, filterable: false, editable: false,
			                groupable: false, draggable: false, resizable: false,datafield: '',
			                columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
			                cellsrenderer: function (row, column, value) {
			              	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
			                }  
							},
							
        	   { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true },
               { text: 'Product', datafield: 'productid', width: '28%' },
               { text: 'Product Name', datafield: 'productname' },
               { text: 'Unit', datafield: 'unit', width: '10%' },
               { text: 'Unit Price', datafield: 'unitprice', width: '15%',hidden:true },
               { text: 'Method', datafield: 'method', width: '10%',hidden:true},
               { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
               { text: 'specid', datafield: 'specid', width: '10%' ,hidden:true },
               { text: 'Quantity', datafield: 'quantity', width: '10%' },
               { text: 'outqty', datafield: 'outqty', width: '10%',hidden:true },
               { text: 'balqty', datafield: 'balqty', width: '10%',hidden:true },
               { text: 'totqty', datafield: 'totqty', width: '10%',hidden:true  },
               { text: 'stockid', datafield: 'stkid', width: '10%',hidden:true  },
               { text: 'Remarks', datafield: 'remarks'},
               { text: 'brandname', datafield: 'brandname', width: '10%',hidden:true },
               { text: ' Unitd', datafield: 'unitid',  width: '10%',hidden:true},
     	       { text: ' Brchid', datafield: 'branch',  width: '10%',hidden:true},
     	       { text: ' LocationId', datafield: 'location',  width: '10%',hidden:true},
     	    	
					 
					 
					 ]
    
    
    
   
    });
	
    $('.load-wrapp').hide();
    


  

	
});


</script>
<div id="productgriddet"></div>