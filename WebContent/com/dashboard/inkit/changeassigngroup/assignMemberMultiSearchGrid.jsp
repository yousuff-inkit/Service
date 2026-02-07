<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.inkit.changeassigngroup.ClsChangeAssignGroupDAO" %>
<% String contextPath=request.getContextPath();%>
 <%ClsChangeAssignGroupDAO DAO=new ClsChangeAssignGroupDAO();%>
 <% 
 /* int assgnid=request.getParameter("assgnid")==null?0:Integer.parseInt(request.getParameter("assgnid").trim()); */
 int assgnid=0;
 
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").trim());
 %>

 <script type="text/javascript">
 
 var assignteam;
 
 var assgnid='<%=assgnid%>';
 
   assignteam='<%=DAO.assignteam(session,assgnid)%>';
 
        $(document).ready(function () { 
        	var id='<%=id%>';
        	
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'name', type: 'String'  },
     						{name : 'empid', type: 'String'  },
     						{name : 'dbname', type: 'String'  },

     						{name : 'doc_no', type: 'String'  },
     						{name : 'grpcode', type: 'String'  },
                          	],
                          	localdata: assignteam,
                          //	 url: url1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxgrptosearch").jqxGrid(
            {
                width: '100%',
                height: 390,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'checkbox',
                filtermode:'excel',
				showfilterrow: true,
                filterable: true,
            
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Employee', datafield: 'name' },
					{ text: 'empid', datafield: 'empid', hidden:true },
					{ text: 'dbname', datafield: 'dbname', hidden:true },
					
					{ text: 'doc_no', datafield: 'doc_no', hidden:true },
					{ text: 'Assign Group', datafield: 'grpcode', width: '45%', hidden:true },
					]
            });
    
                  }); 

        function addArea(){
        	
        	var formname='Service Settings';
        	var formcode='SERS';
        	var lblname='Service Area Settings';
        	var lbldrp='area';
        	var detName='Service Settings';
        	
        	 var url=document.URL;
		     var reurl=url.split("/com/");
		     var path1='com/controlcentre/settings/ServiceSettings/serviceSettings.jsp';
        	var path= path1+"?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"&mode=A";
			  
			   top.addTab( detName,reurl[0]+"/"+path);
        	
        	<%-- window.open("<%=contextPath%>/com/controlcentre/settings/ServiceSettings/serviceSettings.jsp?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"","Service Settings","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260"); --%>
      
        }
        
                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxgrptosearch"></div>
    
    </body>
</html>