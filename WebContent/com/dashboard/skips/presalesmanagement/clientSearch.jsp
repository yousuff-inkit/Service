<%@page import="com.dashboard.skips.presalesmanagement.ClsPresalesmanagementDAO"%>
<%    ClsPresalesmanagementDAO DAO= new ClsPresalesmanagementDAO();  %>  
<%
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 %>    
<style>
#jqxclient{
	background-color:#fff;      
	height: 20px;
} 
</style>
       <script type="text/javascript"> 
        var data2='<%=DAO.clientData(id)%>';                
		$(document).ready(function () { 	   
            var source =
            {
                datatype: "json",   
                datafields: [
                             {name : 'refname', type: 'string'  },
                             {name : 'cldocno', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxclient").jqxInput({ source: dataAdapter, displayMember: "refname", valueMember: "cldocno",width: '97%', height: 20,placeHolder: "Please enter client name"});
            $("#jqxclient").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {          
                              if (item.value == dataAdapter.records[i].cldocno) {   
                                  document.getElementById("hidcldocno").value=dataAdapter.records[i].cldocno;
                                  document.getElementById("hidclient").value=dataAdapter.records[i].refname;  
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
            }); 
    </script>  
    <input id="jqxclient" class="p-l-5 input-sm form-control"/>    