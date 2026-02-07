<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@include file = "enquiryStatus.jsp" %>
 <%@ taglib prefix="s" uri="/struts-tags"%>
 <% String from =request.getParameter("from")==null?"0":request.getParameter("from").toString();
  String to=request.getParameter("to")==null?"0":request.getParameter("to").toString();
  String branch =request.getParameter("branch")==null?"0":request.getParameter("branch").toString();
  String salesman=request.getParameter("salesman")==null?"0":request.getParameter("salesman").toString();
  ClsStatusDAO sd= new ClsStatusDAO(); 
 %>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script type="text/javascript">

	
	var RESULTDATA9= '<%= sd.getInstSalColRept(from,request,branch,salesman) %>';

        $(document).ready(function () { 	
        	 	 
             var num = 0; 
             var source =
	          {
	              datatype: "json",
	              datafields: [
							    {name : 'brch', type: 'string'  },
								{name : 'salname', type: 'string'  },
	                         	{name : 'lastinst', type: 'number'  },
	                         	{name : 'curinst', type: 'number'  },
	                       		{name : 'lastsales', type: 'number'  },
	                       		{name : 'cursales', type: 'number'  },
	      						],
	      				    localdata: RESULTDATA9,  
	              
	              
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
                                     title: { text: 'Amount' },

                                         series: [
													/* { dataField: 'curinst', displayText: 'Installation Current Year Current Month' },
													{ dataField: 'lastinst', displayText: 'Installation Last Year Current Month' }, */
													{ dataField: 'cursales', displayText: 'Sales Current Year Current Month' },
													{ dataField: 'lastsales', displayText: 'Sales Last Year Current Month' },
                                         ]
                                     }
                                 ]
                         };
                     
         //jqxsalJobGrid jqxsalJobChart jqxsalEnqGrid jqxsalEnqChart
           //jqxEnqCountGrid
	          //jqxEnqChart
	          $('#jqxInstSAlChart').jqxChart(settings);

	          var source =
	          {
	              datatype: "json",
	              datafields: [
							    {name : 'brch', type: 'string'  },
							    {name : 'salname', type: 'string'  },
								{name : 'lastinst', type: 'number'  },
								{name : 'curinst', type: 'number'  },
								{name : 'lastsales', type: 'number'  },
								{name : 'cursales', type: 'number'  },
	      						],
	      				    localdata: RESULTDATA9,  
	              
	              
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
           $("#jqxInstSalGrid").jqxGrid({  
               width: '99%',
               height: 293,
               filterable: true,
               showfilterrow: true,  
               source: dataAdapter,
               columns:
               [
					{ text: "Branch", width: '15%', datafield: "brch" },
					{ text: "Salesman", width: '15%', datafield: "salname" },
                  /*  { text: "Installation Current Year Current Month", width: '18%', datafield: "curinst" },
                   { text: "Installation Last Year Same Month", width: '18%', datafield: "lastinst" }, */
                   { text: "Sales Last Year Current Month", width: '18%', datafield: "lastsales" },
                   { text: "Sales Current Year Current Month", width: '18%', datafield: "cursales" },
               ]
           });
           
           $("#jqxInstSalGrid").on('filter', function () {
               var rows = $("#jqxInstSalGrid").jqxGrid('getrows');
               var chart = $('#jqxInstSAlChart').jqxChart('getInstance');
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
    <th  width="15%"align="left">Salesman</th>
    <!-- <th  width="10%"align="center">Installation Current Year Current Month</th>
    <th width="10%" align="center">Installation Last Year Same Month</th> -->
    <th width="10%" align="center">Sales Last Year Current Month</th>
    <th width="10%" align="center">Sales Current Year Current Month</th>
  </tr>
  <s:iterator var="stat" value='#request.instsalcoldetails' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>2){%>
    
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
 
<div id="jqxInstSalGrid" style="margin-left: 20px;display:none"></div>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" ><div id='jqxInstSAlChart' style="margin-top: 1px; width: 500px; height: 300px; position: relative;">
    </div></div>

 </div>
 
 
</body>
</html>