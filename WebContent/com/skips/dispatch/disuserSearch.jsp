<%@page import="com.skips.dispatch.ClsDispatchDAO"%>  
<%
ClsDispatchDAO DAO=new ClsDispatchDAO();                   
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
            	  var cdata= '<%=DAO.searchuser(session)%>';      
                 // alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'user', type: 'string'  },
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxInputUserdis").jqxInput({ source: dataAdapter, displayMember: "user", valueMember: "doc_no", items: 20 ,width: 250, height: 20});
                $("#jqxInputUserdis").on('select', function (event) {      
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {   
                                	  document.getElementById("hiduserdis").value=dataAdapter.records[i].doc_no;
                                	 
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxInputUserdis" />