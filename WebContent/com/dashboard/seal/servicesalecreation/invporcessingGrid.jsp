<%@page import="com.dashboard.seal.servicesalecreation.ClsServiceSaleCreationDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%ClsServiceSaleCreationDAO DAO = new ClsServiceSaleCreationDAO();%>
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
		    	    {name : 'voc_no' , type: 'String' },
		         	{name : 'date' , type: 'date' },
		       	    {name : 'invdate' , type: 'date' },
		       	    {name : 'doc_no' , type: 'String' },
		            {name : 'amount' , type: 'number' },
		         	{name : 'invno' , type: 'String' },  
		            {name : 'payterm' , type: 'String'}, 
					{name : 'desc1', type: 'String'   },
		    		{name : 'currency', type: 'String'   },
		    		{name : 'rate', type: 'number'   }, 
		    		{name : 'accname' , type: 'String' },
		            {name : 'account' , type: 'String' }, 
		            {name : 'delterm' , type: 'String' }, 
        ],
        localdata: data1,
       
       pager: function (pagenum, pagesize, oldpagenum) {
           // callback called when a page or page size is changed...tobeinvamt
       }
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
       height: 260,
       source: dataAdapter,
       columnsresize: true,
       //pageable: true,
       altRows: true,
       //sortable: true,
       selectionmode: 'singlerow',
       filtermode:'excel',
       filterable: true,
       showfilterrow: true,
       enabletooltips:true,       
       //showfilterrow: true,
       //pagermode: 'default',
       columns: [
	    	   { text: 'SL#', sortable: false, filterable: false, 
	               groupable: false, draggable: false, resizable: false,
	               datafield: 'sl', columntype: 'number', width: '4%',
	               cellsrenderer: function (row, column, value) {
	                   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	               }  
	             },	 
	             { text: 'Doc No', datafield: 'voc_no', width: '6%' },   
	             { text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true },
	             { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
	             { text: 'Inv No', datafield:'invno', width: '7%' },
	             { text: 'Inv Date', datafield: 'invdate', width: '7%',cellsformat:'dd.MM.yyyy' },
	             { text: 'Client', datafield:'accname' },
	             { text: 'Pay Terms', datafield:'payterm', width: '12%' },
	             { text: 'Del Terms', datafield:'delterm', width: '10%' },
	             { text: 'Description', datafield:'desc1', width: '13%' },        
	             { text: 'Currency', datafield:'currency', width:'5%' },    
	             { text: 'Rate', datafield:'rate', width:'5%',cellsformat:'d4',cellsalign:'right',align:'right' },
	             { text: 'Total', datafield:'amount', width:'9%',cellsformat:'d2',cellsalign:'right',align:'right' },
		 ]     
   });
   $('#overlay,#PleaseWait').hide();
   $("#jqxinvGrid").on('rowdoubleclick',function(event){ 
	   var rowindex =  event.args.rowindex;
	   var doc_no = $("#jqxinvGrid").jqxGrid('getcellvalue', rowindex, 'doc_no');       
	   $("#hiddocno").val(doc_no);   
	   $("#invno").val($("#jqxinvGrid").jqxGrid('getcellvalue', rowindex, 'invno'));       
	   $("#payterms").val($("#jqxinvGrid").jqxGrid('getcellvalue', rowindex, 'payterm')); 
	   $("#delterms").val($("#jqxinvGrid").jqxGrid('getcellvalue', rowindex, 'delterm')); 
	   $("#invdesc").val($("#jqxinvGrid").jqxGrid('getcellvalue', rowindex, 'desc1'));      
	   $("#detdiv").load("invdetailGrid.jsp?id="+1+"&nipurdoc="+doc_no);        
   });  
});    

</script>
<div id="jqxinvGrid"></div>     