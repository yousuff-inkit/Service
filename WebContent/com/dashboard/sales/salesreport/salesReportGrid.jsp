<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.sales.salesreport.ClsSalesReportDAO" %>

<%ClsSalesReportDAO DAO= new ClsSalesReportDAO();
String check=request.getParameter("check")==null?"0":request.getParameter("check");
String branchval = request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();
String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String summaryType = request.getParameter("summarytype")==null?"0":request.getParameter("summarytype").trim();
String hidsalesman=request.getParameter("hidsalesman")==null?"":request.getParameter("hidsalesman");
String hidpassdate=request.getParameter("hidpassdate")==null?"":request.getParameter("hidpassdate");
String hidaccno=request.getParameter("hidaccno")==null?"":request.getParameter("hidaccno");
String hideptid=request.getParameter("hideptid")==null?"":request.getParameter("hideptid");
String hidbrandid=request.getParameter("hidbrandid")==null?"":request.getParameter("hidbrandid");
String hidproductid=request.getParameter("hidproductid")==null?"":request.getParameter("hidproductid");
%>
<script type="text/javascript">
 var check='<%=check%>';
 var dataexcel;
 $(document).ready(function () {
	 var data1;
	 
	 
	 var summaryType='<%=summaryType%>';
	 
	 if(check==1){
		   data1='<%=DAO.reloadGrid(branchval,fromDate,toDate,summaryType,hidsalesman,hidpassdate,hidaccno,hideptid,hidbrandid,hidproductid)%>'; 
		   dataexcel='<%=DAO.reloadExceldata(branchval, fromDate, toDate, summaryType, hidsalesman, hidpassdate, hidaccno, hideptid, hidbrandid, hidproductid)%>';
	 }
	 else{
		 data1;
	 }
	 
	 var rendererstring=function (aggregates){
		   	var value=aggregates['sum'];
		   	if(typeof(value) == "undefined"){
    			value=0.00;
    		}
		   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	 }  
	   
	 var source =
	    {
	        datatype: "json",
	        datafields: [

	                  		{name : 'refno',type:'number'},
	                  		{name : 'refname',type:'string'},
	                  		{name : 'date',type:'date'},
	                  		{name : 'sales',type:'number'},
	                  		{name : 'retamt',type:'number'},
	                  		{name : 'nettotal', type: 'number'}
					
	                  		],
					    localdata: data1,
	        
					   
	    
	        pager: function (pagenum, pagesize, oldpagenum) {
	            // callback called when a page or page size is changed.
	        }
	    };
	 
	 $("#salesReportGrid").on("bindingcomplete", function (event) {
	    	$("#overlay, #PleaseWait").hide();
	    	});        
	    
	    

	    var dataAdapter = new $.jqx.dataAdapter(source,
	    		 {
	        		loadError: function (xhr, status, error) {
	                alert(error);    
	                }
			            
		            }		
	    );
	    
	    
	    
	    $("#salesReportGrid").jqxGrid(
	    {
	        width: '98%',
	        height: 516,
	        columnsheight:23,
	        source: dataAdapter,
	        showaggregates:true,
	        showstatusbar:true,
	        statusbarheight: 21,
	        filtermode:'excel',
	        filterable: true,
	        selectionmode: 'singlerow',
	        pagermode: 'default',
	        sortable: true,
	        columnsresize: true,
	        editable:false,
	        columns: [
						{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
			             groupable: false, draggable: false, resizable: false,datafield: '',
			             columntype: 'number', width: '6%',cellsalign: 'center', align: 'center',
			             cellsrenderer: function (row, column, value) {
			            	 return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
			             }    
						},
	       				{ text: 'Ref No',datafield:'refno',width:'10%'},
	       				{ text: 'Type',datafield:'refname' },
	       				{ text: 'Type ',datafield:'date' ,cellsformat:'dd.MM.yyyy'},
	       				{ text: 'Sales',datafield:'sales',width:'17%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
	       				{ text: 'Return', datafield: 'retamt', width:"17%",cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
	       				{ text: 'Net Total',datafield:'nettotal',width:'20%',cellsformat: 'd2', align: 'right', cellsalign: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring}
    				],
	    });
	    
	    
	    if(summaryType=="dat"){
	    	
	    	  $('#salesReportGrid').jqxGrid('hidecolumn', 'refname');
	    	  $('#salesReportGrid').jqxGrid('showcolumn', 'date');
	    }
	    else
	    	{
	    	  $('#salesReportGrid').jqxGrid('showcolumn', 'refname');
	    	  $('#salesReportGrid').jqxGrid('hidecolumn', 'date');
	    	
	    	}
	    
	 
 });
 
 </script>
 
 <div id="salesReportGrid"></div>