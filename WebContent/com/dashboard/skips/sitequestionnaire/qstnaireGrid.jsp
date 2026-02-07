<%@page import="com.dashboard.skips.sitequestionnaire.ClsSiteQuestionnaireDAO" %>
<%
 ClsSiteQuestionnaireDAO DAO= new ClsSiteQuestionnaireDAO();   
 String cldocno = request.getParameter("cldocno")==null || request.getParameter("cldocno").equals("")?"0":request.getParameter("cldocno").trim().toString();
 String site = request.getParameter("site")==null?"":request.getParameter("site").trim().toString();%>
<script type="text/javascript">
		var data2;
        $(document).ready(function () { 	
        		data2='<%=DAO.searchqstn(cldocno, site)%>';      
            var source =
            {
                datatype: "json",
                datafields: [
							
                	{name : 'seqno', type: 'string' },
					{name : 'question', type: 'string' },
					{name : 'answer', type: 'string' },
                	{name : 'rowno', type: 'string' },

                	],
                		 localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#qstnGrid").jqxGrid(
            {
            	width: '100%',
                height: 252,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                filterable:true,
                selectionmode: 'singlerow',
            
                columns: [
							{ text: 'S#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Seqno', datafield: 'seqno', width: '12%',hidden:true },
							{ text: 'Questions', datafield: 'question', width: '50%',editable:false },	
					    	{ text: 'Answers', datafield: 'answer' },								
							{ text: 'rowno', datafield: 'rowno', width: '12%',hidden:true },

							]
            });
        });
    </script>
    <div id="qstnGrid"></div>