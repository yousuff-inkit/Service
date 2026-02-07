<%@page import="com.controlcentre.masters.clientskip.ClsClientskipDAO" %>
<%
ClsClientskipDAO DAO= new ClsClientskipDAO();
 String docNo=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();%>
<script type="text/javascript">
		var tempDocNo1='<%=docNo%>';
		var temp1='0';
		
		var data2;
		
        $(document).ready(function () { 	
        	
        	if(tempDocNo1)
        	 { 
        		data2='<%=DAO.searchqstn(docNo)%>';   
        	 }   
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
                height: 150,
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
            
            
            //Add empty row
            if(temp1=='1'){
           	   $("#qstnGrid").jqxGrid('addrow', null, {});
             }
            
            if(tempDocNo1>0 && tempMode1=='view'){
            	$("#qstnGrid").jqxGrid('disabled', true);
            }
            
        });
    </script>
    <div id="qstnGrid"></div>
 