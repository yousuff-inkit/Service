<%@page import="com.project.execution.quotationmbl.ClsQuotationDAO"%>   
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); %>
 <%
// String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 int surtrno =request.getParameter("surtrno")==null?0:Integer.parseInt(request.getParameter("surtrno").trim());
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString();
 String reviseno=request.getParameter("reviseno")==null?"0":request.getParameter("reviseno").trim().toString();
 String enqno=request.getParameter("enqno")==null?"0":request.getParameter("enqno").trim().toString();
 String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim().toString();
 %>      
    <script type="text/javascript">
    var servdata;
    var surtrno='<%=surtrno%>';   
    var docno='<%=docno%>';
    var trno='<%=trno%>';
    var enqno='<%=enqno%>';
    if(trno>0){
    	 servdata = '<%=DAO.enquiryLoad(session,trno,dtype) %>';        
    }
    if(docno>0){
    	servdata = '<%=DAO.serviceGridLoad(session,docno,reviseno) %>';
    }
    if(surtrno==2 && enqno>0){
    	servdata = '<%=DAO.serviceEstLoad(session,enqno,dtype) %>';   
    }
    
      var rendererstring1=function (aggregates){
        	var value=aggregates['sum1'];
        	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
        }
    	  
    	  var cellclassname = function (row, column, value, data) {
        		/* if (data.qty==0) {
        			document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
                    return "redClass";
                }
        		else{
        			//document.getElementById("errormsg").innetText="";
        		} */
        		};
     
    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
    }
   
   
        $(document).ready(function () { 	
        	//chkproductconfig();
        	  $('#gridtext').keyup(function(){
     	

	     $("#newprosearchGrid").jqxGrid('clearfilters');
	
       $('#item').val($(this).val());
       var dataField = "item";
applyFilter(dataField,$(this).val());  
       
       
       
   }); 
          
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'site' , type: 'String' },
							{name : 'siteid' , type: 'String' }, 
                          	{name : 'stype' , type: 'String' },
                          	{name : 'stypeid' , type: 'String' },
                          	{name : 'scope', type: 'string'},
							{name : 'scopeid', type: 'string'},
                          	{name : 'unit' , type: 'String' },
                          	{name : 'unitid' , type: 'String' },
     						{name : 'item', type: 'String'  },
                          	{name : 'qty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'scopeamount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'desc1', type: 'String'  },
     						{name : 'revision_no', type: 'String'  },
     						{name : 'psrno', type: 'String'  },
     						{name : 'prdname', type: 'String'  },
     						{name : 'stdprice', type: 'number'    },
     						{name : 'lbrchg', type: 'number'},
							{name : 'scopestdcost', type: 'number'},
							{name : 'discount', type: 'number'},
							{name : 'disper', type: 'number'},
							{name : 'rowno', type: 'number'},
							{name : 'subservname', type: 'string'},
							{name : 'subservid', type: 'string'},
                          	],
                 localdata: servdata,
                
                
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
            $("#serviceGrid").jqxGrid(
            {
                width: '100%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                sortable: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:20,
             	editmode: 'selectedcell',
             	selectionmode: 'singlecell', 
                editable:true,
                sortable: false,
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Description',datafield:'desc1'},
					{ text: 'Site', datafield: 'site', width: '16%',editable:false,hidden:true },
					{ text: 'siteid', datafield: 'siteid', width: '10%',hidden:true},
					{ text: 'Service.Type', datafield: 'stype', width: '16%',editable:false },
					{ text: 'Sub.Service.Type', datafield: 'subservname', width: '16%',editable:false },
					{ text: 'stypeid', datafield: 'stypeid', width: '10%',hidden:true},
					{ text: 'subtypeid', datafield: 'subservid', width: '10%',hidden:true},
					{ text: 'Scope', datafield: 'scope', width: '3%',editable: false,hidden:true },
					{ text: 'Item', datafield: 'item', width: '8%',cellclassname: cellclassname,columntype: 'custom',hidden:true,  
						    createeditor: function (row, cellvalue, editor, cellText, width, height) {
						         editor.html('<input type="text" id="item" name="item" style="width:100%;height:99%;"   />' ); 
						    }, 
					},
					{ text: 'Unit', datafield: 'unit', width: '5%',editable:false  },         
					{ text: 'Qty', datafield: 'qty', width: '5%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },     
					{ text: 'Unitid', datafield: 'unitid', width: '10%',hidden:true},
					{ text: 'Amount',datafield:'amount',width:'10%',cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					{ text: 'Discount',datafield:'discount',hidden: true,width:'10%',cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					{ text: 'Discount %',datafield:'disper',hidden: true,width:'10%',cellsformat: 'd2', editable: false, width: '10%', cellsalign: 'right', align: 'right'},
					{ text: 'Scope Amount', datafield: 'scopeamount', width: '7%',hidden: true, cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname: cellclassname },
					{ text: 'Total',datafield:'total',cellsformat: 'd2',editable:false, width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 
					{ text: 'revision_no', datafield: 'revision_no', width: '10%',hidden: true},       
					{ text: 'psrno', datafield: 'psrno', width: '10%',hidden: true},
					{ text: 'prdname', datafield: 'prdname', width: '10%',hidden: true},
					{ text: 'Scope Id', datafield: 'scopeid', width: '10%',cellclassname: cellclassname, hidden: true}, 
					{ text: 'stdprice', datafield: 'stdprice', width: '10%',cellclassname: cellclassname,hidden: true},
					{ text: 'Labour Charge', datafield: 'lbrchg', width: '10%',cellclassname: cellclassname,hidden: true},
					{ text: 'Scope Standard Cost', datafield: 'scopestdcost', width: '10%',cellclassname: cellclassname,hidden: true}, 
					{text: 'rowno',datafield:'rowno',width:'25%',editable:false,hidden:true},
					]
            });
            
            $('#serviceGrid').on('celldoubleclick', function(event) {
                var rowBoundIndex = event.args.rowindex;
                var datafield = event.args.datafield;
                var serid= $('#serviceGrid').jqxGrid('getcellvalue',  rowBoundIndex, "stypeid");
                var checkid=2;

                if ((datafield == "subservname")) {
                	  getsubSerType(rowBoundIndex,serid); 
                }
                if ((datafield == "stype")) {
                    getserType(rowBoundIndex);
                }
                if ((datafield == "stype")) {
                    getserType(rowBoundIndex);
                }
                if ((datafield == "site")) {
                    getsite(rowBoundIndex);
                }
                if (datafield == "unit") {
                    unitSearchContent('unitSearchGrid.jsp?rowno=' + rowBoundIndex+'&checkid='+checkid);
                }
                if (datafield == "scope") {

                    scopeSearchContent('scopeSearchGrid.jsp?rowno=' + rowBoundIndex);
                    document.getElementById("rowindex").value = rowBoundIndex;

                }
                if (datafield == "item") {
                    if (document.getElementById("productchk").value == 1) {
                        var rowindextemp = event.args.rowindex;
                        var scopeid = $('#serviceGrid').jqxGrid('getcellvalue', rowindextemp, "scopeid");
                        var stypeid = $('#serviceGrid').jqxGrid('getcellvalue', rowindextemp, "stypeid");
                        $('#txtgridservicetypeid').val(stypeid);
                        $('#txtgridscopeid').val(scopeid);
                        productSearchContent('productMasterSearch.jsp?scopeid=' + scopeid + '&stypeid=' + stypeid);
                        //productSearchContent('productMasterSearch.jsp');
                    } else {

                    }
                    var rowindextemp = event.args.rowindex;
                    document.getElementById("rowindex").value = rowindextemp;

                }

            });
            
            $("#serviceGrid").on('cellvaluechanged', function(event) {
                var datafield = event.args.datafield;
                var rowBoundIndex = event.args.rowindex;
                if(parseInt($('#datas').val()) != 1) {
                    if (datafield == "item") {
                        $('#serviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "item", $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "prdname"));
                        $('#sidesearchwndow').jqxWindow('close');
                    }
                }

                if (datafield == "qty" || datafield == "amount" || datafield == "discount") {
                    var qty = $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                    var amount = $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
                    var discount = $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");
                    var total=0, disper=0;

                    if (qty == "" || typeof(qty) == "undefined" || qty == "NaN") {
                        qty = 0;
                    }

                    if (amount == "" || typeof(amount) == "undefined" || amount == "NaN") {
                        amount = 0;
                    }
                    
                    if (discount == "" || typeof(discount) == "undefined" || discount == "NaN") {  
                    	discount = 0;
                    }

                    /* if (parseInt($('#presalesscopeallowed').val()) == 1) {

                        scopeamount = $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "scopeamount");

                        if (!(scopeamount == "" || typeof(scopeamount) == "undefined" || typeof(scopeamount) == "NaN")) {
                            total = (parseFloat(qty) * parseFloat(amount)) + (parseFloat(qty) * parseFloat(scopeamount));
                        } else {
                            total = parseFloat(qty) * parseFloat(amount);
                        }

                    } else { */

                        total = (parseFloat(qty) * parseFloat(amount)) - parseFloat(discount);
                        $('#serviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total", total);
                    //}  
                    var disper = (parseFloat(discount)*100)/total; 
                    $('#serviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "disper", disper);
   
                    if (parseFloat(qty) > 0 && parseFloat(amount) > 0) {
                        getNetTotalValue();
                    }
                }

                if (datafield == "stypeid") {
                    var rows = $('#serviceGrid').jqxGrid('getrows');
                    var rowlength = rows.length;
                    var rowindex1 = rowlength - 1;
                    var typeId = $("#serviceGrid").jqxGrid('getcellvalue', rowindex1, "stypeid");
                    if (typeof(typeId) != "undefined") {
                        $("#serviceGrid").jqxGrid('addrow', null, {});
                    }
                }

                var summaryData3 = $("#serviceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'], true);
                document.getElementById("txtgrtotal").value = summaryData3.sum.replace(/,/g, '');
            });

            $("#popupWindow1").jqxWindow({
                width: 250,
                resizable: false,
                isModal: true,
                autoOpen: false,
                cancelButton: $("#Cancel"),
                modalOpacity: 0.01
            });
            // create context menu
            var contextMenu = $("#Menu1").jqxMenu({
                width: 200,
                height: 25,
                autoOpenPopup: false,
                mode: 'popup'
            });
            $("#serviceGrid").on('contextmenu', function() {
                return false;
            });

            $("#Menu1").on('itemclick', function(event) {
                var args = event.args;
                var rowindex = $("#serviceGrid").jqxGrid('getselectedrowindex');
                if ($.trim($(args).text()) == "Edit Selected Row") {
                    editrow = rowindex;
                    var offset = $("#serviceGrid").offset();
                    $("#popupWindow1").jqxWindow({
                        position: {
                            x: parseInt(offset.left) + 60,
                            y: parseInt(offset.top) + 60
                        }
                    });
                    // get the clicked row's data and initialize the input fields.
                    var dataRecord = $("#serviceGrid").jqxGrid('getrowdata', editrow);
                    // show the popup window.
                    $("#popupWindow1").jqxWindow('show');
                } else {
                    var rowid = $("#serviceGrid").jqxGrid('getrowid', rowindex);
                    $("#serviceGrid").jqxGrid('deleterow', rowid);
                    var summaryData3 = $("#serviceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'], true);
                    document.getElementById("txtgrtotal").value = summaryData3.sum.replace(/,/g, '');
                    var disprc = parseFloat(document.getElementById('txtdisper').value);
                    var disamt = parseFloat(document.getElementById('txtdisamt').value);
                    if (disprc != 0 && disamt != 0) {
                        //fundisper();
                        getNetTotalValue();
                    } else if (disprc != 0 && disamt == 0) {
                        //fundisper();
                        getNetTotalValue();
                    } else if (disprc == 0 && disamt != 0) {

                        //fundisamt();
                        getNetTotalValue();
                    } else {
                        //fundisper();
                        getNetTotalValue();
                    }


                }
            });

            $("#serviceGrid").on('rowclick', function(event) {
                if (event.args.rightclick) {
                    if (document.getElementById("mode").value == "A" || document.getElementById("mode").value == "E") {
                        $("#serviceGrid").jqxGrid('selectrow', event.args.rowindex);
                        var scrollTop = $(window).scrollTop();
                        var scrollLeft = $(window).scrollLeft();
                        contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                        return false;
                    }
                }
            });


            $("#serviceGrid").jqxGrid('addrow', null, {});
            });
            </script>
    
    <div id='jqxWidget'>
   <div id="serviceGrid"></div>
    <div id="popupWindow1">

 <div id='Menu1'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">