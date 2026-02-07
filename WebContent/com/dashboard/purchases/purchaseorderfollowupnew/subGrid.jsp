<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.purchases.purchaseorderfollowupnew.ClsPurchaseOrderFollowupNewDAO"%>
<%ClsPurchaseOrderFollowupNewDAO DAO = new ClsPurchaseOrderFollowupNewDAO();%>

<% 
String docnos = request.getParameter("docnos") == null?"0":request.getParameter("docnos").toString();
String accdocno = request.getParameter("accdocno") == null?"0":request.getParameter("accdocno").toString();
String cmbbilltype = request.getParameter("cmbbilltype") == null?"0":request.getParameter("cmbbilltype").toString();
String date = request.getParameter("date") == null?"0":request.getParameter("date").toString();
%>

<script type="text/javascript">

var subGridData='<%=DAO.subGridLoad(session, docnos, accdocno, cmbbilltype, date)%>';  

        $(document).ready(function () { 	
        	chkbrand();
        	chktax();
        	chkbatch();
        	
        	var rendererstring1=function (aggregates){
               	var value=aggregates['sum1'];
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
            }    
            
         	var rendererstring=function (aggregates) {
         		var value=aggregates['sum'];
         		return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
         	}
             
         	var cellclassname =  function (row, column, value, data) {
            	
            }
         	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [     
     						
                      		{name : 'productid', type: 'string'    },
                    		{name : 'productname', type: 'string'    },
                    		{name : 'unit', type: 'String'    },
     						{name : 'qty', type: 'number'    },
     						{name : 'unitprice', type: 'number'    },
     						{name : 'total', type: 'number'    },
     						{name : 'discount', type: 'number'    },       
     					
     						{name : 'nettotal', type: 'number'    },
     						{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						
     						{name : 'qutval', type: 'number'    },
     						{name : 'saveqty', type: 'number'    },
     						
     						{name : 'discper', type: 'number'    },
     						
     						{name : 'checktype', type: 'number'    },   //no use
     						{name : 'pqty', type: 'number'    },
     						
     				     	{name : 'proid', type: 'string'    },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'specid', type: 'string'  },
                    		
                    		{name : 'foc', type: 'number'    },  
                    		{name : 'stockid', type: 'number'  },
                    		 
                    		{name : 'oldqty', type: 'number'  },
                    		{name : 'cost_price', type: 'number'  },
                    		  
                    		{name : 'orderdiscper', type: 'string'    },
       						
       						{name : 'orderamount', type: 'string'    },
       						{name : 'brandname', type: 'string'    },

       						{name : 'taxper', type: 'number'  },  
        					{name : 'taxamount', type: 'number'  },
        					{name : 'taxperamt', type: 'number'  },
                    		
        					{name : 'exp_date', type: 'date'    },
        					{name : 'batch_no', type: 'string'    },
        					
        					{name : 'taxdocno', type: 'string'    },
        					
        					{name : 'brhid', type: 'string'    },
        					{name : 'account', type: 'string'    },
        					{name : 'refrowno', type: 'string'    },
                    		  
                 ],
              
                 localdata: subGridData,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
           
            $("#serviecGrid").on("bindingcomplete", function(event) {
                var rows = $("#serviecGrid").jqxGrid('getrows');

                for (var i = 0; i < rows.length; i++) {
                    var netotal = $('#serviecGrid').jqxGrid('getcellvalue', i, "nettotal");

                    var taxper = $('#serviecGrid').jqxGrid('getcellvalue', i, "taxper");
                    if (parseFloat(taxper) > 0) {
                        var taxempamount = parseFloat(netotal) * (parseFloat(taxper) / 100);

                        $('#serviecGrid').jqxGrid('setcellvalue', i, "taxperamt", taxempamount);

                        var taxtotalamount = parseFloat(netotal) + parseFloat(taxempamount);

                        $('#serviecGrid').jqxGrid('setcellvalue', i, "taxamount", taxtotalamount);
                    } else {
                        $('#serviecGrid').jqxGrid('setcellvalue', i, "taxamount", netotal);
                    }
                }
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            
            $("#serviecGrid").jqxGrid(
            {
                width: '99%',
                height: 250,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                statusbarheight: 21,
                selectionmode: 'checkbox',
                pagermode: 'default',
                
                columns: [
                
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '2%',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                        	{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '8%',cellclassname: cellclassname,  editable: false }, 
							{ text: 'Product Name', datafield: 'productname',  cellclassname: cellclassname ,columntype: 'custom',  editable: false }, 
							{ text: 'Brand Name', datafield: 'brandname', width: '10%',cellclassname: cellclassname,  editable: false,hidden:true },
							{ text: 'Unit', datafield: 'unit', width: '5%',cellclassname: cellclassname,  editable: false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'oldqty', datafield: 'oldqty', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true },
							{ text: 'Quantity', datafield: 'qty',cellsalign: 'right', width: '4%' ,align:'right',cellclassname: cellclassname,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'FOC', datafield: 'foc', width: '5%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
							{ text: 'Unit Price', datafield: 'unitprice', width: '7%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2',cellclassname: cellclassname ,
								/* cellbeginedit: function (row) {
	                                  return false;
								}, 	 */
							},
							{ text: 'Total', datafield: 'total', width: '7%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2' ,cellclassname: cellclassname},
							{ text: 'Discount %', datafield: 'discper', width: '7%' ,  cellsformat:'d2',cellsalign: 'right', align:'right',cellclassname: cellclassname,
								 /* cellbeginedit: function (row) {
	                                  return false;
								 }, 	 */
							},
							{ text: 'Discount', datafield: 'discount', width: '6%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname,
								 /* cellbeginedit: function (row) {
	                                  return false;
								 },  */	
							},
							{ text: 'Net Amount', datafield: 'nettotal', width: '8%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
							{ text: 'Cost Price', datafield: 'cost_price', width: '7%',cellsformat:'d2',cellsalign: 'right', align:'right',editable: false,cellclassname: cellclassname,hidden:true},
							{ text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true},
							{ text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true  },
							{ text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },
							{ text: 'stockid', datafield: 'stockid', width: '10%' ,hidden:true },
							{ text: 'qutval', datafield: 'qutval', width: '10%' ,cellsformat:'d2',hidden:true   },
							{ text: 'pqty', datafield: 'pqty', width: '9%',cellsformat:'d2' ,hidden:true  },
							{ text: 'saveqty', datafield: 'saveqty', width: '10%' ,cellsformat:'d2',hidden:true     },
							{ text: 'pid', datafield: 'proid', width: '10%' ,hidden:true   }, 
  							{ text: 'pname', datafield: 'proname', width: '10%'   ,hidden:true}, 
							{ text: 'checktype', datafield: 'checktype', width: '10%'  ,hidden:true},    
							{ text: 'specid', datafield: 'specid', width: '10%' ,hidden:true  },
                         	{ text: 'orderdiscper', datafield: 'orderdiscper', width: '10%'  ,hidden:true  },
					     	{ text: 'orderamount', datafield: 'orderamount', width: '10%'   ,hidden:true },
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Total Amount', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							{ text: 'taxdocno', datafield: 'taxdocno', width: '10%'   ,hidden:true  },
							{ text: 'Batch No', datafield: 'batch_no', width: '8%' ,hidden:true },
							{ text: 'Exp Date', datafield: 'exp_date', width: '7%' ,columntype: 'datetimeinput', align: 'left', cellsalign: 'left',cellsformat:'dd.MM.yyyy',hidden:true},	   
							
	              ]  
            });
            
            $('.load-wrapp').hide();
            
            $("#serviecGrid").on('cellvaluechanged', function(event) {
          	    var datafield = event.args.datafield;

          	    var rowBoundIndex = event.args.rowindex;

          	    if (datafield == "qty") {
          	        var qutval = $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qutval");

          	        var quty = $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");

          	        if (quty > qutval) {
          	        	 Swal.fire({
          		            type: 'error',
          		            title: 'Warning',
          		            text: ' Qty value not more than Actual Qty '+qutval
          		        });
          	            qty = qutval;
          	            $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty", qutval);

          	        } else {
          	            qty = $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
          	        }

          	        $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "saveqty", qty);

          	        valchange(rowBoundIndex, datafield);
          	    }

          	    if (datafield == "unitprice") {
          	        valchange(rowBoundIndex, datafield);
          	    }

          	    if (datafield == "discount") {
          	        valchange(rowBoundIndex, datafield);
          	    }

          	    if (datafield == "discper") {
          	        var totals = $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
          	        var discper = $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
          	        var discounts = parseFloat((parseFloat(totals) * parseFloat(discper)) / 100).toFixed(2);

          	        $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "discount", discounts);
          	    }

          	    if (datafield == "nettotal") {
          	        var netotal = $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal");

          	        var taxper = $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper");
          	        if (parseFloat(taxper) > 0) {
          	            var taxempamount = parseFloat(parseFloat(netotal) * (parseFloat(taxper) / 100)).toFixed(2);
          	            $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt", taxempamount);
          	            var taxtotalamount = parseFloat(parseFloat(netotal) + parseFloat(taxempamount)).toFixed(2);
          	            $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", taxtotalamount);
          	        } else {
          	            $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", netotal);
          	        }
          	    }
          	});
            
        });
        
    	function valchange(rowBoundIndex, datafield) {
      	    var qty = $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
      	    var unitprice = $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
      	    var discount = $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");

      	    var total = parseFloat(qty) * parseFloat(unitprice);

      	    $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "total", total);

      	    var nettotal = parseFloat(total) - parseFloat(discount);
      	    if (discount == "" || discount == null || discount == "undefiend") {
      	        $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal", total);
      	    } else {
      	        $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal", nettotal);
      	    }
      	}
           
          	function chkbrand() {
          	    var x = new XMLHttpRequest();
          	    x.onreadystatechange = function() {
          	        if (x.readyState == 4 && x.status == 200) {
          	            var items = x.responseText.trim();
          	            if (parseInt(items) > 0) {
          	                $('#serviecGrid').jqxGrid('showcolumn', 'brandname');
          	            } else {
          	                $('#serviecGrid').jqxGrid('hidecolumn', 'brandname');
          	            }
          	        }
          	    }
          	    x.open("GET", "checkbrand.jsp?", true);
          	    x.send();
          	}

          	function chktax() {
          	    var x = new XMLHttpRequest();
          	    x.onreadystatechange = function() {
          	        if (x.readyState == 4 && x.status == 200) {
          	            var items = x.responseText.trim();
          	            if (parseInt(items) > 0) {
          	                $('#cmbbilltype').show();
          	                $('#serviecGrid').jqxGrid('showcolumn', 'taxper');
          	                $('#serviecGrid').jqxGrid('showcolumn', 'taxamount');
          	                $('#serviecGrid').jqxGrid('showcolumn', 'taxperamt');
          	            } else {
          	                $('#cmbbilltype').hide();
          	                $('#serviecGrid').jqxGrid('hidecolumn', 'taxper');
          	                $('#serviecGrid').jqxGrid('hidecolumn', 'taxamount');
          	                $('#serviecGrid').jqxGrid('hidecolumn', 'taxperamt');
          	            }
          	        }
          	    }
          	    x.open("GET", "checktax.jsp?", true);
          	    x.send();
          	}

          	function chkbatch() {
          	    var x = new XMLHttpRequest();
          	    x.onreadystatechange = function() {
          	        if (x.readyState == 4 && x.status == 200) {
          	            var items = x.responseText.trim();
          	            var item = items.split('::');

          	            var batch = item[0];
          	            var expdate = item[1];

          	            if (parseInt(batch) > 0) {
          	                $('#serviecGrid').jqxGrid('showcolumn', 'batch_no');
          	            } else {
          	                $('#serviecGrid').jqxGrid('hidecolumn', 'batch_no');
          	            }

          	            if (parseInt(expdate) > 0) {
          	                $('#serviecGrid').jqxGrid('showcolumn', 'exp_date');
          	            } else {
          	                $('#serviecGrid').jqxGrid('hidecolumn', 'exp_date');
          	            }
          	        }
          	    }
          	    x.open("GET", "checkbatch.jsp?", true);
          	    x.send();
          	}
        
</script>
    
<div id="serviecGrid"></div>