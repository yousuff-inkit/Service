
<%@page import="com.dashboard.skips.skiptariff.ClsSkiptariffDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsSkiptariffDAO DAO= new ClsSkiptariffDAO();
 %>

 <script type="text/javascript">
 
 var skiptype;

 
 skiptype='<%=DAO.skipSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'skipsize', type: 'String'  },
     						{name : 'skipsizeid', type: 'string'  },
     						
     						
     						
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
            $("#jqxskipsizeSearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'skipsizeid', width: '20%',hidden :true },
					{ text: 'Skip Size', datafield: 'skipsize' },
					
					 
					
					]
            });
    
          //  $("#jqxskipsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxskipsizeSearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				              	 document.getElementById("txtskipsize").value=$('#jqxskipsizeSearch').jqxGrid('getcellvalue', rowindex1, "skipsize"); 
				             	  document.getElementById("txtskipsizeid").value=$('#jqxskipsizeSearch').jqxGrid('getcellvalue', rowindex1, "skipsizeid");
				             	  //$("#jqxEnquiry").jqxGrid('addrow', null, {});
				              
				                $('#skipsizeWindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
        
                       
    </script>
    <div id="jqxskipsizeSearch"></div>
    
    </body>
</html>