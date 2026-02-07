<%@page import="com.dashboard.skips.tippingdetails.ClsTippingDetailsDAO" %>
<% ClsTippingDetailsDAO DAO= new ClsTippingDetailsDAO();  %>  
<%
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 %>    
<style>
#jqxcontractno{
	background-color:#fff;      
	height: 20px;
}
</style>
       <script type="text/javascript">
        var data4='<%=DAO.contractnoSearch() %>';          
		$(document).ready(function () { 	   
            var source =
            {
                datatype: "json",   
                datafields: [
                             {name : 'tr_no', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: data4,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxcontractno").jqxInput({ source: dataAdapter, displayMember: "doc_no", valueMember: "doc_no",width: '100%', height: 25,placeHolder: "Enter contract no"});
            $("#jqxcontractno").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {        
                              if (item.value == dataAdapter.records[i].tr_no) {      
                                  document.getElementById("hidcontrno").value=dataAdapter.records[i].tr_no;        
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
            }); 
    </script>  
    <input id="jqxcontractno" class="p-l-5 input-sm form-control"/>     