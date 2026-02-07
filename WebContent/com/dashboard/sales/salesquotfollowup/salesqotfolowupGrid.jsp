
 
 <%@page import="com.dashboard.sales.ClsSalesReportsDAO"%>
 <% ClsSalesReportsDAO searchDAO = new ClsSalesReportsDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	String acno = request.getParameter("acno")==null?"NA":request.getParameter("acno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
	String ostk = request.getParameter("ostk")==null?"0":request.getParameter("ostk").trim();
	String quotdocno = request.getParameter("quotdocno")==null?"0":request.getParameter("quotdocno").trim();
	
  	
 %> 
       
   <style type="text/css">
  .advanceClass
  {
       background-color: #f2e98c;
  }
  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        
        }
</style>
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas;

 if(temp4!='NA')
{ 
	
	 datas='<%=searchDAO.qotfollowsearch(barchval,fromdate,todate,statusselect,acno,ostk,quotdocno)%>'; 
		// alert(enqdata); --%>
} 
else
{ 
	
	datas;
	
	}  

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
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     
 
                        {name : 'voc_no', type: 'int'  },
						{name : 'date', type: 'date'  },
					 
						{name : 'qty', type: 'number'  },
						
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'unit', type: 'String'  },
						{name : 'refno', type: 'String'  },
						
						
						{name : 'dtype', type: 'String'  },
						
						{name : 'out_qty', type: 'number'  },
						
						{name : 'balqty', type: 'number'  },
						
						{name : 'amount', type: 'number'  },
						
						{name : 'total', type: 'number'  },
						
						{name : 'disper', type: 'number'  },
						{name : 'discount', type: 'number'  },
						{name : 'nettotal', type: 'number'  },
						
						{name : 'account', type: 'String'  },      
						{name : 'acname', type: 'String'  }, 
						
						
					    {name : 'doc_no', type: 'int'  },
						
						{name : 'clstatus', type: 'Int'  }, 
						
						 {name : 'fdate', type: 'date'  },
							{name : 'prodoc', type: 'Int'  }, 
							
							{name : 'specno', type: 'Int'  }, 
							{name : 'brhid', type: 'Int'  }, 
							
							{name : 'val', type: 'Int'  },
							{name : 'stkqty', type: 'number'  }, 
							{name : 'totstkqty', type: 'number'  }, 
							
							
							  
						
						],
				    localdata: datas,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname =  function (row, column, value, data) {


   	  var ss= $('#salqotlistgrid').jqxGrid('getcellvalue', row, "clstatus");
   		          if(parseInt(ss)>0)
   		  		{
   		  		
   		  		return "yellowClass";
   		  	
   		  		}
   		    	  var ss1= $('#salqotlistgrid').jqxGrid('getcellvalue', row, "val");
   		          if(parseInt(ss1)>0)
   		  		{
   		  		
   		  		return "advanceClass";
   		  	
   		  		}  
   	    	/* return "greyClass";
   	    	
   		        var element = $(defaultHtml);
   		        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
   		        return element[0].outerHTML;
   	*/

   		}

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#salqotlistgrid").jqxGrid(
    {
        width: '99.5%',
        height: 450,
        source: dataAdapter,
        
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
     
  
        
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '3%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                   
                   { text: 'doc_no ',datafield: 'doc_no', width: '4%' ,cellclassname: cellclassname ,hidden:true},
                     { text: 'Doc No',datafield: 'voc_no', width: '4%' ,cellclassname: cellclassname},
         			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
         		 
         			 { text: 'Type',datafield: 'dtype', width: '5%',cellclassname: cellclassname },
         		     { text: 'Account', datafield: 'account',  width: '5%' ,cellclassname: cellclassname },
                     { text: 'Account Name', datafield: 'acname',  width: '14%' ,cellclassname: cellclassname },
           	         { text: 'Product Id', datafield: 'productid',  width: '10%',cellclassname: cellclassname }, 
           	         { text: 'Product Name', datafield: 'productname',  width: '22%',cellclassname: cellclassname },  
           	         { text: 'Unit', datafield: 'unit',  width: '4%' ,cellclassname: cellclassname},
     
           	         
           	         { text: ' Qty', datafield: 'qty',  width: '5%' ,cellsformat:'d2',cellclassname: cellclassname},
           	         
           	        { text: 'Out Qty', datafield: 'out_qty',  width: '5%' ,cellsformat:'d2',cellclassname: cellclassname},
		           	 { text: 'Bal. Qty', datafield: 'balqty',  width: '5%' ,cellsformat:'d2',cellclassname: cellclassname},
		           	 
		        	 { text: 'Stock Qty', datafield: 'stkqty',  width: '5%' ,cellsformat:'d2',cellclassname: cellclassname},
		        	 { text: 'Total Stock Qty', datafield: 'totstkqty',  width: '8%' ,cellsformat:'d2',cellclassname: cellclassname},
		        	 { text: 'val', datafield: 'val', width: '8%',hidden:true  },
		       
           	        /*  
           	      	 { text: 'Unit Price', datafield: 'amount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		           	 { text: 'Total', datafield: 'total',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		           	 { text: 'Discount %', datafield: 'disper',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		           	 { text: 'Discount', datafield: 'discount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
		             { text: 'Net Total', datafield: 'nettotal',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
							 */
		         	{ text: 'Follow up Date', datafield: 'fdate', width: '7%',cellsformat:'dd.MM.yyyy' },
		         	
		        	{ text: 'brhid', datafield: 'brhid', width: '8%'  ,hidden:true},
		         	
					
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#salqotlistgrid').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
        
        document.getElementById("docno").value= $('#salqotlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");  
        
        
        document.getElementById("branchids").value= $('#salqotlistgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
        
        document.getElementById("specno").value= $('#salqotlistgrid').jqxGrid('getcellvalue', rowindex1, "specno");
        
        document.getElementById("prodoc").value= $('#salqotlistgrid').jqxGrid('getcellvalue', rowindex1, "prodoc");
        
  
        
        $('#date').jqxDateTimeInput({ disabled: false});
    	
   	 $('#cmbinfo').attr("disabled",false);
   	 $('#remarks').attr("readonly",false);
   	 $('#Update').attr("disabled",false); 
        

	       $("#detaildiv").load("detailgrid.jsp?rdoc="+$('#salqotlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+"&specno="+$('#salqotlistgrid').jqxGrid('getcellvalue', rowindex1, "specno")+"&prodoc="+$('#salqotlistgrid').jqxGrid('getcellvalue', rowindex1, "prodoc"));
	    
	 
      
    });  
   
    
   
    
});


</script>
<div id="salqotlistgrid"></div>