<%@page import="javax.servlet.http.HttpServletRequest" %>
                <%@page import="javax.servlet.http.HttpSession" %>
                <%@page import="com.controlcentre.legacydata.productopening.ClsproductopeningDAO"%>
                <% ClsproductopeningDAO searchDAO = new ClsproductopeningDAO();


                String brch=request.getParameter("brch")==null?"0":request.getParameter("brch");

                %> 





                 
                <script type="text/javascript">


                var locdata= '<%=searchDAO.locationsearch(brch) %>';   
                        $(document).ready(function () { 
                                     
                            // prepare the data
                            var source =
                            {
                                datatype: "json",
                                datafields: [


                                             {name : 'doc_no', type: 'String'  },    
                      						{name : 'loc_name', type: 'String'  },
                      				 
                                             
                                             
                                        ],
                                		localdata: locdata, 
                                
                                pager: function (pagenum, pagesize, oldpagenum) {
                                    // callback called when a page or page size is changed.
                                }
                                                        
                            };
                            
                            var dataAdapter = new $.jqx.dataAdapter(source);
                            
                            $("#locgrid").jqxGrid(
                            {
                                width: '100%',
                                height: 300,
                                source: dataAdapter,
                           
                                selectionmode: 'singlerow',
                                
                                columns: [
                                          
                          				{ text: 'ID', datafield: 'doc_no', width: '20%',hidden:true},
                    					{ text: 'NAME', datafield: 'loc_name', width: '100%' }
                										
                						]
                            });
                            
                             $('#locgrid').on('rowdoubleclick', function (event) {
                                var rowindex1 = event.args.rowindex;
                 
                              var rowindex2=  document.getElementById("rowindex").value;
               
    		 
  							
    							   
       
                              $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "locid",$('#locgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));

                              $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "location",$('#locgrid').jqxGrid('getcellvalue', rowindex1, "loc_name"));
                              $('#locationwindow').jqxWindow('close');  
                        
                            }); 
                             
                        });
                    </script>
                    <div id="locgrid"></div>