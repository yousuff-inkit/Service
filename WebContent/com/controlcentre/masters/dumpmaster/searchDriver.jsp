<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.dumpmaster.route.ClsRouteDAO"%>
<%
ClsRouteDAO searchDAO = new ClsRouteDAO();
%>  

 
<script type="text/javascript">


var locdata= '<%=searchDAO.searchDriver(session) %>';   
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'driverid', type: 'String'  },    
      						{name : 'driver', type: 'String'  },
                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#driverGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
                
                columns: [
                          
          				{ text: 'Doc No', datafield: 'driverid', width: '20%'},
    					{ text: 'Driver Name', datafield: 'driver', width: '80%',editable:false }
										
						]
            });
            
             $('#driverGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
 
              //   txtlocationid
                 document.getElementById("errormsg").innerText="";
                document.getElementById("driverid").value = $('#driverGrid').jqxGrid('getcellvalue', rowindex1, "driverid");
                document.getElementById("txtdriver").value = $('#driverGrid').jqxGrid('getcellvalue', rowindex1, "driver");

              $('#driversearchwndow').jqxWindow('close');  
        
            }); 
             
        });
    </script>
    <div id="driverGrid"></div>