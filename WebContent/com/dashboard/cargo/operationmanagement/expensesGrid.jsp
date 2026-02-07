<%@page import="com.dashboard.cargo.operationmanagement.ClsOperationManagementDAO"%>
<%
    ClsOperationManagementDAO DAO=new ClsOperationManagementDAO();       
	String enqdocno = request.getParameter("enqdocno")==null || request.getParameter("enqdocno")==""?"0":request.getParameter("enqdocno").trim();
	String qotdocno = request.getParameter("qotdocno")==null || request.getParameter("qotdocno")==""?"0":request.getParameter("qotdocno").trim();
	String docno = request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim();
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();                 
%>           

<script type="text/javascript">
var expdata;
var list2 =['CREDIT','CASH-VAT','CASH','PAYABLE','HR'];                        
var list1 =['ACTUAL','QUOTED'];
var id='<%=id%>';
if(id==1){   
	expdata='<%=DAO.expensesDataLoad(enqdocno,qotdocno,docno,id)%>';                               
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
			             {name : 'costprice', type: 'number'},
			             {name : 'amount', type: 'number'},
			             {name : 'account', type: 'string'},
			             {name : 'billing', type: 'string'},
			             {name : 'acno', type: 'string'},   
			             {name : 'type', type: 'string'},
			             {name : 'remarks', type: 'string'},
			             {name : 'nettotal', type: 'number'},
			             {name : 'vatper', type: 'number'},  
			             {name : 'vatamt', type: 'number'}, 
			             {name : 'tax', type: 'number'}, 
			             {name : 'rowno', type: 'number'}, 
			             {name : 'invno', type: 'string'},
			             {name : 'invdate', type: 'date'},
                 ],
                 localdata: expdata,
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

            
            $("#jqxExpense").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                editable: false,
                altRows: true,
                selectionmode: 'singlecell',        
                pagermode: 'default',
                
                showaggregates: true,   
                showstatusbar:true,
                statusbarheight:25,  
                columns: [
                          { text: 'Service Type', datafield: 'sertype', width: '9%', editable: false },
                          { text: 'Billing', datafield: 'billing', columntype:'dropdownlist',
							  createeditor: function (row, column, editor) {
                                editor.jqxDropDownList({ autoDropDownHeight: true, source: list1 });
							  }
						  },
                          { text: 'Cost Price', datafield: 'costprice', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
                          { text: 'Type', datafield: 'type', width: '8%', columntype:'dropdownlist',
							  createeditor: function (row, column, editor) {
                                editor.jqxDropDownList({ autoDropDownHeight: true, source: list2 });
							  }
						  },  
						  { text: 'Account', datafield: 'account', width: '9%', editable: false },   
						  { text: 'Inv No', datafield: 'invno', width: '7%'},
						  { text: 'Inv Date', datafield: 'invdate', width: '6%',cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput'},    
						  { text: 'Amount', datafield: 'amount', width: '7%',cellsformat: 'd2', align: 'right', cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Vat %', datafield: 'vatper', width: '7%',cellsformat: 'd2', editable: false, align: 'right', cellsalign: 'right'},
						  { text: 'Vat', datafield: 'vatamt', width: '7%',cellsformat: 'd2', align: 'right', editable: false, cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Total', datafield: 'nettotal', width: '7%',cellsformat: 'd2', align: 'right', editable: false, cellsalign: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
						  { text: 'Remarks', datafield: 'remarks', width: '15%'},    
						  { text: 'acno', datafield: 'acno', width: '12%',hidden: true },         
                          { text: 'srvdocno', datafield: 'srvdocno', width: '12%',hidden: true },   
                          { text: 'tax', datafield: 'tax', width: '12%',hidden: true }, 
                          { text: 'rowno', datafield: 'rowno', width: '12%',hidden: true }, 
						  ]              
            }); 
            funCalcBalance();  
 });     
</script>  
<div id="jqxExpense"></div>
<input type="hidden" id="rowindex2"/> 