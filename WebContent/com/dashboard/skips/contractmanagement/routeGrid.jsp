<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractmanagement.ClsContractManagementDAO" %>
<%
         ClsContractManagementDAO DAO= new ClsContractManagementDAO();  
		 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		 String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").trim().toString();  
		 String srno=request.getParameter("srno")==null || request.getParameter("srno")==""?"0":request.getParameter("srno").trim().toString();  
 %>   
<script type="text/javascript">
  
var routedata;
var id='<%=id%>';
$(document).ready(function () {     	
             var num = 1;   
             routedata='<%=DAO.quotedetLoad(session, rdocno, srno, id)%>';                        
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
		                  	{name : 'wastetype', type: 'String'  },
                        	{name : 'skiptype', type: 'String'  },
                        	{name : 'site', type: 'String'  },  
                        	{name : 'qty', type: 'number'  },  
                        	{name : 'skip', type: 'String'  },  
                        	{name : 'skipid', type: 'String'  },  
                        	{name : 'delid', type: 'String'  }, 
                        	{name : 'route', type: 'String'  },
                 ],
                 localdata: routedata,  
                
                
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

            
            $("#jqxrouteGrid").jqxGrid(  
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'singlerow',      
                pagermode: 'default', 
                filterable: true,
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                ready: function () {
                    // callback function which is called by jqxGrid when the widget is initialized and the binding is completed.
                	var ownership=$('#hidownership').val();
        	    	if(ownership=="OWN SKIP"){
        	    		$("#jqxrouteGrid").jqxGrid('showcolumn', 'skip');   
        	    	}else{
        	    		$("#jqxrouteGrid").jqxGrid('hidecolumn', 'skip');  
        	    	}
                },
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Route', datafield: 'route',editable:false, width: '20%'},   
                            { text: 'Skip', datafield: 'skip',editable:false, width: '20%'},   
                            { text: 'Waste Type', datafield: 'wastetype',editable:false},    
                            { text: 'Skip Size', datafield: 'skiptype',editable:false, width: '20%'},
                            { text: 'Site', datafield: 'site',editable:false, width: '20%'},  
                            { text: 'Skipid', datafield: 'skipid',editable:false, width: '4%',hidden:true}, 
                            { text: 'delid', datafield: 'delid',editable:false, width: '4%',hidden:true}, 
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxrouteGrid').on('rowdoubleclick', function (event) {           
           	  var rowindex1=event.args.rowindex;    
           	  document.getElementById("hiddelid").value=$('#jqxrouteGrid').jqxGrid('getcellvalue', rowindex1, "delid");  
              document.getElementById("lblotherdetails4").innerHTML=$("#lblname").val()+" Skip -"+$('#jqxrouteGrid').jqxGrid('getcellvalue', rowindex1, "skip"); 
          });
        });
    </script>
    <div id="jqxrouteGrid"></div>        