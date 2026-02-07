
 
 <%@page import="com.dashboard.management.storemanagement.ClsStoremanagementDAO"%>
 <% ClsStoremanagementDAO DAO = new ClsStoremanagementDAO(); 
 String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
 String brhid = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
 %> 
   
 
<script type="text/javascript">

  

     $(document).ready(function () {
	    
    	 var temp4='<%=brhid%>';
    	  
         datas11='<%=DAO.invreqdetlist(load,brhid)%>'; 
         
              var source =
                  {
                   datatype: "json",
                   datafields: [   
                	   
                	   {name : 'rowno', type: 'number'  },
   				    	{name : 'vocno', type: 'number'  },
						{name : 'docno', type: 'number'  },
						{name : 'quantity', type: 'number'  },
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'unit', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'psrno', type: 'number'  },
						{name : 'unitid', type: 'number'  },
						{name : 'branch', type: 'number'  },
						{name : 'brhid', type: 'String'  },
						{name : 'locid', type: 'String'  },
						{name : 'location', type: 'number'  },
						{name : 'date', type: 'date'  },
						{name : 'rebrch', type: 'String'  },
						{name : 'reqloc', type: 'String'  },
						{name : 'balqty', type: 'number'  },
							
						
						
						
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
    
  
    $("#invreqgriddet").jqxGrid(
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
        selectionmode: 'checkbox',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        enabletooltips: true,
        columns: [   
        	 { text: 'Sr.No.', sortable: false, filterable: false, editable: false,
                 groupable: false, draggable: false, resizable: false,datafield: '',
                 columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                 cellsrenderer: function (row, column, value) {
               	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                 }  
 				},  
 				     { text: 'Req Doc No', datafield: 'vocno',  width: '5%'},
 				    { text: 'Row NO', datafield: 'rowno',  width: '5%',hidden:true},
				     { text: 'Doc No', datafield: 'docno',  width: '5%',hidden:true},
 				     { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},
        	         { text: 'Branch', datafield: 'rebrch',  width: '14%'},
        	         { text: 'BranchId', datafield: 'brhid',  width: '14%',hidden:true},
        	         { text: 'LocationId', datafield: 'locid',  width: '10%',hidden:true},
            	      { text: 'Location', datafield: 'reqloc',  width: '10%'},
           	         { text: 'Product Id', datafield: 'productid',  width: '10%' }, 
           	         { text: 'Product Name', datafield: 'productname'},
           	         { text: 'Qty', datafield: 'quantity',  width: '5%',cellsformat:'d2',cellsalign:'right',align:'right'},
           	         { text: 'Unit', datafield: 'unit',  width: '4%'},
           	         { text: 'Remarks', datafield: 'remarks'},
           	  	     {text: 'psrno', datafield: 'psrno', width: '10%',hidden:true},
           	    	 { text: ' Unitd', datafield: 'unitid',  width: '10%',hidden:true},
           	    	 { text: ' Brchid', datafield: 'branch',  width: '10%',hidden:true},
           	    	 { text: ' LocationId', datafield: 'location',  width: '10%',hidden:true},
           	    	 { text: 'balqty', datafield: 'balqty', width: '10%',hidden:true},
           	    
                     
	 	       	]
   
    });
	
    $('.load-wrapp').hide();
    
    
	
 
});


</script>
<div id="invreqgriddet"></div>