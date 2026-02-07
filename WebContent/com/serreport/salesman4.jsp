<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@include file = "enquiryStatus.jsp" %>
<%ClsStatusDAO sd= new ClsStatusDAO(); %>
  
<style>
#jqxInput1{
	background-color:#fff;
}
</style>
 
  <script type="text/javascript">
  
 
            $(document).ready(function () {
                
            	 var dd2=  '<%=sd.salesman(session)%>';
            	 
            	 
                // prepare the data
                var source =
                {   
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'sal_name', type: 'string'  },
                                
                                 ],
                    localdata: dd2,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxInputSalesman4Type").jqxInput({ source: dataAdapter, displayMember: "sal_name",items: 20 , valueMember: "doc_no", width: 200, height: 20});
                $("#jqxInputSalesman4Type").on('select', function (event) {
                	  if (event.args) {
                          var item = event.args.item;   
                          if (item) {     
                        	 
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {
                                    document.getElementById("smdocno").value=dataAdapter.records[i].doc_no;
                              
                                      break;      
                                  }  
                              }
                              
                             
                              
                              
                          }
                      }
                	  
                    }); 
                
                  
            });
        </script>
        <input id="jqxInputSalesman4Type" />
        <br />
         