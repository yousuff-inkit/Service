<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.dumpmaster.route.ClsRouteDAO"%>
<%
ClsRouteDAO searchDAO = new ClsRouteDAO();
String vehgrpids = request.getParameter("vehgrpids")==null?"":request.getParameter("vehgrpids");
%>  

 
<script type="text/javascript">


var locdata= '<%=searchDAO.searchVehicle(session,vehgrpids) %>';      
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'vehicleid', type: 'String'  },    
      						{name : 'vehicle', type: 'String'  },
                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#vehicleGrid").jqxGrid(
            {
                width: '100%',
                height: 310,
                source: dataAdapter,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
                
                columns: [
                          
          				{ text: 'Doc No', datafield: 'vehicleid', width: '20%'},
    					{ text: 'Vehicle', datafield: 'vehicle', width: '80%',editable:false }
										
						]
            });
            
             $('#vehicleGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
 
              //   txtlocationid
                 document.getElementById("errormsg").innerText="";
                document.getElementById("vehicleid").value = $('#vehicleGrid').jqxGrid('getcellvalue', rowindex1, "vehicleid");
                document.getElementById("txtvehicle").value = $('#vehicleGrid').jqxGrid('getcellvalue', rowindex1, "vehicle");

              $('#vehiclesearchwndow').jqxWindow('close');  
        
            }); 
             
        });
    </script>
    <div id="vehicleGrid"></div>