<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@include file = "enquiryStatus.jsp" %>
 <%@ taglib prefix="s" uri="/struts-tags"%>
 <% String from =request.getParameter("from")==null?"0":request.getParameter("from").toString();
  String to=request.getParameter("to")==null?"0":request.getParameter("to").toString();
  String branch =request.getParameter("branch")==null?"0":request.getParameter("branch").toString();
  String amount1=request.getParameter("amount1")==null?"0":request.getParameter("amount1").toString();
  String amount2 =request.getParameter("amount2")==null?"0":request.getParameter("amount2").toString();
  ClsStatusDAO sd= new ClsStatusDAO(); 
 %>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script type="text/javascript">

	
	var RESULTDATA6= '<%= sd.getZonSalRept(from,to,request,branch,amount1,amount2) %>';

        $(document).ready(function () { 	
        	 	 
             var num = 0; 
             var source1 =
	          {
	              datatype: "json",
	              datafields: [
	                          
	                         	{name : 'source'  },
	                         	{name : 'srcper'  },
	               
	                       		//{name : 'count', type: 'string'  },
	      						],
	      				    localdata: RESULTDATA6,  
	              
	              
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
    title: "",
    description: "",
    source: dataAdapter1,
    colorScheme: 'scheme05',
    seriesGroups:
        [
            {
                type: 'pie',
                showLabels: true,
                series:
                    [
                        { 
                            dataField: 'srcper',
                            displayText: 'source',
                            labelRadius: 100,
                            initialAngle: 15,
                            radius: 180,
                            formatSettings: { sufix: '%', decimalPlaces: 1 }
                           
                        }
                    ]
            }
        ]
};
             //jqxJobChart
             //jqxJobCountGrid
             $('#jqxZoneChart').jqxChart(settings);
             var source1 =
	          {
	              datatype: "json",
	              datafields: [
	                          
	                         	{name : 'zone', type: 'string'  },
	                         	{name : 'branchname', type: 'string'  },
	                         	{name : 'curyearcurmonthamount', type: 'number'  },
	                         	{name : 'lastyearcurmonthamount', type: 'number'  },
	                         	{name : 'diff', type: 'number'  },
	                       		//{name : 'code', type: 'string'  }
	      						],
	      				    localdata: RESULTDATA6,  
	              
	              
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

             $("#jqxZoneGrid").jqxGrid({
                 width: '100%',
                 height: 290,
                 filterable: true,
                 showfilterrow: true,
                 source: dataAdapter1,
                 columns:
                 [
                     { text: "Branch", width: '20%', datafield: "branchname" },
                     { text: "Zone", width: '20%', datafield: "zone" },
                     { text: "Current year Current Month", width: '20%',columngroup: 'Amount', datafield: "curyearcurmonthamount",cellsformat: 'd2',renderer: columnrenderer, cellsrenderer: cellsrenderer },
                     { text: "Last year Current Month", width: '20%',columngroup: 'Amount', datafield: "lastyearcurmonthamount",cellsformat: 'd2',renderer: columnrenderer, cellsrenderer: cellsrenderer },
                     { text: "Difference", width: '20%',columngroup: 'Amount', datafield: "diff",cellsformat: 'd2',renderer: columnrenderer, cellsrenderer: cellsrenderer },
                     // { text: "Count", width: '20%', datafield: "count" },
                 ],
             columngroups: [
                            { text: 'Amount', align: 'center', name: 'Amount' },
                           ]
             });
             $("#jqxZoneGrid").on('filter', function () {
                 var rows = $("#jqxZoneGrid").jqxGrid('getrows');
                 var chart = $('#jqxZoneChart').jqxChart('getInstance');
                 chart.source = rows;
                 chart.update();
             });
//         

                /*  $("#overlay, #PleaseWait").hide(); */
        });
    </script>
 </head>
 <body> 
<%--  <div align="center">
	<table id="maintbl" width="100%" border="1" cellpadding="4" style="border-collapse:collapse; border: 1px solid black;">
  <tr>
    <th width="5%" align="left">Sr No</th>
    <th  width="10%"align="left">Branch</th>
    <th  width="10%"align="left">Current year Current Month</th>
    <th  width="10%"align="center">Last year Current Month</th>
    <th width="10%" align="center">Difference</th>
  
  </tr>
  <s:iterator var="stat" value='#request.zone' >
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
</div> --%>
<br><br>
   <div class="row" align="center" >
 
<div id="jqxZoneGrid" style="margin-left: 20px;display:none"></div>
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" ><div id='jqxZoneChart' style="margin-top: 1px; width: 500px; height: 500px; position: relative;">
    </div></div>

 </div>
 
 
</body>
</html>