<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.marketing.salesactivitymanagement.ClsSalesActivityManagementDAO"%>   
<%
	ClsSalesActivityManagementDAO DAO=new ClsSalesActivityManagementDAO();  
%> 
<% String contextPath=request.getContextPath();%>
 <style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
}   
</style>

 <script type="text/javascript">
 
 var cldata;

 
 cldata='<%=DAO.clientData(session)%>';     
 
        $(document).ready(function () { 
         
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
     						{name : 'refname', type: 'String'  },
     						{name : 'cldocno', type: 'String'  }
     						
                          	],
                          	localdata: cldata,
                          //	 url: url1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source); 
            
            $("#jqxclientsearch").jqxInput({ source: dataAdapter, displayMember: "refname", valueMember: "cldocno", items: 20 ,width: 360, height: 28});  
            $("#jqxclientsearch").on('select', function (event) {      
            	  if (event.args) {
                      var item = event.args.item;              
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {  
                              if (item.value == dataAdapter.records[i].cldocno) {   
                            	  document.getElementById("hidclientid").value=dataAdapter.records[i].cldocno;
                            	  inputsload();    
                            	  break;       
                              }
                          }
                      }
                  }   
                });
       }); 
    </script>
    <input  type="text" id="jqxclientsearch"  class="form-control input-sm"/>