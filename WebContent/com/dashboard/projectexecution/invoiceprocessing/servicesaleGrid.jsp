<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.invoiceProcessing.ClsInvoiceProcessingDAO"%>
<%
ClsInvoiceProcessingDAO DAO=new ClsInvoiceProcessingDAO(); 
%>

<%
int id =request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").toString());  
String trno =request.getParameter("trno")==null || request.getParameter("trno")==""?"":request.getParameter("trno").toString(); 
String processid =request.getParameter("processid")==null || request.getParameter("processid")==""?"0":request.getParameter("processid").toString(); 
String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();
%>  
<script type="text/javascript">

	<%-- var descdatas='<%=DAO.loadServiceSales(trno,id,processid,date)%>';   --%>              

    var list =['GL','HR'];
//alert(descdatas);

        $(document).ready(function () { 	
       
            
        	  var rendererstring1=function (aggregates){
               	var value=aggregates['sum1'];
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
               }
            var rendererstring=function (aggregates){
         	   var value=aggregates['sum'];
         	   return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">'  + value + '</div>';
             }
               
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [//srno, description, unitprice, qty, total, discount, nettotal, nuprice, acno, costtype, costcode, remarks, account, description, atype, CostGroup
     						
							    {name : 'type', type: 'string'  },
								{name : 'account', type: 'string'    },
								{name : 'accname', type: 'string'    },
								{name : 'description', type: 'string'    },
								{name : 'qty', type: 'int'    },
								{name : 'unitprice', type: 'number'    },
								{name : 'total', type: 'number'    },
								{name : 'discount', type: 'number'    },
								{name : 'nettotal', type: 'number'    },
								{name : 'costtype', type: 'string'    },
								{name : 'costgroup', type: 'string'    },
								{name : 'costcode', type: 'number'    },
								{name : 'nuprice', type: 'number'    },
								{name : 'remarks', type: 'string'    },
								{name : 'headdoc', type: 'number'    },
								{name : 'qutval', type: 'number'    },
								{name : 'grtype', type: 'number'    },
								{name : 'gst', type: 'number'  },  
								{name : 'igst', type: 'number'  },    
	        					{name : 'taxamount', type: 'number'  },
	        					{name : 'taxperamt', type: 'number'  },
	        					{name : 'idno', type: 'number'  }, 
	        					{name : 'interstate', type: 'number'  },  
	        					{name : 'refid', type: 'number'  },  
                 ],              
              
                 localdata: descdatas,
                
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
            
            $("#nidescdetailsGrid").jqxGrid(
            {
            	 width: '100%',
                 height: 175,
                 source: dataAdapter,
                 //showaggregates:true,
                 //showstatusbar:true,  
                 editable: true,
                 enabletooltips:true,  
                 statusbarheight: 25,
                 selectionmode: 'singlecell',
                 columns: [
                           { text: 'SL#', sortable: false, filterable: false, editable: false,  
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
							{ text: 'Description', datafield: 'description'},
							{ text: 'idno', datafield: 'idno', width: '13%' ,hidden:true}, 
							{ text: 'Qty', datafield: 'qty', width: '6%', cellsalign: 'left', align:'left', editable: false},
							{ text: 'Unit Price', datafield: 'unitprice', width: '8%',cellsalign: 'right', align:'right',cellsformat:'d2', editable: false },
							{ text: 'Total', datafield: 'total', width: '8%',cellsformat:'d2',cellsalign: 'right', align:'right', editable:false},
							{ text: 'Discount', datafield: 'discount', width: '8%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1, editable: false},
							{ text: 'Net Total', datafield: 'nettotal', width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable:false},
							{ text: 'CGST / IGST', datafield: 'igst', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , editable: false },
							{ text: 'GST', datafield: 'gst', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , editable: false },
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '8%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right'  ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: false},
							{ text: 'Net Total', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							{ text: 'Type', datafield: 'type', width: '4%',hidden:true},
							{ text: 'Account', datafield: 'account', width: '4%' ,cellsalign: 'center', align:'center',hidden:true},
							{ text: 'Account Name', datafield: 'accname', width: '12%' ,hidden:true},
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%' ,hidden:true},
							{ text: 'Cost Code', datafield: 'costcode', width: '5%' ,hidden:true},  
							{ text: 'Remarks', datafield: 'remarks', width: '19%',hidden:true },
							{ text: 'Qutval', datafield: 'qutval', width: '20%',hidden:true},
							{ text: 'nuprice', datafield: 'nuprice', width: '9%',cellsformat:'d2',hidden:true},
							{ text: 'Head doc', datafield: 'headdoc', width: '20%' ,hidden:true},     
							{ text: 'Cost id', datafield: 'costtype', width: '8%',hidden:true },
							{ text: 'grtype', datafield: 'grtype', width: '20%',hidden:true }, 
							{ text: 'interstate', datafield: 'interstate', width: '20%',hidden:true },
							{ text: 'refid', datafield: 'refid', width: '20%',hidden:true },  
	              ]
            });
            $("#overlay, #PleaseWait").hide();     
        });
        
    </script>
    <div id="nidescdetailsGrid"></div>    
