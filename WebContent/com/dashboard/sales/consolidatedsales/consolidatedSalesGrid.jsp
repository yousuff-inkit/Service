<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.sales.consolidatedsales.ClsConsolidatedSalesDAO" %>

<%ClsConsolidatedSalesDAO DAO= new ClsConsolidatedSalesDAO();
String check=request.getParameter("check")==null?"0":request.getParameter("check");
String branchval = request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();
String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
String salesman = request.getParameter("salesman")==null?"0":request.getParameter("salesman").trim();
String groupby = request.getParameter("groupby")==null?"0":request.getParameter("groupby").trim();
  %>
<script type="text/javascript">
 var check='<%=check%>';
 $(document).ready(function () {
	 var data1;
	 
	 if(check==1){
		   data1='<%=DAO.getData(branchval,fromDate,toDate,cldocno,category,salesman)%>'; 
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
	        	            {name : 'refno',type:'string'},
	        	            {name : 'date',type:'date'},
	                  		{name : 'dtype',type:'string'},
	                  		{name : 'voc_no',type:'string'},
	                  		{name : 'refname',type:'string'},
	                  		{name : 'amount',type:'number'},
	                  		{name : 'vatamt',type:'number'},
	                  		{name : 'nettotal',type:'number'},
	                  		{name : 'sal_name',type:'string'},
	                  		{name : 'slno', type: 'number'    },
	                  		{name : 'category',type:'string'},
					
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
	        height: 515,
	        columnsheight:23,
	        source: dataAdapter,
	        showaggregates:true,
	        showstatusbar:true,
	        statusbarheight: 21,
	        filtermode:'excel',
	        filterable: true,
	        showfilterrow: true,
	        selectionmode: 'singlerow',
	        pagermode: 'default',
	        sortable: true,
	        columnsresize: true,
	        editable:false,
	        enabletooltips:true,
	        columns: [
	        	        { text: 'Sr.No', datafield: 'slno', width: '3%' },
						{ text: 'Ref No', datafield:'refno', width:"8%" },
						{ text: 'Date ', datafield:'date', width:"8%", cellsformat:'dd.MM.yyyy'},
	       				{ text: 'Type', datafield:'dtype', width:"8%" },
	       				{ text: 'Doc No', datafield:'voc_no', width:"8%" },
	       				{ text: 'Client Name', datafield:'refname'},
	       				{ text: 'Amount', datafield:'amount',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
	       				{ text: 'Vat Amount', datafield:'vatamt',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
	       				{ text: 'Net Total', datafield: 'nettotal', width:"10%",cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
	       				{ text: 'Salesman', datafield:'sal_name', width:'20%'},
	       				{ text: 'Category', datafield:'category', width:'10%',hidden:true},
    				],
	    });
	    $("#overlay, #PleaseWait").hide();
	    
	 
 });
 </script>
 
 <div id="salesReportGrid"></div>