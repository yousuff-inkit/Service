 
 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.skips.clientskip.ClsClientskipDAO" %>
  
<%
 ClsClientskipDAO DAO=new ClsClientskipDAO();
 %>
 <script type="text/javascript">
 
 var radata;
<%--  if('NA' != '<%=item%>')  {
	 radata = '<%=item%>';
 } 
  --%>
  var rowIndex = '<%=request.getParameter("rowBoundIndex")%>';
  radata='<%=DAO.depSearch(session)%>';  
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'dep_id', type: 'string'  },
     						{name : 'dep', type: 'String'  }
     						
     						
                          	],
                          	localdata: radata,
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
            $("#jqxdepsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '6%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Id', datafield: 'dep_id', width: '10%' ,hidden:true},

					{ text: 'Department', datafield: 'dep' },
					
					
					 
					
					]
            });
    
            //$("#jqxdepsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxdepsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				                	
						      
				              	$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "dep",$('#jqxdepsearch').jqxGrid('getcellvalue', rowindex1, "dep"));
		               			$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "dep_id",$('#jqxdepsearch').jqxGrid('getcellvalue', rowindex1, "dep_id"));
				              
				               
				        //   $("#cpDetailsGrid").jqxGrid("addrow", null, {});
				              
				                $('#depinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxdepsearch"></div>
    
    </body>
</html>