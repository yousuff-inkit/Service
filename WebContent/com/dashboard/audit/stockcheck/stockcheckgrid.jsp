<%@page import="com.dashboard.audit.stockcheck.ClsStockCheckGridDAO"%>
<%ClsStockCheckGridDAO DAO= new ClsStockCheckGridDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
String date=request.getParameter("date")==null?"":request.getParameter("date");
String chk=request.getParameter("chk")==null?"":request.getParameter("chk");
%>
<script type="text/javascript">
   var chk ='<%=chk%>'; 
   var data;
   if(chk==1){
   	data='<%=DAO.searchStock(date,chk)%>'; 
   }
        $(document).ready(function () { 	
        	
           var rendererstring1=function (aggregates){
           		var value=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
           }    
              
           var rendererstring=function (aggregates){
	           var value=aggregates['sum'];
	           return '<div style="margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
           }
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'amt', type: 'number'},
     						{name : 'tr_no', type: 'number'},
     						{name : 'transtype', type: 'string'},
     						{name : 'pp', type: 'number'},
     						{name : 'io', type: 'int'},
     						{name : 'transno', type: 'int'},
     						{name : 'reason', type: 'string'},
                        ],
                		  localdata: data, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxDashBoardMaster").jqxGrid(
            {
                width: '95%',
                height: 489,
                source: dataAdapter,
                filterable:true,
                sortable: true,
                showfilterrow: true,
                editable: true,
                selectionmode: 'row',
                localization: {thousandsSeparator: ""},
                showaggregates:true,
                showstatusbar:true,
                       
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                            groupable: false, draggable: false, resizable: false,datafield: '',
                            columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                            cellsrenderer: function (row, column, value) {
  	                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }  
	                       },
							{ text: 'Doc No.', datafield: 'transno', width:'15%'},
							{ text: 'Tr No.', datafield: 'tr_no', width:'16%'},
							{ text: 'Type', datafield: 'transtype', width:'16%',aggregates: ['sum'],aggregatesrenderer:rendererstring1},
							{ text: 'JV Amount', datafield: 'amt',width:'16%', cellsalign: 'right', cellsformat: 'd2', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'In/Out Amount', datafield: 'pp', width:'16%', cellsalign: 'right',cellsformat: 'd2',  align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Status', datafield: 'reason', width:'16%'},
						]
            });
            
            $('.load-wrapp').hide();
            
            	            
        });
    </script>
    <div id="jqxDashBoardMaster"></div>