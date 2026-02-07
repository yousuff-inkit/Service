<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.sales.salesorderfollowup.ClsSalesOrderFollowupDAO"%>
<%ClsSalesOrderFollowupDAO DAO = new ClsSalesOrderFollowupDAO();%>

<% 
String brhid = request.getParameter("brhid") == null?"0":request.getParameter("brhid").toString();
String docnos = request.getParameter("docnos") == null?"0":request.getParameter("docnos").toString();
String locationid = request.getParameter("locationid") == null?"0":request.getParameter("locationid").toString();
String date = request.getParameter("date") == null?"0":request.getParameter("date").toString();
%>

<script type="text/javascript">

var subGridData='<%=DAO.deliveryGridLoad(session, brhid, docnos, brhid, date)%>';   

        $(document).ready(function () { 
        	
        	chkfoc();
        	chkbrand();
        	
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
					{ name : 'foc', type: 'int' },
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
					{ name : 'ordout_qty', type: 'number' }, 
					{ name : 'valorderqty', type: 'number' }, 
					{ name : 'totalorderqty', type: 'number' }, 
					{ name : 'brandname', type: 'string' },
					{ name : 'vattype', type: 'string' },
					
					{ name : 'cldocno', type: 'string' },
    				{ name : 'refrowno', type: 'string' },
                    		  
                 ],
              
                 localdata: subGridData,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
              }
                                        
          };
            
            $("#jqxDeliveryNote").on("bindingcomplete", function(event) {
                var vattype = $('#jqxDeliveryNote').jqxGrid('getcellvalue', 0, "vattype");
                if (vattype == "exclusive") {
                    $('#cmbvatype').val("exclusive");
                }
                if (vattype == "inclusive") {
                    $('#cmbvatype').val("inclusive");
                }
                if (vattype == "export") {
                    $('#cmbvatype').val("export");
                }
                if (vattype == "") {
                    vattype = 'exclusive';
                    $('#cmbvatype').val('exclusive');
                }
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                  }
		          }		
            );
            
            $("#jqxDeliveryNote").jqxGrid(
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
                        columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                        cellsrenderer: function (row, column, value) {
                      	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        }  
						},
						{ text: 'Product', datafield: 'productid', width: '20%',cellclassname: cellclassname , editable:false},
                        { text: 'Product Name', datafield: 'productname' ,cellclassname: cellclassname  , editable:false},	
						{ text: 'Brand Name', datafield: 'brandname', width: '10%' , editable:false,cellclassname: cellclassname,hidden:true  },
						{ text: 'Unit', datafield: 'unit', width: '7%',editable:false,cellclassname: cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
						{ text: 'Size', datafield: 'size', width: '7%',editable:false,cellclassname: cellclassname,hidden:true },
						{ text: 'Quantity', datafield: 'qty',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'oldqty', datafield: 'oldqty', width: '7%',cellclassname: cellclassname,hidden:true    },
						{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname,hidden:true    },
						{ text: 'FOC', datafield: 'foc', width: '7%',cellclassname: cellclassname ,hidden:true},
						{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname ,hidden:true  },
						{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname ,hidden:true   },
						{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true},
						{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,hidden:true},
						{ text: 'Unit price', datafield: 'unitprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true },
						{ text: 'Total', datafield: 'total', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname ,hidden:true },
						{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,hidden:true },
						{ text: 'Discount', datafield: 'dis', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,hidden:true},
						{ text: 'Net Total', datafield: 'netotal', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname ,hidden:true},
						
                	]
          });
            
            $('.load-wrapp').hide();
            
            $("#jqxDeliveryNote").on('cellvaluechanged', function(event) {
                var datafield = event.args.datafield;
                var rowBoundIndex = event.args.rowindex;

                if (datafield == 'qty') {
                    valchange(rowBoundIndex, datafield);
                }
            });
        
            function valchange(rowBoundIndex, datafield) {
                var qty = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                var oldqty = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
                var totqty = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
                var outqty = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
                var balqty = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
                var unitprice = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
                var totwtkg = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "totwtkg");
                var kgprice = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "kgprice");
                var unitprice = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
                var total = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "total");
                var discper = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "discper");
                var discount = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                var netotal = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "netotal");
                var valorderqty = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "valorderqty");
                var ordout_qty = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "ordout_qty");
                var totalorderqty = $('#jqxDeliveryNote').jqxGrid('getcellvalue', rowBoundIndex, "totalorderqty");

                if (datafield == 'qty') {
                    tmpqty = qty + outqty;
                    tmpqty1 = oldqty + balqty;

                    if (balqty < valorderqty) {
                        valorderqty = balqty;
                    }

                    if (qty > valorderqty) {
                        Swal.fire({
                            type: 'error',
                            title: 'Warning',
                            text: "Quantity should not be greater than available  quantity " + valorderqty
                        });
                        $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowBoundIndex, "qty", valorderqty);
                        qty = valorderqty;
                    } else {
                        $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowBoundIndex, "chkqty", 0);
                    }
                }

                if (datafield == 'totwtkg' || datafield == 'kgprice') {
                    if (!(totwtkg == "" || typeof(totwtkg) == "undefined" || typeof(totwtkg) == "NaN" || kgprice == "" || typeof(kgprice) == "undefined" || typeof(kgprice) == "NaN")) {
                        unitprice = (parseFloat(kgprice) * parseFloat(totwtkg)) / qty;
                    }
                }

                total = parseFloat(qty) * parseFloat(unitprice);

                if (datafield == 'qty') {
                    if (parseFloat(discper) > 0) {
                        discount = (parseFloat(total) * parseFloat(discper)) / 100;
                    }
                }

                if (datafield == 'dis') {
                    discper = (100 / parseFloat(total)) * parseFloat(discount);
                }

                if (datafield == 'discper') {
                    discount = (parseFloat(total) * parseFloat(discper)) / 100;
                }
                if (discount == "" || typeof(discount) == "undefined" || typeof(discount) == "NaN") {
                    discount = 0.0;
                }
                netotal = parseFloat(total) - parseFloat(discount);

                $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowBoundIndex, "unitprice", unitprice);
                $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowBoundIndex, "total", total);
                $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowBoundIndex, "dis", discount);
                $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowBoundIndex, "discper", discper);
                $('#jqxDeliveryNote').jqxGrid('setcellvalue', rowBoundIndex, "netotal", netotal);
            }

        });
        
        function chkfoc() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    var item = items.split('##');
                    var foc = item[0];
                    var kg = item[1];
                    if (parseInt(foc) > 0) {
                        $('#jqxDeliveryNote').jqxGrid('showcolumn', 'foc');
                    } else {
                        $('#jqxDeliveryNote').jqxGrid('hidecolumn', 'foc');
                    }

                    if (parseInt(kg) > 0) {
                        $('#jqxDeliveryNote').jqxGrid('showcolumn', 'kgprice');
                        $('#jqxDeliveryNote').jqxGrid('showcolumn', 'totwtkg');
                    } else {
                        $('#jqxDeliveryNote').jqxGrid('hidecolumn', 'kgprice');
                        $('#jqxDeliveryNote').jqxGrid('hidecolumn', 'totwtkg');
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
                        $('#jqxDeliveryNote').jqxGrid('showcolumn', 'brandname');
                    } else {
                        $('#jqxDeliveryNote').jqxGrid('hidecolumn', 'brandname');
                    }
                }
            }
            x.open("GET", "checkbrand.jsp?", true);
            x.send();
        }
        
</script>
    
<div id="jqxDeliveryNote"></div>