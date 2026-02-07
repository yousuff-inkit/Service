
 
 <%@page import="com.dashboard.purchases.nipurchaseorderfollowup.ClsNIPurchaseOrderFollowupDAO"%>
 <% ClsNIPurchaseOrderFollowupDAO searchDAO = new ClsNIPurchaseOrderFollowupDAO(); 
 
    String docno = request.getParameter("docno")==null?"NA":request.getParameter("docno").trim();
 
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=docno%>';
var datas11;

 if(temp4!='NA')
{ 
	 
	<%--  datas11ex='<%=searchDAO.orderlistsubsearchEx(docno)%>'; --%> 
	 datas11='<%=searchDAO.orderlistsubsearch(docno)%>'; 
	 
	 
	 
		 
} 
else
{ 
	
	datas11;
	 
	}  
 var list =['GL','HR'];
$(document).ready(function () {
	
	  var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
   var rendererstring=function (aggregates){
   	var value=aggregates['sum'];
 	 if(typeof(value) == "undefined"){
         value=0.00;
        }
 	
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     
 
                     
					 
						{name : 'qty', type: 'number'  },
						
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'unit', type: 'String'  },
					 
						{name : 'brandname', type: 'String'  },
						{name : 'srno', type: 'String'  },
						
						{name : 'type', type: 'String'  },
						{name : 'account', type: 'String'  },
						{name : 'accname', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'costgroup', type: 'String'  },
						{name : 'costcode', type: 'String'  },
						{name : 'costtype', type: 'String'  },
						{name : 'grtype', type: 'String'  },
						{name : 'out_qty', type: 'number'  },
						{name : 'accountnw', type: 'String'  },
						{name : 'headdoc', type: 'String'  },
						{name : 'amount', type: 'number'  },
						
						{name : 'total', type: 'number'  },
						
						{name : 'disper', type: 'number'  },
						{name : 'discount', type: 'number'  },
						{name : 'nettotal', type: 'number'  },
						
						{name : 'psrno', type: 'number'  },
						
						

						{name : 'taxper', type: 'number'  },
						{name : 'taxamount', type: 'number'  },
						{name : 'totalamount', type: 'number'  },
						{name : 'slno', type: 'number'    },
				  
			 
						
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
    
    
   
   
    
    $("#ordersubgrid").jqxGrid(
    {
        width: '100%',
        height: 230,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        columnsresize: true,
        
        selectionmode: 'checkbox',
        pagermode: 'default',
        editable:true,
        columns: [   
                  
        	     { text: 'Sr.No', datafield: 'slno', width: '3%' }, 
           	        /*  { text: 'Product Id', datafield: 'productid',  width: '13%' },  */
           	         { text: 'Product Name', datafield: 'productname'  },
           	      /* 	 { text: 'Brand Name', datafield: 'brandname',  width: '10%' },
           	         { text: 'Unit', datafield: 'unit',  width: '5%' }, */
           	         { text: 'Qty', datafield: 'qty',  width: '5%' ,cellsformat:'d2'},
           	         { text: 'Out Qty', datafield: 'out_qty',  width: '5%' ,cellsformat:'d2'},
		           	 { text: 'Unit Price', datafield: 'amount',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
		           	 { text: 'Total', datafield: 'total',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		           	 /* { text: 'Discount %', datafield: 'disper',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right'}, */
		           	 { text: 'Discount', datafield: 'discount',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Net Total', datafield: 'nettotal',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Taxper', datafield: 'taxper',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Tax Amount', datafield: 'taxamount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Total Amount', datafield: 'totalamount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		             { text: 'Type', datafield: 'type', width: '4%', cellsalign: 'center',align: 'center',columntype:'dropdownlist',editable: true,createeditor: function (row, column, editor) {
                         editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                     }
					    },
					{ text: 'Account', datafield: 'accountnw', width: '4%' ,editable: true,cellsalign: 'center', align:'center'},
					{ text: 'Account Name', datafield: 'accname', width: '12%' ,editable: false},
					{ text: 'Cost Type', datafield: 'costgroup', width: '8%',editable: true },
					{ text: 'Cost Code', datafield: 'costcode', width: '6%',editable: true },
					{ text: 'Remarks', datafield: 'remarks', width: '20%' ,editable: true},
		             {text: 'srno', datafield: 'srno', width: '10%',hidden:true},
		             {text: 'psrno', datafield: 'psrno', width: '10%',hidden:true},
		             {text: 'grtype', datafield: 'grtype', width: '10%',hidden:true},
		             {text: 'headdoc', datafield: 'headdoc', width: '10%',hidden:true},
		             {text: 'costtype', datafield: 'costtype', width: '10%',hidden:true},
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $("#ordersubgrid").on('cellclick', function (event) 
    		{

	   var rowindextemp2 = event.args.rowindex;
       //document.getElementById("rowindex").value = rowindextemp2;
       //document.getElementById("rowindex1").value = rowindextemp2;
/*        alert(event.args.datafield); */
       
       if(event.args.datafield=="account")
    	   {
    	
       $("#ordersubgrid").jqxGrid('clearselection');
    	   }
       if(event.args.datafield=="costgroup")
	   {
	
       $("#ordersubgrid").jqxGrid('clearselection');
	   } 
       if(event.args.datafield=="costcode")
	   {
	
       $("#ordersubgrid").jqxGrid('clearselection');
	   } 
       
   
       
            }); 
    $('#ordersubgrid').on('celldoubleclick', function (event) {
    	
  	  var refno=document.getElementById("masterdocno").value;

	
  	
      if(event.args.datafield=="accountnw")
	   {
	
      var rowindextemp = event.args.rowindex;
      document.getElementById("rowindex1").value = rowindextemp;
     
      $('#ordersubgrid').jqxGrid('clearselection');
         var value = $('#ordersubgrid').jqxGrid('getcellvalue', rowindextemp, "type");
               CashSearchContent('accountGridSearch.jsp?atype='+value);
             } 
      if(event.args.datafield=="costgroup")
	   {
     var rowindextemp1 = event.args.rowindex;
     document.getElementById("rowindex").value = rowindextemp1;
     $('#ordersubgrid').jqxGrid('clearselection');
     var value = $('#ordersubgrid').jqxGrid('getcellvalue', rowindextemp1, "grtype"); 
 
              costSearchContent('costtypegridsearch.jsp?');
          
              
            } 
      if(event.args.datafield=="costcode")
	   {
	
     var rowindextemp2 = event.args.rowindex;
     document.getElementById("rowindex").value = rowindextemp2;
     $('#ordersubgrid').jqxGrid('clearselection');
     
     var value = $('#ordersubgrid').jqxGrid('getcellvalue', rowindextemp2, "grtype"); 
    
     
        var values = $('#ordersubgrid').jqxGrid('getcellvalue', rowindextemp2, "costtype");
        var aa="ordersubgrid";
        costcodeSearchContent('../../../../com/costcenter/costCodeSearchGrid.jsp?costtype='+values+'&formname='+aa);
        
                 
            } 
       
      
      
       });
});


</script>
<div id="ordersubgrid"></div>