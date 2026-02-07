
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
 
 var wastetype;

 var rowIndex='<%=rowIndex%>';
 
 wastetype='<%=DAO.wasteSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'wastedoc', type: 'String'  },
     						{name : 'wastetype', type: 'string'  },
     						
     						
     						
                          	],
                          	localdata: wastetype,
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
            $("#jqxwastesearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'wastedoc', width: '20%' },
					{ text: 'Waste Type', datafield: 'wastetype', width: '72%' }
					
					 
					
					]
            });
    
            //$("#jqxwastesearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxwastesearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "wastetype",$('#jqxwastesearch').jqxGrid('getcellvalue', rowindex1, "wastetype"));
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "wastedoc",$('#jqxwastesearch').jqxGrid('getcellvalue', rowindex1, "wastedoc"));
				               		//	$("#jqxEnquiry").jqxGrid('addrow', null, {});
				              
				                $('#wasteinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
                       
    </script>
    <div id="jqxwastesearch"></div>
    
    </body>
</html>