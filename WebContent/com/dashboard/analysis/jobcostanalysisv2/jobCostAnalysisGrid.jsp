<%@page import="com.dashboard.analysis.jobcostanalysisv2.ClsJobCostAnalysisDAO" %>
<% ClsJobCostAnalysisDAO DAO=new ClsJobCostAnalysisDAO(); %>  
<%  String branch = request.getParameter("branch")==null?"NA":request.getParameter("branch").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String contracttype = request.getParameter("contracttype")==null?"0":request.getParameter("contracttype").trim();
  	String contract = request.getParameter("contract")==null?"0":request.getParameter("contract").trim();
  	String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
  	String salesmandocno = request.getParameter("salesmandocno")==null?"0":request.getParameter("salesmandocno").trim();
  	String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
  	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
%> 
       
<style type="text/css">
  .variationClass
  {
      background-color: #DAF7A6;
  }
  .actualClass
  {
      background-color: #FFEBEB;
  }
  .incomeClass
  {
     background-color: #F5EEF8;
  }
  .estimationClass
  {
     background-color: #EBF5FB;
  }
</style>
 
<script type="text/javascript">
	var datas;    
 	$(document).ready(function () {
 		datas= '<%=DAO.jobCostAnalysisGridLoading(branch,fromdate,todate,contracttype,contract,cldocno,salesmandocno,type,check)%>';  
 		 
 		var rendererstring=function (aggregates){     
           	var value=aggregates['sum'];
           	if(typeof(value) == "undefined"){
           		value=0.00;
           	}
           	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
           }

	    var source =
	    {
	        datatype: "json",
	        datafields: [   
	                     {name :'jobnumber', type:'int' },
	                     {name :'client', type:'String' },
	                     {name :'startdate', type:'date' },
					     {name :'enddate', type: 'date'  },
						 {name :'status', type:'String' },
						 {name :'salesperson', type:'String' }, 
	                     {name :'incomeamount', type:'number' },
	                     {name :'actualmaterialamount', type:'String' }, 
						 {name :'actualprofit', type:'number'},
						 {name : 'currency', type: 'String' },
  					     {name : 'rate', type: 'number' },
  					     {name : 'desc1', type: 'String' },
  					     {name : 'brhid', type: 'String' },
  						
					    ],
					    localdata: datas,
	        
	        
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
    
   $("#jobCostGridID").jqxGrid(
    {
        width: '99%',
        height: 510,  
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        sortable:true,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 21,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        enabletooltips:true,   
        columns: [    
					{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,datafield: '',
					    columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }    
						},
                     { text: 'Job No',datafield: 'jobnumber', width: '4%' },
                     { text: 'Branch', datafield: 'brhid',  width: '5%' },
            	     { text: 'Client',datafield: 'client',width:'16%'  },
         			 { text: 'Start Dt',datafield: 'startdate', cellsformat: 'dd.MM.yyyy', width: '6%' },
         		     { text: 'End Dt', datafield: 'enddate', cellsformat: 'dd.MM.yyyy',  width: '6%' },
                     { text: 'Status', datafield: 'status',  width: '5%' },
           	         { text: 'Sales person', datafield: 'salesperson',  width: '8%' }, 
           	      	 { text: 'Description',  width: '15%', datafield: 'desc1', },
           	      	 { text: 'Currency', datafield: 'currency', width: '5%' },
					 { text: 'Rate', datafield: 'rate',width: '5%' ,cellsalign:'right',align:'right',cellsformat:'d4'}, 
					 { text: 'Income',datafield: 'incomeamount', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'incomeClass' },
      		     	 { text: 'Expeneses',datafield: 'actualmaterialamount', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'actualClass' },
        	         { text: 'Profit', datafield: 'actualprofit',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'actualClass' },
        	        
           	       ],
    });
    $("#overlay, #PleaseWait").hide();
   
});

</script>
<div id="jobCostGridID"></div>