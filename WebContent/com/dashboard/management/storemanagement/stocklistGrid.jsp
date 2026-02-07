
 
 <%@page import="com.dashboard.management.storemanagement.ClsStoremanagementDAO"%>
 <% ClsStoremanagementDAO DAO = new ClsStoremanagementDAO(); 
 String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
 String brhid = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();%> 
      
 
<script type="text/javascript">

    var datas1; 

     $(document).ready(function () {
	     var rendererstring1=function (aggregates){
         var value=aggregates['sum1'];
         return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
         var rendererstring=function (aggregates){
   	     var value=aggregates['sum'];
	     if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	      {
		  value=0.0;
	       }
        	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
         }
         var temp4='<%=brhid%>';
         datas1='<%=DAO.stocklistgrid(load,brhid)%>'; 
         
              var source =
                  {
                   datatype: "json",
                   datafields: [   
                     
						{name : 'qty', type: 'number'  },
						{name : 'brhid', type: 'String'  },
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'amount', type: 'number'  },
						{name : 'category', type: 'String'  },
						{name : 'brandname', type: 'String'  },
						{name : 'branchname', type: 'String'  },
						{name : 'loc_name', type: 'String'  },
						{name : 'subcategory', type: 'String'  },
						{name : 'unit', type: 'String'  },
					
						],
				    localdata: datas1,
        
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
    
  
    $("#stocklistgriddet").jqxGrid(
    {
        width: '99.5%',
        height: 500,
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
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                    { text: 'BranchId', datafield: 'brhid',  width: '10%',hidden:true }, 
            	       
                     { text: 'Product Id', datafield: 'productid',  width: '10%' }, 
           	         { text: 'Product Name', datafield: 'productname'},
           	   	 	 { text: 'Brand Name', datafield: 'brandname', width: '10%' ,},
           	   		 { text: ' Category', datafield: 'category',  width: '13%'  },
           	         { text: ' Subcategory', datafield: 'subcategory',  width: '10%'},
           	         { text: ' Branch', datafield: 'branchname',  width: '13%'  },
           	         { text: ' Location', datafield: 'loc_name',  width: '10%'  },
           	         { text: ' Qty', datafield: 'qty',  width: '5%',cellsformat:'d2',cellsalign:'right',align:'right'},
           	         { text: ' Unit', datafield: 'unit',  width: '5%'},
 		             { text: 'Amount', datafield: 'amount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		           	 
	 	       	]
   
    });
	
    $('.load-wrapp').hide();
    
});


</script>
<div id="stocklistgriddet"></div>