<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.dumpinglist.ClsDumpingListDAO" %>
<%
ClsDumpingListDAO DAO= new ClsDumpingListDAO();                     
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();  
		String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim(); 
		%>   
<script type="text/javascript">
  
var quotedata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 quotedata='<%=DAO.contractGridLoad(id,fromdate,todate)%>';                 
            var source =
            {
                datatype: "json",
                datafields: [
                	        {name : 'doc_no', type: 'number'  },
                	        {name : 'dumpdate', type: 'date'  },
                	        {name : 'dumptime', type: 'date'  },
		                	{name : 'remarks', type: 'String'  },
		                  	{name : 'weight', type: 'String'  },
							{name : 'skip', type: 'string'   },
		              		{name : 'wasttype', type: 'String'  },
							{name : 'dumpsite', type: 'String'  },
							{name : 'driver', type: 'String'  },
							{name : 'helper', type: 'String'  },
		                	{name : 'vehicle', type: 'String'  },
		                	{name : 'slno', type: 'number'    },
		                	
                        	
                 ],
                 localdata: quotedata,  
                
                
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

            $("#jqxdumpinglistGrid").jqxGrid(  
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
                rowsheight:25,
                filtermode:'excel',
                sortable:true,
                columnsresize: true,   
            	
       
                columns: [
                            { text: 'Sr.No', datafield: 'slno', width: '3%' },  
                            { text: 'Doc No',datafield:'doc_no',width:'5%',editable:false},    
                            { text: 'Dump Date', datafield: 'dumpdate',editable:false,width:'6%',cellsformat:'dd.MM.yyyy'},  
                            { text: 'Dump Time', datafield: 'dumptime',editable:false,width:'5%',cellsformat:'HH:mm'}, 
                            { text: 'Weight', datafield: 'weight',editable:false,width:'5%'},  
                            { text: 'Skip', datafield: 'skip',editable:false,width:'5%'}, 
                            { text: 'Waste Type', datafield: 'wasttype',editable:false,width:'10%'},  
                            { text: 'Dump Site', datafield: 'dumpsite',editable:false,width:'10%'},   
                            { text: 'Driver', datafield: 'driver',editable:false,width:'10%'},   
                        	{ text: 'Helper', datafield: 'helper',editable:false,width:'10%'},
                        	{ text: 'Vehicle',datafield:'vehicle',editable:false,width:'13%'},  
                        	 { text: 'Remarks', datafield: 'remarks',editable:false},   
                        	
                        	]
            });
            $("#overlay, #PleaseWait").hide(); 
        });
    </script>
    <div id="jqxdumpinglistGrid"></div> 