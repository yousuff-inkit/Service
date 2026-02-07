<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.marketing.amcmanagement.ClsAmcManagementDAO"%>   
<% ClsAmcManagementDAO DAO=new ClsAmcManagementDAO(); %>
<% String contextPath=request.getContextPath();%>
<style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
}   
</style>
 <script type="text/javascript">
 
 var assignfrm;

 
 assignfrm='<%=DAO.assignfrm(session)%>'; 
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'String'  },
     						{name : 'grpcode', type: 'String'  },
                          	],
                          	localdata: assignfrm,
                          //	 url: url1,
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxgrpsearch").jqxInput({ source: dataAdapter, displayMember: "grpcode", valueMember: "doc_no", items: 20 ,width: 170, height: 20,placeHolder: "Enter Assign Group"});
            $("#jqxgrpsearch").on('select', function (event) {       
            	  if (event.args) {
                      var item = event.args.item;              
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {  
                              if (item.value == dataAdapter.records[i].doc_no) {     
                            	  document.getElementById("hidgroupid").value=dataAdapter.records[i].doc_no;  
                            	  break;       
                              }
                          }
                      }
                  }   
                });
        
             }); 
    </script>
    <input  type="text" id="jqxgrpsearch" class="p-l-5 input-sm form-control" onchange="inputload();"/>
    </body>
</html>