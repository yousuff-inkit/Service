<%@page import="com.project.execution.quotationmbl.ClsQuotationDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); 
		 int id =request.getParameter("srvid")==null?0:Integer.parseInt(request.getParameter("srvid").trim());
System.out.println("id on :"+id);
 %>   
<script type="text/javascript"> 
            $(document).ready(function () {
             var drpdata= '<%=DAO.subServiceType(session,id)%>';                    

            	  var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'name', type: 'string'  },
                                 {name : 'srvid', type: 'string'  },
                    ],     
                    localdata: drpdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);  
                // Create a jqxInput  
                 
                $("#jqxSubServType").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", items: 20 ,width: 166, height: 20,placeHolder:"Enter Sub Service Type"});
                $("#jqxSubServType").on('select', function (event) {            
                	  if (event.args) {  
                          var item = event.args.item;                 
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {          
                                  if (item.value == dataAdapter.records[i].doc_no) {         
                                	  document.getElementById("subservtypeid").value=dataAdapter.records[i].doc_no;
                                	  //document.getElementById("servtype").value=dataAdapter.records[i].stype;
                                	
                                  }
                              }
                          }
                      }   
                    }); 
            });        
        </script>
         <input id="jqxSubServType"/>               