<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractmanagement.ClsContractManagementDAO" %>
<%
         ClsContractManagementDAO DAO= new ClsContractManagementDAO();  
		 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		 String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").trim().toString();  
		 String srno=request.getParameter("srno")==null || request.getParameter("srno")==""?"0":request.getParameter("srno").trim().toString(); 
		 String delid=request.getParameter("delid")==null || request.getParameter("delid")==""?"0":request.getParameter("delid").trim().toString();  
 %>   
<script type="text/javascript">
  
var skipdata;
var id='<%=id%>';
$(document).ready(function () {     	
             var num = 1;   
             skipdata='<%=DAO.skipHistoryLoad(session, id, rdocno, srno, delid)%>';                             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
		                  	{name : 'status', type: 'String'  },
                        	{name : 'user', type: 'String'  },
                        	{name : 'oldskip', type: 'String'  },  
                        	{name : 'newskip', type: 'String'  },  
                        	{name : 'date', type: 'Date'  },  
                        	{name : 'time', type: 'String'  },  
                        	{name : 'remarks', type: 'String'  },
                 ],
                 localdata: skipdata,    
                
                
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

            
            $("#jqxskipGrid").jqxGrid(  
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'singlerow',      
                pagermode: 'default', 
                filterable: true,
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Date', datafield: 'date',editable:false, width: '8%',cellsformat:'dd.MM.yyyy'},
                            { text: 'Time', datafield: 'time',editable:false, width: '5%',cellsformat:'HH.mm'}, 
                            { text: 'User', datafield: 'user',editable:false, width: '15%'},    
                            { text: 'Old Skip', datafield: 'oldskip',editable:false, width: '13%'},  
                            { text: 'New Skip', datafield: 'newskip',editable:false, width: '13%'},  
                            { text: 'Status', datafield: 'status',editable:false, width: '12%'},  
                            { text: 'Remarks', datafield: 'remarks',editable:false, width: '30%'},    
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
        });
    </script>
    <div id="jqxskipGrid"></div>      