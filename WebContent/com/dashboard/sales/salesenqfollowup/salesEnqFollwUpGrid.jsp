
 
 <%@page import="com.dashboard.sales.ClsSalesReportsDAO"%>
 <%
 ClsSalesReportsDAO searchDAO = new ClsSalesReportsDAO(); 
  
     String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
 	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
   	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas;

 if(temp4!='NA')
{ 
	
	 datas='<%=searchDAO.saleEnqFollowUpGridLoding(barchval,fromdate,todate)%>'; 
		// alert(enqdata); --%>
} 
else
{ 
	
	datas;
	
	}  

$(document).ready(function () {
    // prepare the data
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
						 {name : 'fdate', type: 'date'  },
						 {name : 'specno', type: 'int'  },
						 {name : 'brhid', type: 'int'  },
						 {name : 'doc_no', type: 'int'  },
						 {name : 'prodoc', type: 'int'  },
						 
			 
						
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
    
    
   
   
    
    $("#enquirylistGrid").jqxGrid(
    {
        width: '98%',
        height: 400,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
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
          
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                  { text: 'Doc No',datafield: 'voc_no', width: '6%' },
         		  { text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
         		  { text: 'Ref No',datafield: 'ref_no', width: '14%' },
           	      { text: 'Product Id', datafield: 'productid',  width: '16%' }, 
           	      { text: 'Product Name', datafield: 'productname',  width: '22%' },
           	      { text: 'Unit', datafield: 'unit',  width: '10%' },
           	      { text: 'Quantity', datafield: 'qty',  width: '10%' ,cellsformat:'d2'},
           	      { text: 'Follow up Date', datafield: 'fdate', width: '8%',cellsformat:'dd.MM.yyyy' },
           	   { text: 'prodoc',datafield: 'prodoc', width: '6%',hidden:true},
           	{ text: 'Brhid',datafield: 'brhid', width: '6%',hidden:true },
           	{ text: 'Doc No',datafield: 'doc_no', width: '6%' ,hidden:true},  
           			
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#enquirylistGrid').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
        
        document.getElementById("docno").value= $('#enquirylistGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");  
        
        
        document.getElementById("branchids").value= $('#enquirylistGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
        
   /*   document.getElementById("specno").value= $('#enquirylistGrid').jqxGrid('getcellvalue', rowindex1, "specno"); */
        
        document.getElementById("prodoc").value= $('#enquirylistGrid').jqxGrid('getcellvalue', rowindex1, "prodoc");
         
  
        
        $('#date').jqxDateTimeInput({ disabled: false});
    	
   	 $('#cmbinfo').attr("disabled",false);
   	 $('#remarks').attr("readonly",false);
   	 $('#Update').attr("disabled",false); 
        

	       $("#detaildiv").load("detailgrid.jsp?rdoc="+$('#enquirylistGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+"&prodoc="+$('#enquirylistGrid').jqxGrid('getcellvalue', rowindex1, "prodoc"));
	    
	 
      
    });  
   
    
   
});


</script>
<div id="enquirylistGrid"></div>