<%-- <%@page import="com.services.masters.inspector.ClsInspectorDAO" %>
<%ClsInspectorDAO DAO=new ClsInspectorDAO();%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<script type="text/javascript">
 
  var atypedata;
 <%--  atypedata='<%=DAO.tradeSearch(session)%>'; --%>
        
  $(document).ready(function () { 
 
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'atradeid', type: 'String'  },
     						{name : 'atrade', type: 'String'  }
                          	],
                          	localdata: atypedata,
                
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

            $("#jqxadrsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable: true,
                showfilterrow: true,
            	
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
		                              groupable: false, draggable: false, resizable: false,
		                              datafield: '', columntype: 'number', width: '5%',
		                              cellsrenderer: function (row, column, value) {
		                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
		                              }
							},
							{ text: 'Trade', datafield: 'atrade', width: '90%' }
					]
            });
    
            //$("#jqxadrsearch").jqxGrid('addrow', null, {});
             
			$('#jqxadrsearch').on('rowdoubleclick', function (event)  { 
				       var rowindex1=event.args.rowindex;
				                	
					   document.getElementById("atrade").value=$('#jqxadrsearch').jqxGrid('getcellvalue', rowindex1, "atrade");
					   document.getElementById("atradeid").value=$('#jqxadrsearch').jqxGrid('getcellvalue', rowindex1, "atradeid");
				              
				       $('#tradeinfowindow').jqxWindow('close');
				            
			 }); 	 
				                   
}); 
				       
                       
</script>
<div id="jqxadrsearch"></div>
    
</body>
</html>