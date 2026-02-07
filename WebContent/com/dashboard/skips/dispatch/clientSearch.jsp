<%@page import="com.dashboard.skips.dispatch.ClsDispatchDAO"%>
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
  var cdata;
            $(document).ready(function () {
            	   cdata= '<%=DAO.searchclient(session)%>';      
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'refname', type: 'string'  },
                                 {name : 'address', type: 'string'  },
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxInputClient").jqxInput({ source: dataAdapter, displayMember: "refname", valueMember: "doc_no", items: 20 ,width: 170, height: 20});
                $("#jqxInputClient").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {   
                                	  document.getElementById("hidcldocno").value=dataAdapter.records[i].doc_no;
                                	  document.getElementById("address").value=dataAdapter.records[i].address;
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxInputClient" />