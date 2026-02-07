<%@page import="com.skips.quotation.ClsQuotationDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 	ClsQuotationDAO DAO= new ClsQuotationDAO();
 %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>

 <script type="text/javascript">
 var wastetype;
 var rowIndex='<%=rowIndex%>';
 wastetype='<%=DAO.specSearch(session)%>';
        $(document).ready(function () { 
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'String'  },
     						{name : 'spec', type: 'String'  },
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
            $("#jqxspecsearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
					{ text: 'Spec', datafield: 'spec', width: '72%' }
					]
            });
			          $('#jqxspecsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "spec",$('#jqxspecsearch').jqxGrid('getcellvalue', rowindex1, "spec"));
				               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "specid",$('#jqxspecsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				               			$("#jqxQuote").jqxGrid('addrow', null, {});
				                        $('#specinfowindow').jqxWindow('close');   
				        }); 	 
        
                  }); 
                       
    </script>
    <div id="jqxspecsearch"></div>
    
    </body>
</html>