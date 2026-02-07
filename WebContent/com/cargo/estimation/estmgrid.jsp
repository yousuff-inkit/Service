<%@page import="com.cargo.estimation.ClsEstimationDAO"%>
<%
ClsEstimationDAO DAO = new ClsEstimationDAO();
String modeid = request.getParameter("modeid")==null?"0":request.getParameter("modeid").trim();
String shipid = request.getParameter("shipid")==null?"0":request.getParameter("shipid").trim();
String smodeid = request.getParameter("smodeid")==null?"0":request.getParameter("smodeid").trim();
String enqdocno = request.getParameter("enqdocno")==null?"0":request.getParameter("enqdocno").trim();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%>

<script type="text/javascript">
var reqdata1;
var list =['CASH','CARD','ONLINE'];
var list1 =['ACTUAL','QUOTED'];
var id='<%=id%>';
if(id==1){
	reqdata1='<%=DAO.estmDataLoad(docno,enqdocno,id,modeid,smodeid,shipid)%>';
}
$(document).ready(function () {
	$("#jqxEstimation").jqxGrid({ disabled: true});
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
			             {name : 'sertype', type: 'string'},
			             {name : 'remarks', type: 'string'},
			             {name : 'srvdocno', type: 'int'},
			             {name : 'currency', type: 'string'},
			             {name : 'rate', type: 'number'},
			             {name : 'price', type: 'number'},
			             {name : 'qty', type: 'number'},
			             {name : 'uom', type: 'string'},
			             {name : 'basetotal', type: 'number'},
			             {name : 'total', type: 'number'},
			             {name : 'billing', type: 'string'},
			             {name : 'vendor', type: 'string'},
			             {name : 'unitid', type: 'string'},
			             {name : 'vndid', type: 'string'},
			             {name : 'curid', type: 'string'},
			             {name : 'status', type: 'string'},
			             {name : 'costprice', type: 'number'},
			             {name : 'margin', type: 'number'}, 
			             {name : 'marginper', type: 'number'},     
                 ],
                 localdata: reqdata1,
                 deleterow: function (rowid, commit) {
                     // synchronize with the server - send delete command
                     // call commit with parameter true if the synchronization with the server is successful 
                     // and with parameter false if the synchronization failed.
                     commit(true);
                 },
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

            $("#jqxEstimation").on("bindingcomplete", function (event) {
            	var rows=$("#jqxEstimation").jqxGrid('getrows');
        		for(var i=0;i<rows.length;i++){
        			if($('#jqxEstimation').jqxGrid('getcellvalue', i, "status")==1){
        				$('#jqxEstimation').jqxGrid('selectrow', i);
        			}
        		}
        	});      
            
            
            $("#jqxEstimation").jqxGrid(
            {
                width: '100%',
                height: 250,
                source: dataAdapter,
                editable: true,
                //pagermode: 'default',
                filterable: true,
				showfilterrow: true,
                showaggregates: true,     
                showstatusbar:true,
                statusbarheight:25, 
                enabletooltips: true,          
				columnsresize: true, 
				selectionmode: 'singlecell',   
                columns: [
                          { text: 'Service Type', datafield: 'sertype', editable: false },
                          { text: 'Remarks', datafield: 'remarks', editable: false },
      					  { text: 'Currency', datafield: 'currency', width: '5%', editable: false },	
      					  { text: 'Rate', datafield: 'rate', width: '7%', editable: false,cellsformat: 'd4', align: 'right', cellsalign: 'right' },
      					  { text: 'Price', datafield: 'price', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right' },
						  { text: 'QTY', datafield: 'qty', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right'  },	
						  { text: 'UOM', datafield: 'uom', width: '5%', editable: false },      
						  { text: 'Total', datafield: 'total', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right' , editable: false},	
						  { text: 'Base Total', datafield: 'basetotal', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right', editable: false, aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Billing', datafield: 'billing', width: '10%' , columntype:'dropdownlist',
							  createeditor: function (row, column, editor) {
                                editor.jqxDropDownList({ autoDropDownHeight: true, source: list1 });
							  }         
						  }, 
						  { text: 'Vendor', datafield: 'vendor', editable: false,hidden: true},              
						  { text: 'srvdocno', datafield: 'srvdocno', width: '12%',hidden: true },
						  { text: 'unitid', datafield: 'unitid', width: '12%',hidden: true},
						  { text: 'vndid', datafield: 'vndid', width: '12%',hidden: true},
						  { text: 'curid', datafield: 'curid', width: '12%',hidden: true },
						  { text: 'status', datafield: 'status', width: '12%',hidden: true },
						  { text: 'Cost Price', datafield: 'costprice', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Margin %', datafield: 'marginper', width: '7%',cellsformat: 'd2', align: 'right', editable: false, cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Margin', datafield: 'margin', width: '7%',cellsformat: 'd2', align: 'right', editable: false, cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
			              ]
                   
            });
           
           
        	
            $("#jqxEstimation").on("celldoubleclick", function (event){
            	var columnindex1=event.args.datafield;
            	$('#rowindex').val(event.args.rowindex);
            	if(columnindex1 == "currency")
            	{ 
            		currencySearchContent("currencySearch.jsp");
            	}
            	if(columnindex1 == "uom")
            	{ 
            		unitSearchContent("unitSearch.jsp");
            	}
            	if(columnindex1 == "vendor")
            	{ 
            		vendorSearchContent("vendorSearch.jsp");
            	}
            	
            });
             $("#jqxEstimation").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
            	var rowBoundIndex = event.args.rowindex;
            	if(datafield=="qty" || datafield=="price"){
            		var price= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "price");
            		var qty= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "qty");
            		var total=parseFloat(price)*parseFloat(qty);
            		$("#jqxEstimation").jqxGrid('setcellvalue', rowBoundIndex, "total", total);
            	}
            	if(datafield=="total" || datafield=="rate"){
            		var rate= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "rate");
            		var total= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "total");
            		var basetotal=parseFloat(rate)*parseFloat(total);
            		$("#jqxEstimation").jqxGrid('setcellvalue', rowBoundIndex, "basetotal", basetotal);
            	}
            	if(datafield=="total" || datafield=="costprice"){    
            		var costprice= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "costprice");
            		var total= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "basetotal");
            		var margin=parseFloat(total)-parseFloat(costprice);          
            		$("#jqxEstimation").jqxGrid('setcellvalue', rowBoundIndex, "margin", margin); 
            		var marginper=(margin/parseFloat(total))*100;        
            		$("#jqxEstimation").jqxGrid('setcellvalue', rowBoundIndex, "marginper", marginper);     
            	}
            });  
            
             $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
             // create context menu
                var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
                $("#jqxEstimation").on('contextmenu', function () {
                    return false;
                });
                
                $("#Menu").on('itemclick', function (event) {
             	   var args = event.args;
                    var rowindex = $("#jqxEstimation").jqxGrid('getselectedrowindex');
                    if ($.trim($(args).text()) == "Edit Selected Row") {
                        editrow = rowindex;
                        var offset = $("#jqxEstimation").offset();
                        $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                        // get the clicked row's data and initialize the input fields.
                        var dataRecord = $("#jqxEstimation").jqxGrid('getrowdata', editrow);
                        // show the popup window.
                        $("#popupWindow").jqxWindow('show');
                    }
                    else {
                        var rowid = $("#jqxEstimation").jqxGrid('getrowid', rowindex);
                        $("#jqxEstimation").jqxGrid('deleterow', rowid);
                    }
                });
                $("#jqxEstimation").on('rowclick', function (event) {
                    if (event.args.rightclick) {
         		   
                        $("#jqxEstimation").jqxGrid('selectrow', event.args.rowindex);
                        var scrollTop = $(window).scrollTop();
                        var scrollLeft = $(window).scrollLeft();
                        contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                        return false;
                    
         		   }
                });	  
}); 
function currencySearchContent(url) {
	$.get(url).done(function (data) {
		$('#currencysearchwindow').jqxWindow('open');
		$('#currencysearchwindow').jqxWindow('setContent', data);
	});
}
function unitSearchContent(url) {
	$.get(url).done(function (data) {
		$('#unitsearchwindow').jqxWindow('open');
		$('#unitsearchwindow').jqxWindow('setContent', data);
	});
}
function vendorSearchContent(url) {
	$.get(url).done(function (data) {
		$('#vendorsearchwindow').jqxWindow('open');
		$('#vendorsearchwindow').jqxWindow('setContent', data);
	});
}
    </script>
   
   
  <div id='jqxWidget'>
     <div id="jqxEstimation"></div>
     <input type="hidden" id="rowindex"/>
    <div id="popupWindow">
 <input type="hidden" name="invoicerow" id="invoicerow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>