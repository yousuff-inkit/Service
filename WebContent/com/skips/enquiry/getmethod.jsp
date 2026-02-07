
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
 
 var method;

 var rowIndex='<%=rowIndex%>';
 
 method='<%=DAO.methodSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'method', type: 'String'  },
     						{name : 'srno', type: 'string'  },
     						
     						
     						
                          	],
                          	localdata: method,
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
            $("#jqxmethodsearch").jqxGrid(
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
					{ text: 'SR No', datafield: 'srno', width: '20%' },
					{ text: 'Method', datafield: 'method', width: '72%' },
					
					 
					
					]
            });
    
         //   $("#jqxmethodsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxmethodsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "method",$('#jqxmethodsearch').jqxGrid('getcellvalue', rowindex1, "method"));
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "srno",$('#jqxmethodsearch').jqxGrid('getcellvalue', rowindex1, "srno"));
				               			//$("#jqxEnquiry").jqxGrid('addrow', null, {});
				              
				                $('#methodinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
        
                       
    </script>
    <div id="jqxmethodsearch"></div>
    
    </body>
</html>