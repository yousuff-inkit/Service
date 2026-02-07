<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@include file = "enquiryStatus.jsp" %>
 <%@ taglib prefix="s" uri="/struts-tags"%>  
 <% 
 ClsStatusDAO sd= new ClsStatusDAO(); 
 %>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script type="text/javascript">

  /* Bar Chart Starts */
  /* ----------------------------------- */
  var data10= '<%= sd.getCntRenewal() %>';   
  var source =
  {
      datatype: "json",
      datafields: [
          { name: 'contracts' },
          { name: 'expiring_in_days' },  
      ],
      localdata: data10
  };
  
  // prepare chart data as an array            
  
 var dataAdapter = new $.jqx.dataAdapter(source,
 		 {
     		loadError: function (xhr, status, error) {
              alert(error);    
              }
	            
          } );
 
 // prepare jqxChart settings
  var settings = {
      title: "Contract Expiry",
      description: "",
      showLegend: true,
      enableAnimations: true,
      padding: { left: 5, top: 5, right: 5, bottom: 5 },
      titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
      source: dataAdapter,
      xAxis:
          {
              dataField: 'expiring_in_days',
              showGridLines: true,
          },
          colorScheme: 'scheme02',
          seriesGroups:
          [
              {
                  type: 'column',
                  columnsGapPercent: 50,
                  seriesGapPercent: 0,
                  axisSize: 'auto',
                  //columnsMaxWidth: 20,
                  //columnsMinWidth: 1,
                  valueAxis:
                  {
                      displayValueAxis: true,
                      description: ' Contracts Expiry ',
                  },
                  series: [
                          { dataField: 'contracts', displayText: 'No of contracts'}, 
                      ]
              }
          ]
  };
  // setup the chart
  $('#jqxCntRenewChart').jqxChart(settings);  
  /* -------------------------------------- */
  /* Bar Chart Ends */
    </script>
 </head>
 <body> 
<br><br>
   <div class="row" align="center" > 
 
<div id="jqxContractRenewal" style="margin-left: 20px;display:none"></div> 
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" ><div id='jqxCntRenewChart' style="margin-top: 1px; width: 1200px; height: 400px; position: relative;">
    </div></div>

 </div>
 
 
</body>
</html>