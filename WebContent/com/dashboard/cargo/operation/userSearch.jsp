<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%>
<% ClsOperationDAO assignment=new ClsOperationDAO(); %>
<script type="text/javascript">
$(document).ready(function () { 	
	var data1; 
	data1='<%=assignment.userSearch()%>';    
	var source =
	{
			datatype: "json",
			datafields: [
			             {name : 'user', type: 'string'},  
			             {name : 'doc_no', type: 'int'   }
			             ],
                 localdata: data1,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
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
            
            $("#jqxUser").jqxInput({ source: dataAdapter, displayMember: "user", valueMember: "doc_no", items: 20 ,width: '97%', height: 18,placeHolder: "Enter Assignment To"});
            $("#jqxUser").on('select', function (event) {     
            	  if (event.args) {
                      var item = event.args.item;                
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {
                              if (item.value == dataAdapter.records[i].doc_no) {                    
                            	  document.getElementById("hidassignmentid").value=dataAdapter.records[i].doc_no;
                            	  break;       
                              }
                          }
                      }
                  }   
                }); 
        });   
    </script>
     <input id="jqxUser"  class="p-l-5 input-sm form-control"/>