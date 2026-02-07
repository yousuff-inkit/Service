<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@include file = "enquiryStatus.jsp" %>
 <%@ taglib prefix="s" uri="/struts-tags"%>
 <% String jobno =request.getParameter("jobno")==null?"0":request.getParameter("jobno").toString();
  String empid=request.getParameter("empid")==null?"0":request.getParameter("empid").toString();
  String chk=request.getParameter("check")==null?"0":request.getParameter("check").toString();
  String from =request.getParameter("from")==null?"0":request.getParameter("from").toString();
  String to=request.getParameter("to")==null?"0":request.getParameter("to").toString();
  ClsStatusDAO sd= new ClsStatusDAO(); 
 %>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
table, th, td {
  border: 1px solid black;
  padding: 5px;
}
</style>
  <script type="text/javascript">

	
	var RESULTDATA5= '<%= sd.getUtilization(from,to,jobno,empid,chk,request) %>';

        $(document).ready(function () { 	
        	 	 
             var num = 0; 
             var source1 =
	          {
	              datatype: "json",
	              datafields: [
	                          
	                         	{name : 'costtype', type: 'string'  },
	                         	{name : 'costcode', type: 'string'  },
	                         	{name : 'name', type: 'string'  },
	                         	{name : 'concname', type: 'string'  },
	                         	{name : 'labourhrs', type: 'string'  },
	                         	{name : 'labourvalue', type: 'string'  },
	                         	{name : 'labourhrstime', type: 'string'  },
	                         	
	                       		//{name : 'count', type: 'string'  },
	      						],
	      				    localdata: RESULTDATA5,  
	              
	              
	              pager: function (pagenum, pagesize, oldpagenum) {
	                  // callback called when a page or page size is changed.
	              }
	          };
	           
             var dataAdapter1 = new $.jqx.dataAdapter(source1,
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
                           /* padding: { left: 5, top: 5, right: 5, bottom: 5 },
                           titlePadding: { left: 90, top: 0, right: 0, bottom:10 }, */
                           source: dataAdapter1,
							xAxis:
                           {
                               dataField: 'name',
                               gridLines: {visible: false},
                               tickMarks: {visible: true},
                               columnSeriesOverlap: false,
                               
                              
                           },
                       valueAxis:
                       {
                    	   title: { text: 'Labour Hours' },
                           labels: { horizontalAlignment: 'right' }
                       },
                       colorScheme: 'scheme02',
                       seriesGroups:
                           [
                               {
                                   type: 'column',
                                    columnsGapPercent: 10,
                                   seriesGapPercent: 10, 
                                   /* columnsTopWidthPercent: 50,
                                   columnsBottomWidthPercent: 100, */
                                   title: { text: 'Labour Hours' },
                                       series: [
                                               { dataField: 'labourhrstime', displayText: 'Labour Hours',cellsalign:'right' ,align:'right',cellsformat:'d2',
                                               	labels: {
                                                       visible: true,
                                                      
                                                   },	
                                                },
                                               
                                       ]
                                   }
                               ]
                       };
             //jqxJobChart
             //jqxJobCountGrid
             $('#jqxUtilizationChart').jqxChart(settings);
             var source1 =
	          {
	              datatype: "json",
	              datafields: [
	                          
							    {name : 'costtype', type: 'string'  },
								{name : 'costcode', type: 'string'  },
								{name : 'name', type: 'string'  },
								{name : 'labourhrs', type: 'string'  },
								{name : 'labourvalue', type: 'string'  },
								{name : 'labourhrstime', type: 'string'  },
	                       		//{name : 'code', type: 'string'  }
	      						],
	      				    localdata: RESULTDATA5,  
	              
	              
	              pager: function (pagenum, pagesize, oldpagenum) {
	                  // callback called when a page or page size is changed.
	              }
	          };
	           
             var dataAdapter1 = new $.jqx.dataAdapter(source1,
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

             $("#jqxUtilizationGrid").jqxGrid({
                 width: '95%',
                 height: 290,
                 filterable: true,
                 showfilterrow: true,
                 source: dataAdapter1,
                 columns:
                 [
                     { text: "Name", width: '60%', datafield: "name" },
                     { text: "Labour Hrs", width: '40%', datafield: "labourhrs",cellsformat:'d2',renderer: columnrenderer, cellsrenderer: cellsrenderer },
                    // { text: "Count", width: '20%', datafield: "count" },
                 ]
             });
             $("#jqxUtilizationGrid").on('filter', function () {
                 var rows = $("#jqxUtilizationGrid").jqxGrid('getrows');
                 var chart = $('#jqxUtilizationChart').jqxChart('getInstance');
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
    <th width="2%" align="left">Sr No</th>
    <th  width="15%"align="left">Employee</th>
    <th  width="3%"align="left">Type</th>
    <th  width="2%"align="left">Job No</th>
    <th  width="4%"align="left">Labour Hours</th>
    <th  width="4%"align="left">Labour Hours Time</th>
    <th  width="4%"align="left">Labour Value</th>
  
  </tr>
  <s:iterator var="stat" value='#request.utlzn' >
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
 
<div id="jqxUtilizationGrid" style="margin-left: 20px;display:none"></div>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" ><div id='jqxUtilizationChart' style="margin-top: 1px; width: 1200px; height: 300px; position:relative;">
    </div></div>

 </div>
 
 
</body>
</html>