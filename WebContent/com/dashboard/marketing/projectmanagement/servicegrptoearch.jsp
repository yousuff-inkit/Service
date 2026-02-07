<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.marketing.projectmanagement.ClsProjectManagementDAO"%>   
<%
ClsProjectManagementDAO DAO=new ClsProjectManagementDAO();    
%> 
<% String contextPath=request.getContextPath();%>   
<% 
   String assgnid=request.getParameter("assgnid")==null || request.getParameter("assgnid")==""?"0":request.getParameter("assgnid").trim();     
%>
<style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
}   
</style>
 <script type="text/javascript">
 
 var assignteam;


 var assgnid='<%=assgnid%>';
 
   assignteam='<%=DAO.assignteam(session,assgnid)%>';   
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'empid', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						{name : 'grpcode', type: 'String'  },
     						{name : 'name', type: 'String'  },
                          	],
                          	localdata: assignteam,
                          //	 url: url1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxgrptosearch").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", items: 20 ,width: 170, height: 20,placeHolder: "Enter Group Member"});
            $("#jqxgrptosearch").on('select', function (event) {       
            	  if (event.args) {
                      var item = event.args.item;              
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {  
                              if (item.value == dataAdapter.records[i].doc_no) {     
                            	  document.getElementById("hidgrpmemberid").value=dataAdapter.records[i].doc_no;         
                            	  document.getElementById("hidgrpempid").value=dataAdapter.records[i].empid;  
                            	  break;       
                              }
                          }
                      }
                  }   
                });
         }); 
    </script>
    <input  type="text" id="jqxgrptosearch" class="p-l-5 input-sm form-control"/>    
    </body>
</html>