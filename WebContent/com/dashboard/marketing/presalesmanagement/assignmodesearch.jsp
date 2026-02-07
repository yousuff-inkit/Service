<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.marketing.presalesmanagement.ClsPresalesManagementDAO"%>   
<%
ClsPresalesManagementDAO DAO=new ClsPresalesManagementDAO();  
%> 
<% String contextPath=request.getContextPath();%>
 <style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
}   
</style>

 <script type="text/javascript">
 
 var assignmode;

 
   assignmode='<%=DAO.assignmode(session)%>'; 
 
        $(document).ready(function () { 
         
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
     						{name : 'assign', type: 'String'  },
     						{name : 'docno', type: 'String'  }
     						
                          	],
                          	localdata: assignmode,
                          //	 url: url1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source); 
            
            $("#jqxassignsearch").jqxInput({ source: dataAdapter, displayMember: "assign", valueMember: "docno", items: 20 ,width: 170, height: 20});
            $("#jqxassignsearch").on('select', function (event) {      
            	  if (event.args) {
                      var item = event.args.item;              
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {  
                              if (item.value == dataAdapter.records[i].docno) {   
                            	  document.getElementById("hidassignid").value=dataAdapter.records[i].docno;   
                            	  break;       
                              }
                          }
                      }
                  }   
                });
       }); 
    </script>
    <input  type="text" id="jqxassignsearch"/>