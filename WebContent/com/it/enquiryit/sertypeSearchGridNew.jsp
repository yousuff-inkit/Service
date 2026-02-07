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
 
 		var sldata='<%=DAO.sertypeSearch(session,id)%>';
        
		$(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'docno', type: 'String'  },
     						{name : 'groupname', type: 'String'  }
     					
     						
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

            $("#sertypeSearchGridID").jqxGrid(
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
							{ text: 'Doc No', datafield: 'docno',hidden:true },
							{ text: 'Service type', datafield: 'groupname' },
							
						 ]
            });
    
           
			   $('#sertypeSearchGridID').on('rowdoubleclick', function (event)  { 
				              	
				   var rowindex1=event.args.rowindex;

				   document.getElementById("hidcmbsertype").value= $('#sertypeSearchGridID').jqxGrid('getcellvalue', rowindex1, "docno");
				   document.getElementById("cmbsertype").value=$('#sertypeSearchGridID').jqxGrid('getcellvalue', rowindex1, "groupname");
				                
				   $('#serTypeDetailsWindow').jqxWindow('close');
				            		 
			   }); 	 
                  
		}); 
				       
                       
    </script>
    <div id="sertypeSearchGridID"></div>
    