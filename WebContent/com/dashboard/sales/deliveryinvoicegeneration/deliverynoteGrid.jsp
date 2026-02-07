
 
 <%@page import="com.dashboard.sales.deliveryinvoicegeneration.ClsDeliveryInvoiceGenerationDAO"%>
 <% ClsDeliveryInvoiceGenerationDAO searchDAO = new ClsDeliveryInvoiceGenerationDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	String acno = request.getParameter("acno")==null?"NA":request.getParameter("acno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas;

 if(temp4!='NA')
{ 
	
	 datas='<%=searchDAO.deliveryNotelistsearch(barchval,fromdate,todate,statusselect,acno)%>'; 
	 
	 datass='<%=searchDAO.deliveryNotelistsearchex(barchval,fromdate,todate,statusselect,acno)%>'; 
		// alert(enqdata); --%>
} 
else
{ 
	
	datas;
	
	}  

$(document).ready(function () {
	 chkfoc();
	  var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
   var rendererstring=function (aggregates){
   	var value=aggregates['sum'];
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     
 
                        {name : 'voc_no', type: 'int'  },
                        {name : 'doc_no', type: 'int'  },
						{name : 'date', type: 'date'  },
					 
						{name : 'qty', type: 'number'  },
						
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'brhid', type: 'String'  },
						{name : 'specid', type: 'String'  },
						{name : 'unit', type: 'String'  },
						{name : 'unitdocno', type: 'String'  },
						{name : 'refno', type: 'String'  },
						{name : 'locid', type: 'String'  },
						
						{name : 'dtype', type: 'String'  },
						
						{name : 'out_qty', type: 'number'  },
						{name : 'prodoc', type: 'number'  },
						{name : 'balqty', type: 'number'  },
						
			 
						
						{name : 'account', type: 'String'  },      
						{name : 'acname', type: 'String'  }, 
						
						
						{name : 'foc', type: 'number'  },
						{name : 'foc_out', type: 'number'  },
						
						{name : 'focbal', type: 'number'  },
						 {name : 'taxper', type: 'number'  },  
	       					 {name : 'taxamount', type: 'number'  },
	       					{name : 'nettaxamount', type: 'number'  }, 
	       					{name : 'unitprice', type: 'number' },
     						{name : 'total', type: 'number' },
     						{name : 'disper', type: 'number' },
     						{name : 'discount', type: 'number' },
     						{name : 'nettotal', type: 'number' },
     						{name : 'vattype', type: 'String'  }, 
						
				 
			 
						
						],
				    localdata: datas,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
 
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
    			if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
    			   {
    				value=0.0;
    			   }
    			
    			return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
    		}
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#dellistgrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow:true,
        sortable:true,
        
/*         showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21, */
        
        selectionmode: 'checkbox',
        pagermode: 'default',
        editable:false,
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
 
                     { text: 'Doc No',datafield: 'voc_no', width: '5%' },
                     { text: 'docno',datafield: 'doc_no', width: '5%',hidden:true },
                     { text: 'brhid',datafield: 'brhid', width: '5%',hidden:true },
                     { text: 'unitdocno',datafield: 'unitdocno', width: '5%',hidden:true },
                     { text: 'prodoc',datafield: 'prodoc', width: '5%',hidden:true },
                     { text: 'locid',datafield: 'locid', width: '5%',hidden:true },
         			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},
         			 { text: 'VatType', datafield: 'vattype',  width: '6%'  },
         			 { text: 'Ref No',datafield: 'ref_no', width: '10%',hidden:true },
         			 { text: 'Type',datafield: 'dtype', width: '8%',hidden:true },
         		     { text: 'Account', datafield: 'account',  width: '5%'  },
                     { text: 'Account Name', datafield: 'acname',  width: '12%'  },
           	         { text: 'Product Id', datafield: 'productid',  width: '14%' }, 
           	         { text: 'Product Name', datafield: 'productname',  width: '25%' },
           	         { text: 'Unit', datafield: 'unit',  width: '5%' },
           	         { text: 'Total Qty', datafield: 'qty',  width: '6%' ,cellsformat:'d2'},
           	         { text: 'Out Qty', datafield: 'out_qty',  width: '6%' ,cellsformat:'d2',hidden:true},
		           	 { text: 'Balance Qty', datafield: 'balqty',  width: '6%' ,cellsformat:'d2',hidden:true },
		           	 
		           	 { text: 'FOC Qty', datafield: 'foc',  width: '6%' ,cellsformat:'d2' ,hidden:true},
		           	 { text: 'FOC Out Qty', datafield: 'foc_out',  width: '6%' ,cellsformat:'d2' ,hidden:true },
		           	
		           	 { text: 'FOC Balance Qty', datafield: 'focbal',  width: '8%' ,cellsformat:'d2' ,hidden:true },
		         	{ text: 'Unit price', datafield: 'unitprice', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,editable:false },
					{ text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1   },
				    { text: 'Discount %', datafield: 'disper', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,editable:false,hidden:true 	},
					{ text: 'Discount', datafield: 'discount', width: '5%', cellsformat: 'd2', cellsalign: 'right',editable:false , align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,hidden:true  }, 
					{ text: 'Net Total', datafield: 'nettotal', width: '7%', cellsformat: 'd2', cellsalign: 'right'  , align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false },
			/* 		{text: 'Batch No', datafield: 'batch_no', width: '11%' ,editable:false },
					{text: 'Exp Date', datafield: 'exp_date', width: '6%' ,columntype: 'datetimeinput', align: 'left',editable:false , cellsalign: 'left',cellsformat:'dd.MM.yyyy'},
			 */
					
								 
					
					{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false},
					{ text: 'Tax Amount', datafield: 'taxamount', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					
					{ text: 'Net Total', datafield: 'nettaxamount', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
		         	
 

					 
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#dellistgrid').on('rowselect', function (event) 
	    		{ 
    	$('#duedate').jqxDateTimeInput({disabled: false});
		     $("#txtlocation").attr("disabled",false); 
			 $("#refnos").attr("disabled",false); 
			 $("#description").attr("disabled",false); 
			 $("#updatdata").attr("disabled",false); 
			 $('#date').jqxDateTimeInput({disabled: false});
			  var rowindex1=event.args.rowindex;
			   var ddoc=document.getElementById("hiddoc").value;
			   var clntacno=$('#dellistgrid').jqxGrid('getcellvalue', rowindex1, "account");
			  // alert("ddoc1===="+ddoc);
			   if(ddoc!="" && ddoc!=null && ddoc!="undefiend"){
			   ddoc=ddoc+","+$('#dellistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
			   }else{
				   ddoc=$('#dellistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
			   }
			   //alert("ddoc===="+ddoc);
			   document.getElementById("hiddoc").value=ddoc;
 			   document.getElementById("masterdoc_no").value=ddoc;
 			   
 			 document.getElementById("branchvals").value=$('#dellistgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
 			var nettotal= $('#dellistgrid').jqxGrid('getcellvalue', rowindex1, "nettotal");
 			if(parseFloat(nettotal)==0){
 				$.messager.alert('Message','Total Value Is 0','warning');
 				  $('#dellistgrid').jqxGrid('unselectrow', rowindex1);
 			}
    	var vatype=$('#dellistgrid').jqxGrid('getcellvalue', rowindex1, "vattype");
    	var chkacno=$('#dellistgrid').jqxGrid('getcellvalue', rowindex1, "account");
    	 var rows = $("#dellistgrid").jqxGrid('getrows');
    	 var selectedrows = $("#dellistgrid").jqxGrid('selectedrowindexes');
		//  selectedrows = selectedrows.sort(function(a,b){return a - b});
		 // alert("vatype==="+vatype);
		  for(var i=0 ; i < selectedrows.length ; i++){ 
			  //alert("rowindex1==="+rowindex1);
			  var count=selectedrows.length;
			  var chk=selectedrows[i];
			  if(parseInt(count)>1){
					  if(parseInt(rowindex1)!=parseInt(chk)){
						  var vatypenw=$('#dellistgrid').jqxGrid('getcellvalue', chk, "vattype");
						  var chkacnonw=$('#dellistgrid').jqxGrid('getcellvalue', chk, "account");
						  //alert("vatype=="+vatype+"==vatypenw=="+vatypenw);
						  if(!(vatype==vatypenw) ){
							  if(vatype==""){
								  
							  }
							  else{
								  $('#dellistgrid').jqxGrid('unselectrow', rowindex1);
								  $.messager.alert('Message','Diffrent VatType Not Allowed','warning');
								  break;
							  }
							 
						  }
						  if(!(parseInt(chkacno)==parseInt(chkacnonw))){
							  $('#dellistgrid').jqxGrid('unselectrow', rowindex1);
							  $.messager.alert('Message','Diffrent Customer Not Allowed','warning');
							  break;
						  }
					  }
		    }
		  }
	    		});
    
  
});
function chkfoc()
{
 
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200)
    {
      var items= x.responseText.trim();
     
      if(parseInt(items)>0)
       {
     
 
    	  $('#dellistgrid').jqxGrid('showcolumn', 'foc');
    	  $('#dellistgrid').jqxGrid('showcolumn', 'foc_out');
    	  $('#dellistgrid').jqxGrid('showcolumn', 'focbal');
    	  
    
    	  
    	  
        }
          else
      {
      
        	  $('#dellistgrid').jqxGrid('hidecolumn', 'foc');
        	  $('#dellistgrid').jqxGrid('hidecolumn', 'foc_out');
        	  $('#dellistgrid').jqxGrid('hidecolumn', 'focbal');
        	   
      
      }
      
       }}
   x.open("GET","checkfoc.jsp?",true);
	x.send();
 
      
        
	
}

</script>
<div><input type="hidden" id="hiddoc" name="hiddoc"></div>
<div id="dellistgrid"></div>