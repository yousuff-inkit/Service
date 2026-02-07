<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.serviceexecution.ClsServiceExecutionDAO" %>
<%
ClsServiceExecutionDAO DAO= new ClsServiceExecutionDAO();       
		 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
  		 String days=request.getParameter("days")==null || request.getParameter("days")==""?"":request.getParameter("days").trim().toString();  
         String date = request.getParameter("startdate")==null?"0":request.getParameter("startdate");         
		 String enddate = request.getParameter("enddate")==null?"0":request.getParameter("enddate");
		 String time = request.getParameter("time")==null?"":request.getParameter("time");
		 String noofvisit = request.getParameter("noofvisit")==null?"0":request.getParameter("noofvisit");
		 String serviceterm = request.getParameter("serviceterm")==null?"0":request.getParameter("serviceterm");
		 String alternatedays = request.getParameter("alternatedays")==null?"0":request.getParameter("alternatedays");  
		 String daynos=request.getParameter("daynos")==null || request.getParameter("daynos")==""?"0":request.getParameter("daynos").trim().toString();
		 //System.out.println("days==="+days);    
 %>   
<script type="text/javascript">  
  
var schdata;
var id='<%=id%>';
$(document).ready(function () {         	
             var num = 1;   
        		 schdata='<%=DAO.scheduleMultipleLoad(session, date, enddate, time, noofvisit, serviceterm, days, alternatedays, daynos, id)%>';               
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
		                  	{name : 'day', type: 'String'  },
                        	{name : 'date', type: 'Date'  }, 
                        	{name : 'time', type: 'String'  },  
                 ],
                 localdata: schdata,  
                
                
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

            
            $("#jqxScheduleGrid").jqxGrid(  
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'singlecell',    
                pagermode: 'default', 
                filterable: true,
                filtermode: 'excel',
       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Date', datafield: 'date',editable:true, columntype: 'datetimeinput',width:'25%',cellsformat:'dd.MM.yyyy'},  
                            { text: 'Time', datafield: 'time',editable:true,width:'25%',cellsformat:'HH:mm',columntype:"datetimeinput", createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
      	                      editor.jqxDateTimeInput({ showCalendarButton: false });
      	                      }
      					    },  
                            { text: 'Day', datafield: 'day',editable:false},   
			     ]
            });
            $("#loadingoverlay").fadeOut();
        });
    </script>
    <div id="jqxScheduleGrid"></div> 