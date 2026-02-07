<%@page import="com.dashboard.realestate.propertymanagement.ClsPropertyManagementDAO"%>
<%
ClsPropertyManagementDAO DAO= new ClsPropertyManagementDAO();                                          
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
 
<style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
	  
}   
</style>
 
  <script type="text/javascript"> 
            $(document).ready(function () {
            	  var cdata= '<%=DAO.searchclient()%>';      
                  //alert("sdata"+cdata);     
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'cldocno', type: 'string'  },
                                 {name : 'refname', type: 'string'  },
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxClient").jqxInput({ source: dataAdapter, displayMember: "refname", valueMember: "cldocno", items: 20 ,width: '100%', height: 18,placeHolder: "Enter Client"});
                $("#jqxClient").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].cldocno) {       
                                	  document.getElementById("hidcldocno").value=dataAdapter.records[i].cldocno;
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxClient"  class="p-l-5 input-sm form-control"/>