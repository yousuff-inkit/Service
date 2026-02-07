<%@page import="com.dashboard.skips.presalesmanagement.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsPresalesmanagementDAO DAO= new ClsPresalesmanagementDAO();  
 %>
 <%
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String id=request.getParameter("id")==null?"0":request.getParameter("id").trim().toString();
 %>
    <script type="text/javascript">
    var sitedata;
    
    $(document).ready(function () { 
    		sitedata='<%=DAO.siteGridLoad(session,docno,id)%>';  
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'srno' , type: 'number' },
     						{name : 'site', type: 'String'  },
                          	{name : 'area', type: 'String'  },
                          	{name : 'sitedocno', type: 'String'  },
                          	{name : 'remarks', type: 'String'  },
                          	{name : 'route', type: 'String'  },
                          	{name : 'gpsx', type: 'String'  },
                          	{name : 'gpsy', type: 'String'  },
                          	{name : 'description', type: 'String'  },  
                          	],
                 localdata: sitedata,
                
                
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
            $("#siteGrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                sortable: true,
                editable:false,
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Site', datafield: 'site'},
					{ text: 'Area',datafield:'area',width:'25%',editable:false},
					{ text: 'Remarks', datafield: 'remarks', width: '40%' },
					{ text: 'sitedocno',datafield:'sitedocno',width:'25%',editable:false,hidden:true},
					{ text: 'route',datafield:'route',width:'25%',editable:false,hidden:true},
					{ text: 'gpsx',datafield:'gpsx',width:'25%',editable:false,hidden:true},
					{ text: 'gpsy',datafield:'gpsy',width:'25%',editable:false,hidden:true},
					{ text: 'description',datafield:'description',width:'25%',editable:false,hidden:true},  
					]
            });
            $('.load-wrapp').hide(); 
            $('#siteGrid').on('rowdoubleclick', function (event) { 
             	  var rowindex1=event.args.rowindex;   
             	  document.getElementById("sitedocno").value=$('#siteGrid').jqxGrid('getcellvalue', rowindex1, "sitedocno");
             	  document.getElementById("txtroute").value=$('#siteGrid').jqxGrid('getcellvalue', rowindex1, "route");
             	  document.getElementById("txtgpsx").value=$('#siteGrid').jqxGrid('getcellvalue', rowindex1, "gpsx");
             	  document.getElementById("txtgpsy").value=$('#siteGrid').jqxGrid('getcellvalue', rowindex1, "gpsy");  
             	  document.getElementById("txtdesc").value=$('#siteGrid').jqxGrid('getcellvalue', rowindex1, "description");
             	  document.getElementById("selectedsite").innerHTML=$('#siteGrid').jqxGrid('getcellvalue', rowindex1, "site");   
            }); 	 
    });  
    </script>
    <div id="siteGrid"></div>
