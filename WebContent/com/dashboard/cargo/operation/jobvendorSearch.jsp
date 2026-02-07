<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%>
<%ClsOperationDAO assignment=new ClsOperationDAO();%>
<script type="text/javascript">
var jobvnddata; 
$(document).ready(function () {     
    	 jobvnddata='<%=assignment.vendorSearch()%>';             
         var source =    
        	 {
                datatype: "json",
                datafields: [
     						{name : 'acno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
                          	],
                          	localdata: jobvnddata,
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            // Create a jqxInput  
            
            $("#jqxJobVendor").jqxInput({ source: dataAdapter, displayMember: "refname", valueMember: "acno", items: 20 ,width: '97%', height: 18,placeHolder: "Enter Vendor Account"});
            $("#jqxJobVendor").on('select', function (event) {     
            	  if (event.args) {
                      var item = event.args.item;                
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {
                              if (item.value == dataAdapter.records[i].acno) {       
                            	  document.getElementById("hidjobvndid").value=dataAdapter.records[i].acno;
                            	  break;       
                              }  
                          }
                      }
                  }   
                }); 
        });   
    </script>
     <input id="jqxJobVendor"  class="p-l-5 input-sm form-control"/>