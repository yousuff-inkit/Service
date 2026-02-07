<%@page import="com.dashboard.procurment.purchaseorderprocess.ClsPurchaseOrderProcessDAO"%>
<% ClsPurchaseOrderProcessDAO searchDAO = new ClsPurchaseOrderProcessDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	 
  	String psrno = request.getParameter("psrno")==null?"NA":request.getParameter("psrno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
  	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
  	String locid = request.getParameter("locid")==null?"0":request.getParameter("locid").trim();
  	String hidbrand = request.getParameter("hidbrand")==null?"0":request.getParameter("hidbrand").trim();
	String hidtype = request.getParameter("hidtype")==null?"0":request.getParameter("hidtype").trim();
	String hidproduct = request.getParameter("hidproduct")==null?"0":request.getParameter("hidproduct").trim();
	String hidcat = request.getParameter("hidcat")==null?"0":request.getParameter("hidcat").trim();
	String hidsubcat = request.getParameter("hidsubcat")==null?"0":request.getParameter("hidsubcat").trim();
	String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
	String hidept = request.getParameter("hidept")==null?"0":request.getParameter("hidept").trim();
	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
	String cldocno = request.getParameter("hidcldocno")==null?"0":request.getParameter("hidcldocno").trim();
	String acno = request.getParameter("hidacno")==null?"0":request.getParameter("hidacno").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
   
 %> 
   
<style type="text/css">

 .op
  {
      background-color:#FCEFCE;
  }
  
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .greyClass
    {
        background-color: #e6e6e6;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
  .sl
  {
      background-color:#FCEFCE;
  }
  
 .prd
  {
      background-color:#ffe0cc;
  }
  
 .pr
  {
      background-color:#EBEBC1;
  }
  
    
   .advanceClass5
  {
      background-color: #FCC4F7;
  }
   .advanceClass4
  {
       background-color: #efd4f7;
  }
   .advanceClass3
  {
     
      background-color: #C4F3F5        ;
  }
   .advanceClass2
  {
      background-color:/*  #bed9f4; */ #CFECF1    ;  
  }
   .advanceClass1
  {
      background-color:   #eff4be;  ;
  }
    .balanceClass
  {
      background-color: #E0F8F1;
  }
    
</style>     
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
var datas;
 if(temp4!='NA')
{ 
	 datas='<%=searchDAO.stocklist(barchval,statusselect,psrno,load,locid,hidbrand,hidtype,hidproduct,hidcat,hidsubcat,branchid,hidept,type,cldocno,acno,fromdate,todate)%>'; 
} 
else
{ 
	datas;
}  

$(document).ready(function () {
	var rendererstring1=function (aggregates){
    	var value=aggregates['sum1'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
    }    
   	var rendererstring=function (aggregates){
   		var value=aggregates['sum'];
		if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN"){
			value=0.0;
	   	}
   		return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   	}
      
    var source =
    {
        datatype: "json",
        datafields: [   
					 
						{name : 'qty', type: 'number'  },
						{name : 'foc', type: 'number'  },
						{name : 'extfoc', type: 'number'  },
						{name : 'psrno', type: 'number'  },
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'amount', type: 'number'  },
						{name : 'brandname', type: 'String'  },
						{name : 'unit', type: 'String'  },
						{name : 'expry', type: 'String'  },
						{name : 'lastpurate', type: 'String'  },
						{name : 'price', type: 'number'  },
						{name : 'department', type: 'String'  },
						{name : 'stkqty', type: 'number'  },
						{name : 'reorderlevel', type: 'number'  },
						{name : 'reorderqty', type: 'number'  },
						{name : 'stdpack', type: 'number'  },
						{name : 'leaddays', type: 'String'  },
						{name : 'saqty', type: 'number'  },
						{name : '3mavg', type: 'number'  },
						{name : '6mavg', type: 'number'  },
						{name : '12mavg', type: 'number'  },
						{name : 'local', type: 'number'  },
						{name : 'export', type: 'number'  },
						{name : 'avgsaqty', type: 'number'  },
						{name : 'poqty', type: 'number'  },
						{name : 'rsvqty', type: 'number'  },
						{name : 'soqty', type: 'number'  },
						{name : 'netqty', type: 'number'  },
						{name : 'total', type: 'number'  },
						{name : 'shipqty5', type: 'number'  },
						{name : 'shipqty15', type: 'number'  },
						{name : 'shipqty30', type: 'number'  },
						{name : 'shiptot', type: 'number'  },
						{name : 'stktotal', type: 'number'  }
						
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
    
    $("#stocklistgrid").jqxGrid(
    {
        width: '98%',
        height: 550,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        enableAnimations: true,
        filtermode:'excel',
        sortable:true,
        editable:true,
		enabletooltips:true,        
        selectionmode: 'checkbox',
        filterable:true,
        showfilterrow: true,
        pagermode: 'default',
        statusbarheight: 25,
     
        columns: [   
            { text: 'SL#', sortable: false, filterable: false, pinned:true, editable: false,
                groupable: false, draggable: false, resizable: false,
                datafield: 'sl', columntype: 'number', width: '3%',
                cellsrenderer: function (row, column, value) {
                    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }  
              },	
          	{ text: 'Psrno', datafield: 'psrno',editable:false,  width: '6%',hidden:true, pinned:true}, 
     	    { text: 'Product Id', datafield: 'productid',editable:false,  width: '6%', pinned:true }, 
     	    { text: 'Product Name', datafield: 'productname',editable:false, pinned:true},
     	   	{ text: 'Brand Name', datafield: 'brandname', width: '10%',editable:false , pinned:true},
     	   	{ text: 'UOM', datafield: 'unit', width: '3%',editable:false , pinned:true},
     	   	{ text: 'Std Pack', datafield: 'stdpack',  width: '5%',cellsformat:'d2',cellsalign:'right',align:'right',editable:false  },
     	   	{ text: 'Stock Qty', datafield: 'stkqty',  width: '5%',cellsformat:'d2',cellsalign:'right',align:'right',editable:false  },
     	    { text: 'Reorder Level', datafield: 'reorderlevel',  width: '5%',cellsformat:'d2',cellsalign:'right',align:'right'},
			{ text: 'Reorder Qty', datafield: 'reorderqty',  width: '5%',cellsformat:'d2',cellsalign:'right',align:'right'},
			{ text: 'Net Qty', datafield: 'netqty',  width: '5%',cellsformat:'d2',cellsalign:'right',align:'right'},
     	    { text: 'Lead Days', datafield: 'leaddays',  width: '5%',editable:false},
     	    { text: 'New Ord Qty', datafield: 'qty',  width: '5%' ,cellsformat:'d2',cellsalign:'right',align:'right', cellclassname: 'advanceClass5' },
			{ text: 'Foc', datafield: 'foc',  width: '5%' ,cellsformat:'d2',cellsalign:'right',align:'right', cellclassname: 'advanceClass5' ,hidden:true},
			{ text: 'Ext_Foc', datafield: 'extfoc',  width: '5%' ,cellsformat:'d2',cellsalign:'right',align:'right' , cellclassname: 'advanceClass5',hidden:true },
     	    { text: 'Last Purchase', datafield: 'lastpurate', width: '7%',editable:false,cellsalign:'right',align:'right' },
     	    { text: 'New Ord Price', datafield: 'price', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' },
     	    { text: 'Total', datafield: 'total', width: '7%',cellsformat:'d2',editable:false,cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
     	    { text: 'Expiry', datafield: 'expry', width: '7%',editable:false, hidden:true},
     	    { text: 'Sales Qty', datafield: 'saqty', width: '6%',editable:false,cellsalign:'right',align:'right' },
     	    { text: 'Av. Sales Montly', datafield: 'avgsaqty',hidden:true, width: '8%',editable:false,cellsalign:'right',align:'right' },
     	    { text: 'PO Pending', datafield: 'poqty', width: '6%',editable:false,cellsalign:'right',align:'right' },
     	    { text: 'SO Pending', datafield: 'soqty', width: '6%',editable:false,cellsalign:'right',align:'right' },
			{ text: 'Department', datafield: 'department',editable:false, width: '10%' },
			{ text: '3M- AVG', datafield: '3mavg', width: '6%',editable:false,cellsalign:'right',align:'right'},
     	    { text: '6M- AVG', datafield: '6mavg', width: '6%',editable:false,cellsalign:'right',align:'right'},
     	    { text: '12M- AVG', datafield: '12mavg', width: '6%',editable:false,cellsalign:'right',align:'right'},
			{text: '<5', datafield: 'shipqty5', width: '6%',editable:false,cellsalign:'right',align:'right' ,columngroup:'pointransit'},
			{text: '5 - 15', datafield: 'shipqty15', width: '6%',editable:false,cellsalign:'right',align:'right' ,columngroup:'pointransit'},
			{text: '15 - 30', datafield: 'shipqty30', width: '6%',editable:false,cellsalign:'right',align:'right' ,columngroup:'pointransit'},
			{ text: 'Reserve', datafield: 'rsvqty',editable:false, width: '6%'},
			{ text: 'Total', datafield: 'shiptot',editable:false,  width: '6%',editable:false,cellsalign:'right',align:'right'},
			{text: 'Export', datafield: 'export', width: '6%',editable:false,cellsalign:'right',align:'right' ,columngroup:'busorder'},
			{text: 'Local', datafield: 'local', width: '6%',editable:false,cellsalign:'right',align:'right' ,columngroup:'busorder'},
			{text: 'Total Stock', datafield: 'stktotal', width: '6%',editable:false,cellsalign:'right',align:'right'}
				]
				,columngroups: 
	                     [
	                       { text: 'Sales', align: 'center', name: 'sales'},
	                       { text: 'In Transit', align: 'center', name: 'intransit'},
	                       {text: 'PO In Transit', align: 'center', name: 'pointransit'},
	                       {text: 'Buss. Order', align: 'center', name: 'busorder'}
	                       
	                    
	                     ]
    
    });
    $("#overlay, #PleaseWait").hide();
    $('.load-wrapp').hide();
    
    $("#stocklistgrid").on('rowselect', function (event) {
    	 var rowBoundIndex = event.args.rowindex;
    	 valchange(rowBoundIndex);
    });

    
	$("#stocklistgrid").on('cellvaluechanged', function (event){
	 	var datafield = event.args.datafield;
	    var rowBoundIndex = event.args.rowindex;
		    
	    if(datafield=="qty" || datafield=="price")
	    {
	    	valchange(rowBoundIndex);
	    }
 	});
    
});

function valchange(rowBoundIndex)
{
    var qty=parseFloat($('#stocklistgrid').jqxGrid('getcellvalue',rowBoundIndex,'qty'));
	var price=parseFloat($('#stocklistgrid').jqxGrid('getcellvalue',rowBoundIndex,'price'));
	   
	var total=0;
	if(qty>0 && price>0){
		total = (qty*price).toFixed(2);
	}
	$('#stocklistgrid').jqxGrid('setcellvalue',rowBoundIndex,'total',total)
}



</script>
<div id="stocklistgrid"></div>