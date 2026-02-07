<%@page import="com.dashboard.procurment.intercompinventorymgmt.*" %>
<%
	ClsInterCompInventoryMgmtDAO DAO= new ClsInterCompInventoryMgmtDAO();
	String id=request.getParameter("id")==null?"0":request.getParameter("id");
	String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
%>
<script type="text/javascript">
	$(document).ready(function () {
   		var id='<%=id%>';
   		var salesorderdata=[];
   		if(id=='1'){
   			salesorderdata='<%=DAO.getSalesOrderData(id,uptodate)%>';
		}
    // prepare the data
    	var source =
    	{
        	datatype: "json",
        	datafields: [
				{name : 'doc_no',type:'number'},
                {name : 'date',type:'date'},
                {name : 'refno',type:'string'},
                {name : 'billtype',type:'string'},
                {name : 'cldocno',type:'string'},
                {name : 'refname',type:'string'},
                {name : 'reftype',type:'string'},
                {name : 'refvocno',type:'string'},
                {name : 'description',type:'string'},
                {name : 'product',type:'string'},
                {name : 'productname',type:'string'},
                {name : 'unit',type:'string'},
                {name : 'qty',type:'number'},
                {name : 'outqty',type:'number'},
                {name : 'balqty',type:'number'},
                {name : 'unitprice',type:'number'},
                {name : 'total',type:'number'},
                {name : 'taxamount',type:'number'},
                {name : 'taxtotal',type:'number'},
                {name : 'psrno',type:'number'},
                {name : 'detrowno',type:'number'},
                {name : 'brhid',type:'string'},
                {name : 'branch',type:'string'}
			],
			localdata: salesorderdata,
        	
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
    
    
    	$("#salesOrderGrid").jqxGrid(
    	{
        	width: '100%',
        	height: 310,
        	source: dataAdapter,
        	showaggregates:true,
        	filterable: true,
        	showfilterrow: true,
        	selectionmode: 'checkbox',
       		sortable:false,
        	columns: [
        		{ text: 'Branch',datafield:'branch',width:'10%'},
        		{ text: 'Branch Id',datafield:'brhid',width:'6%',hidden:true},
        		
            	{ text: 'Doc No',datafield:'doc_no',width:'6%'},
            	{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
            	{ text: 'Ref No',datafield:'refno',width:'10%'},
            	{ text: 'Bill Type',datafield:'billtype',width:'5%',hidden:true},
            	{ text: 'Client #',datafield:'cldocno',width:'5%',hidden:true},
            	{ text: 'Customer',datafield:'refname',width:'10%'},
            	{ text: 'Ref Type',datafield:'reftype',width:'4%',hidden:true},
            	{ text: 'Ref.Doc #',datafield:'refvocno',width:'6%',hidden:true},
            	{ text: 'Description',datafield:'description',width:'10%'},
            	{ text: 'Product',datafield:'product',width:'10%'},
            	{ text: 'Product Name',datafield:'productname',width:'15%'},
            	{ text: 'PSRNO',datafield:'psrno',width:'15%',hidden:true},
            	{ text: 'Det.Rowno',datafield:'detrowno',width:'15%',hidden:true},
            	{ text: 'Unit',datafield:'unit',width:'5%'},
            	{ text: 'Qty',datafield:'qty',width:'4%',cellsformat:'d2',align:'right',cellsalign:'right'},
            	{ text: 'Out Qty',datafield:'outqty',width:'4%',cellsformat:'d2',align:'right',cellsalign:'right'},
            	{ text: 'Bal.Qty',datafield:'balqty',width:'4%',cellsformat:'d2',align:'right',cellsalign:'right'},
            	{ text: 'Unit Price',datafield:'unitprice',width:'6%',cellsformat:'d2',align:'right',cellsalign:'right'},
            	{ text: 'Total',datafield:'total',width:'6%',cellsformat:'d2',align:'right',cellsalign:'right'},
            	{ text: 'Tax Amount',datafield:'taxamount',width:'6%',cellsformat:'d2',align:'right',cellsalign:'right'},
            	{ text: 'Net Total',datafield:'taxtotal',width:'6%',cellsformat:'d2',align:'right',cellsalign:'right'}
            ]
		});
	});
</script>
<div id="salesOrderGrid"></div>