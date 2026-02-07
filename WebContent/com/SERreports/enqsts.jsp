<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@include file = "enquiryStatus.jsp" %>
 <%@ taglib prefix="s" uri="/struts-tags"%>
 <% String from =request.getParameter("from")==null?"0":request.getParameter("from").toString();
  String to=request.getParameter("to")==null?"0":request.getParameter("to").toString();
  String branch =request.getParameter("branch")==null?"0":request.getParameter("branch").toString();
  String salesman=request.getParameter("salesman")==null?"0":request.getParameter("salesman").toString();
  String status=request.getParameter("status")==null?"0":request.getParameter("status").toString();
  ClsStatusDAO sd= new ClsStatusDAO(); 
 %>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script type="text/javascript">

	
	var RESULTDATA= '<%= sd.getStatusCount(from,to,request,branch,salesman,status) %>';

        $(document).ready(function () { 	
        	 	 
             var num = 0; 
             var source =
	          {
	              datatype: "json",
	              datafields: [
							    {name : 'branch', type: 'string'  },
								{name : 'salname', type: 'string'  },
	                         	{name : 'status', type: 'string'  },
	                         	{name : 'code', type: 'string'  },
	                       		{name : 'count', type: 'string'  },
	      						],
	      				    localdata: RESULTDATA,  
	              
	              
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
                                   dataField: 'code',
                                   gridLines: { visible: true }
                               },
                           colorScheme: 'scheme02',
                           seriesGroups:
                               [
                                   {  
                                       type: 'column',
                                       columnsGapPercent: 50,
                                       axisSize: 'auto',
                                       seriesGapPercent: 0,
                                       valueAxis:
                                       {
                                           visible: true,
                                           unitInterval: 50,
                                           minValue: 0,   
                                           /* maxValue: 50, */
                                           title: { text: 'Count' }
                                       },
                                       series: [
                                               { dataField: 'count', displayText: 'Count' },
                                               
                                       ]
                                   }
                               ]
                       };
                       
           //jqxsalJobGrid jqxsalJobChart jqxsalEnqGrid jqxsalEnqChart
             //jqxEnqCountGrid
	          //jqxEnqChart
	          $('#jqxEnqChart').jqxChart(settings);

	          var source =
	          {
	              datatype: "json",
	              datafields: [
								{name : 'branch', type: 'string'  },
								{name : 'salname', type: 'string'  },
	                         	{name : 'status', type: 'string'  },
	                       		{name : 'count', type: 'string'  },
	                       		{name : 'code', type: 'string'  }
	      						],
	      				    localdata: RESULTDATA,  
	              
	              
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
             $("#jqxEnqCountGrid").jqxGrid({  
                 width: '99%',
                 height: 293,
                 filterable: true,
                 showfilterrow: true,  
                 source: dataAdapter,
                 columns:
                 [
					  { text: "Branch", width: '15%', datafield: "branch" },
					  { text: "Salesman", width: '15%', datafield: "salname" },
                     { text: "Status", width: '30%', datafield: "status" },
                     { text: "Code", width: '20%', datafield: "code" },
                     { text: "Count", width: '20%', datafield: "count",renderer: columnrenderer, cellsrenderer: cellsrenderer },
                 ]
             });
             
             $("#jqxEnqCountGrid").on('filter', function () {
                 var rows = $("#jqxEnqCountGrid").jqxGrid('getrows');
                 var chart = $('#jqxEnqChart').jqxChart('getInstance');
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
    <th  width="20%"align="left">Branch</th>
    <th  align="left">Salesman</th>
    <th  align="center">Status</th>
    <th width="5%" align="center">Code</th>
    <th width="5%" align="center">Count</th>
   
  </tr>
  <s:iterator var="stat" value='#request.enqcountdetails' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>4){%>
    
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
 
<div id="jqxEnqCountGrid" style="margin-left: 20px;display:none"></div>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" ><div id='jqxEnqChart' style="margin-top: 1px; width: 500px; height: 300px; position: relative;">
    </div></div>

 </div>
 
 
</body>
</html>