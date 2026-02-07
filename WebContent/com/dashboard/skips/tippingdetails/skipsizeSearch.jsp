<%@page import="com.dashboard.skips.tippingdetails.ClsTippingDetailsDAO" %>
<% ClsTippingDetailsDAO DAO= new ClsTippingDetailsDAO();  %>  
<%
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 %>    
<style>
#jqxskipesize{
	background-color:#fff;      
	height: 20px;
}
</style>
       <script type="text/javascript">
        var data3='<%=DAO.skipsizeSearch(id) %>';             
		$(document).ready(function () { 	   
            var source =
            {
                datatype: "json",   
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: data3,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source); 
            
            $("#jqxskipesize").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "name",width: '100%', height: 25,placeHolder: "Enter Skip Size"});
            $("#jqxskipesize").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {        
                              if (item.value == dataAdapter.records[i].name) {   
                                  document.getElementById("skipsizeid").value=dataAdapter.records[i].doc_no;      
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
            }); 
    </script>  
    <input id="jqxskipesize" class="p-l-5 input-sm form-control"/>     