<%@page import="com.dashboard.procurment.stockmgmt.ClsStockMgmtDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.stockLedger.ClsStockLedger" %>
<%   
	String hidbrand = request.getParameter("hidbrand")==null?"0":request.getParameter("hidbrand").trim();
	String hidtype = request.getParameter("hidtype")==null?"0":request.getParameter("hidtype").trim();
	String hidproduct = request.getParameter("hidproduct")==null?"0":request.getParameter("hidproduct").trim();
	String hidcat = request.getParameter("hidcat")==null?"0":request.getParameter("hidcat").trim();
	String hidsubcat = request.getParameter("hidsubcat")==null?"0":request.getParameter("hidsubcat").trim();
	String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
	String hidept = request.getParameter("hidept")==null?"0":request.getParameter("hidept").trim();
	String fromDate = request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").trim();
	String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();

	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
	//ClsStockLedger dao= new ClsStockLedger();
	ClsStockMgmtDAO dao=new ClsStockMgmtDAO();
%>
<style type="text/css">
 
 
  

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
   .advanceClass
  {
      background-color: #FBEFF5;
  }
  .balanceClass
  {
      background-color: #E0F8F1;
  }
  .unappliedClass
  {
     color: #FF0000;
  }     
  /* Custom class to apply blur effect */
.blur-row {
    filter: blur(5px);
    opacity: 0.6;
}
.selected-row {
    background-color: #black; /* Bright green for better visibility */
    color: white; /* Change text color for contrast */
    border: 2px solid #FFFFFF; /* White border */
}
.jqx-grid-row:hover {
    background-color: #f1f1f1; /* Light gray for hover */
}
</style>
<script type="text/javascript">
    
       var partdata;
       var type='<%=type%>';
    	
	  	if(type=='1'){ 
	  	<%-- 	dat1='<%=dao.stockLedgerSummary1(session,hidbrand,fromDate,toDate,hidtype,hidcat,hidsubcat,hidproduct,branchid,hidept,load)%>'; --%>  
	  		partdata='<%=dao.stockLedgerSummary(session,hidbrand,fromDate,toDate,hidtype,hidcat,hidsubcat,hidproduct,branchid,hidept,load)%>';  
	  	} 
		else{
			partdata = [];
	}
	  	console.log("type: " + type);
	    console.log(partdata);
	    var blurredRowIndex = -1; // To store the row index that was double-clicked
	    var selectedRowIndex = -1; // To store the row index that was selected
