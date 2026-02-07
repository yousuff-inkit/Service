  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.it.quotationit.ClsQuotationItDAO"%>
<% ClsQuotationItDAO searchDAO = new ClsQuotationItDAO(); %>
<%
String doc=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
%>

<script type="text/javascript">
var temp='<%=doc%>';
var descdata1;
$(document).ready(function () {
 if(parseInt(temp)>0)
 {
	descdata1='<%=searchDAO.labourgridreload(doc)%>';  
 }
 var rendererstring2=function (aggregates){
 	var value=aggregates['sum2'];
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
 }    
  var rendererstring1=function (aggregates){
   	var value=aggregates['sum1'];
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
   }    
 var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
 var source =
 {
     datatype: "json",
     datafields: [     
		{name : 'description', type: 'String'},
		{name : 'remarks', type: 'String'},
		{name : 'qty', type: 'number'    },
		{name : 'unitprice', type: 'number'    },
		{name : 'total', type: 'number'    },
		{name : 'markupper', type: 'number'    },       
		{name : 'markupval', type: 'number'    },
		{name : 'nettotal', type: 'number'    },
      ],
   
      localdata: descdata1,
      
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

$("#labourGrid").jqxGrid(
{
    width: '99.5%',
    height: 297,
    source: dataAdapter,
    showaggregates:true,
    showstatusbar:true,
    editable: true,
    disabled:true,
    statusbarheight: 21,
    selectionmode: 'singlecell',
    pagermode: 'default',
    
    columns: [
              
		   { text: 'SL#', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,
             datafield: 'sl', columntype: 'number', width: '3%',
             cellsrenderer: function (row, column, value) {
                 return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
             }  
           },
		    { text: 'Description', datafield: 'description', width: '20%' },
		    { text: 'Remarks', datafield: 'remarks', width: '18%' },
			{ text: 'Quantity', datafield: 'qty',cellsalign: 'left', width: '7%' ,align:'left',cellsformat:'d2'},
			{ text: 'Unit Price', datafield: 'unitprice', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2'},
			{ text: 'Total', datafield: 'total', width: '13%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2'},
			{ text: 'Mark Up %', datafield: 'markupper', width: '7%' ,  cellsformat:'d2',cellsalign: 'right', align:'right'},
			{ text: 'Value', datafield: 'markupval', width: '9%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,editable: false},
			{ text: 'Total Amount', datafield: 'nettotal', width: '13%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },							
            ]
      });
      if(temp==0){
    	 $("#labourGrid").jqxGrid('addrow', null, {});
     }
     if($('#mode').val()=='E' || $('#mode').val()=='A'){
		 $("#labourGrid").jqxGrid({ disabled: false}); 
	 } 
     $('#labourGrid').on('celldoubleclick', function (event) {
   		var columnindex1=event.args.datafield;
   		var rowBoundIndex = event.args.rowindex;
   		if(columnindex1 == "productname"){
   			$('#departmentsearchwindow').jqxWindow('open');
   			departmentSearchContent('departmentSearch.jsp?rowBoundIndex='+rowBoundIndex);
   		}
   		else if(columnindex1 == "brandname"){
   			$('#brandsearchwindow').jqxWindow('open');
   			brandSearchContent('brandSearch.jsp?rowBoundIndex='+rowBoundIndex);
   		}
     });
     $("#labourGrid").on('cellvaluechanged', function (event){
    	 var datafield = event.args.datafield;
    	 var rowBoundIndex = event.args.rowindex;
    	 if(datafield=="qty"||datafield=="unitprice"||datafield=="markupper"){
    		 var qty=$("#labourGrid").jqxGrid('getcellvalue',rowBoundIndex,"qty");
    		 var unitprice=$("#labourGrid").jqxGrid('getcellvalue',rowBoundIndex,"unitprice");
    		 $('#labourGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",parseFloat(qty)*parseFloat(unitprice));
    		 var markupper=$("#labourGrid").jqxGrid('getcellvalue',rowBoundIndex,"markupper");
    		 var total=$("#labourGrid").jqxGrid('getcellvalue',rowBoundIndex,"total");
    		 if(markupper=="" || markupper==null || markupper==0 ||typeof(markupper)=="undefined"|| typeof(markupper)=="NaN")
     		 {
    			 markupper=0;
     		 }
    		 if(total=="" || total==null || total==0 ||typeof(total)=="undefined"|| typeof(total)=="NaN")
     		 {
    			 total=0;
     		 }
    		 var markupval=parseFloat(total)*parseFloat(markupper)/100;
    		 $('#labourGrid').jqxGrid('setcellvalue', rowBoundIndex, "markupval",markupval);
    		 $('#labourGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total+markupval);
		 }
    	 if(datafield=="nettotal"){
    		 var materialtotal=$("#materialtotal").val();
    		 if(materialtotal=="" || materialtotal==null || materialtotal==0 ||typeof(materialtotal)=="undefined"|| typeof(materialtotal)=="NaN")
     		 {
    			 materialtotal=0.00;
     		 }
    		 var summaryData= $("#labourGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
    		 var labourtotal=summaryData.sum.replace(/,/g,'');
    		 
    		 $("#labourtotal").val(labourtotal);
    		 $("#materialtotal").val(materialtotal);

/*     		 var grandtotal= parseFloat(labourtotal)+parseFloat(materialtotal);
    		 $("#grandtotal").val(grandtotal); */
    		 calctotal();
    	 }
    	 if(datafield=="description"){
    		 $("#labourGrid").jqxGrid('addrow', null, {});
    	 }
    	 else if(datafield=="remarks"){
    		 $("#labourGrid").jqxGrid('addrow', null, {});
    	 }
     });
     
     $("#popupWindow1").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
     // create context menu
        var contextMenu = $("#Menu1").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
        $("#labourGrid").on('contextmenu', function () {
            return false;
        });
        
        $("#Menu1").on('itemclick', function (event) {
     	   var args = event.args;
            var rowindex = $("#labourGrid").jqxGrid('getselectedrowindex');
            if ($.trim($(args).text()) == "Edit Selected Row") {
                editrow = rowindex;
                var offset = $("#labourGrid").offset();
                $("#popupWindow1").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                // get the clicked row's data and initialize the input fields.
                var dataRecord = $("#labourGrid").jqxGrid('getrowdata', editrow);
                // show the popup window.
                $("#popupWindow1").jqxWindow('show');
            }
            else {
                var rowid = $("#labourGrid").jqxGrid('getrowid', rowindex);
                $("#labourGrid").jqxGrid('deleterow', rowid);
                var summaryData= $("#labourGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
       		 	var materialtotal=summaryData.sum.replace(/,/g,'');
       		    $("#labourtotal").val(materialtotal);
       		 	calctotal();
            }
        });
        $("#labourGrid").on('rowclick', function (event) {
            if (event.args.rightclick) {
 		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                $("#labourGrid").jqxGrid('selectrow', event.args.rowindex);
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                return false;
            }
 		   }
        });
        
        var rows=$("#labourGrid").jqxGrid("getrows");
        if(rows.length==0){
     	   $("#labourGrid").jqxGrid("addrow", null, {});   
        }
});
function departmentSearchContent(url) {
		$.get(url).done(function (data) {
			$('#departmentsearchwindow').jqxWindow('setContent', data);
		}); 
	}
function brandSearchContent(url) {
	$.get(url).done(function (data) {
		$('#brandsearchwindow').jqxWindow('setContent', data);
	}); 
}
</script>
<div id="labourGrid"></div>
<input type="hidden" id="rowindex">
<div id="popupWindow1">
 <input type="hidden" name="invoicerow" id="invoicerow">
 
 <div id='Menu1'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>