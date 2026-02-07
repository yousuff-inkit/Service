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

	
	var RESULTDATA10= '<%= sd.getEnqJobStatusCount(from,to,request,branch,salesman) %>';

        $(document).ready(function () { 	
        	 	 
             var num = 0; 
              var source =
             {
                 datatype: "json",
                 datafields: [
                             
                            	{name : 'branch', type: 'string'  },
                            	{name : 'salesman', type: 'string'  },
                          		{name : 'qots', type: 'number'  },
                          		{name : 'jobs', type: 'number'  },
                          		{name : 'enqs', type: 'number'  },
                          		{name : 'perjob', type: 'number'  },
                          		/* {name : 'perjobs', type: 'string'  }, */
         						],
         				    localdata: RESULTDATA10,  
                 
                 
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
                             dataField: 'salesman',
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
                                 columnsBottomWidthPercent: 0,
                                 title: { text: 'Count' },

                                     series: [
                                             { dataField: 'enqs', displayText: 'Enquiries' },
                                             { dataField: 'jobs', displayText: 'Jobs' },
                                             { dataField: 'qots', displayText: 'Quotations' },
                                     ]
                                 }
                             ]
                     };
                       
           //jqxsalJobGrid jqxsalJobChart jqxsalEnqGrid jqxsalEnqChart
             //jqxEnqCountGrid
             //jqxEnqChart
             $('#jqxEnqJobChart').jqxChart(settings); 

             var source =
             {
                 datatype: "json",
                 datafields: [
                             
   						    {name : 'branch', type: 'string'  },
   							{name : 'salesman', type: 'string'  },
   							{name : 'qots', type: 'number'  },
   							{name : 'jobs', type: 'number'  },
   							{name : 'enqs', type: 'number'  },
   							{name : 'perjob', type: 'number'  },
         						],
         				    localdata: RESULTDATA10,  
                 
                 
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
             $("#jqxEnqJobStatGrid").jqxGrid({  
                 width: '99%',
                 height: 293,
                 filterable: true,
                 showfilterrow: true,  
                 source: dataAdapter,
                 editable: true,
                 columns:
                 [
                     { text: "Branch", width: '20%', datafield: "branch" },
                     { text: "Salesman",datafield: "salesman" },
                     { text: "Enquiries", width: '10%', datafield: "enqs",renderer: columnrenderer, cellsrenderer: cellsrenderer },
                     { text: "Quotations", width: '10%', datafield: "qots",renderer: columnrenderer, cellsrenderer: cellsrenderer },
                     { text: "Jobs", width: '10%', datafield: "jobs",renderer: columnrenderer, cellsrenderer: cellsrenderer },
                     { text: "Percentage of Jobs", width: '10%', datafield: "perjob",cellsformat:'p',renderer: columnrenderer, cellsrenderer: cellsrenderer}, 
                 ]
             });
             
             $("#jqxEnqJobStatGrid").on('filter', function () {
                  var rows = $("#jqxEnqJobStatGrid").jqxGrid('getrows');
                 var chart = $('#jqxEnqJobChart').jqxChart('getInstance');
                 chart.source = rows;
                 chart.update(); 
             });
//         

                /*  $("#overlay, #PleaseWait").hide(); */
        });
    </script>
    </head>
  <body>
  <div id="jsprintgrid" align="center">
	<table id="maintbl" width="80%" border="1" cellpadding="4" style="border-collapse:collapse; border: 1px solid black;">
  <tr>
    <th width="5%" align="center">Sr No</th>
    <th width="15%"align="left">Branch</th>
    <th width="10%"align="left">Salesman</th>
    <th width="5%" align="center">Enquiries</th>
    <th width="5%" align="center">Quotations</th>
    <th width="5%" align="center">Jobs</th>
    <th width="5%" align="center">Percentage Of Jobs</th>
  </tr>
  <s:iterator var="stat" value='#request.details' >
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
 
<div id="jqxEnqJobStatGrid" style="margin-left: 20px;display:none"></div>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" ><div id='jqxEnqJobChart' style="margin-top: 1px; width: 500px; height: 300px; position: relative;">
    </div></div>

 </div> 
   
 
</body>
</html>