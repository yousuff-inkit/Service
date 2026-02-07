<%@page import="com.dashboard.skips.replacementrequest.ClsReplacementRequestDAO" %>
<% ClsReplacementRequestDAO DAO= new ClsReplacementRequestDAO();  %>
<%
	String client=request.getParameter("client")==null || request.getParameter("client")==""?"":request.getParameter("client").trim().toString(); 
	String docno=request.getParameter("cnttrno")==null || request.getParameter("cnttrno")==""?"0":request.getParameter("cnttrno").trim().toString();            
%>    
<style>
#jqxSite{
	background-color:#fff;      
	height: 20px;
}
</style>
       <script type="text/javascript">
        var datast='<%=DAO.siteSearch(client,docno) %>';        
		$(document).ready(function () { 	   
            var source =
            {
                datatype: "json",   
                datafields: [
                             {name : 'refname', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                             {name : 'tr_no', type: 'string'  },
                             {name : 'sr_no', type: 'string'  },
                             {name : 'site', type: 'string'  },
                             {name : 'skipsize', type: 'string'  },
                             {name : 'wastetype', type: 'string'  },
                             {name : 'wasteid', type: 'string'  },
                             {name : 'siteid', type: 'string'  },
                             {name : 'cldocno', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: datast,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxSite").jqxInput({ source: dataAdapter, displayMember: "site", valueMember: "siteid",width: '100%', height: 20,placeHolder: "Enter Site"});  
            $("#jqxSite").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {          
                              if (item.value == dataAdapter.records[i].siteid) {        
                                  document.getElementById("hidsiteid").value=dataAdapter.records[i].siteid; 
                                  var cldocno = document.getElementById("hidcldocno").value;
                                  var client = document.getElementById("jqxClient").value;
                                  console.log("client====="+client);  
                                  var site = dataAdapter.records[i].site;   
                                  if(cldocno=="" || cldocno==null){
                                	 console.log("cldocno====="+cldocno);
                                    $("#client").load("clientSearch.jsp?site="+encodeURIComponent(site)+"&cnttrno="+$("#hidcnttrno").val());
                                  }
                                    /* if(cldocno!=""){
                                	  document.getElementById("jqxClient").value=client;  
                                      document.getElementById("hidcldocno").value=cldocno;  
                                  } */
                                  $("#contractno").load("contractSearch.jsp?client="+encodeURIComponent(client)+"&site="+encodeURIComponent(site));
                                  getDeliveries();
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
            }); 
    </script>  
    <input id="jqxSite" class="p-l-5 input-sm form-control"/> 