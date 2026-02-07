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
                
            	 var dd2=  '<%=sd.area(session)%>';
            	 
            	 
                // prepare the data
                var source =
                {   
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'area', type: 'string'  },
                                
                                 ],
                    localdata: dd2,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxInputAreaType").jqxInput({ source: dataAdapter, displayMember: "area",items: 20 , valueMember: "doc_no", width: 200, height: 20});
                $("#jqxInputAreaType").on('select', function (event) {
                	  if (event.args) {
                          var item = event.args.item;   
                          if (item) {     
                        	 
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {
                                    document.getElementById("ardocno").value=dataAdapter.records[i].doc_no;
                              
                                      break;      
                                  }  
                              }
                              
                             
                              
                              
                          }
                      }
                	  
                    }); 
                
                  
            });
        </script>
        <input id="jqxInputAreaType" />
        <br />
         