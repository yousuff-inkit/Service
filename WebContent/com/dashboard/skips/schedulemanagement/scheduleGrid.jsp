 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<%@page import="com.dashboard.skips.schedulemanagement.ClsScheduleManagementDAO"%>  
 <% ClsScheduleManagementDAO DAO = new ClsScheduleManagementDAO(); 
  String contextPath=request.getContextPath();
  String id=request.getParameter("id")==null || request.getParameter("id").trim()==""?"0":request.getParameter("id").trim();%>
<script type="text/javascript">
	var sdata='<%=DAO.scheduleData(session,id)%>';   
        $(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'driver', type: 'string'  },        
     						{name : 'helper', type: 'string'   },
     						{name : 'route', type: 'string'   },
							{name : 'date', type: 'date' }, 
							{name : 'time', type: 'string' },  
							{name : 'doc_no', type: 'string' },  
                        ],
                         localdata: sdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
           
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxschedulegrid").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                editable: true,
                
                selectionmode: 'singlecell',  
                filterable:true,
                showfilterrow:true,
                enabletooltips:true,
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                            }   },
                            { text: 'Doc No', datafield: 'doc_no',  width: '10%' },
                            { text: 'Date', datafield: 'date',  width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Time', datafield: 'time',  width: '10%' },
							{ text: 'Driver', datafield: 'driver', editable: false},							
							{ text: 'Helper', datafield: 'helper', width: '20%', editable: false  },
							{ text: 'Route', datafield: 'route', width: '20%', editable: false  },							
						]
            });
         
      
            $('.load-wrapp').hide(); 
            
        });
</script>
<div id="jqxschedulegrid"></div>
 