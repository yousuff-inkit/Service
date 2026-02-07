 
 

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
  <%-- radata='<%=DAO.qstionSearch(session)%>';  --%>
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'rowno', type: 'string'  },
     						{name : 'question', type: 'String'  }
     						
     						
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
            $("#jqxqstnsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                enabletooltips:true,
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '6%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					
					{ text: 'Rowno', datafield: 'rowno', width: '94%',hidden:true },
					{ text: 'Questions', datafield: 'question', width: '94%' },

					
					
					 
					
					]
            });
    
            //$("#jqxactivitysearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxactivitysearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	
				                	
						      
				              	$('#qstnGrid').jqxGrid('setcellvalue', rowIndex, "question",$('#jqxqstnsearch').jqxGrid('getcellvalue', rowindex1, "question"));
		               			$('#qstnGrid').jqxGrid('setcellvalue', rowIndex, "rowno",$('#jqxqstnsearch').jqxGrid('getcellvalue', rowindex1, "rowno"));
				              
				               
				           $("#qstnGrid").jqxGrid("addrow", null, {});
				              
				                $('#qstninfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxqstnsearch"></div>
    
    </body>
</html>