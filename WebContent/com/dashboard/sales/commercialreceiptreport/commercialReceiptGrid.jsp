<%@ page import="com.dashboard.sales.commercialreceiptreport.ClsCommercialReceiptDAO" %>
<% ClsCommercialReceiptDAO DAO=new ClsCommercialReceiptDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim(); %>

<style type="text/css">
	  .cashClass
	  {
	      background-color: #FBEFF5;
	  }
	  .cardClass
	  {
	      background-color: #E0F8F1;
	  }
	   .chequeClass
	  {
	      background-color: #ECE0F8;
	  }
	  .appliedClass
	  {
	  	  background-color: #F9FFED;
	  }
	  .balanceClass
	  {
	  	  color: #FF472A;
	  }
</style>

<script type="text/javascript">
      var data1;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data1='<%=DAO.commercialReceiptGridLoading(branchval,fromDate, toDate)%>';
			   var dataExcelExport='<%=DAO.commercialReceiptGridExcelExport(branchval,fromDate, toDate)%>';
	  	}
	  	
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'branch', type: 'String' },
					{ name: 'rdocno', type: 'int' },
					{ name : 'date', type: 'date' },
					{ name: 'dtype', type: 'String' },
                    { name: 'srno', type: 'int' },
                    { name: 'refname', type: 'String' },
                    { name: 'cashtotal', type: 'number' },
                    { name: 'cardtotal', type: 'number' },
                    { name: 'chequetotal', type: 'number' },
                    { name: 'applied', type: 'number' },
                    { name: 'balance', type: 'number' },
                    { name: 'description', type: 'String' }
	            ],
                localdata: data1,
               
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
            $("#commercialReceiptGridID").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
             	columnsresize : true,
                localization: {thousandsSeparator: ""},
                
                columns: [
						{ text: 'CMR No.', datafield: 'srno', width: '7%' },
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '6%' },
						{ text: 'Type', datafield: 'dtype', width: '4%' },
						{ text: 'Doc No', datafield: 'rdocno', width: '6%' },
						{ text: 'Branch', datafield: 'branch', width: '8%' },
	                    { text: 'Client', datafield: 'refname', width: '14%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
	                    { text: 'Cash Total', datafield: 'cashtotal', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'cashClass'  },
	                    { text: 'Card Total', datafield: 'cardtotal', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'cardClass' },
	                    { text: 'Cheque Total', datafield: 'chequetotal', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'chequeClass'  },
	                    { text: 'Applied', datafield: 'applied', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'appliedClass' },
	                    { text: 'Balance', datafield: 'balance', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'balanceClass' },
	                    { text: 'Description', datafield: 'description', width: '20%' },
					 ]
            });
            
            if(temp=='NA'){
                $("#commercialReceiptGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            var cashtotal1="";var cardtotal1="";var chequetotal1="";var applied1="";var balance1="";var netamount="";
            var cashtotal=$('#commercialReceiptGridID').jqxGrid('getcolumnaggregateddata', 'cashtotal', ['sum'], true);
            cashtotal1=cashtotal.sum;
            var cardtotal=$('#commercialReceiptGridID').jqxGrid('getcolumnaggregateddata', 'cardtotal', ['sum'], true);
            cardtotal1=cardtotal.sum;
            var chequetotal=$('#commercialReceiptGridID').jqxGrid('getcolumnaggregateddata', 'chequetotal', ['sum'], true);
            chequetotal1=chequetotal.sum;
            var applied=$('#commercialReceiptGridID').jqxGrid('getcolumnaggregateddata', 'applied', ['sum'], true);
            applied1=applied.sum;
            var balance=$('#commercialReceiptGridID').jqxGrid('getcolumnaggregateddata', 'balance', ['sum'], true);
            balance1=balance.sum;
            if(!isNaN(cashtotal1 || cardtotal1 || chequetotal1)){
            	netamount= parseFloat(cashtotal1) + parseFloat(cardtotal1) + parseFloat(chequetotal1);
      		    funRoundAmt(netamount,"txtnetamount");
      		  }
      		else{
		    	 $('#txtnetamount').val(0.00);
		    }

        });

</script>
<div id="commercialReceiptGridID"></div>
