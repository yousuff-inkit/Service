<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.marketing.salesactivitymanagement.ClsSalesActivityManagementDAO"%>   
<%
	ClsSalesActivityManagementDAO DAO=new ClsSalesActivityManagementDAO();  
%> 
<% String contextPath=request.getContextPath();%>
<%
     String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno")==""?"0":request.getParameter("cldocno").toString();
 %>  
 <style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
}   
</style>

 <script type="text/javascript">
 
 var teldata;
 teldata='<%=DAO.contactpersonData(session,cldocno)%>';       
 
        $(document).ready(function () { 
         
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
     						{name : 'tel', type: 'String'  }   
     						
                          	],
                          	localdata: teldata,
                          //	 url: url1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source); 
            
            $("#jqxtel").jqxInput({ source: dataAdapter, displayMember: "tel", valueMember: "tel", items: 20 ,width: 360, height: 28});  
            $("#jqxtel").on('select', function (event) {      
            	  if (event.args) {
                      var item = event.args.item;              
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {  
                              if (item.value == dataAdapter.records[i].tel) {   
                            	  document.getElementById("hidtel").value=dataAdapter.records[i].tel;              
                            	  break;       
                              }
                          }
                      }
                  }   
                });
       }); 
    </script>
    <input  type="text" id="jqxtel"  class="form-control input-sm"/>