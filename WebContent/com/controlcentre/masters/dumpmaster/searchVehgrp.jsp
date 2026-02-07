<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.dumpmaster.route.ClsRouteDAO"%>
<%
ClsRouteDAO searchDAO = new ClsRouteDAO();
%> 

 
<script type="text/javascript">


var locdata= '<%=searchDAO.searchVehgrp(session) %>';   
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'doc_no', type: 'String'  },    
      						{name : 'gname', type: 'String'  },
                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#vehgrpGrid").jqxGrid(
            {
                width: '100%',
                height: 310,
                source: dataAdapter,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
                
                columns: [
                          
          				{ text: 'Doc No', datafield: 'doc_no', width: '20%'},
    					{ text: 'Vehicle Group', datafield: 'gname', width: '80%' }
										
						]
            });
            
             $('#vehgrpGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
 
              //   txtlocationid
                 document.getElementById("errormsg").innerText="";
                document.getElementById("vehgrpid").value = $('#vehgrpGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtvehgrp").value = $('#vehgrpGrid').jqxGrid('getcellvalue', rowindex1, "gname");

              $('#vehgrpsearchwndow').jqxWindow('close');  
        
            }); 
             
        });
    </script>
    <div id="vehgrpGrid"></div>