$(document).ready(function () {
    // prepare the data
	  var rendererstring1=function (aggregates){
       	var value=aggregates['sum1'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
       }    
    
 var rendererstring=function (aggregates){
 	var value=aggregates['sum'];
	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	   {
		value=0.0;
	   }
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
     var rendererstring2=function (aggregates){
	 	var value=aggregates['sum'];
		if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
		   {
			value=0.0;
		   }
	 	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	 }
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     
                  
                     
                        {name : 'pno', type: 'String'  },
                        {name : 'pname', type: 'String'  },
                        {name : 'opnqty', type: 'number'  },
                        {name : 'opnval', type: 'number'  },
						{name : 'inqty', type: 'number'  },
						{name : 'inval', type: 'number'  },
						{name : 'isqty', type: 'number'  },
						{name : 'isval', type: 'number'  },
						{name : 'balqty', type: 'number'  },
						{name : 'balval', type: 'number'  },
						{name : 'stv', type: 'number'  },
						{name : 'cpu', type: 'number'  },
						{name : 'psrno', type: 'String'},
						{name : 'specid', type: 'String'},
						
						
						],
				    localdata: partdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
        if (row === blurredRowIndex) {
            return "blur-row";  // Blur the row when double-clicked
        }
        if (row === selectedRowIndex) {
            return "selected-row";  // Apply the selected row style
        }
        
        // Other cell-specific styles (if any)
        if (column === 'opnqty' || column === 'opnval') {
            return "balanceClass";  // Example: apply balanceClass to specific columns
        }
        
        // You can add more conditions for other specific columns
        if (column === 'pno') {
            return "advanceClass";  // Example: apply advanceClass to the 'pno' column
        }
        // You can add more conditions for other specific columns
        if (column === 'inqty') {
            return "advanceClass4";  // Example: apply advanceClass to the 'pno' column
        }
        // You can add more conditions for other specific columns
        if (column === 'inval') {
            return "advanceClass4";  // Example: apply advanceClass to the 'pno' column
        }
        // You can add more conditions for other specific columns
        if (column === 'isqty') {
            return "sl";  // Example: apply advanceClass to the 'pno' column
        }
        // You can add more conditions for other specific columns
        if (column === 'isval') {
            return "sl";  // Example: apply advanceClass to the 'pno' column
        }
        // You can add more conditions for other specific columns
        if (column === 'balqty') {
            return "advanceClass3";  // Example: apply advanceClass to the 'pno' column
        }
        // You can add more conditions for other specific columns
        if (column === 'stv') {
            return "advanceClass3";  // Example: apply advanceClass to the 'pno' column
        }
        // You can add more conditions for other specific columns
        if (column === 'cpu') {
            return "advanceClass5";  // Example: apply advanceClass to the 'pno' column
        }
        // You can add more conditions for other specific columns
        if (column === 'pname') {
            return "advanceClass";  // Example: apply advanceClass to the 'pno' column
        }
        
        // Add any other cell class conditions here

        return '';  // Return an empty string if no class is applied
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    
   
   
    
    $("#partSearchgrid").jqxGrid(
    {
        width: '99%',
        height: 500,
        //margin-left: '15px',
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%' , pinned: true,cellclassname:'advanceClass1',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
                    { text: 'Branch', datafield: 'branch',  width: '10%',hidden:true },
           	         { text: 'PRODUCT CODE', datafield: 'pno',pinned: true,  width: '12%'  ,cellclassname}, 
					 { text: 'DESCRIPTION', datafield: 'pname',pinned: true,  width: '30%',cellclassname ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
					 { text: 'QUANTITY',datafield: 'opnqty', width: '8%', cellsformat: 'd2',columngroup:'opening'  ,cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring2  },
					 { text: 'VALUE',datafield: 'opnval', width: '9%', cellsformat: 'd2',columngroup:'opening' ,cellsalign: 'right', align:'right' ,cellclassname ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
					 { text: 'QUANTITY',datafield: 'inqty', width: '8%', cellsformat: 'd2',columngroup:'in' ,cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring2   },
					 { text: 'VALUE',datafield: 'inval', width: '9%', cellsformat: 'd2',columngroup:'in' ,cellsalign: 'right', align:'right' ,cellclassname ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
				     { text: 'QUANTITY',datafield: 'isqty', width: '8%', cellsformat: 'd2',columngroup:'issued' ,cellclassname  ,aggregates: ['sum'],aggregatesrenderer:rendererstring2 },
				     { text: 'VALUE',datafield: 'isval', width: '9%', cellsformat: 'd2',columngroup:'issued',cellsalign: 'right', align:'right' ,cellclassname ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 { text: 'QUANTITY', datafield: 'balqty', width: '8%', cellsformat: 'd2',columngroup:'balance'  ,cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring2  },
					 { text: 'VALUE', datafield: 'stv', width: '9%', cellsformat: 'd2',columngroup:'balance',cellsalign: 'right', align:'right' ,cellclassname ,aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					 { text: 'COST PER UNIT', datafield: 'cpu', width: '8%', cellsformat: 'd2' ,cellsalign: 'right', align:'right' ,cellclassname},
					 { text: 'psrno', datafield: 'psrno', width: '10%',hidden:true},
					
					], columngroups: 
	                     [
	                       { text: 'OPENING STOCK', align: 'center', name: 'opening',width: '20%',cellclassname },
	                       { text: 'IN STOCK', align: 'center', name: 'in',width: '20%',cellclassname },
	                       { text: 'ISSUED STOCK', align: 'center', name: 'issued',width: '20%',cellclassname },
	                       { text: 'BALANCE STOCK', align: 'center', name: 'balance',width: '20%',cellclassname }
	                     ]
   
    });
 // Handle row select
    $('#partSearchgrid').on('rowselect', function (event) {
        var args = event.args;
        selectedRowIndex = args.rowindex; // Store the selected row index
        $('#partSearchgrid').jqxGrid('refresh'); // Refresh the grid to apply the class
    });
    $('#partSearchgrid').on('rowdoubleclick', function (event) {
    	 var args = event.args;
    	    // row's bound index.
    	    var boundIndex = args.rowindex;
    	    // row's visible index.
    	    var visibleIndex = args.visibleindex;
    	    // right click.
    	    var rightclick = args.rightclick; 
    	    // original event.
    	    var ev = args.originalEvent;

        //blurredRowIndex = boundIndex; // Store the double-clicked row index
        
        // Get the part number for other purposes
        var part_no = $('#partSearchgrid').jqxGrid('getcellvalue', boundIndex, "psrno");
       // alert('Part No: ' + part_no);
        getProDetails(part_no);
        // Select the row to highlight it
        $('#partSearchgrid').jqxGrid('clearselection'); // Clear any previous selection
        $('#partSearchgrid').jqxGrid('selectrow', boundIndex); // Select the current row

        $('#partSearchgrid').jqxGrid('refresh'); // Refresh the grid to apply styles
    });

   
    //$("#overlay, #PleaseWait").hide();
    $('.load-wrapp').hide();
});


</script>
<div id="partSearchgrid"></div>