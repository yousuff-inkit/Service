<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%>
<%ClsOperationDAO assignment=new ClsOperationDAO();%>
<script type="text/javascript">
var cldata; 
$(document).ready(function () {     
    	 cldata='<%=assignment.vendorSearch()%>';             
         var source =    
        	 {
                datatype: "json",
                datafields: [
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						{name : 'mail1', type: 'String'  }   
                          	],
                          	localdata: cldata,
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
            
            $("#jqxVendor").jqxInput({ source: dataAdapter, displayMember: "refname", valueMember: "cldocno", items: 20 ,width: '97%', height: 18,placeHolder: "Enter Assignment To"});
            $("#jqxVendor").on('select', function (event) {     
            	  if (event.args) {
                      var item = event.args.item;                
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {
                              if (item.value == dataAdapter.records[i].cldocno) {       
                            	  document.getElementById("hidassignmentid").value=dataAdapter.records[i].cldocno;
                            	  break;       
                              }
                          }
                      }
                  }   
                }); 
        });   
    </script>
     <input id="jqxVendor"  class="p-l-5 input-sm form-control"/>