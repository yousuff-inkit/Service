<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.servicescheduleanalysis.ClsServiceScheduleAnalysisDAO" %>
<%
		ClsServiceScheduleAnalysisDAO DAO= new ClsServiceScheduleAnalysisDAO();     
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
        String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim().toString(); 
        String todate=request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();   
        String grptype=request.getParameter("grptype")==null?"":request.getParameter("grptype").trim().toString();   
 %>   
<script type="text/javascript">   
  
var serschdata;
var id='<%=id%>';
var type = '<%=grptype%>';
$(document).ready(function () {   	
             var num = 1; 
        		 serschdata='<%=DAO.groupwiseLoad(session, id, fromdate, todate, grptype)%>';                       
            
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'type', type: 'String'  },
							{name : 'count', type: 'number'  },
                 ],
                 localdata: serschdata,  
                
                
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

            
            $("#jqxGroupwise").jqxGrid(  
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                editable: false,
                altRows: true,
                selectionmode: 'singlerow',   
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
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
                            { text: ''+type, datafield: 'type',editable:false,width:'86%'},    
                            { text: 'Count', datafield: 'count',editable:false,width:'10%'},   
                            ]
            });
            $("#overlay, #PleaseWait").hide(); 
        });
    </script>
    <div id="jqxGroupwise"></div>       