
<%@page import="com.operations.marketing.enquiryfurniture.ClsEnquiryFurnitureDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsEnquiryFurnitureDAO DAO= new ClsEnquiryFurnitureDAO();
 %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>

 <script type="text/javascript">
 
 var skiptype;

 var rowIndex='<%=rowIndex%>';
 
 skiptype='<%=DAO.skipSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'skiptype', type: 'String'  },
     						{name : 'skipdoc', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: skiptype,
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
            $("#jqxskipsearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'skipdoc', width: '20%' },
					{ text: 'Skip type', datafield: 'skiptype', width: '72%' },
					
					 
					
					]
            });
    
            $("#jqxskipsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxskipsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "skiptype",$('#jqxskipsearch').jqxGrid('getcellvalue', rowindex1, "skiptype"));
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "skipdoc",$('#jqxskipsearch').jqxGrid('getcellvalue', rowindex1, "skipdoc"));
				               			$("#jqxEnquiry").jqxGrid('addrow', null, {});
				              
				                $('#skipinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
        
                       
    </script>
    <div id="jqxskipsearch"></div>
    
    </body>
</html>