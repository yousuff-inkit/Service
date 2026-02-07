<%@page import="com.dashboard.skips.serviceexecution.ClsServiceExecutionDAO" %>
<%  ClsServiceExecutionDAO DAO= new ClsServiceExecutionDAO();  %>
<%
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").trim().toString(); 
 String srno=request.getParameter("srno")==null || request.getParameter("srno")==""?"0":request.getParameter("srno").trim().toString(); 
 %>          
<style>
#jqxSkipsize{
	background-color:#fff;      
	height: 20px;
}
</style>
       <script type="text/javascript">
        var data2='<%=DAO.skipsizeSearch(id,rdocno,srno) %>';              
		$(document).ready(function () { 	   
            var source =
            {
                datatype: "json",   
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxSkipsize").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no",width: '100%', height: 28,placeHolder: "Enter Skip No"});
            $("#jqxSkipsize").on('select', function (event) {            
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {             
                              if (item.value == dataAdapter.records[i].doc_no) {   
                                  document.getElementById("poskipno").value=dataAdapter.records[i].doc_no;      
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
            }); 
    </script>  
    <input id="jqxSkipsize" class="p-l-5 input-sm form-control"/>          