<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.marketing.projectmanagement.ClsProjectManagementDAO"%>   
<%
ClsProjectManagementDAO DAO=new ClsProjectManagementDAO();    
%>  
<% String contextPath=request.getContextPath();%>
 <style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
}   
</style>
 <script type="text/javascript">
 
 var usersearch;

 
   usersearch='<%=DAO.userSearch(session)%>';
 
        $(document).ready(function () { 
         
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
     						{name : 'username', type: 'String'  },
     						{name : 'docno', type: 'String'  }
     						
                          	],
                          	localdata: usersearch,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source); 
            
            $("#jqxusersearch").jqxInput({ source: dataAdapter, displayMember: "username", valueMember: "docno", items: 20 ,width: 170, height: 20});
            $("#jqxusersearch").on('select', function (event) {      
            	  if (event.args) {
                      var item = event.args.item;              
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {  
                              if (item.value == dataAdapter.records[i].docno) {    
                            	  document.getElementById("hiduserid").value=dataAdapter.records[i].docno;   
                            	  break;       
                              }
                          }
                      }
                  }   
                });
      }); 
    </script>
    <input  type="text" id="jqxusersearch"/>