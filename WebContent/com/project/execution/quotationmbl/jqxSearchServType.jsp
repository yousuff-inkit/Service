<%@page import="com.project.execution.quotationmbl.ClsQuotationDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); %>   
<script type="text/javascript"> 
            $(document).ready(function () {
             var drpdata= '<%=DAO.serviceType(session)%>';                    

            	  var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'docno', type: 'string'  },
                                 {name : 'stype', type: 'string'  },
                    ],     
                    localdata: drpdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);  
                // Create a jqxInput  
                 
                $("#jqxServType").jqxInput({ source: dataAdapter, displayMember: "stype", valueMember: "docno", items: 20 ,width: 166, height: 20,placeHolder:"Enter Service Type"});
                $("#jqxServType").on('select', function (event) {            
                	  if (event.args) {  
                          var item = event.args.item;                 
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {          
                                  if (item.value == dataAdapter.records[i].docno) {         
                                	  document.getElementById("servtypeid").value=dataAdapter.records[i].docno;
                                	  //document.getElementById("servtype").value=dataAdapter.records[i].stype;
                                	  //funSubService();
                                	
                                  }
                              }
                          }
                      }   
                    }); 
            });        
        </script>
         <input id="jqxServType" onchange="funSubService();"/>               