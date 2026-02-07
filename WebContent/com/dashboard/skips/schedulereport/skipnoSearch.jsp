<%@page import="com.dashboard.skips.schedulereport.ClsScheduleReportDAO" %>
<% ClsScheduleReportDAO DAO= new ClsScheduleReportDAO();  %>  
<%
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 String delid=request.getParameter("delid")==null || request.getParameter("delid")==""?"0":request.getParameter("delid").trim().toString(); 
 String type=request.getParameter("type")==null || request.getParameter("type")==""?"0":request.getParameter("type").trim().toString(); 
 %>     
<style>
#jqxskipnoPO{
	background-color:#fff;      
	height: 16px;
	padding: 5px 10px; 
	width: 93.5%; 
}
.jqx-input{
     
}
</style>
       <script type="text/javascript">
        var data4='<%=DAO.skipnoSearch(delid,type) %>';                    
		$(document).ready(function () { 	   
            var source =
            {
                datatype: "json",   
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: data4,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source); 
            
            $("#jqxskipnoPO").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "name",placeHolder: "Please enter skip no"});
            $("#jqxskipnoPO").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {         
                              if (item.value == dataAdapter.records[i].name) {     
                                  document.getElementById("poskipno").value=dataAdapter.records[i].doc_no;         
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
            }); 
    </script>  
    <input id="jqxskipnoPO" class="p-l-5 input-sm form-control"/>             