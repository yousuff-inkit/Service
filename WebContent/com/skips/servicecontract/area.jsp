<%@page import="com.skips.servicecontract.ClsServiceContractDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsServiceContractDAO DAO= new ClsServiceContractDAO();  
 %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>

 <script type="text/javascript">
 
 var areadata;

 var rowIndex='<%=rowIndex%>';
 
 areadata='<%=DAO.areaSearch(session)%>';
 
 
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
								{name : 'city_name', type: 'String'  },
								{name : 'country_name', type: 'String'  },
								{name : 'region_name', type: 'String'  },     
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
                 height: 330,
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
					{ text: 'Doc No', datafield: 'areadocno', width: '13%',hidden:true }, 
					{ text: 'AREA', datafield: 'area'},
					{ text: 'State', datafield: 'city_name', width: '25%' },
					{ text: 'Country', datafield: 'country_name', width: '25%' },
					{ text: 'Region', datafield: 'region_name', width: '20%' }
					]
            }); 
    
            //$("#jqxareasearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxareasearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	  
				               			$('#siteGrid').jqxGrid('setcellvalue', rowIndex, "area",$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "area"));
				               			$('#siteGrid').jqxGrid('setcellvalue', rowIndex, "areaid",$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "areadocno"));
				               			$("#siteGrid").jqxGrid('addrow', null, {});
				              
				                $('#areainfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

                 
    </script>
    <div id="jqxareasearch"></div>
    
    </body>
</html>