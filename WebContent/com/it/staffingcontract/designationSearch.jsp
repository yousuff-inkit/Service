<%@page import="com.it.staffingcontract.ClsStaffingContractDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsStaffingContractDAO DAO= new ClsStaffingContractDAO(); %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>

 <script type="text/javascript">
 
 var areadata;

 var rowIndex='<%=rowIndex%>';
 

 
 areadata='<%=DAO.desigSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'desigid', type: 'String'  },
     						{name : 'desig', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: areadata,
                          //	 url: url1,
          
				
                
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
            $("#jqxdesigsearch").jqxGrid(
            {
                width: '100%',
                height: 420,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'desigid', width: '21%' },
					{ text: 'Designation', datafield: 'desig', width: '72%' }
					
					 
					
					]
            });
    
            $("#jqxdesigsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxdesigsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "desig",$('#jqxdesigsearch').jqxGrid('getcellvalue', rowindex1, "desig"));
				               			$('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "desigid",$('#jqxdesigsearch').jqxGrid('getcellvalue', rowindex1, "desigid"));

				               			
				                $('#desiginfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
							$("#jqxcontractDetails").jqxGrid('addrow', null, {});

        
                  }); 

        
                       
    </script>
    <div id="jqxdesigsearch"></div>
    
    </body>
</html>