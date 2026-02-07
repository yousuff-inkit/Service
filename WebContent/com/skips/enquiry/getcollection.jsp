
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
 
 var collection;

 var rowIndex='<%=rowIndex%>';
 
 collection='<%=DAO.collectionSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		  
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'collection', type: 'String'  },
     						{name : 'collectionsrno', type: 'string'  },
     						
     						
     						
                          	],
                          	localdata: collection,
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
            $("#jqxcollectionsearch").jqxGrid(
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
					{ text: 'SR No', datafield: 'collectionsrno', width: '20%' },
					{ text: 'Collection', datafield: 'collection', width: '72%' },
					
					 
					
					]
            });
    
        //    $("#jqxcollectionsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxcollectionsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "collection",$('#jqxcollectionsearch').jqxGrid('getcellvalue', rowindex1, "collection"));
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "collectionsrno",$('#jqxcollectionsearch').jqxGrid('getcellvalue', rowindex1, "collectionsrno"));
				               			$("#jqxEnquiry").jqxGrid('addrow', null, {});
				              
				                $('#collectioninfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
        
                       
    </script>
    <div id="jqxcollectionsearch"></div>
    
    </body>
</html>