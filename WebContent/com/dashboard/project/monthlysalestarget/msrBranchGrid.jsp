<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.project.monthlysalestarget.ClsMonthlySalesTargetDAO"%>
<%
ClsMonthlySalesTargetDAO DAO=new ClsMonthlySalesTargetDAO();         
%>               
<% 
   String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>          
   
<script type="text/javascript">               
var data2,dataexcel2;    
        data2='<%=DAO.loadGridData(check)%>';
        $(document).ready(function () {  
        	var rendererstring=function (aggregates){
             	var value=aggregates['sum'];
             	if (typeof value === 'undefined') {
             		value='0.00';
             	}
             	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
        	}
        	
        	var rendererstring1=function (aggregates){
             	var value=aggregates['sum1'];
             	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
             }
        	
        	
            var source =
            {
                datatype: "json",
                datafields: [
						{name : 'brhid', type: 'string'  }, 
                        {name : 'rowno', type: 'string'  }, 
						{name : 'year', type: 'string'  }, 
						{name : 'month', type: 'string'  },
						{name : 'branch', type: 'string'  },
						{name : 'targetval', type: 'number'  },
						{name : 'percent', type: 'number'  },
                        ],
                         localdata: data2,       
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            		  
            };
             
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxmqrSubGrid").jqxGrid(
            {
                width: '99%',       
                height: 500,   
                source: dataAdapter,
                editable: false,
                columnsresize:true,
                showaggregates: true,
                showstatusbar:true,
                statusbarheight: 25,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',      
                pagermode: 'default',
    
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },   
							{ text: 'Year', datafield: 'year', width: '8%'},  
							{ text: 'rowno', datafield: 'rowno', width: '8%',hidden:true},  
							{ text: 'Month', datafield: 'month', width: '8%'},
							{ text: 'Branch', datafield: 'branch'},  
							{ text: 'GP%', datafield: 'percent',width: '5%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum1'],aggregatesrenderer:rendererstring1},  
							{ text: 'brhid', datafield: 'brhid',hidden:true, width: '8%'},  
							{ text: 'Target Value', datafield: 'targetval', width: '10%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							]
            });
            $("#overlay, #PleaseWait").hide();   
            $('#jqxmqrSubGrid').on('rowdoubleclick', function (event) {  
                var rowindex1 = event.args.rowindex;
                document.getElementById("rowno").value = $('#jqxmqrSubGrid').jqxGrid('getcellvalue', rowindex1, "rowno");   
                document.getElementById("cmbyear").value = $('#jqxmqrSubGrid').jqxGrid('getcellvalue', rowindex1, "year");
                document.getElementById("cmbmonth").value = $('#jqxmqrSubGrid').jqxGrid('getcellvalue', rowindex1, "month");
                document.getElementById("targetval").value = $('#jqxmqrSubGrid').jqxGrid('getcellvalue', rowindex1, "targetval");
                document.getElementById("cmbbranchs").value = $('#jqxmqrSubGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
                document.getElementById("percentval").value = $('#jqxmqrSubGrid').jqxGrid('getcellvalue', rowindex1, "percent");   
            });
});  
           
</script> 
 <div id="jqxmqrSubGrid"></div>
