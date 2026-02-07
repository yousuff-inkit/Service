<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.sales.salesorderfollowup.ClsSalesOrderFollowupDAO"%>
<%ClsSalesOrderFollowupDAO DAO = new ClsSalesOrderFollowupDAO();%>

<% 
String brhid = request.getParameter("brhid") == null?"0":request.getParameter("brhid").toString();
String docnos = request.getParameter("docnos") == null?"0":request.getParameter("docnos").toString();
String cmbtype = request.getParameter("cmbtype") == null?"0":request.getParameter("cmbtype").toString();
String date = request.getParameter("date") == null?"0":request.getParameter("date").toString();
String clientcaid = request.getParameter("clientcaid") == null?"0":request.getParameter("clientcaid").toString();
String cmbbilltype = request.getParameter("cmbbilltype") == null?"0":request.getParameter("cmbbilltype").toString();
String cldocno = request.getParameter("cldocno") == null?"0":request.getParameter("cldocno").toString();
%>

<script type="text/javascript">

		var subGridData='<%=DAO.invoiceGridLoad(session, brhid, docnos, cmbtype, date, clientcaid, cmbbilltype, cldocno)%>';   

        $(document).ready(function () { 	

        	chkfoc();
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
     						
                	{ name : 'productid', type: 'string' }, 
					{ name : 'productname', type: 'string' },
					{ name : 'unit', type: 'string' },
					{ name : 'size', type: 'number' },
					{ name : 'totqty', type: 'number' },
					{ name : 'qty', type: 'number' },
					{ name : 'outqty', type: 'number' },
					{ name : 'oldqty', type: 'number' },
					{ name : 'balqty', type: 'number' },
					{ name : 'foc', type: 'number' },
					{ name : 'refqty', type: 'int' },
					{ name : 'totwtkg', type: 'number' },
					{ name : 'kgprice', type: 'number' },
					{ name : 'unitprice', type: 'number' },
					{ name : 'total', type: 'number' },
					{ name : 'discper', type: 'number' },
					{ name : 'dis', type: 'number' },
					{ name : 'netotal', type: 'number' },
					{ name : 'proid', type: 'string' },
        			{ name : 'proname', type: 'string' },
        			{ name : 'prodoc', type: 'number' },
        			{ name : 'specid', type: 'number' },
					{ name : 'unitdocno', type: 'number' },
					{ name : 'psrno', type: 'number' },
					{ name : 'stkid', type: 'number' },
					{ name : 'locid', type: 'number' },
				    { name : 'brandname', type: 'string' },
				    { name : 'count', type: 'string' },
				   	{ name : 'allowdiscount', type: 'number' },
				  	{ name : 'lbrchg', type: 'number' },
				 	{ name : 'taxper', type: 'number' }, 
					{ name : 'taxperamt', type: 'number' }, 
				 	{ name : 'taxamount', type: 'number' }, 
					{ name : 'discountset', type: 'number' }, 
					{ name : 'collectqty', type: 'string' }, 
				 	{ name : 'taxdocno', type: 'string' },
					{ name : 'vatype', type: 'string' },
					{ name : 'costprice', type: 'number' },  
					{ name : 'setbalqty', type: 'number' },  
    					
    				{ name : 'cldocno', type: 'string' },
    				{ name : 'refrowno', type: 'string' },
                    		  
                 ],
              
                 localdata: subGridData,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#jqxInvoiceGrid").on("bindingcomplete", function(event) {
                var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');
                var vattype = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', 0, "vatype");
                if (vattype == 'exclusive') {
                    $('#cmbvatype').val('exclusive');
                }

                if (vattype == 'inclusive') {
                    $('#cmbvatype').val('inclusive');
                }

                if (vattype == 'export') {
                    $('#cmbvatype').val('export');
                }

                if (vattype == "") {
                    vattype = 'exclusive';
                    $('#cmbvatype').val('exclusive');
                }


                for (var i = 0; i < rows.length; i++) {
                    var tsk = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "taxper");
                    if (typeof(tsk) === "undefined") {
                        tsk = 0;
                    }

                    var calfix = "100";
                    var cal = parseFloat(calfix) + parseFloat(tsk);
                    var qty = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "qty");
                    var uprice = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "unitprice");
                    var tot = (parseFloat(qty) * parseFloat(uprice)).toFixed(window.parent.amtdec.value);
                    $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "total", tot);

                    if (parseFloat(qty) > 0) {
                        if (vattype == "exclusive") {
                            discper = (100 / parseFloat(total)) * parseFloat(discount);
                            var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "total");
                            var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "dis");
                            var val1 = parseFloat(total) - parseFloat(discount);
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "netotal", val1);
                            var taxper = ((parseFloat(val1) / 100) * parseFloat(tsk)).toFixed(window.parent.amtdec.value);
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxperamt", taxper);
                            var tot1 = parseFloat(val1) + parseFloat(taxper);
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxamount", tot1);
                        }

                        if (vattype == "inclusive") {
                            var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "total");
                            var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "dis");
                            var val1 = parseFloat(total) - parseFloat(discount);
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxamount", val1);
                            var val2 = ((parseFloat(val1) / parseFloat(cal)) * 100).toFixed(window.parent.amtdec.value);
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "netotal", val2);
                            var val3 = parseFloat(val1) - parseFloat(val2);
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxperamt", val3);
                        }
                        if (vattype == "export") {
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxper", 0);
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxperamt", 0);
                            discper = (100 / parseFloat(total)) * parseFloat(discount);
                            var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "total");
                            var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "dis");
                            var val1 = parseFloat(total) - parseFloat(discount);
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxamount", val1);
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "netotal", val1);
                        }
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
            
            $("#jqxInvoiceGrid").jqxGrid(
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
					{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,datafield: '',
                      columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                      cellsrenderer: function (row, column, value) {
                    	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
					},
					{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '10%',cellclassname: cellclassname,editable:false},
					{ text: 'Product Name', datafield: 'productname'  ,cellclassname: cellclassname ,editable:false },	
					{ text: 'Brand Name', datafield: 'brandname', width: '10%' , editable:false,cellclassname: cellclassname,hidden:true  },
					{ text: 'Unit', datafield: 'unit', width: '4%',editable:false,cellclassname: cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },	
					{ text: 'Size', datafield: 'size', width: '7%',editable:false,cellclassname: cellclassname,hidden:true },
					{ text: 'Quantity', datafield: 'qty', width: '4%',cellclassname: cellclassname ,cellsformat: 'd2',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellsalign: 'right', align: 'right'},
					{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname   ,hidden:true   },
					{ text: 'FOC', datafield: 'foc', width: '7%',cellclassname: cellclassname ,hidden:true, cellsformat: 'd2'},
					{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname,hidden:true    },
					{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname,hidden:true    },
					{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true},
					{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true },
					{ text: 'Unit Price', datafield: 'unitprice', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname 	,
						cellbeginedit: function (row) {
				         if (document.getElementById("cmbtype").value=="SOR")
                         {
                              return false;
                         } 
					  },},
					{ text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,
						cellbeginedit: function (row) {
					         if (document.getElementById("cmbtype").value=="SOR")
                             {
                                  return false;
                             } 
						  },},
					{ text: 'Discount', datafield: 'dis', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname,
							  cellbeginedit: function (row) {
							         if (document.getElementById("cmbtype").value=="SOR")
		                             {
		                                  return false;
		                             } 
								  },},
					{ text: 'Net Total', datafield: 'netotal', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
					{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
					{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Total Amount', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
            	]
            });
            
            $('.load-wrapp').hide();
            
            $("#jqxInvoiceGrid").on('cellvaluechanged', function(event) {
                var datafield = event.args.datafield;

                var rowBoundIndex = event.args.rowindex;
               
                if (datafield == 'qty' || datafield == 'dis' || datafield == 'discper' || datafield == 'unitprice') {
                    valchange(rowBoundIndex, datafield);
                }

                if (datafield == 'unitprice'){
                    var discount1 = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");

                    if (parseFloat(discount1) == 0) {

                    } else {
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper", 0);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper", discount1);
                    }
                }
                
                if (netotal > 0) {
                    if (datafield == "netotal"){
                        var netotal = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "netotal");
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal", netotal);
                        var discount1 = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                        var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");

                        if (parseFloat(discount1) == 0) {
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal", total);
                        }

                        var netotal = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "netotal");

                        var taxper = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper");
                        if (parseFloat(taxper) > 0) {
                            var taxempamount = (parseFloat(netotal) * (parseFloat(taxper) / 100)).toFixed(window.parent.amtdec.value);
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt", taxempamount);
                            var taxtotalamount = parseFloat(netotal) + parseFloat(taxempamount);

                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", taxtotalamount);

                        } else {
                            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", netotal);
                        }
                    }
                }
                if (datafield == 'qty' || datafield == 'dis' || datafield == 'discper' || datafield == 'unitprice') {
                    //funcalutax();
                }
            });
            
            if (document.getElementById("cmbtype").value == 'DEL') {

                var locid1 = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', 0, "locid");

                var rows1 = $("#jqxInvoiceGrid").jqxGrid('getrows');
                var aa = 0;
                for (var i = 0; i < rows1.length; i++) {
                    if (parseInt(rows1[i].locid) != parseInt(locid1)) {
                        aa = 1;
                        break;
                    } else {
                        aa = 0;
                    }
                }

                if (parseInt(aa) == 1) {
                	Swal.fire({
                        type: 'error',
                        title: 'Warning',
                        text: 'Products contains different locations'
                    });
                }
            }
        });
        
        function valchange(rowBoundIndex, datafield) {

            var vattype = document.getElementById("cmbvatype").value;
            var warning;
            var qty = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
            var oldqty = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
            var totqty = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
            var outqty = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
            var balqty = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
            var unitprice = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            var totwtkg = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "totwtkg");
            var kgprice = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "kgprice");
            var unitprice = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
            var discper = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            var netotal = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "netotal");

            var tsk = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper");
            if (typeof(tsk) === "undefined") {
                tsk = 0;
            }
            var calfix = "100";
            var cal = parseFloat(calfix) + parseFloat(tsk);
            if (datafield == 'qty') {
                tmpqty = qty + outqty;
                tmpqty1 = oldqty + balqty;

                if (document.getElementById("cmbtype").value != "SOR") {

                    if (qty > balqty) {
                    	 Swal.fire({
                             type: 'error',
                             title: 'Warning',
                             text: 'Quantity should not be greater than available  quantity '+ balqty
                     	});

                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty", balqty);
                        qty = balqty;
                    }

                } else {

                    var tempqty = 0;
                    var temps = 0;
                    if (balqty > totqty) {
                        tempqty = totqty;
                        temps = 1;
                    } else if (balqty <= totqty) {
                        tempqty = balqty;
                        temps = 1;
                    }

                    if (parseInt(temps) > 0) {

                    } else {
                        tempqty = qty;
                    }
                    if (qty > tempqty) {
                    	Swal.fire({
                            type: 'error',
                            title: 'Warning',
                            text: 'Quantity should not be greater than available  quantity '+ tempqty
                    	});

                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty", tempqty);
                        qty = tempqty;
                    } else {
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "chkqty", 0);
                    }
                }
            }

            if (datafield == 'totwtkg' || datafield == 'kgprice') {
                if (!(totwtkg == "" || typeof(totwtkg) == "undefined" || typeof(totwtkg) == "NaN" || kgprice == "" || typeof(kgprice) == "undefined" || typeof(kgprice) == "NaN")) {
                    unitprice = ((parseFloat(kgprice) * parseFloat(totwtkg)) / qty).toFixed(window.parent.amtdec.value);
                }
            }

            total = (parseFloat(qty) * parseFloat(unitprice)).toFixed(window.parent.amtdec.value);

            if (datafield == 'qty') {

                if (parseFloat(discper) > 0) {
                    discount = ((parseFloat(total) * parseFloat(discper.toFixed(2))) / 100).toFixed(window.parent.amtdec.value);
                }
                var qty = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                var uprice = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");

                var taxper = 0;
                var tot = (parseFloat(qty) * parseFloat(uprice)).toFixed(window.parent.amtdec.value);
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total", tot);
                if (parseFloat(qty) > 0) {
                    if (vattype == "exclusive") {
                        discper = (100 / parseFloat(total)) * parseFloat(discount);
                        var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
                        var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                        var val1 = parseFloat(total) - parseFloat(discount);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal", val1);
                        var taxper = ((parseFloat(val1) / 100) * parseFloat(tsk)).toFixed(window.parent.amtdec.value);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt", taxper);
                        var tot1 = parseFloat(val1) + parseFloat(taxper);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", tot1);
                    }

                    if (vattype == "inclusive") {
                        var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
                        var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                        var val1 = parseFloat(total) - parseFloat(discount);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", val1);
                        var val2 = ((parseFloat(val1) / parseFloat(cal)) * 100).toFixed(window.parent.amtdec.value);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal", val2);
                        var val3 = parseFloat(val1) - parseFloat(val2);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt", val3);
                    }

                    if (vattype == "export") {
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxper", 0);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt", 0);
                        discper = (100 / parseFloat(total)) * parseFloat(discount);
                        var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
                        var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                        var val1 = parseFloat(total) - parseFloat(discount);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", val1);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal", val1);
                    }
                }
            }

            if (datafield == 'dis') {

                var qty = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                if (parseFloat(qty) > 0) {
                    if (vattype == "exclusive") {
                        discper = (100 / parseFloat(total)) * parseFloat(discount);
                        var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
                        var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                        var val1 = parseFloat(total) - parseFloat(discount);

                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal", val1);
                        var taxper = ((parseFloat(val1) / 100) * parseFloat(tsk)).toFixed(window.parent.amtdec.value);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt", taxper);
                        var tot1 = parseFloat(val1) + parseFloat(taxper);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", tot1);
                    }

                    if (vattype == "inclusive") {
                        var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
                        var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                        var val1 = parseFloat(total) - parseFloat(discount);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", val1);
                        var val2 = ((parseFloat(val1) / parseFloat(cal)) * 100).toFixed(window.parent.amtdec.value);
                        //alert("inc netotal==="+val2)
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal", val2);
                        var val3 = parseFloat(val1) - parseFloat(val2);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt", val3);

                    }
                    if (vattype == "export") {
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxper", 0);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt", 0);
                        discper = (100 / parseFloat(total)) * parseFloat(discount);
                        var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
                        var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                        var val1 = parseFloat(total) - parseFloat(discount);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", val1);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal", val1);
                    }

                }

            }

            if (datafield == 'unitprice') {

                var qty = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                var uprice = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");

                var tot = (parseFloat(qty) * parseFloat(uprice)).toFixed(window.parent.amtdec.value);
                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total", tot);
                if (parseFloat(qty) > 0) {
                    if (vattype == "exclusive") {
                        discper = (100 / parseFloat(total)) * parseFloat(discount);
                        var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
                        var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                        var val1 = parseFloat(total) - parseFloat(discount);

                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal", val1);
                        var taxper = ((parseFloat(val1) / 100) * parseFloat(tsk)).toFixed(window.parent.amtdec.value);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt", taxper);
                        var tot1 = parseFloat(val1) + parseFloat(taxper);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", tot1);
                    }

                    if (vattype == "inclusive") {
                        var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
                        var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                        var val1 = parseFloat(total) - parseFloat(discount);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", val1);
                        var val2 = ((parseFloat(val1) / parseFloat(cal)) * 100).toFixed(window.parent.amtdec.value);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal", val2);
                        var val3 = parseFloat(val1) - parseFloat(val2);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt", val3);
                    }
                    if (vattype == "export") {
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxper", 0);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt", 0);
                        discper = (100 / parseFloat(total)) * parseFloat(discount);
                        var total = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
                        var discount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                        var val1 = parseFloat(total) - parseFloat(discount);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount", val1);
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal", val1);
                    }
                }
            }

            if (datafield == 'discper') {
                if (parseInt(document.getElementById("pmgt").value) > 0) {

                    var dscper = 0;
                    var allowdiscount = 0,
                        discallowper = 0;
                    allowdiscount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "allowdiscount");

                    if ($('#cmbtype').val() == 'SOR') {
                        allowdiscount = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
                    }

                    if (dscper == "" || dscper == null) {
                        discallowper = parseFloat(allowdiscount);

                    } else {
                        discallowper = (parseFloat(allowdiscount) * (parseFloat(dscper) / 100)).toFixed(window.parent.amtdec.value);
                    }

                    if (parseFloat(dscper) > 0) {

                    } else {
                        discper = 0.00;
                    }
                    if (parseFloat(discallowper) > 0) {

                    } else {
                        discallowper = 0.00;
                    }

                    discper = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
                    if (typeof(discper) === "undefined") {
                        discper = 0.00;
                    }

                    if (parseFloat(discper.toFixed(2)) <= parseFloat(discallowper.toFixed(2))) {

                        discper = discper;

                    } else {
                        if (parseFloat(discper) > 0) {
                            if (isNaN(discallowper)) {
                                discallowper = 0;
                            }

                            Swal.fire({
                                type: 'error',
                                title: 'Warning',
                                text: 'Maximum Allowed Discount Is '+ discallowper.toFixed(2)
                        	});
                        }
                        discper = discallowper;
                        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper", discper);
                    }

                    discount = ((parseFloat(total) * parseFloat(discper.toFixed(2))) / 100).toFixed(window.parent.amtdec.value);

                } else {
                    discount = ((parseFloat(total) * parseFloat(discper)) / 100).toFixed(window.parent.amtdec.value);
                }

                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "dis", discount);
            }
            if (discount == "" || typeof(discount) == "undefined" || typeof(discount) == "NaN") {
                discount = 0.0;
            }

            netotal = parseFloat(total) - parseFloat(discount);

            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total", total);

            if (datafield == 'qty') {
                if (parseFloat(discper) > 0) {
                    discount = ((parseFloat(total) * (parseFloat(discper.toFixed(2)) / 100))).toFixed(window.parent.amtdec.value);
                    $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "dis", discount);
                }
            }
        }
        
        function chkfoc() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    var item = items.split('##');
                    var foc = item[0];
                    var kg = item[1];
                    if (parseInt(foc) > 0) {
                        $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'foc');
                    } else {
                        $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'foc');
                    }

                    if (parseInt(kg) > 0) {
                        $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'kgprice');
                        $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'totwtkg');
                    } else {
                        $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'kgprice');
                        $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'totwtkg');
                    }
                }
            }
            x.open("GET", "checkfoc.jsp", true);
            x.send();
        }
        
        function chkbrand() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if (parseInt(items) > 0) {
                        $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'brandname');
                    } else {
                        $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'brandname');
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
                        $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'taxper');
                        $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'taxamount');
                        $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'taxperamt');
                    } else {
                        $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'taxper');
                        $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'taxamount');
                        $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'taxperamt');
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
                    var pmgt = item[2];
                   
                    if (parseInt(batch) > 0) {
                        document.getElementById("batchno").value = 1;
                    }

                    if (parseInt(expdate) > 0) {
                        document.getElementById("expdate").value = 1;
                    }
                    if (parseInt(pmgt) > 0) {
                        document.getElementById("pmgt").value = 1;
                    } else {
                        document.getElementById("pmgt").value = 0;
                    }
                }
            }
            x.open("GET", "checkbatch.jsp?", true);
            x.send();
        }
        
</script>
    
<div id="jqxInvoiceGrid"></div>