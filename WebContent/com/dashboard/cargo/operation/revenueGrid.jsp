<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%>            
<%
ClsOperationDAO DAO=new ClsOperationDAO();
String enqdocno = request.getParameter("enqdocno")==null || request.getParameter("enqdocno")==""?"0":request.getParameter("enqdocno").trim();
String qotdocno = request.getParameter("qotdocno")==null || request.getParameter("qotdocno")==""?"0":request.getParameter("qotdocno").trim(); 
String docno = request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();       
%>

<script type="text/javascript">
var revdata;
var list =['CASH','CARD','ONLINE'];           
var list1 =['ACTUAL','QUOTED'];
var id='<%=id%>';
if(id==1){
	revdata='<%=DAO.revenueDataLoad(enqdocno,qotdocno,docno,id)%>';                    
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
			             {name : 'tobebilled', type: 'number'},
			             {name : 'unitid', type: 'string'},
			             {name : 'nettotal', type: 'number'},
			             {name : 'curid', type: 'string'},
			             {name : 'vatper', type: 'number'},
			             {name : 'vatamt', type: 'number'},
			             {name : 'tax', type: 'number'},  
			             {name : 'inacno', type: 'string'},
			             {name : 'rowno', type: 'string'},
                 ],
                 localdata: revdata,
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

            
            $("#jqxRevenue").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'singlecell',         
                pagermode: 'default',   
                
                showaggregates: true,   
                showstatusbar:true,
                statusbarheight:25,  
                columns: [
                          { text: 'Service Type', datafield: 'sertype', editable: false },	
      					  { text: 'Currency', datafield: 'currency', width: '7%', editable: false },	
      					  { text: 'Rate', datafield: 'rate', width: '7%', editable: true,cellsformat: 'd4', align: 'right', cellsalign: 'right' },
      					  { text: 'Price', datafield: 'price', width: '7%', editable: true,cellsformat: 'd2', align: 'right', cellsalign: 'right' },
						  { text: 'QTY', datafield: 'qty', width: '7%', editable: true,cellsformat: 'd2' },	
						  { text: 'UOM', datafield: 'uom', width: '5%', editable: false },      
						  { text: 'Total', datafield: 'total', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right' , editable: true},	
						  { text: 'Base Total', datafield: 'basetotal', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right', editable: true, aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Billing', datafield: 'billing', width: '10%', columntype:'dropdownlist',
							  createeditor: function (row, column, editor) {
                                editor.jqxDropDownList({ autoDropDownHeight: true, source: list1 });
							  }
						  },	
						  { text: 'srvdocno', datafield: 'srvdocno', width: '12%',hidden: true },
						  { text: 'unitid', datafield: 'unitid', width: '12%',hidden: true },
						  { text: 'inacno', datafield: 'inacno', width: '12%',hidden: true },
						  { text: 'tax', datafield: 'tax', width: '12%',hidden: true },
						  { text: 'curid', datafield: 'curid', width: '12%',hidden: true },  
						  { text: 'rowno', datafield: 'rowno', width: '12%',hidden: true },     
						  { text: 'To be billed', datafield: 'tobebilled', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Vat %', datafield: 'vatper', width: '7%', editable: false,cellsformat: 'd2', align: 'right', cellsalign: 'right' },
						  { text: 'Vat', datafield: 'vatamt', width: '7%',cellsformat: 'd2', align: 'right', editable: false, cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Total', datafield: 'nettotal', width: '7%',cellsformat: 'd2', align: 'right', editable: false, cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
			              ]              
                   
            });     
            $("#jqxRevenue").jqxGrid('addrow', null, {});
            $("#jqxRevenue").jqxGrid({disabled:true});    
            $("#jqxRevenue").on("celldoubleclick", function (event){
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
            	if(columnindex1 == "sertype")      
            	{ 
            		serTypeSearchContent("serviceTypeSearch.jsp?modeid="+$("#hidmodeid").val()+"&shipid="+$("#hidshipid").val()+"&smodeid="+$("#hidsmodeid").val()+"&id="+1);                
            	}
            	
            });
            $("#jqxRevenue").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
            	var rowBoundIndex = event.args.rowindex;      
            	if(datafield=="tobebilled" || datafield=="vatper"){
            		var tobebilled= $('#jqxRevenue').jqxGrid('getcellvalue', rowBoundIndex, "tobebilled");
            		var vatper= $('#jqxRevenue').jqxGrid('getcellvalue', rowBoundIndex, "vatper");
            		var vatamt=(parseFloat(tobebilled)*parseFloat(vatper))/100;
            		var nettotal=parseFloat(tobebilled)+vatamt;   
            		$("#jqxRevenue").jqxGrid('setcellvalue', rowBoundIndex, "vatamt", vatamt);
            		$("#jqxRevenue").jqxGrid('setcellvalue', rowBoundIndex, "nettotal", nettotal);
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
function serTypeSearchContent(url) {    
	$.get(url).done(function (data) {
		$('#sertypesearchwindow').jqxWindow('open');
		$('#sertypesearchwindow').jqxWindow('setContent', data);
	});
}
    </script>
    <div id="jqxRevenue"></div>
  <input type="hidden" id="rowindex"/> 