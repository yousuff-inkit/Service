<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@include file = "enquiryStatus.jsp" %>
 <%@ taglib prefix="s" uri="/struts-tags"%>
 <% String from =request.getParameter("from")==null?"0":request.getParameter("from").toString();
  String to=request.getParameter("to")==null?"0":request.getParameter("to").toString();
  String branch =request.getParameter("branch")==null?"0":request.getParameter("branch").toString();
  ClsStatusDAO sd= new ClsStatusDAO(); 
 %>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script type="text/javascript">

	
	var RESULTDATA8= '<%= sd.getCashFlow(from,request,branch) %>';

        $(document).ready(function () { 	
        	 	 
             var num = 0; 
             var source =
 	          {
 	              datatype: "json",
 	              datafields: [
 							    {name : 'branchname', type: 'string'  },
 								{name : 'cashincurrent', type: 'number'  },
 	                         	{name : 'cashinlast', type: 'number'  },
 	                         	{name : 'cashindiff', type: 'number'  },
 	                         	{name : 'cashoutcurrent', type: 'number'  },
 	                         	{name : 'cashoutlast', type: 'number'  },
 	                         	{name : 'cashoutdiff', type: 'number'  },
 	                       		
 	      						],
 	      				    localdata: RESULTDATA8,  
 	              
 	              
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
                       // prepare jqxChart settings
                       var settings = {
                     title: " ",
                     description: " ",
                     enableAnimations: true,
                     showLegend: true,
                     padding: { left: 5, top: 5, right: 5, bottom: 5 },
                     titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
                     source: dataAdapter,
                     xAxis:
                     {
                         dataField: 'branchname',
                         tickMarks: {
                             visible: true,
                             interval: 1
                         },
                         gridLines: {
                             visible: true,
                             interval: 1
                         }
                     },
                 valueAxis:
                 {
                     labels: { horizontalAlignment: 'right' }
                 },
                 colorScheme: 'scheme02',
                 seriesGroups:
                     [
                         {
                             type: 'column',
                             columnsGapPercent: 10,
                             seriesGapPercent: 10,
                             columnsTopWidthPercent: 100,
                             columnsBottomWidthPercent: 10,
                             title: { text: 'Month' },

                                 series: [
                                         { dataField: 'cashincurrent', displayText: 'Cash in Current Year Current Month' },
                                         { dataField: 'cashinlast', displayText: 'Cash in Last Year Current Month' },
                                         { dataField: 'cashoutcurrent', displayText: 'Cash out Current Year Current Month' },
                                         { dataField: 'cashoutlast', displayText: 'Cash out Last Year Current Month' },
                                 ]
                             }
                         ]
                 };
                       
           //jqxsalJobGrid jqxsalJobChart jqxsalEnqGrid jqxsalEnqChart
             //jqxEnqCountGrid
 	          //jqxEnqChart
 	          $('#jqxCashFlwChart').jqxChart(settings);

 	          var source =
 	          {
 	              datatype: "json",
 	              datafields: [
							    {name : 'branchname', type: 'string'  },
								{name : 'cashincurrent', type: 'number'  },
								{name : 'cashinlast', type: 'number'  },
								{name : 'cashindiff', type: 'number'  },
								{name : 'cashoutcurrent', type: 'number'  },
								{name : 'cashoutlast', type: 'number'  },
								{name : 'cashoutdiff', type: 'number'  },
 	      						],
 	      				    localdata: RESULTDATA8,  
 	              
 	              
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
             var cellsrenderer = function (row, column, value) {
                 return '<div style="text-align: right; margin-top: 5px;">' + value + '</div>';
             }
             var columnrenderer = function (value) {
                 return '<div style="text-align: right; margin-top: 5px;">' + value + '</div>';       
             }
             $("#jqxCashFlwGrid").jqxGrid({  
                 width: '99%',
                 height: 293,
                 filterable: true,
                 showfilterrow: true,  
                 source: dataAdapter,
                 columns:
                 [
 					{ text: "Branch", datafield: "branchname" },
 					{ text: "Cash in Current Year and Current month",columngroup: 'Cash In', width: '10%', cellsformat: 'd2', datafield: "cashincurrent",renderer: columnrenderer, cellsrenderer: cellsrenderer },
                   { text: "Cash in Last Year and Current month",columngroup: 'Cash In', width: '10%', cellsformat: 'd2', datafield: "cashinlast",renderer: columnrenderer, cellsrenderer: cellsrenderer },
                   { text: "Cash in Difference",columngroup: 'Cash In', width: '10%', cellsformat: 'd2', datafield: "cashindiff",renderer: columnrenderer, cellsrenderer: cellsrenderer },
                   { text: "Cash out Current Year and Current month",columngroup: 'Cash Out', width: '10%', cellsformat: 'd2', datafield: "cashoutcurrent",renderer: columnrenderer, cellsrenderer: cellsrenderer},
                   { text: "Cash out Last Year and Current month",columngroup: 'Cash Out', width: '10%', cellsformat: 'd2', datafield: "cashoutlast",renderer: columnrenderer, cellsrenderer: cellsrenderer },
                   { text: "Cash out Difference",columngroup: 'Cash Out', width: '10%', cellsformat: 'd2', datafield: "cashoutdiff",renderer: columnrenderer, cellsrenderer: cellsrenderer },
                 ],
             
             columngroups: [
                             { text: 'Cash In', align: 'center', name: 'Cash In' },
                             { text: 'Cash Out', align: 'center', name: 'Cash Out' },
                            ]
             });
             
             $("#jqxCashFlwGrid").on('filter', function () {
                 var rows = $("#jqxCashFlwGrid").jqxGrid('getrows');
                 var chart = $('#jqxCashFlwChart').jqxChart('getInstance');
                 chart.source = rows;
                 chart.update();
             });
//         

                /*  $("#overlay, #PleaseWait").hide(); */
        });
    </script>
 </head>
 <body> 
 <div align="center">
	<table id="maintbl" width="100%" border="1" cellpadding="4" style="border-collapse:collapse; border: 1px solid black;">
  <tr>
    <th width="5%" align="left">Sr No</th>
    <th  width="10%"align="left">Branch</th>
    <th  width="10%"align="left">Cash in Current Year and Current month</th>
    <th  width="10%"align="left">Cash in Last Year and Current month</th>
    <th  width="10%"align="center">Cash in Difference</th>
    <th width="10%" align="center">Cash out Current Year and Current month</th>
    <th width="10%" align="center">Cash out Last Year and Current month</th>
    <th width="10%" align="center">Cash out Difference</th>
  </tr>
  <s:iterator var="stat" value='#request.cshflw' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>1){%>
    
  <td  align="right" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr> 
</s:iterator> 
 
</table>
</div>
<br><br>
   <div class="row" align="center" >
 
<div id="jqxCashFlwGrid" style="margin-left: 20px;display:none"></div>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" ><div id='jqxCashFlwChart' style="margin-top: 1px; width: 500px; height: 300px; position: relative;">
    </div></div>

 </div>
 
 
</body>
</html>