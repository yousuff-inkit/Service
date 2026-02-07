<%@page import="com.common.ClsExeFolio" %>
<%ClsExeFolio cef=new ClsExeFolio(); %>     

<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style>
.redClass
{
   color: #FF0000;            
}
iframe {
    overflow: scroll visible;
}
#btnReload{   
  	display: inline-block;
    margin-bottom: 0;
    font-weight: 400;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    background-image: none;
    border: none;
    padding: 3px 8px;  
    font-size: 14px;
    line-height: 1.42857143;
    border-radius: 20px;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);                 
    position: relative;
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   transition: all 0.3s;
  }
</style>

<script type="text/javascript">
$(document).ready(function () {
	
	var iframe = document.getElementById("folio");  
	iframe.onload = function(){ 
	    iframe.style.height = 100+iframe.contentWindow.document.body.scrollHeight + 'px'; 
	}
	
	 /* Partial Pie Chart Starts*/ 
    var data  =<%=cef.ApprovalStatus()%>;
    
    var dataStatCounter = data;

    var charts = [
        { title: '', label: 'Stat', dataSource: dataStatCounter }
    ];
    for (var i = 0; i < charts.length; i++) {
        var chartSettings = {
            source: charts[i].dataSource,
            title: 'Approval Status',
            description: charts[i].title,
            enableAnimations: false,
            showLegend: true,
            showBorderLine: true,
            padding: { left: 5, top: 5, right: 5, bottom: 5 },
            titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
            colorScheme: 'scheme02',
            seriesGroups: [
                {
                    type: 'pie',
                    showLegend: true,
                    enableSeriesToggle: true,
                    series:
                        [
                            {
                                dataField: 'per',
                                displayText: 'level',
                                showLabels: true,
                                labelRadius: 140,
                                labelLinesEnabled: true,
                                labelLinesAngles: true,
                                labelsAutoRotate: false,
                                initialAngle: 0,
                                radius: 110,
                                minAngle: 0,
                                maxAngle: 180,
                                centerOffset: 0,
                                offsetY: 110,
                                formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                    if (isNaN(value))
                                        return value;
                                    return value + '%';
                                }
                            }
                        ]
                }
            ]
        };
        // select container and apply settings
        var selector = '#approvalStatus' + (i + 1);
        $(selector).jqxChart(chartSettings);
        var tdwidth=$('#apprtable tr').eq(1).find('td').eq(1).width();
        tdwidth=parseInt(tdwidth)-130;
        $('#approvalStatus1').css('width',tdwidth+'px');     
    }
});
function funload(){        
    $("#overlay, #PleaseWait").show(); 
    var path="";   
    $("#folio").attr("src",path);    
    $("#approvalDataGrid").load("approvalDataGridNew.jsp");                                                            
}  
    </script>
</head>
<body style="overflow:auto;">
<!-- <div class='hidden-scrollbar'> -->
	<table width="100%" id="apprtable">
          <tr>
			<td width="5%" align="center">
				<button type="button" id="btnReload" title="Reload" style="cursor: pointer;background-color:#E0ECF8;" onclick="funload();">
					<img alt="Submit"  src="<%=contextPath%>/icons/icon-reload.png">
				</button>
			</td>  
			<td width="35%"><h2 style="text-align:right">                                                   
					<b>Executive Management Folio</b>                                                       
				</h2> </td>      
			<td width="15%">&nbsp;</td>                              
		</tr> 
		<tr>  
			<td width="65%" rowspan="2"><div id="approvalData"><jsp:include
						page="approvalDataNew.jsp"></jsp:include></div></td>
		</tr>
		<tr>
			<td><div id='approvalStatus1'
					style="width: 100%; height: 150px;"></div></td>
		</tr> 
		<tr><td> 
			<input type="hidden" id="formData" />       
			<input type="hidden" id="branchid" />    
			<input type="hidden" id="mode" />        
			<input type="hidden" id="backdateallowed" name="backdateallowed" value='<s:property value="backdateallowed"/>' />
			<input type="hidden" id="pdcascdcdateallowed" name="pdcascdcdateallowed" value='<s:property value="pdcascdcdateallowed"/>' />
			<input type="hidden" id="monthclosed" name="monthclosed" value='<s:property value="monthclosed"/>' />
			<input type="hidden" id="taxdateval" name="taxdateval" value='<s:property value="taxdateval"/>' />
			<input type="hidden" name="formcurrencytype" id="formcurrencytype" value='<s:property value="formcurrencytype"/>' />
			<input type="hidden" id="curdec" name="curdec" value='<s:property value="curdec"/>' />
			<input type="hidden" id="amtdec" name="amtdec" value='<s:property value="amtdec"/>' />
			<input type="hidden" id="chkexportdata" name="chkexportdata" value='<s:property value="chkexportdata"/>' /></td></tr>   
	</table>    
<iframe id="folio" width = "100%"  scrolling="yes">                                 
</iframe>         
 </body>
</html>