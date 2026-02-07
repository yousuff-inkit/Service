<%-- <%@page import="com.services.masters.inspector.ClsInspectorDAO" %>
<%ClsInspectorDAO ClsInspectorDAO=new ClsInspectorDAO(); %> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<script type="text/javascript">
 
 	var atypedata;
 <%--    atypedata='<%=ClsInspectorDAO.atypeSearch(session)%>'; --%>
    
    $(document).ready(function () { 
 
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'atypedocno', type: 'String'  },
     						{name : 'atype', type: 'String'  }
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
           
            $("#jqxatypesearch").jqxGrid(
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
							{ text: 'Type', datafield: 'atype', width: '90%' }
					]
            });
    
            //$("#jqxatypesearch").jqxGrid('addrow', null, {});
      
			$('#jqxatypesearch').on('rowdoubleclick', function (event)  { 
				      var rowindex1=event.args.rowindex;
				      var temp="";
				                	
				      document.getElementById("atype").value=$('#jqxatypesearch').jqxGrid('getcellvalue', rowindex1, "atype");
					  document.getElementById("atypeid").value=$('#jqxatypesearch').jqxGrid('getcellvalue', rowindex1, "atypedocno");
				              
				      $('#typeinfowindow').jqxWindow('close');
				               
				            
			 }); 	 
				           
}); 
				                              
</script>
<div id="jqxatypesearch"></div>
    
</body>
</html>