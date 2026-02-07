<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.sales.consolidatedsales.ClsConsolidatedSalesDAO" %>

<%ClsConsolidatedSalesDAO DAO= new ClsConsolidatedSalesDAO();
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");;%>

<script type="text/javascript">
        
var data1= '<%=DAO.clientsearch(cldocno)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno', type: 'int'   },
     						{name : 'clname', type: 'string'   }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                
                columns: [
                          
							{ text: 'Doc No',  datafield: 'cldocno', width: '10%' },
							{ text: 'Client', datafield: 'clname', width: '90%' },
						]
            });
            
            $('#clientSearchGridID').on('rowdoubleclick', function (event) {
                
                var rowindex2 = event.args.rowindex;
                document.getElementById("client").value=$('#clientSearchGridID').jqxGrid('getcellvalue', rowindex2, "clname");
                document.getElementById("cldocno").value=$('#clientSearchGridID').jqxGrid('getcellvalue', rowindex2, "cldocno");
                $('#Searchwindow').jqxWindow('close');
            }); 
            $("#overlay, #PleaseWait").hide();
            
        });
    </script>
    <div id="clientSearchGridID"></div>
 