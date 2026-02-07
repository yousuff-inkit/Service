<%@page import="com.dashboard.skips.serviceschedule.ClsServiceScheduleDAO" %>
<% ClsServiceScheduleDAO DAO= new ClsServiceScheduleDAO();  %>  
<%
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 %>     
<style>
#jqxskipnoTp{
	background-color:#fff;      
	height: 16px;
	padding: 5px 10px; 
	width: 93.5%; 
}
.jqx-input{
     
}
</style>
       <script type="text/javascript">
        var data5='<%=DAO.skipnoSearch() %>';                       
		$(document).ready(function () { 	    
            var source =
            {
                datatype: "json",   
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: data5,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source); 
            
            $("#jqxskipnoTp").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "name",placeHolder: "Please Enter Skip No"});
            $("#jqxskipnoTp").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {         
                              if (item.value == dataAdapter.records[i].name) {     
                                  document.getElementById("tpskipno").value=dataAdapter.records[i].doc_no;         
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
            }); 
    </script>  
    <input id="jqxskipnoTp" class="p-l-5 input-sm form-control"/>                 