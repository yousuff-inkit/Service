<%@page import="com.dashboard.seal.contractrenewal.ClscontractrenewalDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%
	ClscontractrenewalDAO DAO = new ClscontractrenewalDAO();
%>
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
		    	    {name : 'doc_no' , type: 'number' },
		          	{name : 'date' , type: 'date' },
		        	{name : 'validfrom' , type: 'date' },
		        	{name : 'validupto' , type: 'date' },
		            {name : 'cldocno' , type: 'String' },
		          	{name : 'refname' , type: 'String' },  
		            {name : 'tr_no' , type: 'number'}, 
					{name : 'curr', type: 'string'   },
		     		{name : 'curid', type: 'string'   },
		     		{name : 'vattype', type: 'string'   }, 
		     		{name : 'total' , type: 'number' },
		     		{name : 'rate' , type: 'number' },
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
       height: 250,
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
	             { text: 'Doc No', datafield: 'doc_no', width: '10%' },
				 { text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
				 { text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				 { text: 'Type', datafield: 'vattype', width: '7%' },
				 { text: 'Name', datafield: 'refname'},
				 { text: 'trno', datafield: 'tr_no', width: '4%',hidden:true },
				 { text: 'rate', datafield: 'rate',cellsformat:'d4', width: '4%',hidden:true },  
			     { text: 'Currency',datafield:'curr',width:'6%'},   
			     { text: 'curid',datafield:'curid',width:'6%',hidden:true},  
			     { text: 'Start Date', datafield: 'validfrom', width: '8%',cellsformat:'dd.MM.yyyy' },
			     { text: 'End Date', datafield: 'validupto', width: '8%',cellsformat:'dd.MM.yyyy' },
			     { text: 'Total',datafield:'total',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
		 ]  
   });
   $('#overlay,#PleaseWait').hide();
   $("#jqxinvGrid").on('rowdoubleclick',function(event){
	   var rowindex =  event.args.rowindex;
	   var trno = $("#jqxinvGrid").jqxGrid('getcellvalue',rowindex,'tr_no');
	   $("#hidtrno").val(trno);     
	   $("#hiddocno").val($("#jqxinvGrid").jqxGrid('getcellvalue',rowindex,'doc_no')); 
	   var todate = $("#todate").val();  
	   $("#detdiv").load("contractrenewaldetailGrid.jsp?id="+1+"&trno="+trno+"&todate="+todate);      
   });
});  

</script>
<div id="jqxinvGrid"></div>     