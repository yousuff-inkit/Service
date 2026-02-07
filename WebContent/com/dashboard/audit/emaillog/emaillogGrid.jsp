<%@page import="com.dashboard.audit.emaillog.ClsEmailLogDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsEmailLogDAO DAO= new ClsEmailLogDAO();   
 %>
 <%
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

 %> 
    <script type="text/javascript">
    var ccdata;  
    var id='<%=id%>';
    var fromdate='<%=fromdate%>';
    var todate='<%=todate%>';

    $(document).ready(function () { 
    	
    	ccdata='<%=DAO.EmailData(session,id,fromdate,todate)%>';  
    	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'doc_no', type: 'String'  },
                	{name : 'edate', type: 'String'  },
                	{name : 'dtype', type: 'string'  },
                	{name : 'client', type: 'string'  },
	      		    {name : 'mailuser', type: 'string'  },
      	       	    {name : 'email', type: 'String'  },
      	       	    {name : 'branch', type: 'String'  },

                          	],
                 localdata: ccdata,
                
                
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
            $("#jqxemailgrid").jqxGrid(
            {
                width: '100%',
                height: 570,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
                filterable: true, 
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                showfilterrow:true,
                showaggregates:true,
               


                //Add row method
	          
                columns: [{ text: 'SL#', sortable: false, filterable: false, editable: false,
                    groupable: false, draggable: false, resizable: false,
                    datafield: '', columntype: 'number', width: '5%',
                    cellsrenderer: function (row, column, value) {
                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                    }
			},
			{ text: 'Doc No', datafield: 'doc_no', width: '10%',editable:false },
			{ text: 'Date', datafield: 'edate', width: '10%',editable:false },
			{ text: 'Branch',datafield:'branch',width:'10%',editable:false},  
			{ text: 'Dtype',datafield:'dtype',width:'8%',editable:false},  
			{ text: 'Client', datafield: 'client',editable:false },	
			{ text: 'Mail User',datafield:'mailuser',width:'15%',editable:false},
			{ text: 'Email',datafield:'email',width:'15%',editable:false},  
					
					]
            });
          	 $("#overlay, #PleaseWait").hide();

            $("#jqxemailgrid").jqxGrid('addrow', null, {});
                 });
    
  
   
    </script>
    <div id="jqxemailgrid"></div>  
