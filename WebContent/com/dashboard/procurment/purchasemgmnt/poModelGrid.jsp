<%@page
	import="com.dashboard.procurment.purchasemgmnt.ClsPurchasemgmntDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%
 String chk = request.getParameter("id")==null?"0":request.getParameter("id").trim();

String fromdate = request.getParameter("fdate")==null?"0":request.getParameter("fdate").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String divname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
	String branchval = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
	String prdid = request.getParameter("prdid")==null?"0":request.getParameter("prdid").trim();
  	String vndtax = request.getParameter("vndtax")==null?"0":request.getParameter("vndtax").trim();
  	System.out.println("vndtax : "+vndtax);

ClsPurchasemgmntDAO DAO= new ClsPurchasemgmntDAO();      
%>
<script type="text/javascript">
        
        
var rendererstring1=function (aggregates){
   	var value=aggregates['sum'];
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
   }    

var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
}
        $(document).ready(function () { 	
        	var modalreqgriddata=[];
        	var id='<%=chk%>';
            if(id=="1"){
            	modalreqgriddata='<%=DAO.getPrDetails(fromdate,todate,docno,branchval,prdid,chk,session,vndtax)%>';
            } 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'doc_no', type: 'int'  },
  	              {name : 'voc_no', type: 'int'  },
  					{name : 'date', type: 'date'  },
  				 
  					{name : 'qty', type: 'number'  },
  					
  					{name : 'productid', type: 'String'  },
  					{name : 'productname', type: 'String'  },
  					{name : 'unit', type: 'String'  },
  					{name : 'unitdoc', type: 'String'  },
  					{name : 'specid', type: 'String'  },
  					{name : 'taxdocno', type: 'String'  },
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
  					
  					 
  					
  					
  					{name : 'clstatus', type: 'Int'  }, 
  					
  					
  					
  					{name : 'hidtax', type: 'number'  },
  					{name : 'taxper', type: 'number'  },
  					{name : 'taxamount', type: 'number'  }, 
  					{name : 'nettaxamount', type: 'number'  }, 
  					{name : 'psrno', type: 'number'  }, 
                     
                        ],
                		    localdata: modalreqgriddata, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
                if (data.flag == 1) {
                    return "redClass";
                };
            }; 
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#PurOrdGrid").jqxGrid(
            {
                width: '95%',
                height: 297,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable:true,
                showaggregates:true,
                showstatusbar:true,
                columns: [
                	{ text: 'SL#', sortable: false, filterable: false, editable: false,
                        groupable: false, draggable: false, resizable: false,
                        datafield: 'sl', columntype: 'number', width: '2%',
                        cellsrenderer: function (row, column, value) {
                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        }    
                      },
                      { text: 'PR No', datafield: 'voc_no',  width: '5%', editable: false },
                      { text: 'docno', datafield: 'doc_no',  width: '5%', editable: false,hidden:true },
            	         { text: 'Product Id', datafield: 'productid',  width: '8%', editable: false }, 
            	         { text: 'Product Name', datafield: 'productname', editable: false },
            	         { text: 'Unit', datafield: 'unit',  width: '5%' , editable: false},
            	         { text: 'Qty', datafield: 'qty',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right', editable: true,aggregates: ['sum'],aggregatesrenderer:rendererstring},
  		           	 { text: 'Unit Price', datafield: 'amount',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: true},
  		           	 { text: 'Total', datafield: 'total',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: false},
  		             { text: 'Net Total', datafield: 'nettotal',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: false},
  		             
  		             
  		             { text: 'Tax %', datafield: 'taxper',  width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right', editable: false},
  		             { text: 'Tax Amount', datafield: 'taxamount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: false},
  		             { text: ' Total Amount', datafield: 'nettaxamount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: false},
  		             { text: 'Tax %', datafield: 'hidtax',  width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right', editable: false,hidden:true},
  							
						]
            });
            
            $("#PurOrdGrid").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    
                   	 if(datafield=="amount")
               		  {
                   		 var acno=$('#acno').val();
                   		 if(acno==""){
                   		  $.messager.alert('Message','Please Select a Vendor  ','warning');  
                   		  $('#PurOrdGrid').jqxGrid('setcellvalue', rowBoundIndex, "amount",0);
                   		 
                   		 return 0;
                   		 }
                   		var qty= $('#PurOrdGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
                       	var unitprice=	$('#PurOrdGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");	
                       	var total=parseFloat(qty)*parseFloat(unitprice);
                      		
               		    $('#PurOrdGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
               		  $('#PurOrdGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
               		  
               		var netotal=$('#PurOrdGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
            		  var taxper= $('#PurOrdGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper"); 
            		  
            		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
            		  
            		  
            		  $('#PurOrdGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxempamount);
            		  
            		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
            		  
            		  $('#PurOrdGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettaxamount",taxtotalamount);
               		  }
                    });
         
        });
    </script>
    <div id="PurOrdGrid"></div>