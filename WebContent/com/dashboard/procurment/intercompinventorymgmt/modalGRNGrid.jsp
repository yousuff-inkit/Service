<%@page import="com.dashboard.procurment.intercompinventorymgmt.*" %>
<%
	ClsInterCompInventoryMgmtDAO DAO= new ClsInterCompInventoryMgmtDAO();
	String id=request.getParameter("id")==null?"0":request.getParameter("id");
	String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
	String detrowno=request.getParameter("detrowno")==null?"":request.getParameter("detrowno");
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
	String locid=request.getParameter("locid")==null?"":request.getParameter("locid");
	String date=request.getParameter("date")==null?"":request.getParameter("date");
%>
<script type="text/javascript">
	$(document).ready(function () {
   		var id='<%=id%>';
   		var modalgrndata=[];
   		if(id=='1'){
   			modalgrndata='<%=DAO.getModalGRNData(id,cldocno,detrowno,brhid,date,locid)%>';
		}
   		var rendererstring=function (aggregates){
   			var value=aggregates['sum'];
   		   	if(value=="" || value=="undefined" || value==null || typeof(value)=="undefined"){
   		   		value="0.0";
   		   	}
   			return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   		}
    // prepare the data
    	var source =
    	{
        	datatype: "json",
        	datafields: [
				{name : 'psrno',type:'number'},
				{name : 'rowno',type:'number'},
                {name : 'productid',type:'string'},
                {name : 'productname',type:'string'},
                {name : 'unit',type:'string'},
                {name : 'qty',type:'number'},
                {name : 'oldqty',type:'number'},
                {name : 'outqty',type:'number'},
                {name : 'balqty',type:'number'},
                {name : 'unitprice',type:'number'},
                {name : 'total',type:'number'},
                {name : 'discountpercent',type:'number'},
                {name : 'discountvalue',type:'number'},
                {name : 'discountpercent',type:'number'},
                {name : 'nettotal',type:'number'},
                {name : 'taxpercent',type:'number'},
                {name : 'taxamount',type:'number'},
                {name : 'taxtotal',type:'number'},
                {name : 'specid',type:'number'},
                {name : 'unitdocno',type:'number'}
			],
			localdata: modalgrndata,
        	
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
    
    
    	$("#modalGRNGrid").jqxGrid(
    	{
        	width: '100%',
        	height: 200,
        	source: dataAdapter,
        	showaggregates:true,
        	filterable: true,
        	showfilterrow: true,
        	selectionmode: 'singlecell',
        	showstatusbar:true,
        	showaggregates:true,
        	statusbarheight:25,
       		sortable:false,
       		editable:true,
        	columns: [
            	{ text: 'Product',datafield:'productid',width:'20%',editable:false},
            	{ text: 'Product Name',datafield:'productname',width:'60%',editable:false},
            	{ text: 'Spec Id',datafield:'specid',width:'5%',hidden:true},
            	{ text: 'Unit Doc No',datafield:'unitdocno',width:'5%',hidden:true},
            	{ text: 'Unit',datafield:'unit',width:'10%',editable:false},
            	{ text: 'PSR No',datafield:'psrno',width:'5%',editable:false,hidden:true},
            	{ text: 'Det.Row.No',datafield:'rowno',width:'5%',editable:false,hidden:true},
            	{ text: 'Qty',datafield:'qty',width:'10%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true},
            	{ text: 'Old Qty',datafield:'oldqty',width:'4%',cellsformat:'d2',align:'right',cellsalign:'right',hidden:true},
            	{ text: 'Out Qty',datafield:'outqty',width:'4%',cellsformat:'d2',align:'right',cellsalign:'right',hidden:true},
            	{ text: 'Bal.Qty',datafield:'balqty',width:'4%',cellsformat:'d2',align:'right',cellsalign:'right',hidden:true},
            	{ text: 'Unit Price',datafield:'unitprice',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true,hidden:true},
            	{ text: 'Total',datafield:'total',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
            	{ text: 'Discount%',datafield:'discountpercent',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true,hidden:true},
            	{ text: 'Discount',datafield:'discountvalue',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
            	{ text: 'Net Total',datafield:'nettotal',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
            	{ text: 'Tax%',datafield:'taxpercent',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false,hidden:true},
            	{ text: 'Tax Amount',datafield:'taxamount',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
            	{ text: 'Tax Total',datafield:'taxtotal',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true}
            ]
		});
    	
    	$("#modalGRNGrid").on('cellendedit', function (event){
    		
    		var dataField = event.args.datafield;
    		var rowBoundIndex = event.args.rowindex;
    		var value = args.value;
    		funmodalGRNGridChange(dataField,rowBoundIndex,value);
			
    	});
	});
	
	function funmodalGRNGridChange(datafield,rowindex,value){
		var qty=$('#modalGRNGrid').jqxGrid('getcellvalue',rowindex,'qty');
		var unitprice=$('#modalGRNGrid').jqxGrid('getcellvalue',rowindex,'unitprice');
		var discountpercent=$('#modalGRNGrid').jqxGrid('getcellvalue',rowindex,'discountpercent');
		var discountvalue=$('#modalGRNGrid').jqxGrid('getcellvalue',rowindex,'discountvalue');
		var taxpercent=$('#modalGRNGrid').jqxGrid('getcellvalue',rowindex,'taxpercent');
		var discounttype='';//To determine Which Discount column was changed,(Period,Value)
		if(datafield=="qty"){
			qty=value;
		}
		else if(datafield=="unitprice"){
			unitprice=value;
		}
		else if(datafield=="discountpercent"){
			discountpercent=value;
			discounttype='percent';
			discountvalue="0.0";
		}
		else if(datafield=="discountvalue"){
			discountvalue=value;
			discounttype='value';
			discountpercent="0.0";
		}
		else if(datafield=="taxpercent"){
			taxpercent=value;
		}
		
		var total=parseFloat(qty)*parseFloat(unitprice);
		discountpercent=discountpercent==null || discountpercent=="" || discountpercent=="undefined" || typeof(discountpercent)=="undefined"?"0.0":discountpercent;
		discountvalue=discountvalue==null || discountvalue=="" || discountvalue=="undefined" || typeof(discountvalue)=="undefined"?"0.0":discountvalue;
		taxpercent=taxpercent==null || taxpercent=="" || taxpercent=="undefined" || typeof(taxpercent)=="undefined"?"0.0":taxpercent;
		if(parseFloat(discountpercent)>0.0){
			discountvalue=(parseFloat(discountpercent)/100)*parseFloat(total);
		}
		else if(parseFloat(discountvalue)>0.0){
			discountpercent=(parseFloat(discountvalue)/parseFloat(total))*100;
		}
		
		var subtotal=parseFloat(total)-parseFloat(discountvalue);
		var taxvalue=parseFloat(taxpercent)>0.0?(parseFloat(subtotal)*(parseFloat(taxpercent)/100)):"0.0";
		var taxtotal=parseFloat(subtotal)+parseFloat(taxvalue);
		
		$('#modalGRNGrid').jqxGrid('setcellvalue',rowindex,'total',total);
		$('#modalGRNGrid').jqxGrid('setcellvalue',rowindex,'discountpercent',discountpercent);
		$('#modalGRNGrid').jqxGrid('setcellvalue',rowindex,'discountvalue',discountvalue);
		$('#modalGRNGrid').jqxGrid('setcellvalue',rowindex,'nettotal',subtotal);
		$('#modalGRNGrid').jqxGrid('setcellvalue',rowindex,'taxamount',taxvalue);
		$('#modalGRNGrid').jqxGrid('setcellvalue',rowindex,'taxtotal',taxtotal);
	}
</script>
<div id="modalGRNGrid"></div>