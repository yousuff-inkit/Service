<%@page import="com.project.execution.quotationmbl.ClsQuotationDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); %>   
<script type="text/javascript"> 
            $(document).ready(function () {
             var drpdata= '<%=DAO.unitSearch(session)%>';                    

            	  var source =
                {
                    datatype: "json",
                    datafields: [
                    	{name : 'doc_no', type: 'int'  },
                        {name : 'unit', type: 'string'  },
                        {name : 'unit_desc', type: 'string'},
                    ],     
                    localdata: drpdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);  
                // Create a jqxInput  
                 
                $("#jqxUnit").jqxInput({ source: dataAdapter, displayMember: "unit", valueMember: "doc_no", items: 20 ,width: 166, height: 20,placeHolder:"Enter Unit"});
                $("#jqxUnit").on('select', function (event) {            
                	  if (event.args) {  
                          var item = event.args.item;                 
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {          
                                  if (item.value == dataAdapter.records[i].doc_no) {         
                                	  document.getElementById("unitid").value=dataAdapter.records[i].doc_no;
                                	  //document.getElementById("servtype").value=dataAdapter.records[i].stype;
                                	
                                  }
                              }
                          }
                      }   
                    }); 
            });        
        </script>
         <input id="jqxUnit" />               