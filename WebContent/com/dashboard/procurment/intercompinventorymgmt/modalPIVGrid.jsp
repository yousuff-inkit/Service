<%@page import="com.dashboard.procurment.intercompinventorymgmt.*" %>
<%
	ClsInterCompInventoryMgmtDAO DAO= new ClsInterCompInventoryMgmtDAO();
	String id=request.getParameter("id")==null?"0":request.getParameter("id");
	String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
	String detrowno=request.getParameter("detrowno")==null?"":request.getParameter("detrowno");
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
	String locid=request.getParameter("locid")==null?"":request.getParameter("locid");
	String billtype=request.getParameter("billtype")==null?"":request.getParameter("billtype");
	String date=request.getParameter("date")==null?"":request.getParameter("date");
%>
<script type="text/javascript">
	$(document).ready(function () {
   		var id='<%=id%>';
   		var modalpivdata=[];
   		if(id=='1'){
   			modalpivdata='<%=DAO.getModalPIVData(cldocno, detrowno, brhid, locid, date, billtype, id)%>';
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
                {name : 'product',type:'string'},
                {name : 'productname',type:'string'},
                {name : 'unit',type:'string'},
                {name : 'qty',type:'number'},
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
                {name : 'stockid',type:'number'},
                {name : 'unitdocno',type:'number'},
                {name : 'taxdocno',type:'string'}
			],
			localdata: modalpivdata,
        	
			pager: function (pagenum, pagesize, oldpagenum) {
            	// callback called when a page or page size is changed.
        	}
    	};
   		
    	$("#modalPIVGrid").on("bindingcomplete", function (event) {
    		var rows=$('#modalPIVGrid').jqxGrid('getrows');
    		for(var i=0;i<rows.length;i++){
    			if(rows[i].psrno!=null && rows[i].psrno!="undefined" && rows[i].psrno!="" && typeof(rows[i].psrno)!="undefined"){
    				var taxpercent=rows[i].taxpercent;
    				taxpercent=taxpercent==null || taxpercent=="undefined" || taxpercent=="" || typeof(taxpercent)=="undefined"?"0":taxpercent;
    				var nettotal=rows[i].nettotal;
    				nettotal=nettotal==null || nettotal=="undefined" || nettotal=="" || typeof(nettotal)=="undefined"?"0":nettotal;
    				var taxamt=0.0;
    				if(parseFloat(taxpercent)>0.0){
    					taxamt=parseFloat(nettotal)*(parseFloat(taxpercent)/100);
    				}
    				var taxtotal=parseFloat(nettotal)+parseFloat(taxamt);
    				$('#modalPIVGrid').jqxGrid('setcellvalue',i,'taxamount',taxamt);
    				$('#modalPIVGrid').jqxGrid('setcellvalue',i,'taxtotal',taxtotal);
    			}
    		}
    	});
    	var dataAdapter = new $.jqx.dataAdapter(source,
    		{
        		loadError: function (xhr, status, error) {
                	alert(error);    
            	}
		   	}		
    	);
    
    
    	$("#modalPIVGrid").jqxGrid(
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
            	{ text: 'Product',datafield:'product',width:'10%',editable:false},
            	{ text: 'Product Name',datafield:'productname',width:'20%',editable:false},
            	{ text: 'Spec Id',datafield:'specid',width:'5%',hidden:true},
            	{ text: 'Stock Id',datafield:'stockid',width:'5%',hidden:true},
            	{ text: 'Unit Doc No',datafield:'unitdocno',width:'5%',hidden:true},
            	{ text: 'Unit',datafield:'unit',width:'5%',editable:false},
            	{ text: 'PSR No',datafield:'psrno',width:'5%',editable:false,hidden:true},
            	{ text: 'Det.Row.No',datafield:'rowno',width:'5%',editable:false,hidden:true},
            	{ text: 'Tax.Doc.No',datafield:'taxdocno',width:'5%',editable:false,hidden:true},
            	{ text: 'Qty',datafield:'qty',width:'5%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true},
            	
            	{ text: 'Out Qty',datafield:'outqty',width:'4%',cellsformat:'d2',align:'right',cellsalign:'right',hidden:true},
            	{ text: 'Bal.Qty',datafield:'balqty',width:'4%',cellsformat:'d2',align:'right',cellsalign:'right',hidden:true},
            	{ text: 'Unit Price',datafield:'unitprice',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true},
            	{ text: 'Total',datafield:'total',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
            	{ text: 'Discount%',datafield:'discountpercent',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true},
            	{ text: 'Discount',datafield:'discountvalue',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring},
            	{ text: 'Net Total',datafield:'nettotal',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
            	{ text: 'Tax%',datafield:'taxpercent',width:'7%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false},
            	{ text: 'Tax Amount',datafield:'taxamount',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
            	{ text: 'Tax Total',datafield:'taxtotal',width:'8%',cellsformat:'d2',align:'right',cellsalign:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring}
            ]
		});
    	
    	$("#modalPIVGrid").on('cellendedit', function (event){
    		
    		var dataField = event.args.datafield;
    		var rowBoundIndex = event.args.rowindex;
    		var value = args.value;
    		funmodalPIVGridChange(dataField,rowBoundIndex,value);
			
    	});
	});
	
	function funmodalPIVGridChange(datafield,rowindex,value){
		var qty=$('#modalPIVGrid').jqxGrid('getcellvalue',rowindex,'qty');
		var unitprice=$('#modalPIVGrid').jqxGrid('getcellvalue',rowindex,'unitprice');
		var discountpercent=$('#modalPIVGrid').jqxGrid('getcellvalue',rowindex,'discountpercent');
		var discountvalue=$('#modalPIVGrid').jqxGrid('getcellvalue',rowindex,'discountvalue');
		var taxpercent=$('#modalPIVGrid').jqxGrid('getcellvalue',rowindex,'taxpercent');
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
		
		$('#modalPIVGrid').jqxGrid('setcellvalue',rowindex,'total',total);
		$('#modalPIVGrid').jqxGrid('setcellvalue',rowindex,'discountpercent',discountpercent);
		$('#modalPIVGrid').jqxGrid('setcellvalue',rowindex,'discountvalue',discountvalue);
		$('#modalPIVGrid').jqxGrid('setcellvalue',rowindex,'nettotal',subtotal);
		$('#modalPIVGrid').jqxGrid('setcellvalue',rowindex,'taxamount',taxvalue);
		$('#modalPIVGrid').jqxGrid('setcellvalue',rowindex,'taxtotal',taxtotal);
	}
</script>
<div id="modalPIVGrid"></div>