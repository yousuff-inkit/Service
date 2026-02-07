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
            	  var rcptdata= '<%=DAO.searchclient()%>';      
                  //alert("sdata"+cdata);     
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'cldocno', type: 'string'  },
                                 {name : 'refname', type: 'string'  },
                                 {name : 'clacno', type: 'string'  },  
                    ],
                    localdata: rcptdata,    
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxClientRcpt").jqxInput({ source: dataAdapter, displayMember: "refname", valueMember: "cldocno", items: 20 ,width: '97%', height: 18,placeHolder: "Enter Client"});
                $("#jqxClientRcpt").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;                
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].cldocno) {       
                                	  document.getElementById("hidrcptcldocno").value=dataAdapter.records[i].cldocno;
                                	  document.getElementById("hidrcptclacno").value=dataAdapter.records[i].clacno;      
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxClientRcpt"  class="p-l-5 input-sm form-control"/>