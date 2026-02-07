<%@page import="com.it.enquiryit.ClsEnquiryDAO" %>
<% ClsEnquiryDAO DAO=new ClsEnquiryDAO(); %>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.analysis.pendingcontract.ClsPendingContract" %>
<%
 String slname = request.getParameter("slname")==null?"0":request.getParameter("slname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
%> 

 <script type="text/javascript">
 
 		var sldata='<%=DAO.industrySearch(session,id)%>';
        
		$(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'doc_no', type: 'String'  },
     						{name : 'name', type: 'String'  }
     					
     						
                          	],
                          	localdata: sldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );

            $("#industrySearchGridID").jqxGrid(
            {
                width: '100%',
                height: 345,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                enabletooltips:true,
     					
                columns: [
							{ text: 'Doc No', datafield: 'doc_no',hidden:true },
							{ text: 'Industry', datafield: 'name' },
							
						 ]
            });
    
           
			   $('#industrySearchGridID').on('rowdoubleclick', function (event)  { 
				              	
				   var rowindex1=event.args.rowindex;

				   document.getElementById("hidcmbenqbtype").value= $('#industrySearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
				   document.getElementById("cmbenqbtype").value=$('#industrySearchGridID').jqxGrid('getcellvalue', rowindex1, "name");
				                
				   $('#industryDetailsWindow').jqxWindow('close');
				            		 
			   }); 	 
                  
		}); 
				       
                       
    </script>
    <div id="industrySearchGridID"></div>
    