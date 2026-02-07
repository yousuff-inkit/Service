
 
 <%@page import="com.dashboard.management.storemanagement.ClsStoremanagementDAO"%>
 <% ClsStoremanagementDAO DAO = new ClsStoremanagementDAO(); 
%> 
   <%String docnos = request.getParameter("docnos")==null?"0":request.getParameter("docnos").trim();  
   
    String brhid = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();  
 String locid = request.getParameter("locid")==null?"0":request.getParameter("locid").trim();  %>  
 
<script type="text/javascript">

  

     $(document).ready(function () {
    	 var rendererstring2=function (aggregates){
    		  	var value=aggregates['sum2'];
    		  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
    		  }    

    			  var rendererstring1=function (aggregates){
    		    	var value=aggregates['sum1'];
    		    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
    		    }
    			  
    			  var rendererstring=function (aggregates){
    					var value=aggregates['sum'];
    					return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
    				}
    			  
    			  var cellclassname = function (row, column, value, data) {
    		    		if (data.qty==0) {
    		    			//document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
    		               // return "redClass";
    		            }
    		    		else{
    		    			//document.getElementById("errormsg").innetText="";
    		    		}
    		    		
    		    		var ss= $('#invissuegriddet').jqxGrid('getcellvalue', row, "qty");
    			          if(parseInt(ss)<=0)
    			  		{
    			  		
    			  		return "redClass";
    			  	
    			  		}
    		    		
    		    		};

      
   datas11='<%=DAO.invissdetlist(docnos,brhid,locid)%>'; 
          
              var source =
                  {
                   datatype: "json",
                   datafields: [   
                		{name : 'productid', type: 'string' }, 
 						{name : 'productname', type: 'string'},
 						{name : 'rowno', type: 'String'},
 						{name : 'dcnoo', type: 'string'},
 						{name : 'voc_no', type: 'string'},
 						{name : 'docno', type: 'string'},
 						{name : 'unit', type: 'string'  },
 						{name : 'size', type: 'number'   },
 						{name : 'totqty', type: 'number'   },
 						{name : 'quantity', type: 'number'   },
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
                		{name : 'specid', type: 'string'    },
 						{name : 'unitdocno', type: 'number'    },
 						{name : 'psrno', type: 'number'    },
 						{name : 'stkid', type: 'number'    },
 						{name : 'brandname', type: 'string'},
 						{name : 'remarks', type: 'string'},
 						{name : 'reqbrhid', type: 'string'},
 						{name : 'reqlocid', type: 'string'},
 						{name : 'branchname', type: 'string'},
 						{name : 'brhid', type: 'string'},
 						{name : 'stkqty', type: 'number'  },
						
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
    
  
    $("#invissuegriddet").jqxGrid(
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
        columns: [       
    		 { text: 'Sr.No.', sortable: false, filterable: false, editable: false,
                groupable: false, draggable: false, resizable: false,datafield: '',
                columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                cellsrenderer: function (row, column, value) {
              	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
				},
			 
				 {text: 'Req Doc No', datafield: 'voc_no', width: '10%' , editable:false  ,  cellclassname: cellclassname },
		    { text: 'Product', datafield: 'productid', width: '20%',cellclassname: cellclassname},
      	    { text: 'Product Name', datafield: 'productname' ,cellclassname: cellclassname},
      	  {text: 'dcnoo', datafield: 'dcnoo', width: '15%' , editable:false  ,  cellclassname: cellclassname ,hidden:true},
            {text: 'rowno', datafield: 'rowno', width: '15%' , editable:false  ,  cellclassname: cellclassname ,hidden:true},
          {text: 'doc_no', datafield: 'docno', width: '15%' , editable:false  ,  cellclassname: cellclassname ,hidden:true},
         {text: 'BranchId', datafield: 'brhid', width: '15%' , editable:false  ,  cellclassname: cellclassname ,hidden:true},
			 {text: 'Branch', datafield: 'branchname', width: '15%' , editable:false  ,  cellclassname: cellclassname ,hidden:true},
			{text: 'Brand Name', datafield: 'brandname', width: '15%' , editable:false  ,  cellclassname: cellclassname ,hidden:true},
			{ text: 'Unit', datafield: 'unit', width: '6%',editable:false,cellclassname: cellclassname },	
			{ text: 'Size', datafield: 'size', width: '7%',editable:false,cellclassname: cellclassname,hidden:true, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
			{ text: 'Quantity', datafield: 'quantity', width: '10%', cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
			{ text: 'stkqty', datafield: 'stkqty', width: '10%',hidden:true},
			{ text: 'oldqty', datafield: 'oldqty', width: '7%',cellclassname: cellclassname  ,hidden:true, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
			{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname ,hidden:true, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
			{ text: 'FOC', datafield: 'foc',cellclassname: cellclassname,hidden:true, cellsformat: 'd2', cellsalign: 'right', align: 'right'},
			{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname ,hidden:true, cellsformat: 'd2', cellsalign: 'right', align: 'right'},
			{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname ,hidden:true, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
			{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true},
			{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true},
			{ text: 'Unit price', datafield: 'unitprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true },
			{ text: 'Total', datafield: 'total', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname,hidden:true },
			{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true },
			{ text: 'Discount', datafield: 'dis', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,hidden:true},
			{ text: 'Net Total', datafield: 'netotal', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname,hidden:true},
			{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
			{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true},
			{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true },
			{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
			{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
			{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true },
			{text: 'stockid', datafield: 'stkid', width: '10%',cellclassname: cellclassname,hidden:true},
			{text: 'remarks', datafield: 'remarks', width: '10%',cellclassname: cellclassname,hidden:true},
			{text: 'reqbrhid', datafield: 'reqbrhid', width: '10%',cellclassname: cellclassname,hidden:true},
			{text: 'reqlocid', datafield: 'reqlocid', width: '10%',cellclassname: cellclassname,hidden:true},
		      ]
   
    });
	
    $('.load-wrapp').hide();
    
    
});
     
     
   

</script>
<div id="invissuegriddet"></div>