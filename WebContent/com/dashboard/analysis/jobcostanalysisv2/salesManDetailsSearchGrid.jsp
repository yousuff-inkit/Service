<%@page import="com.dashboard.analysis.jobcostanalysisv2.ClsJobCostAnalysisDAO" %>
<% ClsJobCostAnalysisDAO DAO=new ClsJobCostAnalysisDAO(); %>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String slname = request.getParameter("slname")==null?"0":request.getParameter("slname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
%> 

 <script type="text/javascript">
 
		$(document).ready(function () { 
			var sldata='<%=DAO.salesManDetailsSearch(session,slname,mob,id)%>';
        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'doc_no', type: 'String'  },
     						{name : 'sal_name', type: 'String'  },
     						{name : 'mob_no', type: 'String'  }
     						
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

            $("#salesManDetailsSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
     					
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'Name', datafield: 'sal_name'  },
							{ text: 'Mobile', datafield: 'mob_no', width: '40%' }, 
						 ]
            });
    
           
			   $('#salesManDetailsSearchGridID').on('rowdoubleclick', function (event)  { 
				              	
				   var rowindex1=event.args.rowindex;

				   document.getElementById("txtsalesmandocno").value= $('#salesManDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
				   document.getElementById("txtsalesman").value=$('#salesManDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "sal_name");
				                
				   $('#salesManDetailsWindow').jqxWindow('close');
				            		 
			   }); 	 
                  
		}); 
				       
                       
    </script>
    <div id="salesManDetailsSearchGridID"></div>
    