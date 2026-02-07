<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.seal.servicecontract.ClsServiceContractDAO" %>
<%
        ClsServiceContractDAO DAO = new ClsServiceContractDAO();
        int trno=request.getParameter("trno")==null || request.getParameter("trno")==""?0:Integer.parseInt(request.getParameter("trno").trim().toString()); 
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
 %> 
 <style type="text/css">  
.colorClass1 {
	background-color: #cae8eb; 
}
</style>  
<script type="text/javascript">
$(document).ready(function () {     
             var onetimedata='<%=DAO.serviceGrid(id,trno)%>';  
             var num = 1; 
            // prepare the data
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
	                  		{name : 'billmethod', type: 'string'   },
                 ],
                 localdata: onetimedata,    
                
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
           var cellclassname = function(row, column, value, data){
        	   var amountlc = $('#jqxServiceOneGrid').jqxGrid('getcellvalue', row, "amountlc");
        	   if(parseFloat(amountlc) > 0) {   
        		    return "colorClass1";  
        	   } 
           } 
            
            $("#jqxServiceOneGrid").jqxGrid(
            {
                width: '100%',
                height: 170,
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                //filterable: true,
                //showfilterrow: true,
                filtermode:'excel',
                sortable:true,
                enabletooltips:true,
                columnsresize: true,
            	showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25, 
       
                columns: [
	                	{ text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname:cellclassname,
	                         groupable: false, draggable: false, resizable: false,
	                         datafield: 'sl', columntype: 'number', width: '4%',
	                         cellsrenderer: function (row, column, value) {
	                             return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	                         }  
	                    },	
	                    { text: 'doc no', datafield: 'doc_no', width: '5%',editable:false,hidden:true },
	                   	{ text: 'acno', datafield: 'acno', width: '5%',editable:false,hidden:true },
	                	{ text: 'billmethod', datafield: 'billmethod', width: '5%',editable:false,hidden:true },
	                   	{ text: 'servid', datafield: 'servid', width: '5%',editable:false,hidden:true },
	                   	{ text: 'Service Name', datafield: 'sername', width: '25%',editable:false,cellclassname:cellclassname },     
						{ text: 'Description', datafield: 'description',cellclassname:cellclassname},	
						{ text: 'Currency',datafield:'curr',width:'6%',editable:false,cellclassname:cellclassname,hidden:true},
						{ text: 'curid',datafield:'curid',width:'6%',editable:false,hidden:true},  
						{ text: 'Rate', datafield: 'rate', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',cellclassname:cellclassname,hidden:true },	
						{ text: 'Amount(Tra.)',datafield:'amounttr',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname},
						{ text: 'Amount(Loc.)', datafield: 'amountlc', width: '10%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname},	
			    ]               
            });  
   
            if($("#mode").val()=="view"){  
            	 $("#jqxServiceOneGrid").jqxGrid({ disabled: true});
            	 $("#jqxServiceYearlyGrid").jqxGrid({ disabled: true});  
            }
            $("#jqxServiceOneGrid").jqxGrid('addrow', null, {});  
            $('#jqxServiceOneGrid').on('celldoubleclick', function(event) { 
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
 		        if(datafield=="curr") {    
 		    	 	getcurr(rowBoundIndex,2);        
	    	    }
 		   });
            $('#jqxServiceOneGrid').on('cellvaluechanged', function(event) { 
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	var rate =  $("#txtrate1").val();
            	var amounttr =  $("#jqxServiceOneGrid").jqxGrid('getcellvalue',rowBoundIndex,'amounttr');
 		        if(datafield=="amounttr") {    
 		    	  if(rate == "" || rate == null || rate == "NaN"){
 		    		  rate = "0";
 		    	  }
 		    	  if(amounttr == "" || amounttr == null || amounttr == "NaN"){
 		    		  amounttr = "0";   
		    	  }
 		    	 $("#jqxServiceOneGrid").jqxGrid('setcellvalue',rowBoundIndex,'amountlc',parseFloat(rate)*parseFloat(amounttr));  
	    	    }  
 		   });
        });  
    </script>
    <div id="jqxServiceOneGrid"></div> 