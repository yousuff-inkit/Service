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
 
 var cpdata;

 
 cpdata='<%=DAO.contactpersonData(session,cldocno)%>';        
 
        $(document).ready(function () { 
         
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
     						{name : 'cperson', type: 'String'  },
     						{name : 'email', type: 'String'  },
     						{name : 'mob', type: 'String'  },
     						{name : 'tel', type: 'String'  }       
     						
                          	],
                          	localdata: cpdata,
                          //	 url: url1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source); 
            
            $("#jqxcperson").jqxInput({ source: dataAdapter, displayMember: "cperson", valueMember: "cperson", items: 20 ,width: 360, height: 28});  
            $("#jqxcperson").on('select', function (event) {      
            	  if (event.args) {
                      var item = event.args.item;              
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {  
                              if (item.value == dataAdapter.records[i].cperson) {   
                            	  document.getElementById("hidcperson").value=dataAdapter.records[i].cperson;   
                            	  document.getElementById("hidmob").value=dataAdapter.records[i].mob;  
                            	  document.getElementById("hidtel").value=dataAdapter.records[i].tel;  
                            	  document.getElementById("jqxmob").value=dataAdapter.records[i].mob;  
                            	  document.getElementById("jqxtel").value=dataAdapter.records[i].tel;  
                            	  break;       
                              }
                          }
                      }
                  }   
                });
       }); 
    </script>
    <input  type="text" id="jqxcperson"  class="form-control input-sm"/> 