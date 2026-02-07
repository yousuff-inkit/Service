<%@page import="com.dashboard.cargo.quotationfollowup.*"%>   
<%
ClsQuotationFollowupDAO DAO = new ClsQuotationFollowupDAO();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
%>

<script type="text/javascript">
var reqdata1;
var list =['CASH','CARD','ONLINE'];
var list1 =['ACTUAL','QUOTED'];
var id='<%=id%>';
if(id==1){
	reqdata1='<%=DAO.estmDataLoad(docno,id,load)%>';              
}   
$(document).ready(function () {
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
			             {name : 'doc_no', type: 'string'}, 
			             {name : 'qty1', type: 'number'},
			             {name : 'out_qty', type: 'number'},
			             {name : 'unitsm', type: 'number'},
                 ],
                 localdata: reqdata1,
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
            $("#jqxEstimation").jqxGrid(
            {
                width: '100%',
                height: 280,   
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
				selectionmode: 'checkbox',   
                columns: [
                          { text: 'Service Type', datafield: 'sertype',editable: false },	
      					  { text: 'Currency', datafield: 'currency', width: '5%',editable: false },	
      					  { text: 'Rate', datafield: 'rate', width: '7%',cellsformat: 'd4', align: 'right', cellsalign: 'right',editable: false },
      					  { text: 'Price', datafield: 'price', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right',editable: false },
						  { text: 'QTY', datafield: 'qty', width: '7%',cellsformat: 'd2' },	
						  { text: 'UOM', datafield: 'uom', width: '5%',editable: false },      
						  { text: 'Total', datafield: 'total', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right',editable: false },	
						  { text: 'Base Total', datafield: 'basetotal', width: '7%',editable: false,cellsformat: 'd2', align: 'right', cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Billing', datafield: 'billing',editable: false, width: '10%' , columntype:'dropdownlist',
							  createeditor: function (row, column, editor) {
                                editor.jqxDropDownList({ autoDropDownHeight: true, source: list1 });
							  }         
						  }, 
						  { text: 'unitsm', datafield: 'unitsm',hidden: true},          
						  { text: 'out_qty', datafield: 'out_qty',hidden: true},   
						  { text: 'qty1', datafield: 'qty1',hidden: true},       
						  { text: 'doc_no', datafield: 'doc_no',hidden: true}, 
						  { text: 'Vendor', datafield: 'vendor',hidden: true},              
						  { text: 'srvdocno', datafield: 'srvdocno', width: '12%',hidden: true },
						  { text: 'unitid', datafield: 'unitid', width: '12%',hidden: true },
						  { text: 'vndid', datafield: 'vndid', width: '12%',hidden: true },
						  { text: 'curid', datafield: 'curid', width: '12%',hidden: true },
						  { text: 'status', datafield: 'status', width: '12%',hidden: true },
						  { text: 'Cost Price', datafield: 'costprice', width: '7%',editable: false,cellsformat: 'd2', align: 'right', cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Margin %', datafield: 'marginper', width: '7%',editable: false,cellsformat: 'd2', align: 'right', cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Margin', datafield: 'margin', width: '7%',editable: false,cellsformat: 'd2', align: 'right', cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
			              ]
                   
            });
            //$("#jqxEstimation").jqxGrid('addrow', null, {});
            $("#jqxEstimation").on('cellvaluechanged', function (event){
                    	var datafield = event.args.datafield;
                    	var rowBoundIndex = event.args.rowindex;
                    	if(datafield=="qty"){
                    		var price= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "price");
                    		var qty= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                    		var total=parseFloat(price)*parseFloat(qty);
                    		$("#jqxEstimation").jqxGrid('setcellvalue', rowBoundIndex, "total", total);
                    		      
                    		var exqty= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "qty1");
                    		var qty= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                    		if(parseInt(qty)>parseInt(exqty)){   
                    			$.messager.alert('Message','You cannot enter qty greater than existing qty','warning');        
                    			$("#jqxEstimation").jqxGrid('setcellvalue', rowBoundIndex, "qty", exqty);	          
                    		}
                    	}
                    	if(datafield=="total" || datafield=="rate"){
                    		var rate= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "rate");
                    		var total= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "total");
                    		var basetotal=parseFloat(rate)*parseFloat(total);
                    		$("#jqxEstimation").jqxGrid('setcellvalue', rowBoundIndex, "basetotal", basetotal);
                    		
                    		var unitsm= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "unitsm");
                    		var qty= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "qty");   
                    		$("#jqxEstimation").jqxGrid('setcellvalue', rowBoundIndex, "costprice", parseFloat(unitsm)*parseFloat(qty));      
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
}); 
</script>
<div id="jqxEstimation"></div>
<input type="hidden" id="rowindex"/> 