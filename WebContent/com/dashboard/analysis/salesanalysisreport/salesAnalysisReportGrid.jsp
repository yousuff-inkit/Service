<%@page import="com.dashboard.analysis.salesanalysisreport.ClsSalesAnalysisReport" %>
<% ClsSalesAnalysisReport cpla=new ClsSalesAnalysisReport();%>


<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();  
	 String frequencyType = request.getParameter("frequencytype")==null||request.getParameter("frequencytype")==""?"0":request.getParameter("frequencytype").trim();
	 String noOfDays = request.getParameter("noofdays")==null||request.getParameter("noofdays")==""?"0":request.getParameter("noofdays").trim();
	 String summarytype = request.getParameter("summarytype")==null||request.getParameter("summarytype")==""?"":request.getParameter("summarytype").trim();
	 
	 String hidsalesman = request.getParameter("hidsalesman")==null||request.getParameter("hidsalesman")==""?"":request.getParameter("hidsalesman").trim();
	 String hidcatid = request.getParameter("hidcatid")==null||request.getParameter("hidcatid")==""?"":request.getParameter("hidcatid").trim();
	 String hideptid = request.getParameter("hideptid")==null||request.getParameter("hideptid")==""?"":request.getParameter("hideptid").trim();
	 String hicashid = request.getParameter("hicashid")==null||request.getParameter("hicashid")==""?"":request.getParameter("hicashid").trim();
	 String hicreditid = request.getParameter("hicreditid")==null||request.getParameter("hicreditid")==""?"":request.getParameter("hicreditid").trim();
	 
	 
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>  
	 
<style type="text/css">
        .headClass
        {
            background-color: #FFEBC2;
        }
        .redClass
        {
            background-color: #FFEBEB;
        }
        .violetClass
        {
            background-color: #EBD6FF;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        .greenClass
        {
           background-color: #CEFFCE;
        }
        
</style>

 <script type="text/javascript">
 
 		var temp='<%=branchval%>';
 		var temp1='<%=fromDate%>';
 		var temp2='<%=toDate%>';
 		var check='<%=check%>';
 		var dataExcelExport;
 		
 		$(document).ready(function () {
			var data = "";
 			
 			if(check=='1'){
 				 data = '<%=cpla.analysisGrid(branchval, fromDate, toDate,summarytype,hidsalesman,hidcatid,hideptid, frequencyType, noOfDays, check,hicashid,hicreditid)%>';
 				dataExcelExport = '<%=cpla.analysisGridExcelExport(branchval, fromDate, toDate,summarytype,hidsalesman,hidcatid,hideptid, frequencyType, noOfDays, check,hicashid)%>'; 
 			}else{
 				data = '[{"columns":[{"text":"Id","datafield":"id","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Parent Id","datafield":"parentid","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Ord No","datafield":"ordno","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Group No","datafield":"groupno","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Group Id","datafield":"gp_id","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Account","datafield":"subac","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Description","datafield":"description","cellsAlign":"left","align":"left","width":"50%","cellclassname":"whiteClass"},{"text":"Total","datafield":"total","cellsAlign":"right","align":"right","width":"25%","cellsFormat":"d2","cellclassname":"whiteClass"},{"text":"","datafield":"amount0","cellsAlign":"right","align":"right","width":"25%","cellsFormat":"d2","cellclassname":"whiteClass"}]},{"rows":[{"id":"1","ordno":"5","groupno":"0","gp_id":"19","subac":"0","description":"","total":"","amount0":""}]}]';
 			} 

            var obj = $.parseJSON(data);
            var columns = obj[0].columns;
            var	rows = obj[1].rows;
 			
            var source =
            {
                datatype: "json",
                datafields: [
                    
                    { name: "id", type: "number" },
                    { name: 'description', type: "string" },
					{ name: 'total', type: "number" },
                    { name: 'amount0', type: "number" },
                    { name: 'amount1', type: "number" },
                    { name: 'amount2', type: "number" },
                    { name: 'amount3', type: "number" },
                    { name: 'amount4', type: "number" },
                    { name: 'amount5', type: "number" },
                    { name: 'amount6', type: "number" },
                    { name: 'amount7', type: "number" },
                    { name: 'amount8', type: "number" },
                    { name: 'amount9', type: "number" },
                    { name: 'amount10', type: "number" },
                    { name: 'amount11', type: "number" },
                    { name: 'amount12', type: "number" },
                    { name: 'amount13', type: "number" },
                    { name: 'amount14', type: "number" },
                    { name: 'amount15', type: "number" },
                    { name: 'amount16', type: "number" },
                    { name: 'amount17', type: "number" },
                    { name: 'amount18', type: "number" },
                    { name: 'amount19', type: "number" },
                    { name: 'amount20', type: "number" },
                    { name: 'amount21', type: "number" },
                    { name: 'amount22', type: "number" },
                    { name: 'amount23', type: "number" },
                    { name: 'amount24', type: "number" },
                    { name: 'amount25', type: "number" },
                    { name: 'amount26', type: "number" },
                    { name: 'amount27', type: "number" },
                    { name: 'amount28', type: "number" },
                    { name: 'amount29', type: "number" },
                    { name: 'amount30', type: "number" }
                ],
                hierarchy:
                {
                    keyDataField: { name: "id" },
                    parentDataField: { name: "parentid" }
                },
                id: "id",
                localdata: rows
            };
           
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#analysisGrid").jqxTreeGrid(
            {
                width: '99.5%',
                height: 525,
                source: dataAdapter,
                columnsresize: true,
                columns: columns,
                ready: function() 
                {
                	var rows = $("#analysisGrid").jqxTreeGrid('getRows');
                	for(var i=1;i <= rows.length; i++){
                		$("#analysisGrid").jqxTreeGrid('expandRow',rows[i-1].id);
                	}
                }, 
            });
            
			$("#overlay, #PleaseWait").hide();
            
            $('#analysisGrid').on('rowDoubleClick', function (event) {
            	var args = event.args;
                var row = event.args.row;
                /* var desc= "Sales Analysis Report"; 
                var accdocno="";
          	    if(row.ordno == 6)
          	    {
          	        var url=document.URL;
					var reurl=url.split("com/");
					
					accdocno=row.subac;
					var detName=row.description;
					var path="com/dashboard/analysis/profitlossanalysis/accountDetailsGrid.jsp";
					top.addTab( detName,reurl[0]+""+path+"?name="+detName+"&main="+desc+"&branchval="+temp+'&fromdate='+temp1+'&todate='+temp2+'&accdocno='+accdocno);
          		} */
          	    
              });
             
        });
 		
    </script>

    <div id="analysisGrid"></div>
