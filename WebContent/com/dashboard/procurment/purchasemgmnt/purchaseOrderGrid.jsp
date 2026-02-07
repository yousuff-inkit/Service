<%@page import="com.dashboard.procurment.purchasemgmnt.ClsPurchasemgmntDAO"%>
<%
   ClsPurchasemgmntDAO DAO= new ClsPurchasemgmntDAO();        
 %>
 <%
 
    String chk = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    String salesmanid = request.getParameter("salesmanid")==null?"0":request.getParameter("salesmanid").trim();
 	String branchval = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
  	String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
    String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
    String areaid =request.getParameter("areaid")==null?"0":request.getParameter("areaid").toString();
    String divname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
 %> 
           	  
<style type="text/css">
     .colorClass2 {  
       background-color: #7ffaa6;   
     }
    .colorClass1 {
       background-color: #B0E2FF; 
    }
</style>

<script type="text/javascript">
 var temp4='<%=chk%>';
 var prorddata,enqfollowupexcel;        
 if(temp4=="1"){
	 prorddata='<%=DAO.enquirylistsearch(session, branchval, fromdate, todate, chk, divname) %>'; 
 }else{
	
 }

$(document).ready(function () { 
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [     
        	{name : 'doc_no', type: 'int'  },
			
			   {name : 'voc_no', type: 'int'  },
				{name : 'date', type: 'date'  },
				{name : 'refno', type: 'String'  },
				{name : 'dtype', type: 'String'  },
				{name : 'acno', type: 'number'  },
				{name : 'productid', type: 'string'    },
     		{name : 'productname', type: 'string'    },
     		{name : 'account', type: 'String'  },      
				{name : 'acname', type: 'String'  }, 
				{name : 'unit', type: 'String'    },
				{name : 'qty', type: 'number'    },
				{name : 'prodoc', type: 'number'    },
				{name : 'unitdocno', type: 'number'    },
				{name : 'total', type: 'number'    },
				{name : 'psrno', type: 'number'    },
				
			  	{name : 'qutval', type: 'number' },
				{name : 'saveqty', type: 'number'},  
				
				{name : 'checktype', type: 'number' },
		        {name : 'pqty', type: 'number'    },  
				
		     	{name : 'proid', type: 'string'    },
     		{name : 'proname', type: 'string'    },
     		{name : 'specid', type: 'string'  },
     		
     		 {name : 'foc', type: 'number'    },  
     		 {name : 'out_qty', type: 'number'    },  
     		 {name : 'balqty', type: 'number'    },  
     		 
     		 {name : 'unitprice', type: 'number'    },   
     		 
     		 {name : 'refrowno', type: 'int'    },  
     		 
     		 {name : 'discount', type: 'number'    },  
     		 {name : 'nettaxamount', type: 'number'    },  
     		 
     		 {name : 'disper', type: 'number'    },  
     		 {name : 'brandname', type: 'string'    },    
     		 {name : 'brhid', type: 'string'    },    
              
     		 {name : 'branchname', type: 'string'    }, 
     		 {name : 'tr_no', type: 'number'    }, 
     		 {name : 'rrefno', type: 'number'    }, 
			
			
						],
				    localdata: prorddata,
        
        
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
  
    $("#purchaseordgrid").jqxGrid(
    {
        width: '99%',
        height: 400,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        sortable:true,
        selectionmode: 'checkbox',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        enabletooltips: true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '2%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }    
                    },
                    { text: 'Doc No',datafield: 'voc_no', width: '3%' },
        			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},
        			 { text: 'Ref No',datafield: 'refno', width: '3%' },
        			 { text: 'Branch',datafield: 'branchname', width: '6%' },
        			 { text: 'Type',datafield: 'dtype', width: '7%' },
        		     { text: 'Account', datafield: 'account',  width: '4%'  },
                    { text: 'Account Name', datafield: 'acname',  width: '9%'  },
          	         { text: 'Product Id', datafield: 'productid',  width: '8%' }, 
          	         { text: 'Product Name', datafield: 'productname',  width: '10%' },
          	         { text: 'Unit', datafield: 'unit',  width: '3%',cellsformat:'d2' },
          	         { text: 'Total Qty', datafield: 'qty',  width: '5%' ,cellsformat:'d2'},
          	         { text: 'Out Qty', datafield: 'out_qty',  width: '5%' ,cellsformat:'d2'},
		           	 { text: 'Balance Qty', datafield: 'balqty',  width: '5%' ,cellsformat:'d2',aggregates: ['sum1']},
		           	 { text: 'Unit Price', datafield: 'unitprice',  width: '4%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum']},
		           	 { text: 'Total', datafield: 'total',  width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum']},
		           	 { text: 'Discount %', datafield: 'disper',  width: '4%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum']},
		           	 { text: 'Discount', datafield: 'discount',  width: '4%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum']},
		             { text: 'Net Total', datafield: 'nettaxamount',  width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum']},
			 ]
    });
    $('.load-wrapp').hide();
  /*   var ven='';
    var temp='';
    $('#purchaseordgrid').on('rowselect', function (event) {
    	var datafield = event.args.datafield;
	    var rowBoundIndex = event.args.rowindex;
	    var rowsCount = $('#purchaseordgrid').jqxGrid('getrows').length;
	    var selectedIndexes = $('#purchaseordgrid').jqxGrid('getselectedrowindexes');
	    var selectedRowCount = selectedIndexes.length;
        ven= $('#purchaseordgrid').jqxGrid('getcellvalue', rowBoundIndex, "account");
        if(temp=='' || selectedRowCount==0 ){
        	temp=ven;
        }else{
        	if(temp!=$('#purchaseordgrid').jqxGrid('getcellvalue', rowBoundIndex, "account")){
        		 $.messager.alert('Message','Please Select Same Vendor  ','warning');  
             	$('#purchaseordgrid').jqxGrid('unselectrow', rowBoundIndex);

        	}
        }
        
        if (event.args.rowindex.length === rowsCount) {
            for(var i=0;i<rowsCount;i++){
            	 ven= $('#purchaseordgrid').jqxGrid('getcellvalue', i, "account");
                 if(temp=='' || selectedRowCount==0 ){
                 	temp=ven;
                 }else{
                 	if(temp!=$('#purchaseordgrid').jqxGrid('getcellvalue', i, "account")){
                 		 $.messager.alert('Message','Please Select Same Vendor  ','warning');  
                      	$('#purchaseordgrid').jqxGrid('unselectrow', i);

                 	}
                 }
            }
        }
        
    });
    
    $('#purchaseordgrid').on('rowunselect', function (event) {
    	var datafield = event.args.datafield;
	    var rowBoundIndex = event.args.rowindex;
	    var rowsCount = $('#purchaseordgrid').jqxGrid('getrows').length;
	    var selectedIndexes = $('#purchaseordgrid').jqxGrid('getselectedrowindexes');
	    var selectedRowCount = selectedIndexes.length;
		if(selectedRowCount==0 || event.args.rowindex.length==0 ){
			ven='';
			temp='';
		}
	
		
    });
  ; */
    
    var rowIndicesToUnselect=0;
    $('#purchaseordgrid').on('rowselect', function (event) {
    	var ven='';
        var temp='';
        var tempbr='';
        var br='';
    	var datafield = event.args.datafield;
	    var rowBoundIndex = event.args.rowindex;
	    //alert("asd");
	    var rowsCount = $('#purchaseordgrid').jqxGrid('getrows').length;
	    var selectedIndexes = $('#purchaseordgrid').jqxGrid('getselectedrowindexes');
	    var selectedRowCount = selectedIndexes.length;
        ven= $('#purchaseordgrid').jqxGrid('getcellvalue', rowBoundIndex, "account");
        br= $('#purchaseordgrid').jqxGrid('getcellvalue', rowBoundIndex, "brhid");
        if(temp=='' || selectedRowCount==0 ){
        	temp=ven;
        }else{
        	if(temp!=ven){
        		 $.messager.alert('Message','Please Select Same Vendor  ','warning');  
             	$('#purchaseordgrid').jqxGrid('unselectrow', rowBoundIndex);
             	
        	}
        }
        
        if(tempbr=='' || selectedRowCount==0){
        	tempbr=br;
        }else{
        	 if(tempbr!=br){
       		 $.messager.alert('Message','Please Select Same Branch  ','warning');  
            	$('#purchaseordgrid').jqxGrid('unselectrow', rowBoundIndex);
            	
       		}
        }
        
        var invalidarray=new Array();
    	var invalidbrarray=new Array();
        if(selectedRowCount>1){
        	var firstvendor='';
        	for(var i=0;i<selectedIndexes.length;i++){
        		if(i==0){
        			firstvendor=$('#purchaseordgrid').jqxGrid('getcellvalue', selectedIndexes[i], "account");
        		}
        		else{
        			
        			var currentvendor=$('#purchaseordgrid').jqxGrid('getcellvalue', selectedIndexes[i], "account");
        			if(firstvendor!=currentvendor){
            			invalidarray.push(selectedIndexes[i]);
            		}	
        		}
        		
        	}
        }
        if(selectedRowCount>1){
        	var firstbrch='';
        	for(var i=0;i<selectedIndexes.length;i++){
        		if(i==0){
        			firstbrch=$('#purchaseordgrid').jqxGrid('getcellvalue', selectedIndexes[i], "brhid");
        		}
        		else{
        			
        			var currentbrch=$('#purchaseordgrid').jqxGrid('getcellvalue', selectedIndexes[i], "brhid");
        			if(firstbrch!=currentbrch){
        				invalidbrarray.push(selectedIndexes[i]);
            		}	
        		}
        		
        	}
        }
        if(invalidarray.length>0){
			$.messager.alert('Message','Please Select Same Vendor  ','warning');

        	for(var i=0;i<invalidarray.length;i++){
            	
            	$('#purchaseordgrid').jqxGrid('unselectrow', invalidarray[i]);
            }
        }
        if(invalidbrarray.length>0){
			$.messager.alert('Message','Please Select Same Branch  ','warning');

        	for(var i=0;i<invalidbrarray.length;i++){
            	
            	$('#purchaseordgrid').jqxGrid('unselectrow', invalidbrarray[i]);
            }
        }
        
        ven='';
      	temp='';
      	br='';
      	tempbr='';
    });
   

});
</script>
<div id="purchaseordgrid"></div>