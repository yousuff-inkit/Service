
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
 
 var servby;

 var rowIndex='<%=rowIndex%>';
 
 servby='<%=DAO.servbySearch(session)%>';
 
  
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'servmethod', type: 'String'  },
     						{name : 'servsrno', type: 'string'  },
     						
     						
     						
                          	],
                          	localdata: servby,
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
            $("#jqxservbysearch").jqxGrid(
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
					{ text: 'SR No', datafield: 'servsrno', width: '20%' },
					{ text: 'Ownership', datafield: 'servmethod', width: '72%' },
					
					 
					
					]
            });
    
        //    $("#jqxservbysearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxservbysearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "servmethod",$('#jqxservbysearch').jqxGrid('getcellvalue', rowindex1, "servmethod"));
				               			$('#jqxEnquiry').jqxGrid('setcellvalue', rowIndex, "servsrno",$('#jqxservbysearch').jqxGrid('getcellvalue', rowindex1, "servsrno"));
				               			//$("#jqxEnquiry").jqxGrid('addrow', null, {});
				              
				                $('#servbyinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
        
                       
    </script>
    <div id="jqxservbysearch"></div>
    
    </body>
</html>