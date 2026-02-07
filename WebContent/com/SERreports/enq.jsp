<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@include file = "enquiryStatus.jsp" %>
<%ClsStatusDAO sd= new ClsStatusDAO(); 
 String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim().toString();
System.out.println("in enq=="+cldocno);
 %>
<style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
	  
}
</style>
 
  <script type="text/javascript"> 
            $(document).ready(function () {
              
            	var cdata= '<%=sd.searchenq(session,cldocno)%>';
               //alert("sdata"+cdata);  
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
									{name : 'enqnoid', type: 'string'  },
									{name : 'enqno', type: 'string'  },
								   	
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                            	  $("#jqxInputCode").jqxInput({ source: dataAdapter, displayMember: "enqnoid",items: 20 , valueMember: "enqno", width: 150, height: 20});
                                  $("#jqxInputCode").on('select', function (event) {
                                  	  if (event.args) {
                                            var item = event.args.item;   
                                            if (item) {
                                                for (var i = 0; i < dataAdapter.records.length; i++) {   
                                                    if (item.value == dataAdapter.records[i].enqno) {
                                  	  document.getElementById("enqno").value=dataAdapter.records[i].enqno;
                                	  document.getElementById("jqxInputName").focus();
                                      break;      
                                                    }  
                                                }
                                            }
                                        }
                     });  
            });   
        </script>
         <input id="jqxInputCode" />
         <br/>
     