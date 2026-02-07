<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.skips.clientallocation.ClsClientAllocationDAO"%>
<%
ClsClientAllocationDAO DAO = new ClsClientAllocationDAO();   
%>  
<script type="text/javascript">
var locdata= '<%=DAO.searchTelesales(session) %>';   
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'doc_no', type: 'String'  },      
      						 {name : 'name', type: 'String'  },
                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxtelesalesGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
                
                columns: [
          				{ text: 'Doc No', datafield: 'doc_no', width: '20%'},
    					{ text: 'Name', datafield: 'name', width: '80%',editable:false } 
						]
            });
            
             $('#jqxtelesalesGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
 
                document.getElementById("hidtelesalesid").value = $('#jqxtelesalesGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");  
                document.getElementById("txttelesales").value = $('#jqxtelesalesGrid').jqxGrid('getcellvalue', rowindex1, "name");  

              $('#telesalessearchWindow').jqxWindow('close');    
        
            }); 
             
        });
    </script>
    <div id="jqxtelesalesGrid"></div>  