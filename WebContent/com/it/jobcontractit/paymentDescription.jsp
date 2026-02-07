<%@page import="com.it.jobcontractit.ClsJobContractItDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath(); %>
<% ClsJobContractItDAO DAO = new ClsJobContractItDAO(); %>
<% int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>

 <script type="text/javascript">
 
 var paymentDescription;

 var rowIndex='<%=rowIndex%>';
 
 paymentDescription='<%=DAO.paymentDescription(session)%>';
 
        $(document).ready(function () { 
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'docno', type: 'String'  },
     						{name : 'name', type: 'String'  },
                          	
     						],
                          	localdata: paymentDescription,
                
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
            $("#jqxPaymentDescription").jqxGrid(
            {
                width: '100%',
                height: 420,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Name', datafield: 'name', width: '100%' }
					
					]
            });
				            
				           $('#jqxPaymentDescription').on('rowdoubleclick', function (event) { 
				              	var rowindex1=event.args.rowindex;
				            	 
				               	$('#paymentGrid').jqxGrid('setcellvalue', rowIndex, "desc1",$('#jqxPaymentDescription').jqxGrid('getcellvalue', rowindex1, "name"));
				              
				                $('#paymentdescwindow').jqxWindow('close');
				            }); 	 
                  }); 
                       
    </script>
    <div id="jqxPaymentDescription"></div>
    
    </body>
</html>