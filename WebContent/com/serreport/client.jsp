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
                
            	 var dd2=  '<%=sd.client(session)%>';
            	 
            	 
                // prepare the data
                var source =
                {   
                    datatype: "json",
                    datafields: [
                                 {name : 'cldocno', type: 'string'  },
                                 {name : 'client', type: 'string'  },
                                 {name : 'enqno', type: 'string'  },
                                 {name : 'jobno', type: 'string'  },
                                 ],
                    localdata: dd2,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxInputServType").jqxInput({ source: dataAdapter, displayMember: "client",items: 20 , valueMember: "cldocno", width: 200, height: 20});
                $("#jqxInputServType").on('select', function (event) {
                	  if (event.args) {
                          var item = event.args.item;   
                          if (item) {     
                        	 
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].cldocno) {
                                    document.getElementById("cldocno").value=dataAdapter.records[i].cldocno;
                                    var cldocno=document.getElementById("cldocno").value;
                  					$("#enq1").load("enq.jsp?cldocno="+cldocno);  
                  					$("#jobno1").load("jobno.jsp?cldocno="+cldocno); 
                  			   setTimeout(function(){ document.getElementById("jqxInputCode").value=dataAdapter.records[i].enqno; 
               				   document.getElementById("jqxInputName").value=dataAdapter.records[i].jobno;
               				   document.getElementById("enqno").value=dataAdapter.records[i].enqno;
							   document.getElementById("jobno").value=dataAdapter.records[i].jobno;
                  					 }, 500);
                                      /* document.getElementById("jqxInputCode").value=dataAdapter.records[i].enqno; 
                					  document.getElementById("jqxInputName").value=dataAdapter.records[i].jobno; */
//                 					  document.getElementById("enqno").value=dataAdapter.records[i].enqno;
//                 		              document.getElementById("jobno").value=dataAdapter.records[i].jobno;
//                 		              $("#enq1").load("enq.jsp?cldocno="+dataAdapter.records[i].cldocno); 
//                 					  $("#jobno1").load("jobno.jsp?cldocno="+dataAdapter.records[i].cldocno);  
                		              document.getElementById("jqxInputCode").focus();  
                                      break;      
                                  }  
                              }
                              
                             
                              
                              
                          }
                      }
                	  
                    }); 
                
                  
            });
        </script>
        <input id="jqxInputServType" />
        <br />
         