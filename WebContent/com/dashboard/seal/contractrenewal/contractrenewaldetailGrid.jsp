<%@page import="com.dashboard.seal.contractrenewal.ClscontractrenewalDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%
	ClscontractrenewalDAO DAO = new ClscontractrenewalDAO();
%>
<% int id = request.getParameter("id")==null || request.getParameter("id").trim().equals("")?0:Integer.parseInt(request.getParameter("id").trim().toString());
   int trno = request.getParameter("trno")==null || request.getParameter("trno").trim().equals("")?0:Integer.parseInt(request.getParameter("trno").trim().toString());
   String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();%>
<script type="text/javascript">
$(document).ready(function () { 	
	var data2 = '<%= DAO.detailGridLoad(id,trno,todate)%>';          
    var num = 0; 
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
		    		{name : 'description', type: 'String'  },
		          	{name : 'sername', type: 'String'  },
					{name : 'amounttr', type: 'number'  },
		      		{name : 'amountlc', type: 'number'  },
					{name : 'curr', type: 'string'   },
		      		{name : 'rate', type: 'number'  },
		      		{name : 'doc_no', type: 'string'  },
		      		{name : 'acno', type: 'string'  },  
		      		{name : 'curid', type: 'string'   },
		      		{name : 'servid', type: 'string'   },   
		      	    {name : 'taxamt' , type: 'number'},    
				    {name : 'taxper' , type: 'number'},    
				    {name : 'nettotal' , type: 'number'}, 
				     						
        ],
        localdata: data2,
       
       
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
   $("#jqxinvdetGrid").jqxGrid(
   {
       width: '100%',
       height: 250,
       source: dataAdapter,
       columnsresize: true,
       editable: true,
       altRows: true,
       //sortable: true,
      /*  selectionmode: 'checkbox',  */     
       filtermode:'excel',
       filterable: true,
       showfilterrow: true,
       showaggregates: true,
       showstatusbar:true,
       rowsheight:25,
       statusbarheight:25,
       //pagermode: 'default',
       columns: [
	    	   { text: 'SL#', sortable: false, filterable: false, editable: false,
	               groupable: false, draggable: false, resizable: false,
	               datafield: 'sl', columntype: 'number', width: '4%',
	               cellsrenderer: function (row, column, value) {
	                   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	               }  
	             },	 
	           { text: 'doc no', datafield: 'doc_no', width: '5%',editable:false,hidden:true },
         	   { text: 'acno', datafield: 'acno', width: '5%',editable:false,hidden:true },
         	   { text: 'servid', datafield: 'servid', width: '5%',editable:false,hidden:true },
         	   { text: 'Service Name', datafield: 'sername', width: '17%',editable:false },     
			   { text: 'Description', datafield: 'description', editable: false},	
			   { text: 'Currency',datafield:'curr',width:'5%',editable:false},
			   { text: 'curid',datafield:'curid',width:'6%',editable:false,hidden:true},    
			   { text: 'Rate', datafield: 'rate', width: '5%', hidden:true,cellsformat:'d4',cellsalign:'right',align:'right'  },	
			   { text: 'Amount(Tra.)',datafield:'amounttr',width:'8%', editable: false,cellsformat:'d2',cellsalign:'right',align:'right',aggregatesrenderer:rendererstring1 },
			   { text: 'Amount(Loc.)', datafield: 'amountlc', hidden:true, width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },	
			   { text: 'Tax %',datafield:'taxper',width:'4%',cellsformat:'d2',cellsalign:'right',align:'right'},
			   { text: 'Tax Amount',datafield:'taxamt',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right',editable:false},
			   { text: 'Net Total',datafield:'nettotal',width:'9%',cellsformat:'d2',cellsalign:'right',align:'right',editable:false},
		 ]         
   });
   $('#jqxinvdetGrid').on('cellvaluechanged', function(event) { 
	   	var rowBoundIndex = event.args.rowindex;
	   	var datafield = event.args.datafield;
	   	
	   	var rate =  $("#jqxinvdetGrid").jqxGrid('getcellvalue',rowBoundIndex,'rate');
	 	var amounttr =  $("#jqxinvdetGrid").jqxGrid('getcellvalue',rowBoundIndex,'amounttr');
	 	var taxper =  $("#jqxinvdetGrid").jqxGrid('getcellvalue',rowBoundIndex,'taxper');
	 	var taxamt = 0.0, nettotal = 0.0, amountlc = 0.0;  
	 	
	    if(datafield=="rate") {    
	    	  if(rate == "" || rate == null || rate == "NaN"){
	    		  rate = "0";
	    	  }
	    	  if(amounttr == "" || amounttr == null || amounttr == "NaN"){
	    		  amounttr = "0";      
	   	      }  
	    	  amountlc = parseFloat(rate)*parseFloat(amounttr);     
	    	 $("#jqxinvdetGrid").jqxGrid('setcellvalue',rowBoundIndex,'amountlc',amountlc.toFixed(2));  
		}
	    
	    if(datafield=="taxper") {    
	    	  if(taxper == "" || taxper == null || taxper == "NaN"){
	    		  taxper = "0";
	    	  }
	    	  if(amounttr == "" || amounttr == null || amounttr == "NaN"){
	    		  amounttr = "0";      
	   	      }    
	    	  taxamt = (parseFloat(taxper)*parseFloat(amounttr))/100;
	    	  nettotal = parseFloat(amounttr) + taxamt;  
	    	 $("#jqxinvdetGrid").jqxGrid('setcellvalue',rowBoundIndex,'taxamt',taxamt.toFixed(2));  
	    	 $("#jqxinvdetGrid").jqxGrid('setcellvalue',rowBoundIndex,'nettotal',nettotal.toFixed(2));  
		 }   
	 });
});  

</script>
<div id="jqxinvdetGrid"></div>       