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
             
           	 var aa1='<%=DAO.unitSearch()%>';
 
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
{name : 'unit', type: 'string'  },
{name : 'doc_no', type: 'int'  }
                                
                                 
                                 
                                 
                                 
                    ],
                    localdata: aa1,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxInputunit").jqxInput({ source: dataAdapter, displayMember: "unit", valueMember: "doc_no", width: 50, height: 20});
                
            $("#jqxInputunit").on('select', function (event) {
            	  if (event.args) {
                      var item = event.args.item;
                      if (item) {
                          

                          for (var i = 0; i < dataAdapter.records.length; i++) { 
                              if (item.value == dataAdapter.records[i].doc_no) {
                            	  
                            	  
                            	 
                            	 
                            	  document.getElementById("vuom").value=dataAdapter.records[i].unit;
                                  document.getElementById("hidunitid").value=dataAdapter.records[i].doc_no;
                                  
                                  break;
                              }
                          }
                          

                           
                      }
                  }
                });  
            });
        </script>
         <input id="jqxInputunit" />
     