
<%@page import="com.dashboard.skips.tippingfeetariff.ClsTippingfeetariffDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsTippingfeetariffDAO DAO= new ClsTippingfeetariffDAO();
 %>

 <script type="text/javascript">
 
 var wastetype;

 
 wastetype='<%=DAO.wastetypeSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'wastetype', type: 'String'  },
     						{name : 'wastetypeid', type: 'string'  },
     						
     						
     						
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
            $("#jqxwastetypeSearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'wastetypeid', width: '20%',hidden :true },
					{ text: 'Waste Type', datafield: 'wastetype' },
					
					 
					
					]
            });
    
          //  $("#jqxskipsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxwastetypeSearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				              	 document.getElementById("txtwastetype").value=$('#jqxwastetypeSearch').jqxGrid('getcellvalue', rowindex1, "wastetype"); 
				             	  document.getElementById("txtwastetypeid").value=$('#jqxwastetypeSearch').jqxGrid('getcellvalue', rowindex1, "wastetypeid");
				             	  //$("#jqxEnquiry").jqxGrid('addrow', null, {});
				              
				                $('#wastetypeWindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
        
                       
    </script>
    <div id="jqxwastetypeSearch"></div>
    
    </body>
</html>