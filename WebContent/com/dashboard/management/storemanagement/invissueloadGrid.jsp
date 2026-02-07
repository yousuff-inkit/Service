
 
 <%@page import="com.dashboard.management.storemanagement.ClsStoremanagementDAO"%>
 <% ClsStoremanagementDAO DAO = new ClsStoremanagementDAO();   %>   
  

 
    <%String docnos = request.getParameter("docnos")==null?"0":request.getParameter("docnos").trim();   
String brhhid = request.getParameter("brhhid")==null?"0":request.getParameter("brhhid").trim();  %>   
   
   
  


<script type="text/javascript">

  

     $(document).ready(function () {
    	  var rendererstring1=function (aggregates){
    	       	var value=aggregates['sum1'];
    	       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
    	       }    
    	    
    	   var rendererstring=function (aggregates){
    	 	var value=aggregates['sum'];
    	 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
    	 }
    	   

    	    	
         datas12='<%=DAO.pendissrptload(docnos,brhhid)%>'; 
         
              var source =
                  {
                   datatype: "json",
                   datafields: [   
                	   {name : 'docnoo', type: 'string' }, 
                	   {name : 'rrefno', type: 'string' }, 
                	   {name : 'voc_no', type: 'string' }, 
                	   {name : 'brhhid', type: 'string' }, 
                   	  {name : 'frmbrhid', type: 'string' }, 
                	   {name : 'tobrhid', type: 'string' }, 
                	   {name : 'frmlocid', type: 'string' }, 
                	   {name : 'tolocid', type: 'string' }, 
                	    {name : 'productid', type: 'string' }, 
 						{name : 'productname', type: 'string'},
 						{name : 'unit', type: 'string'  },
 						{name : 'size', type: 'number'   },
 						{name : 'totqty', type: 'number'   },
 						{name : 'qty', type: 'number'   },
 						{name : 'outqty', type: 'number'   },
 						{name : 'oldqty', type: 'number'   },
 						{name : 'balqty', type: 'number'   },
 						{name : 'foc', type: 'int' },
 						{name : 'refqty', type: 'int'  },
						{name : 'totwtkg', type: 'number' },
						{name : 'kgprice', type: 'number'  },
 						{name : 'unitprice', type: 'number' },
 						{name : 'total', type: 'number' },
 						{name : 'discper', type: 'number' },
 						{name : 'dis', type: 'number' },
 						{name : 'netotal', type: 'number' },
 						{name : 'proid', type: 'string'    },
                		{name : 'proname', type: 'string'    },
                		{name : 'prodoc', type: 'number'    },
                		{name : 'specid', type: 'number'    },
 						{name : 'unitdocno', type: 'number'    },
 						{name : 'psrno', type: 'number'    },
 						{name : 'stkid', type: 'number'    },
 						{name : 'brandname', type: 'string'},
 						{name : 'refstkid', type: 'number'    },
 						{name : 'remarks', type: 'string'},
 						{name : 'branchname', type: 'string'},
 						{name : 'brhid', type: 'string'},
 						{name : 'location', type: 'string'},
						

						],
				    localdata: datas12,
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
              var cellclassname =  function (row, column, value, data) {


        	   	  var ss= $('#pendingissrptload').jqxGrid('getcellvalue', row, "clstatus");
        	   		          if(parseInt(ss)>0)
        	   		  		{
        	   		  		
        	   		  		return "yellowClass";
        	   		  	
        	   		  		}
        	   		}
 
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
  
    $("#pendingissrptload").jqxGrid(
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
							
							{ text: 'DocNo', datafield: 'docnoo', width: '7%',editable:false,cellclassname: cellclassname,hidden:true},
							{ text: 'rrefno', datafield: 'rrefno', width: '7%',editable:false,cellclassname: cellclassname,hidden:true},
							{ text: 'Issue DocNo', datafield: 'voc_no', width: '10%',editable:false,cellclassname: cellclassname},
							{ text: 'brhid', datafield: 'brhhid', width: '7%',editable:false,cellclassname: cellclassname,hidden:true},
							{ text: 'frmbrhid', datafield: 'frmbrhid', width: '7%',editable:false,cellclassname: cellclassname,hidden:true},
							{ text: 'tobrhid', datafield: 'tobrhid', width: '7%',editable:false,cellclassname: cellclassname,hidden:true},
							{ text: 'frmlocid', datafield: 'frmlocid', width: '7%',editable:false,cellclassname: cellclassname,hidden:true},
							{ text: 'tolocid', datafield: 'tolocid', width: '7%',editable:false,cellclassname: cellclassname,hidden:true},
							{ text: 'remarks', datafield: 'remarks', width: '7%',editable:false,cellclassname: cellclassname,hidden:true},
							{text: 'Branch', datafield: 'branchname', width: '15%' , editable:false  ,  cellclassname: cellclassname,hidden:true},
							{text: 'BranchId', datafield: 'brhid', width: '15%' , editable:false  ,  cellclassname: cellclassname,hidden:true},
							{text: 'Location', datafield: 'location', width: '15%' , editable:false  ,  cellclassname: cellclassname,hidden:true},
							
{text: 'Brand Name', datafield: 'brandname', width: '15%' , editable:false  ,  cellclassname: cellclassname,hidden:true},
{ text: 'oldqty', datafield: 'oldqty', width: '7%',cellclassname: cellclassname ,hidden:true },
{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname,hidden:true  },
{ text: 'FOC', datafield: 'foc',cellclassname: cellclassname,hidden:true},
{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname  ,hidden:true },
{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname  ,hidden:true},
{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true},
{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true},
{ text: 'Unit price', datafield: 'unitprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true},
{ text: 'Total', datafield: 'total', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname,hidden:true},
{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true},
{ text: 'Discount', datafield: 'dis', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,hidden:true},
{ text: 'Net Total', datafield: 'netotal', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname,hidden:true},
{text: 'Product Id', datafield: 'proid', width: '10%',cellclassname: cellclassname}, 
{text: 'product Name', datafield: 'proname',cellclassname: cellclassname},
{ text: 'Unit', datafield: 'unit', width: '7%',editable:false,cellclassname: cellclassname },	
{ text: 'Size', datafield: 'size', width: '7%',editable:false,cellclassname: cellclassname,hidden:true},
{ text: 'Quantity', datafield: 'qty', width: '10%',cellclassname: cellclassname,cellsformat:'d2',cellsalign:'right',align:'right' },
{text: 'Product No', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true},
{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true},
{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true},
{text: 'stockid', datafield: 'stkid', width: '10%',cellclassname: cellclassname ,hidden:true},
{text: 'refstkid', datafield: 'refstkid', width: '10%',cellclassname: cellclassname,hidden:true},
					

]
    
    
    
   
    });
	
    $('.load-wrapp').hide();
    


  

	
});


</script>
<div id="pendingissrptload"></div>