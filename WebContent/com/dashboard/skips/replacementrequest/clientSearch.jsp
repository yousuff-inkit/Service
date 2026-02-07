<%@page import="com.dashboard.skips.replacementrequest.ClsReplacementRequestDAO" %>
<% ClsReplacementRequestDAO DAO= new ClsReplacementRequestDAO();  %>
<%
String site=request.getParameter("site")==null || request.getParameter("site")==""?"":request.getParameter("site").trim().toString(); 
String docno=request.getParameter("cnttrno")==null || request.getParameter("cnttrno")==""?"0":request.getParameter("cnttrno").trim().toString();          
 %>    
<style>
#jqxClient{
	background-color:#fff;      
	height: 20px;
}
</style>
       <script type="text/javascript">
        var datacl='<%=DAO.clientSearch(site,docno) %>';        
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
                 localdata: datacl,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxClient").jqxInput({ source: dataAdapter, displayMember: "refname", valueMember: "cldocno",width: '100%', height: 20,placeHolder: "Enter Client"});
            $("#jqxClient").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {          
                              if (item.value == dataAdapter.records[i].cldocno) {        
                                  document.getElementById("hidcldocno").value=dataAdapter.records[i].cldocno; 
                                  var client = dataAdapter.records[i].refname;    
                                  var siteid = document.getElementById("hidsiteid").value;
                                  var site = document.getElementById("jqxSite").value;
                            	  console.log("siteid"+siteid);
                                  if(siteid=="" || siteid==null){
                                  	$("#site").load("siteSearch.jsp?client="+encodeURIComponent(client)+"&cnttrno="+$("#hidcnttrno").val());
                                  }
                                  /* if(siteid!=""){
                                	  document.getElementById("jqxSite").value=site;  
                                      document.getElementById("hidsiteid").value=siteid;  
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
    <input id="jqxClient" class="p-l-5 input-sm form-control"/> 