<%@page import="com.dashboard.skips.invoiceproessing.*" %>
<%ClsInvoiceProcessingDAO dao=new ClsInvoiceProcessingDAO();%>
<% 
String todate =request.getParameter("todate")==null?"":request.getParameter("todate").toString();
String brhid =request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
String id =request.getParameter("id")==null?"":request.getParameter("id").toString();
String type =request.getParameter("type")==null?"":request.getParameter("type").toString(); 
String cldocno =request.getParameter("cldocno")==null?"":request.getParameter("cldocno").toString();  
%>

 <script type="text/javascript">
 var type='<%=type%>';   
 var invdata='<%=dao.invoiceData(todate, brhid, id, cldocno, type)%>';   
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                			{name : 'groupcompanies', type: 'String'  },   
                			{name : 'site', type: 'String'  },
                			{name : 'skiptype', type: 'string'  },
		              		{name : 'skipdoc', type: 'String'  },
		              		{name : 'wastetype', type: 'string'   },
		              		{name : 'wastedoc', type: 'String'  },
		              		{name : 'refname', type: 'String'  }, 
		              		{name : 'siteid', type: 'String'  },     
	                        {name : 'tr_no', type: 'String'  },   
	                        {name : 'doc_no', type: 'number'  },   
	                        {name : 'date', type: 'Date'  }, 
	                    	{name : 'brhid', type: 'String'  },
	                    	{name : 'rowno', type: 'number'  },      
	                    	
	                    	{name : 'totaltrips', type: 'number'  },   
	                    	{name : 'rpcrate', type: 'number'  },   
	                    	{name : 'rpctotal', type: 'number'  },   
	                    	{name : 'tfrate', type: 'number'  },   
	                    	{name : 'tftotal', type: 'number'  },   
	                    	{name : 'gfrate', type: 'number'  },   
	                    	{name : 'gftotal', type: 'number'  },   
	                    	
	                    	{name : 'executedtrip', type: 'number'  }, 
	                    	{name : 'tottrips', type: 'number'  },
	                    	{name : 'chargedtrip', type: 'number'  }, 
	                    	{name : 'invoicetrip', type: 'number'  }, 
	                    	
	                    	{name : 'nettotal', type: 'number'  }, 
	                    	{name : 'mergedinvoice', type: 'String'  },  
	                    	{name : 'refno', type: 'String'  },  
	                    	{name : 'remarks', type: 'String'  },  
                	
                 ],
                 localdata: invdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            $("#jqxInvoiceGrid").on('bindingcomplete', function (event) {
                	if(type=="4" || type=="5" || type=="6"){   
                		  $("#jqxInvoiceGrid").jqxGrid('hidecolumn', 'totaltrips');
                		  $("#jqxInvoiceGrid").jqxGrid('showcolumn', 'executedtrip');
                		  $("#jqxInvoiceGrid").jqxGrid('showcolumn', 'tottrips');
                		  $("#jqxInvoiceGrid").jqxGrid('showcolumn', 'chargedtrip'); 
                		  $("#jqxInvoiceGrid").jqxGrid('showcolumn', 'invoicetrip'); 
                	}else{
                		  $("#jqxInvoiceGrid").jqxGrid('showcolumn', 'totaltrips');
	               		  $("#jqxInvoiceGrid").jqxGrid('hidecolumn', 'executedtrip');
	               		  $("#jqxInvoiceGrid").jqxGrid('hidecolumn', 'tottrips');
	               		  $("#jqxInvoiceGrid").jqxGrid('hidecolumn', 'chargedtrip');   
	               		  $("#jqxInvoiceGrid").jqxGrid('hidecolumn', 'invoicetrip');    
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
                width: '100%',
                height: 530,
                source: dataAdapter,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox', 
                filtermode : 'excel',
                filterable: true,
              //  showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,   
             //   sortable: false,
                //Add row method
                columns: [     
		                	 { text: 'SL#', sortable: false, filterable: false,            
							      groupable: false, draggable: false, resizable: false,
							      datafield: 'sl', columntype: 'number', width: '4%',
							      cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							      }  
							     },  
						      { text: 'rowno', datafield: 'rowno', width: '5%',hidden:true },  	       
		                	  { text: 'Doc No', datafield: 'doc_no',width:'4%'},  
		                	  { text: 'Old Contract No', datafield: 'remarks', width: '5%' },  
		                	  { text: 'Ref No', datafield: 'refno', width: '4%' },   
		                      { text: 'Client', datafield: 'refname', width: '12%' },  
		                      { text: 'Site', datafield: 'site',width:'8%'},   
		                  	  { text: 'siteid',datafield:'siteid',width:'5%',hidden:true},
		                  	  { text: 'Merged Invoice', datafield: 'mergedinvoice',width:'3%'}, 
		                  	  { text: 'Trips', datafield: 'totaltrips', width: '4%',cellsformat:'d0',cellsalign:'right',align:'right'  },
							    
							  { text: 'Actual', datafield: 'executedtrip', width: '4%',cellsformat:'d0',cellsalign:'right',align:'right'  },
							  { text: 'Ctrip', datafield: 'tottrips', width: '4%',cellsformat:'d0',cellsalign:'right',align:'right'  },
							  { text: 'Invoiced trip in advanced', datafield: 'invoicetrip', width: '4%',cellsformat:'d0',cellsalign:'right',align:'right'  }, 
							  { text: 'Chargeable', datafield: 'chargedtrip', width: '4%',cellsformat:'d0',cellsalign:'right',align:'right'  },  
							 
							  { text: 'Rate', datafield: 'rpcrate', columngroup: 'rate', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right'  },
							  { text: 'Total', datafield: 'rpctotal', columngroup: 'rate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'  },
							  
							  { text: 'Rate', datafield: 'tfrate', columngroup: 'tippingfee', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right'  },
							  { text: 'Total', datafield: 'tftotal', columngroup: 'tippingfee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'  },
							  
							  { text: 'Rate', datafield: 'gfrate', columngroup: 'gatefee', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right'  },
							  { text: 'Total', datafield: 'gftotal', columngroup: 'gatefee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'  },
							  
							  { text: 'Net Total', datafield: 'nettotal', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'  },
							  { text: 'Cont.Date', datafield: 'date',width:'7%',cellsformat:'dd.MM.yyyy',hidden:true},
							  { text: 'Group Company', datafield: 'groupcompanies', width: '9%' }, 
							  { text: 'Waste Type', datafield: 'wastetype', width: '10%' },	
							  { text: 'Skip Size', datafield: 'skiptype', width: '10%'},   
		              ],
		              columngroups: 
		                  [
		                    { text: 'Rate Per Collection', align: 'center', name: 'rate' },    
		                    { text: 'Tipping Fee' , align: 'center', name: 'tippingfee' },
		                    { text: 'Gate Fee', align: 'center', name: 'gatefee' }    
		                  ]
            }); 
           $('#overlay,#PleaseWait').hide();
           /* $('#jqxInvoiceGrid').on('rowdoubleclick', function (event) {   
     	   	  var rowindex1=event.args.rowindex;
     	   	  document.getElementById("hidrowno").value=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindex1, "rowno"); 
           }); */   
        });
    </script>
    <div id="jqxInvoiceGrid"></div>  