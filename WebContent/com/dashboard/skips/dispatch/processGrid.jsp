<%@page import="com.dashboard.skips.dispatch.ClsDispatchDAO"%>
<%   
ClsDispatchDAO sd=new ClsDispatchDAO();                   
%>    
   
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<% String enqno =request.getParameter("enqno")==null || request.getParameter("enqno")==""?"0":request.getParameter("enqno").toString();%>

<script type="text/javascript">  
var pldata;               
pldata= '<%= sd.loadGridData(enqno) %>';
       $(document).ready(function () { 	
           
            var num = 0; 
           var source =
           {
               datatype: "json",
               datafields: [
							//{name : 'doc_no', type: 'number'  },
    						{name : 'enqno', type: 'String'  },
    						{name : 'edocno', type: 'number'  },
    						{name : 'jdocno', type: 'number'  },
    						{name : 'qdocno', type: 'number'  },
    						{name : 'qotno', type: 'String'  },
    						{name : 'jobno', type: 'String'  },
    						{name : 'client', type: 'String' },
    						{name : 'process', type: 'String' },
    						{name : 'fromdate', type: 'datetime' },
    						{name : 'fromuser', type: 'String' },
    						{name : 'todate', type: 'datetime' },
    						{name : 'touser', type: 'String' },
    						{name : 'totaltime', type: 'String' },
    						{name : 'remarks', type: 'String' },
						
    						
                ],
                localdata: pldata,  
               
               
               pager: function (pagenum, pagesize, oldpagenum) {
                   // callback called when a page or page size is changed.
               }
           };
           
           var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
           );
           $("#processlogGrid").jqxGrid(  
           {
               width: '100%', 
               height: 340,    
               source: dataAdapter,
               columnsresize: true,
               //pageable: true,
               altRows: true,
               sortable: true,
               selectionmode: 'singlerow',
               filtermode:'excel',
               filterable: true,
				showfilterrow: true,
               //pagermode: 'default',
		        enabletooltips: true,
               sortable: true,
               //Add row method
               columns: [
                         { text: 'SL#', sortable: false, filterable: false, editable: false,
                             groupable: false, draggable: false, resizable: false,
                             datafield: 'sl', columntype: 'number', width: '4%',
                             cellsrenderer: function (row, column, value) {
                                 return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                             }  
                           },    
					{ text: 'Enq No', datafield: 'enqno', width: '6%' },
					{ text: 'edocno', datafield: 'edocno', width: '6%',hidden:true },
					{ text: 'QOT No', datafield: 'qotno', width: '7%' },
					{ text: 'QDocno', datafield: 'qdocno', width: '7%',hidden:true },
					{ text: 'Contract No', datafield: 'jobno', width: '6%'  },
					{ text: 'CDoc No', datafield: 'jdocno', width: '7%',hidden:true },
					{ text: 'Client', datafield: 'client', width: '16%' },
					{ text: 'Process Name', datafield: 'process', width: '15%' },
					{ text: 'From Date', datafield: 'fromdate', width: '11%',cellsformat:'dd.MM.yyyy HH:mm:ss' },
					{ text: 'From User',  datafield: 'fromuser', width: '7%' },
					{ text: 'To Date', datafield: 'todate', width: '11%',cellsformat:'dd.MM.yyyy HH:mm:ss' },
					{ text: 'To User',  datafield: 'touser', width: '7%' },
					{ text: 'Total Time',  datafield: 'totaltime', width: '10%' },
					{ text: 'Remarks',  datafield: 'remarks', width: '40%' },                 
					
	              ]
           });
       });
</script>
<div id="processlogGrid"></div>