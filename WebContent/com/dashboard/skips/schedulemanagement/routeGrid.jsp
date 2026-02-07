 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <%@page import="com.dashboard.skips.schedulemanagement.ClsScheduleManagementDAO"%>
 <% ClsScheduleManagementDAO DAO = new ClsScheduleManagementDAO();   
  String contextPath=request.getContextPath();
  String id=request.getParameter("id")==null || request.getParameter("id").trim()==""?"0":request.getParameter("id").trim();%>
<script type="text/javascript">

	var rdata='<%=DAO.routeData(session,id)%>';   
        $(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						 {name : 'doc_no', type: 'number' }, 
     						 {name : 'code', type: 'string'  },        
     						 {name : 'dumpsite', type: 'string'   },
     						 {name : 'vehgroup', type: 'string'   },
     						 {name : 'area', type: 'string'   },
     						 {name : 'name', type: 'string'   },    
                        ],
                         localdata: rdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
           
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxroutegrid").jqxGrid(
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
							{ text: 'Doc No', datafield: 'doc_no', editable: false,  width: '7%'},
							{ text: 'Code', datafield: 'code', width: '18%', editable: false  },
							{ text: 'Name', datafield: 'name', width: '20%', editable: false  },
							{ text: 'Dumping site', datafield: 'dumpsite', width: '15%', editable: false  },
							{ text: 'Vehicle group', datafield: 'vehgroup', width: '15%', editable: false  },
							{ text: 'Area', datafield: 'area', width: '20%', editable: false  },  
						]
            });
         
      
            $('.load-wrapp').hide(); 
            
        });
</script>
<div id="jqxroutegrid"></div>
 