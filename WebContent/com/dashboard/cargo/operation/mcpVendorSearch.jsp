<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
   ClsOperationDAO DAO=new ClsOperationDAO();     
   int rowindex =request.getParameter("rowindex")==null || request.getParameter("rowindex")==""?0:Integer.parseInt(request.getParameter("rowindex").trim());
   int id =request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim());                   
   String type =request.getParameter("tax")==null?"0":request.getParameter("tax");               
%>
<script type="text/javascript">
  var mcpvnd;      
  var rowindex = '<%=rowindex%>';
  var type = '<%=type%>';
  var check = '<%=id%>'; 
  console.log(check);      
  mcpvnd='<%=DAO.mcpvendorSearch(session) %>';                  
        $(document).ready(function () { 
         var num = 0; 
            var source =      
            {
                datatype: "json",
                datafields: [
							{name : 'vendorid', type: 'String'  },
     						{name : 'vendor', type: 'String'  },
     						{name : 'tax', type: 'String'  },
     						{name : 'tinno', type: 'String'  },
     						{name : 'invno', type: 'String'  },
     						{name : 'invdate', type: 'String'  },
                          	],
                          	localdata: mcpvnd,
                          //	 url: url1,
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxmcpVendorSearch").jqxGrid(
            {
                width: '99%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            	showfilterrow:true,
            	filterable:true,
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'DocNo', datafield: 'vendorid', width: '16%' },
					{ text: 'Vendor Name', datafield: 'vendor', width: '78%' },
					{ text: 'tax', datafield: 'tax', width: '78%', hidden:true },
					{ text: 'tinno', datafield: 'tinno', width: '78%' },
					{ text: 'invno', datafield: 'invno', width: '78%', hidden:true },
					{ text: 'invdate', datafield: 'invdate',width: '78%', hidden:true },
					//{ text: 'dtype', datafield: 'dtype',width: '78%', hidden:true },
					]
            });
            $('#jqxmcpVendorSearch').on('rowdoubleclick', function (event){ 
				              	var rowindex2=event.args.rowindex;
				              	console.log(check);     
				            	if(check==1){    
				            		 var tax=$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "tax");
					                	$('#jqxMCPCash').jqxGrid('setcellvalue', rowindex, "vendor",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "vendor"));
					                	$('#jqxMCPCash').jqxGrid('setcellvalue', rowindex, "vendorid",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "vendorid"));
					                	$('#jqxMCPCash').jqxGrid('setcellvalue', rowindex, "tax",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "tax"));
					                	$('#jqxMCPCash').jqxGrid('setcellvalue', rowindex, "tinno",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "tinno"));
					                	$('#jqxMCPCash').jqxGrid('setcellvalue', rowindex, "invno",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "invno"));
					                	$('#jqxMCPCash').jqxGrid('setcellvalue', rowindex, "invdate",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "invdate"));
	  				                if(tax=="1"){            
					                    var taxamt=5;
					                	$('#jqxMCPCash').jqxGrid('setcellvalue', rowindex, "srvtaxper",taxamt);
					                	//document.getElementById("taxchk").value=1;
					                }
				            	}else if(check==2){                  
				            		 var tax=$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "tax");
					                	$('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex, "vendor",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "vendor"));
					                	$('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex, "vendorid",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "vendorid"));
					                	$('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex, "tax",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "tax"));
					                	$('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex, "tinno",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "tinno"));
					                	$('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex, "invno",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "invno"));
					                	$('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex, "invdate",$('#jqxmcpVendorSearch').jqxGrid('getcellvalue', rowindex2, "invdate"));
	  				                if(tax=="1"){            
					                    var taxamt=5;
					                	$('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex, "srvtaxper",taxamt);
					                	//document.getElementById("taxchk").value=1;
					                }
				            	}else{}      
				                $('#vendorinfowindow').jqxWindow('close');
				     }); 	 
            });      
    </script>
    <div id="jqxmcpVendorSearch"></div>    
    </body>
</html>