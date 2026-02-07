 <%@page import="com.dashboard.management.presalesmanagement.ClsPresalesManagementDAO"%>   
<%
ClsPresalesManagementDAO sd=new ClsPresalesManagementDAO();  
%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
   
 <%
     String id=request.getParameter("id")==null?"":request.getParameter("id").toString();
 %>        
<script type="text/javascript">    
var data1;
data1='<%=sd.presalesQotData(session,id) %>';                                    
$(document).ready(function(){      
	
	var rendererstring=function (aggregates){
		var value=aggregates['sum'];
		
		if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
		   {
			value=0.0;
		   }
		
		return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	}
    
	  var rendererstring1=function (aggregates){
	    	var value=aggregates['sum1'];
	    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
	    }  
	  
    var source =
    {             
            datatype: "json",
            datafields: [ 
                        {name : 'docno',type:'string'},
                        {name : 'voc_no' , type: 'string'},
 						{name : 'date', type:'date'},             
 						{name : 'name', type: 'string'},
 						{name : 'productid', type: 'string' }, 
 						{name : 'productname', type: 'string'},
						{name : 'unit', type: 'string'  },
						{name : 'qty', type: 'number'   },
						{name : 'unitprice', type: 'number' },
						{name : 'total', type: 'number' }, 
						{name : 'discper', type: 'number' },
						{name : 'dis', type: 'number' },
						{name : 'netotal', type: 'number' },
						{name : 'taxper', type: 'number'  },  
 					    {name : 'taxamount', type: 'number'  },
 					    {name : 'taxperamt', type: 'number'  }, 
 					    {name : 'doc_no', type: 'string'},
 					    {name : 'description', type: 'string'},
 					   {name : 'brhid', type: 'string'},
             ],                  
             localdata: data1,      
              
            
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

      

        $("#jqxquotationGrid").jqxGrid(
                {
                	width: '100%',
                    height: 350,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    sortable: true,
                     columnsresize: true,
                    //Add row method
                    columns: [  
                    	{ text: 'Date',datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},   
						{ text: 'Doc No',datafield: 'voc_no', width: '6%'},
    					{ text: 'client',datafield: 'name', width: '20%'}, 
                        { text: 'Product', datafield: 'productid', width: '10%',editable:false},
                        { text: 'Product Name', datafield: 'productname',editable:false},
                        { text: 'Unit', datafield: 'unit', width: '6%',editable:false },	
                    	{ text: 'Quantity', datafield: 'qty', width: '5%' ,  cellsformat: 'd2'},
                    	{ text: 'Unit price', datafield: 'unitprice', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
                        { text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
                        { text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
                        { text: 'Discount', datafield: 'dis', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
                        { text: 'Net Total', datafield: 'netotal', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false},
                        { text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,editable:false},
						{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Total Amount', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
						{ text: 'docno',datafield: 'doc_no', width: '6%',hidden:true},  
						{ text: 'description',datafield: 'description', width: '16%'},
						{ text: 'brhid', datafield: 'brhid', width: '14%',hidden:true},    
					   ]                                              
                });  
                $("#overlay, #PleaseWait").hide();
                $('#jqxquotationGrid').on('rowdoubleclick', function (event) {       
	                   var rowindex = event.args.rowindex;
	                   
	                   document.getElementById("qotdocno").value=$('#jqxquotationGrid').jqxGrid('getcellvalue', rowindex, "doc_no");
	                   document.getElementById("qotbrhid").value=$('#jqxquotationGrid').jqxGrid('getcellvalue', rowindex, "brhid"); 
	                   
	                   var docno=$('#jqxquotationGrid').jqxGrid('getcellvalue', rowindex, "doc_no");    
	                   var rdtype='QOT'; 
	                   
	                   $("#flwupdiv").load("followupGrid.jsp?docno="+docno+"&reftype="+rdtype);
	                   
	                   $('.textpanel p').text('QOT No '+$('#jqxquotationGrid').jqxGrid('getcellvalue',rowindex,'voc_no')+' - '+$('#jqxquotationGrid').jqxGrid('getcellvalue', rowindex, "name"));
                });     
	});     
</script>
<div id="jqxquotationGrid"></div>    