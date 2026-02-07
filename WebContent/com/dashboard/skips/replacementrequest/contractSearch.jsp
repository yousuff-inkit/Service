<%@page import="com.dashboard.skips.replacementrequest.ClsReplacementRequestDAO" %>
<% ClsReplacementRequestDAO DAO= new ClsReplacementRequestDAO();  %>
<%
 String site=request.getParameter("site")==null || request.getParameter("site")==""?"":request.getParameter("site").trim().toString();  
 String client=request.getParameter("client")==null || request.getParameter("client")==""?"":request.getParameter("client").trim().toString();
 %>    
<style>
#jqxcontract{
	background-color:#fff;      
	height: 20px;
}
</style>
       <script type="text/javascript">
        var datacnt='<%=DAO.contractDetailsSearch(client,site) %>';        
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
                             {name : 'skiptype', type: 'string'  },
                             {name : 'nos', type: 'number'  },
                             {name : 'hold', type: 'number'  },
                            
                        ],
                		
                		//  url: url1,
                 localdata: datacnt,
                
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
                              if (item.value == dataAdapter.records[i].tr_no) { 
                                  document.getElementById("hidcnttrno").value = dataAdapter.records[i].tr_no;
                                  document.getElementById("hidcntsrno").value=dataAdapter.records[i].sr_no; 
                                  document.getElementById("jqxSite").value=dataAdapter.records[i].site;  
                                  document.getElementById("hidsiteid").value=dataAdapter.records[i].siteid;  
                                  document.getElementById("jqxClient").value=dataAdapter.records[i].refname; 
                                  document.getElementById("hidcldocno").value=dataAdapter.records[i].cldocno;  
                                  document.getElementById("jqxwastetypeSC").value=dataAdapter.records[i].wastetype; 
                                  document.getElementById("scwasteid").value=dataAdapter.records[i].wasteid; 
                                  document.getElementById("jqxskiptypeSC").value=dataAdapter.records[i].skipsize; 
                                  document.getElementById("scskipid").value=dataAdapter.records[i].skiptype;
                                  document.getElementById("txtcontqty").value=dataAdapter.records[i].nos; 
                                  var hold =dataAdapter.records[i].hold;
                                  document.getElementById("hidrestrict").value = dataAdapter.records[i].hold;
                                  if(parseInt(hold)==1){
                                	  document.getElementById("restrictionmsg").innerHTML="Contract on HOLD";  
                                  }else{
                                	  document.getElementById("restrictionmsg").innerHTML="";   
                                  }
                                  getDeliveries();
                                  getSchDet();
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
            }); 
    </script>  
    <input id="jqxcontract" class="p-l-5 input-sm form-control"/> 