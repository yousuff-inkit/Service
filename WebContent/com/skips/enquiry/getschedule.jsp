
<%@page import="com.skips.enquiry.ClsEnquiryDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsEnquiryDAO DAO= new ClsEnquiryDAO();
 %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>

 <script type="text/javascript">
 
 var schedule;

 var rowIndex='<%=rowIndex%>';
 
 schedule='<%=DAO.scheduleSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'scheduletype', type: 'String'  },
     						{name : 'schedulesrno', type: 'string'  },
     						
     						
     						
                          	],
                          	localdata: schedule,
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
            $("#jqxschedulesearch").jqxGrid(
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
					{ text: 'SR No', datafield: 'schedulesrno', width: '20%' },
					{ text: 'Service Term', datafield: 'scheduletype', width: '72%' },
					
					 
					
					]
            });
    
       //     $("#jqxschedulesearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxschedulesearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "scheduletype",$('#jqxschedulesearch').jqxGrid('getcellvalue', rowindex1, "scheduletype"));
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "schedulesrno",$('#jqxschedulesearch').jqxGrid('getcellvalue', rowindex1, "schedulesrno"));
				               		//	$("#jqxEnquiry").jqxGrid('addrow', null, {});
				              
				                $('#scheduleinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
        
                       
    </script>
    <div id="jqxschedulesearch"></div>
    
    </body>
</html>