<%@page
	import="com.dashboard.procurment.purchasemgmnt.ClsPurchasemgmntDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%
 String chk = request.getParameter("id")==null?"0":request.getParameter("id").trim();
String fromdate = request.getParameter("fdate")==null?"0":request.getParameter("fdate").trim();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String billtype=request.getParameter("billtype")==null?"0":request.getParameter("billtype").trim();
String acno=request.getParameter("acno")==null?"0":request.getParameter("acno").trim(); 
ClsPurchasemgmntDAO DAO= new ClsPurchasemgmntDAO();      
%>
<script type="text/javascript">


        
var pivrendererstring1=function (aggregates){
   	var value=aggregates['sum'];
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
   }    

var pivrendererstring=function (aggregates){
	var value=aggregates['sum'];
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
}
        $(document).ready(function () { 	
        	var modalpivgriddata=[];
        	var id='<%=chk%>';
            if(id=="1"){
            	modalpivgriddata='<%=DAO.reqgridreload(docno,session,fromdate,billtype,acno)%>'; 
            } 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'pivproductid', type: 'string'    },
            		{name : 'pivproductname', type: 'string'    },
            		{name : 'pivunit', type: 'String'    },
						{name : 'pivqty', type: 'number'    },
						{name : 'pivunitprice', type: 'number'    },
						{name : 'pivtotal', type: 'number'    },
						{name : 'pivdiscount', type: 'number'    },       
					
						{name : 'pivnettotal', type: 'number'    },
						{name : 'pivprodoc', type: 'number'    },
						{name : 'pivunitdocno', type: 'number'    },
						{name : 'pivsrno', type: 'number'    },
						
						{name : 'pivqutval', type: 'number'    },
						{name : 'pivsaveqty', type: 'number'    },
						
						{name : 'pivdiscper', type: 'number'    },
						
						{name : 'pivchecktype', type: 'number'    },   //no use
						{name : 'pivpqty', type: 'number'    },
						
				     	{name : 'pivproid', type: 'string'    },
            		{name : 'pivproname', type: 'string'    },
            		{name : 'pivspecid', type: 'string'  },
            		
            		 {name : 'pivfoc', type: 'number'    },  
            		{name : 'pivstockid', type: 'number'  },
            		
            		 
            		  {name : 'pivoldqty', type: 'number'  },
            		  {name : 'pivcost_price', type: 'number'  },
            		  {name : 'brhid', type: 'number'  },
            		  
            		  
            		  {name : 'pivorderdiscper', type: 'string'    },
						
						{name : 'pivorderamount', type: 'string'    },
						{name : 'pivbrandname', type: 'string'    },
						
						
					 {name : 'pivtaxper', type: 'number'  },  
					 {name : 'pivtaxamount', type: 'number'  },
					{name : 'pivtaxperamt', type: 'number'  },
            		//  orderdiscper,orderamount
            		
					  {name : 'pivexp_date', type: 'date'    },
					  {name : 'pivbatch_no', type: 'string'    },
					
					  
					  
					  {name : 'pivtaxdocno', type: 'string'},    
					  {name : 'pivcurid', type: 'number'},    
					  {name : 'pivrate', type: 'number'},    
                     
                        ],
                		    localdata: modalpivgriddata, 
                
                
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
            
            $("#pivGrid").jqxGrid(
            {
                width: '95%',
                height: 200,
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
                  	{ text: 'Product Name', datafield: 'pivproductname',  cellclassname: cellclassname ,columntype: 'custom',  editable: false 
						
						}, 
						{ text: 'Brand Name', datafield: 'pivbrandname', width: '10%',cellclassname: cellclassname,  editable: false },
						{ text: 'Unit', datafield: 'unit', width: '5%',cellclassname: cellclassname,  editable: false,aggregates: ['sum1'],aggregatesrenderer:pivrendererstring1 },
						
			 
						 { text: 'oldqty', datafield: 'pivoldqty', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
						  
						{ text: 'Quantity', datafield: 'pivqty',cellsalign: 'right', width: '4%' ,align:'right',cellclassname: cellclassname,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:pivrendererstring,
						},
						{ text: 'FOC', datafield: 'pivfoc', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
			 
						{ text: 'Unit Price', datafield: 'pivunitprice', width: '7%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2',cellclassname: cellclassname ,
						},
						{ text: 'Total', datafield: 'pivtotal', width: '7%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2' ,cellclassname: cellclassname,
						},
						{text: 'Discount %', datafield: 'pivdiscper', width: '7%' ,  cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname,
						},
						{ text: 'Discount', datafield: 'pivdiscount', width: '6%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum'],aggregatesrenderer:pivrendererstring,cellclassname: cellclassname,
						},
						{ text: 'Net Amount', datafield: 'pivnettotal', width: '8%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:pivrendererstring ,editable: false,cellclassname: cellclassname},
						
						{ text: 'Cost Price', datafield: 'pivcost_price', width: '7%',cellsformat:'d2',cellsalign: 'right', align:'right',editable: false,cellclassname: cellclassname,hidden:true},
		
						{text: 'prodoc', datafield: 'pivprodoc', width: '10%' ,hidden:true},
						{text: 'unitdocno', datafield: 'pivunitdocno', width: '10%',hidden:true  },
						{text: 'psrno', datafield: 'pivsrno', width: '10%',hidden:true },
						
						{text: 'stockid', datafield: 'pivstockid', width: '10%' ,hidden:true },
						
						
						{text: 'qutval', datafield: 'pivqutval', width: '10%' ,cellsformat:'d2',hidden:true   },
						{ text: 'pqty', datafield: 'pivpqty', width: '9%',cellsformat:'d2' ,hidden:true  },
						{text: 'saveqty', datafield: 'pivsaveqty', width: '10%' ,cellsformat:'d2',hidden:true     },
					 
						{text: 'pid', datafield: 'pivproid', width: '10%' ,hidden:true   }, 
						{text: 'pname', datafield: 'pivproname', width: '10%'   ,hidden:true}, 
						
						 
						{text: 'checktype', datafield: 'pivchecktype', width: '10%'  ,hidden:true},    
						{text: 'specid', datafield: 'pivspecid', width: '10%' ,hidden:true  },
						
					//  orderdiscper,orderamount		
                   {text: 'orderdiscper', datafield: 'pivorderdiscper', width: '10%'  ,hidden:true  },
				     {text: 'orderamount', datafield: 'pivorderamount', width: '10%'   ,hidden:true },
			 
						
						{ text: 'Tax %', datafield: 'pivtaxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
						{ text: 'Tax Amount', datafield: 'pivtaxperamt', width: '5%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:pivrendererstring},
						
						{ text: 'Total Amount', datafield: 'pivtaxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:pivrendererstring ,editable:false },
					
						   {text: 'taxdocno', datafield: 'pivtaxdocno', width: '10%'   ,hidden:true  },
						
						{text: 'Batch No', datafield: 'pivbatch_no', width: '8%' ,hidden:true  },
						/* {text: 'Currency', datafield: 'pivcurid', width: '8%' ,hidden:  },
						{text: 'Rate', datafield: 'pivrate', width: '8%' ,hidden:false }, */
						{text: 'Exp Date', datafield: 'pivexp_date', width: '7%' ,columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'dd.MM.yyyy',hidden:true },	   
  							
						]
            });
            function qtyChanged(datafield,rowBoundIndex,val){
            	if(datafield=='pivqty'){
				var unitprice=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivunitprice");
				var total=parseFloat(val)*parseFloat(unitprice);
				//Setting Discount
				var disper=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivdiscper");
				var disamount=parseFloat(disper)/100;
				var netamount=parseFloat(total)-parseFloat(disamount);
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivtotal",total);

				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivdiscount",disamount);
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivnettotal",netamount);
				//setting tax
				var taxamount=0.0;
				var taxper=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivtaxper");
				if(taxper>0){
					 taxamount=parseFloat(taxper)/100;
					 taxamount=parseFloat(taxamount)*parseFloat(netamount);
				}
				
				var totalamount=parseFloat(netamount)+parseFloat(taxamount);
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivtaxperamt",taxamount);
				//Setting netamount
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivtaxamount",totalamount);
				//setting taxtotal
            	}
            	if(datafield=='pivunitprice'){
				var qty=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivqty");
				var total=parseFloat(val)*parseFloat(qty);
				//Setting Discount
				var disper=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivdiscper");
				var disamount=parseFloat(disper)/100;
				var netamount=parseFloat(total)-parseFloat(disamount);
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivtotal",total);

				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivdiscount",disamount);
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivnettotal",netamount);
				//setting tax
				var taxamount=0.0;
				var taxper=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivtaxper");
				if(taxper>0){
					 taxamount=parseFloat(taxper)/100;
					 taxamount=parseFloat(taxamount)*parseFloat(netamount);
				}
				
				
				
				var totalamount=parseFloat(netamount)+parseFloat(taxamount);
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivtaxperamt",taxamount);
				//Setting netamount
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivtaxamount",totalamount);
				//setting taxtotal
            	}
            	if(datafield=='pivdiscper'){
				//Setting Discount
				//alert("Disc per")
				//var disper=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivdiscper");
				var total=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivtotal");
				var disamount=parseFloat(val)/100;
				disamount=parseFloat(total)*parseFloat(disamount);
				var netamount=parseFloat(total)-parseFloat(disamount);
				var total=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivtotal",total);

				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivdiscount",disamount);
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivnettotal",netamount);
				//setting tax
				var taxamount=0.0;
				var taxper=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivtaxper");
				if(taxper>0){
					 taxamount=parseFloat(taxper)/100;
					 taxamount=parseFloat(taxamount)*parseFloat(netamount);
				}
				
				var totalamount=parseFloat(netamount)+parseFloat(taxamount);
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivtaxperamt",taxamount);
				//Setting netamount
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivtaxamount",totalamount);
				//setting taxtotal
            	}
            	if(datafield=='pivdiscount'){
				//Setting Discount
								//alert("Disc amount")

				//var disper=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivdiscper");
				var total=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivtotal");
				/* var disamount=parseFloat(val)/100;
				disamount=parseFloat(total)*parseFloat(disamount); */
				var disper=(parseFloat(val)*100)/parseFloat(total);
				var netamount=parseFloat(total)-parseFloat(val);
				var total=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivtotal",total);

				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivdiscper",disper);
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivnettotal",netamount);
				//setting tax
				var taxamount=0.0;
				var taxper=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivtaxper");
				if(taxper>0){
					 taxamount=parseFloat(taxper)/100;
					 taxamount=parseFloat(taxamount)*parseFloat(netamount);
				}
				
				
				var totalamount=parseFloat(netamount)+parseFloat(taxamount);
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivtaxperamt",taxamount);
				//Setting netamount
				$('#pivGrid').jqxGrid('setcellvalue', rowBoundIndex, "pivtaxamount",totalamount);
				//setting taxtotal
            	}
            }
              $("#pivGrid").on('cellendedit', function (event) 
                    {
            	  		var datafield = event.args.datafield;
            		    var rowBoundIndex = event.args.rowindex;
						var qty=$('#pivGrid').jqxGrid('getcellvalue', rowBoundIndex, "pivqty");
						if(event.args.value>=0){
							//qty=event.args.value;
							qtyChanged(datafield,rowBoundIndex,event.args.value);
						}
                
                    }); 
         
        });
    </script>
    <div id="pivGrid"></div>