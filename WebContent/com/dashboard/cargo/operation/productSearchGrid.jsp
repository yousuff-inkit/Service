<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%> 
<%    ClsOperationDAO DAO=new ClsOperationDAO(); %>  
<%
   int rowindex =request.getParameter("rowindex")==null || request.getParameter("rowindex")==""?0:Integer.parseInt(request.getParameter("rowindex").trim());
   int id =request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim());                   
%>      
<script type="text/javascript">
var rowindex1 = '<%=rowindex%>';
var check = '<%=id%>';     

var productdata= '<%=DAO.productSearch(session) %>';                

        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'psrno', type: 'int'   },
                            {name : 'part_no', type: 'string'   },
     						{name : 'productname', type: 'string'   },
                        ],
                		localdata: productdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxProductSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                   
                columns: [ 
						{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
						    groupable: false, draggable: false, resizable: false,datafield: '',
						    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
						    cellsrenderer: function (row, column, value) {
						  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
							},
                            { text: 'PSRNO', datafield: 'psrno', width: '5%',hidden:true },
                            { text: 'Product Code', datafield: 'part_no', width: '15%'},
							{ text: 'Product Name', datafield: 'productname', width: '90%' },
						]
            });
            
             $('#jqxProductSearch').on('rowdoubleclick', function (event) {
            	 $('#jqxMultipleCashPurchase').jqxGrid('render');
                 var rowindex2 = event.args.rowindex;          
                 if(check==1){
                	 $('#jqxMCPCash').jqxGrid('setcellvalue', rowindex1, "description" ,$('#jqxProductSearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                     $('#jqxMCPCash').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#jqxProductSearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
                 }else if(check==2){    
                	 $('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex1, "description" ,$('#jqxProductSearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                     $('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#jqxProductSearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
                 }else{}
                  $('#productSearchwindow').jqxWindow('close');            
            });  
        });
    </script>
    <div id="jqxProductSearch"></div>
 