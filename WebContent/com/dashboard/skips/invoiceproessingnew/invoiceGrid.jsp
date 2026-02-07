<%@page import="com.dashboard.skips.invoiceproessingnew.*" %>
<%ClsInvoiceProcessingDAO dao=new ClsInvoiceProcessingDAO();%>
<% 
String todate =request.getParameter("todate")==null?"":request.getParameter("todate").toString();
String brhid =request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
String id =request.getParameter("id")==null?"":request.getParameter("id").toString();
String type =request.getParameter("type")==null?"":request.getParameter("type").toString(); 
String cldocno =request.getParameter("cldocno")==null?"":request.getParameter("cldocno").toString();  
%>
<style type="text/css">
     .pinkClass {
       background-color: #C1F884; 
    }
    .yellowClass {
       background-color: #F9C780; 
    }
</style>
 <script type="text/javascript">
 var type='<%=type%>';   
        $(document).ready(function () { 	
        	 var invdata='<%=dao.invoiceData(todate, brhid, id, cldocno, type)%>'; 
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
	                    	{name : 'dno', type: 'String'  },  
	                    	{name : 'manualinv', type: 'number'  }, 
	                    	{name : 'datval', type: 'number'  }, 
                	
                 ],
                 localdata: invdata,
                
                
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
            var cellclassname =  function (row, column, value, data) {
                var manualinv = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', row, "manualinv");
         	    if(parseInt(manualinv)==1) {  
         		    return "pinkClass";    //Manual Invoices
         	    } 
         	    var datval = $('#jqxInvoiceGrid').jqxGrid('getcellvalue', row, "datval");
        	    if(parseInt(datval)==1) {     
        		    return "yellowClass";  //Revised Contracts        
        	    } 
            } 
            $("#jqxInvoiceGrid").jqxGrid(   
            {
                width: '100%',
                height: 568,
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
		                	 { text: 'SL#', sortable: false, filterable: false,cellclassname:cellclassname,            
							      groupable: false, draggable: false, resizable: false,
							      datafield: 'sl', columntype: 'number', width: '4%',
							      cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							      }  
							     },  
						      { text: 'rowno', datafield: 'rowno', width: '5%',hidden:true },  	       
		                	  { text: 'Doc No', datafield: 'doc_no',width:'4%',cellclassname:cellclassname},  
		                	  { text: 'Old Contract No', datafield: 'remarks', width: '5%',cellclassname:cellclassname },  
		                	  { text: 'Ref No', datafield: 'refno', width: '4%',cellclassname:cellclassname },   
		                      { text: 'Client', datafield: 'refname', width: '12%',cellclassname:cellclassname },  
		                      { text: 'Site', datafield: 'site',width:'8%',cellclassname:cellclassname},   
		                  	  { text: 'siteid',datafield:'siteid',width:'5%',hidden:true},
		                  	  { text: 'Merged Invoice', datafield: 'mergedinvoice',width:'3%',cellclassname:cellclassname}, 
							    
							  { text: 'Actual', datafield: 'executedtrip', width: '4%',cellsformat:'d0',cellsalign:'right',align:'right',cellclassname:cellclassname  },
							  { text: 'Ctrip', datafield: 'tottrips', width: '4%',cellsformat:'d0',cellsalign:'right',align:'right',cellclassname:cellclassname  },
							  { text: 'Invoiced trip in advanced', datafield: 'invoicetrip', width: '4%',cellsformat:'d0',cellsalign:'right',align:'right',cellclassname:cellclassname  }, 
							  { text: 'Chargeable', datafield: 'chargedtrip', width: '4%',cellsformat:'d0',cellsalign:'right',align:'right',cellclassname:cellclassname  },  
							 
							  { text: 'Rate', datafield: 'rpcrate', columngroup: 'rate', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname:cellclassname  },
							  { text: 'Total', datafield: 'rpctotal', columngroup: 'rate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname:cellclassname  },
							  
							  { text: 'Rate', datafield: 'tfrate', columngroup: 'tippingfee', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname:cellclassname  },
							  { text: 'Total', datafield: 'tftotal', columngroup: 'tippingfee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname:cellclassname  },
							  
							  { text: 'Rate', datafield: 'gfrate', columngroup: 'gatefee', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname:cellclassname  },
							  { text: 'Total', datafield: 'gftotal', columngroup: 'gatefee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname:cellclassname  },
							  
							  { text: 'Net Total', datafield: 'nettotal', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname:cellclassname  },
							  { text: 'DNO', datafield: 'dno', width: '7%',cellclassname:cellclassname },   
							  { text: 'Cont.Date', datafield: 'date',width:'7%',cellsformat:'dd.MM.yyyy',hidden:true},
							  { text: 'Group Company', datafield: 'groupcompanies', width: '9%',cellclassname:cellclassname }, 
							  { text: 'Waste Type', datafield: 'wastetype', width: '10%',cellclassname:cellclassname },	
							  { text: 'Skip Size', datafield: 'skiptype', width: '10%',cellclassname:cellclassname},  
							  { text: 'manualinv', datafield: 'manualinv', width: '10%',hidden:true}, 
							  { text: 'datval', datafield: 'datval', width: '10%',hidden:true}, 
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