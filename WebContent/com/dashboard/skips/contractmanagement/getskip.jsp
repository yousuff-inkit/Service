<%@page import="com.dashboard.skips.contractmanagement.ClsContractManagementDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsContractManagementDAO DAO= new ClsContractManagementDAO();
 %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
 String skiptype=request.getParameter("skiptype")==null?"":request.getParameter("skiptype").trim().toString();%>     

 <script type="text/javascript">
 
 var skiptype;

 var rowIndex='<%=rowIndex%>';
 
 skiptype='<%=DAO.skipSearch(session,skiptype)%>';    
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'name', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },  
     						
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
                width: '99.9%',
                height: 354,   
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
					{ text: 'Doc No', datafield: 'doc_no', width: '20%' },  
					{ text: 'Skip', datafield: 'name'},
					]
            });
    
            $("#jqxskipsearch").jqxGrid('addrow', null, {});
				           $('#jqxskipsearch').on('rowdoubleclick', function (event)    
				            		{ 
				              	        var rowindex1=event.args.rowindex;
				               			$('#jqxquotdetGrid').jqxGrid('setcellvalue', rowIndex, "skip",$('#jqxskipsearch').jqxGrid('getcellvalue', rowindex1, "name"));
				               			$('#jqxquotdetGrid').jqxGrid('setcellvalue', rowIndex, "skipid",$('#jqxskipsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				                        $('#skipinfowindow').jqxWindow('close');  
				            		 }); 	 
                  }); 
    </script>
    <div id="jqxskipsearch"></div>
    
    </body>
</html>