<%@page import="com.dashboard.skips.tippingdetailsimport.ClsTippingDetailsImportDAO" %>
<% ClsTippingDetailsImportDAO DAO= new ClsTippingDetailsImportDAO();  %>
<%
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 %>    
<style>
#jqxcontract{
	background-color:#fff;      
	height: 20px;
}
</style>
       <script type="text/javascript">
        var data1='<%=DAO.contractDetailsSearch(id) %>';        
		$(document).ready(function () { 	   
            var source =
            {
                datatype: "json",   
                datafields: [
                             {name : 'refname', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                             {name : 'tr_no', type: 'string'  },
                             {name : 'site', type: 'string'  },
                             {name : 'skipsize', type: 'string'  },
                             {name : 'wastetype', type: 'string'  },
                             {name : 'wasteid', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxcontract").jqxInput({ source: dataAdapter, displayMember: "doc_no", valueMember: "tr_no",width: '100%', height: 20,placeHolder: "Enter Contract No"});
            $("#jqxcontract").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {          
                              if (item.value == dataAdapter.records[i].doc_no) {        
                                  document.getElementById("contrno").value=dataAdapter.records[i].tr_no;   
                                  document.getElementById("wastename").value=dataAdapter.records[i].wastetype;   
                                  document.getElementById("jqxwastetype").value=dataAdapter.records[i].wastetype;    
                                  document.getElementById("contractdetlbl").innerHTML=dataAdapter.records[i].refname+" - "+dataAdapter.records[i].site+" - "+dataAdapter.records[i].skipsize+" - "+dataAdapter.records[i].wastetype; 
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
            }); 
    </script>  
    <input id="jqxcontract" class="p-l-5 input-sm form-control"/> 