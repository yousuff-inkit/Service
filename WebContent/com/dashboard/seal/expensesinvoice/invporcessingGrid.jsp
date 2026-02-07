<%@page import="com.dashboard.seal.expensesinvoice.ClsExpensesInvoiceDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%ClsExpensesInvoiceDAO DAO = new ClsExpensesInvoiceDAO();%>
<% int id = request.getParameter("id")==null || request.getParameter("id").trim().equals("")?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
 String brhid = request.getParameter("brhid")==null || request.getParameter("brhid").trim().equals("")?"0":request.getParameter("brhid").trim().toString();
 String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();			
 %>
<script type="text/javascript">
$(document).ready(function () {   	
    var data1 = '<%= DAO.invoiceGridLoad(id,brhid,todate)%>';           
    var num = 0;  
    var source =   
   { 
       datatype: "json",  
       datafields: [
			    	   {name : 'account' , type: 'number' },
			    	   {name : 'date' , type: 'String' },
			           {name : 'accountname' , type: 'String' },
			           {name : 'description' , type: 'String' },  
			           {name : 'amount' , type: 'number'}, 
					   {name : 'invamt' , type: 'number'},    
					   {name : 'tranid' , type: 'String'},
					   {name : 'costcode' , type: 'String' },
					   {name : 'brhid' , type: 'String' },
					   {name : 'costtype' , type: 'String' },
					   {name : 'taxamt' , type: 'number'},    
					   {name : 'taxper' , type: 'number'},    
					   {name : 'nettotal' , type: 'number'},     
					   {name : 'type' , type: 'String'},    
					   {name : 'refname' , type: 'String'},  
					   {name : 'cnttrno' , type: 'String'}, 
        ],
        localdata: data1,
   };
   
   var dataAdapter = new $.jqx.dataAdapter(source,
   		 {
       		loadError: function (xhr, status, error) {
               alert(error);    
               }
           }		
   );
   $("#jqxinvGrid").jqxGrid(  
   {
       width: '100%',
       height: 490,
       source: dataAdapter,
       columnsresize: true,
       //pageable: true,
       altRows: true,
       //sortable: true,
       selectionmode: 'checkbox', 
       filtermode:'excel',
       filterable: true,
       showfilterrow: true,
       editable:true,
       enabletooltips:true,  
       //showfilterrow: true,
       //pagermode: 'default',
       columns: [
	    	   { text: 'SL#', sortable: false, filterable: false,editable:false, 
	               groupable: false, draggable: false, resizable: false,
	               datafield: 'sl', columntype: 'number', width: '4%',
	               cellsrenderer: function (row, column, value) {
	                   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	               }  
	             },  
	             { text: 'Date', datafield: 'date', width: '7%',editable:false },
	             { text: 'Brhid', datafield: 'brhid', width: '1%',editable:false,hidden:true },
	             { text: 'Cost Type', datafield: 'costtype', width: '7%',editable:false },
	             { text: 'Cost Id', datafield: 'costcode', width: '7%',editable:false },
	             { text: 'Client', datafield: 'refname', width: '17%',editable:false },
	             { text: 'Account', datafield: 'account', width: '7%',editable:false },
				 { text: 'Account Name', datafield: 'accountname', width: '15%',editable:false },
				 { text: 'Amount',datafield:'amount',width:'9%',cellsformat:'d2',cellsalign:'right',align:'right',editable:false},
				 { text: 'Invoice Amount',datafield:'invamt',width:'9%',cellsformat:'d2',cellsalign:'right',align:'right'},
				 { text: 'Tax %',datafield:'taxper',width:'4%',cellsformat:'d2',cellsalign:'right',align:'right'},
				 { text: 'Tax Amount',datafield:'taxamt',width:'9%',cellsformat:'d2',cellsalign:'right',align:'right',editable:false},
				 { text: 'Net Total',datafield:'nettotal',width:'9%',cellsformat:'d2',cellsalign:'right',align:'right',editable:false},
				 { text: 'tranid', datafield: 'tranid', width: '7%',editable:false,hidden:true },  
				 { text: 'type', datafield: 'type', width: '7%',editable:false,hidden:true },  
				 { text: 'Description', datafield: 'description',editable:false, width: '27%'},  
				 { text: 'cnttrno', datafield: 'cnttrno', width: '7%',editable:false,hidden:true }, 
				 ]         
   });
   $('#overlay,#PleaseWait').hide();
   $("#jqxinvGrid").on('rowselect',function(event){  
	   var rowindexes = $('#jqxinvGrid').jqxGrid('getselectedrowindexes');
	   if(rowindexes!=""){ 
		   enable();   
	   }else{
		   disable();  
	   }     
   });
  
   $('#jqxinvGrid').on('cellvaluechanged', function(event) { 
   	var rowBoundIndex = event.args.rowindex;
   	var datafield = event.args.datafield;
   	var invamt =  $("#jqxinvGrid").jqxGrid('getcellvalue',rowBoundIndex,'invamt');
 	var taxper =  $("#jqxinvGrid").jqxGrid('getcellvalue',rowBoundIndex,'taxper');
 	var taxamt = 0.0, nettotal = 0.0;
        if(datafield=="invamt" || datafield=="taxper") {    
    	  if(taxper == "" || taxper == null || taxper == "NaN"){
    		  taxper = "0";
    	  }
    	  if(invamt == "" || invamt == null || invamt == "NaN"){
    		  invamt = "0";      
   	     }
    	  taxamt = (parseFloat(taxper)*parseFloat(invamt))/100;
    	  nettotal = invamt + taxamt;
    	 $("#jqxinvGrid").jqxGrid('setcellvalue',rowBoundIndex,'taxamt',taxamt.toFixed(2));  
    	 $("#jqxinvGrid").jqxGrid('setcellvalue',rowBoundIndex,'nettotal',nettotal.toFixed(2));  
	    }  
   });
});  

</script>
<div id="jqxinvGrid"></div>     