 
 

<%@page import="com.inkit.enquiry.ClsEnquiryDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <%
 ClsEnquiryDAO ClsEnquiryDAO=new ClsEnquiryDAO();
 int rowIndex=request.getParameter("rowIndex")==null?0:Integer.parseInt(request.getParameter("rowIndex").trim()); %>

 <script type="text/javascript">
 
 var areadata;

 var rowIndex='<%=rowIndex%>';
 
 <%-- areadata='<%=ClsEnquiryDAO.areaSearch(session)%>'; --%>
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'areadocno', type: 'String'  },
     						{name : 'area', type: 'String'  },
     						
     						
     						
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
            $("#jqxareasearch").jqxGrid(
            {
                width: '100%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Docno', datafield: 'areadocno', width: '25%' },
					{ text: 'AREA', datafield: 'area', width: '75%' }
					
					 
					
					]
            });
    
            //$("#jqxareasearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxareasearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#jqxJobDetails').jqxGrid('setcellvalue', rowIndex, "area",$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "area"));
				               			$('#jqxJobDetails').jqxGrid('setcellvalue', rowIndex, "areaid",$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "areadocno"));
				            	  
				              
				                $('#areainfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxareasearch"></div>
    
    </body>
</html>