
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
 
 var spec;

 var rowIndex='<%=rowIndex%>';
 
 spec='<%=DAO.specSearch(session)%>';
  
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		  
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'spec', type: 'String'  },
     						{name : 'sepcid', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: spec,
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
            $("#jqxspecsearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'sepcid', width: '20%' },
					{ text: 'Spec', datafield: 'spec', width: '72%' },
					
					 
					
					]
            });
    
         //   $("#jqxspecsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxspecsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "spec",$('#jqxspecsearch').jqxGrid('getcellvalue', rowindex1, "spec"));
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "sepcid",$('#jqxspecsearch').jqxGrid('getcellvalue', rowindex1, "sepcid"));
				               		//	$("#jqxEnquiry").jqxGrid('addrow', null, {});
				              
				                $('#specinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
        
                       
    </script>
    <div id="jqxspecsearch"></div>
    
    </body>
</html>