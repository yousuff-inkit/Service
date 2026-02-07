<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.cargo.quotationfollowup.*"%> 
<%ClsQuotationFollowupDAO DAO=new ClsQuotationFollowupDAO(); %>
<%String mode = request.getParameter("modeid")==null?"0":request.getParameter("modeid").trim();%> 
<%String smode = request.getParameter("smodeid")==null?"0":request.getParameter("smodeid").trim();%> 
<%String ship = request.getParameter("shipid")==null?"0":request.getParameter("shipid").trim();%> 

 
<style>
#jqxInput{
	background-color:#fff;
	height: 20px;
	
}
</style>
 
  <script type="text/javascript"> 
	 
 
            $(document).ready(function () {
             
           	 var aa1='<%=DAO.currencySearch()%>';
 
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'currency', type: 'string'  },
			{name : 'rate', type: 'string'  },
			{name : 'curid', type: 'string'  }
                                
                                 
                                 
                                 
                                 
                    ],
                    localdata: aa1,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxInputcur").jqxInput({ source: dataAdapter, displayMember: "currency", valueMember: "curid", width: 50, height: 20});
                
            $("#jqxInputcur").on('select', function (event) {
            	  if (event.args) {
                      var item = event.args.item;
                      if (item) {
                          

                          for (var i = 0; i < dataAdapter.records.length; i++) { 
                              if (item.value == dataAdapter.records[i].curid) {
                            	  
                            	  
                            	 
                            	  document.getElementById("curtype").value=dataAdapter.records[i].currency;
                            	  document.getElementById("hidrate").value=dataAdapter.records[i].rate;
                                  document.getElementById("hidcurid").value=dataAdapter.records[i].curid;
                                  
                                  break;
                              }
                          }
                          

                           
                      }
                  }
                });  
            });
        </script>
         <input id="jqxInputcur" />
     