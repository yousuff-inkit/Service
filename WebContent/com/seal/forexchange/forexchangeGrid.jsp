<%@page import="com.seal.forexchange.ClsForExchangeDAO"%>
<%
	ClsForExchangeDAO DAO= new ClsForExchangeDAO();
%>  
<% int check = request.getParameter("id")==null || request.getParameter("id").equals("")?0:Integer.parseInt(request.getParameter("id").toString());
String adjdate = request.getParameter("adjdate")==null?"":request.getParameter("adjdate");    
int docno = request.getParameter("docno")==null || request.getParameter("docno").equals("")?0:Integer.parseInt(request.getParameter("docno"));%> 

 <script type="text/javascript">  
 
	var data1 = '<%=DAO.loadData(check, adjdate, docno)%>';       
	
 	$(document).ready(function () {   
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
	            	    { name : 'doc_no', type: 'string'   },
						{ name : 'account', type: 'string'   },
						{ name : 'description', type: 'string'  },
						{ name : 'difference', type: 'number'   },  
                    ],
            		localdata: data1, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#jqxForExchange").jqxGrid(
        {
        	width: '99.9%',
            height: 450,
            source: dataAdapter,
            selectionmode: 'checkbox',
 			editable: false,
 			filterable: true,
 			showfilterrow: true,
 			enabletooltips:true,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            columns: [
            	 		{ text: 'SL#', sortable: false, filterable: false,            
					      groupable: false, draggable: false, resizable: false,
					      datafield: 'sl', columntype: 'number', width: '4%',
					      cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					      }  
				        },   
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '10%' },
						{ text: 'Account Name', datafield: 'description',width:'73.8%' },
						{ text: 'Difference', datafield: 'difference', width: '10%',cellsalign:'right',align:'right',cellsformat:'d2' },     
					]
        });
    });
</script>
<div id="jqxForExchange"></div>    