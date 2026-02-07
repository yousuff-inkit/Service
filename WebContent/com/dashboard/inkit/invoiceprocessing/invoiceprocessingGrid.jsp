<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.inkit.invoiceprocessing.ClsInvoiceProcessingDAO"%>  
<%
  ClsInvoiceProcessingDAO DAO=new ClsInvoiceProcessingDAO(); 
  String uptodate =request.getParameter("date")==null?"0":request.getParameter("date").toString();
  String branchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();
  String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString(); 
  int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
  int type =request.getParameter("type")==null || request.getParameter("type")==""?0:Integer.parseInt(request.getParameter("type").toString());
%>

 <script type="text/javascript">
 var perdata;
      perdata= '<%=DAO.loadContractData(uptodate, branchval, clientid, id, type)%>';       
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'doc_no', type: 'String'  }, 
							{name : 'voc_no', type: 'String'  },
							{name : 'brhid', type: 'String' },  
     						{name : 'type', type: 'String'  },
     						{name : 'client', type: 'String' },  
     						{name : 'cldocno', type: 'String' },
     						{name : 'clacno', type: 'String' },  
     						{name : 'date', type: 'date' },
     						{name : 'invdate', type: 'date' },
     						{name : 'rate', type: 'number' },
     						{name : 'clientrate', type: 'number' },
     						{name : 'tothrs', type: 'number' },
     						{name : 'days', type: 'number' },
     						{name : 'invtotal', type: 'number' },    
     						{name : 'clientinvtotal', type: 'number' },    
     						{name : 'nontax', type: 'number' },   
     						{name : 'rowno', type: 'number' },  
     						{name : 'inctax', type: 'number' }, 
     						{name : 'incomeacno', type: 'number' }, 
     						{name : 'costtype', type: 'String' },  
     						{name : 'curr', type: 'String' },  
     						{name : 'currate', type: 'number' },  
                 ],
                 localdata: perdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed...tobeinvamt
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxpinvGrid").jqxGrid(
            {
                width: '100%',
                height: 510,    
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'checkbox',
                filterable: true,
                showfilterrow: true,
                //pagermode: 'default', 
                columns: [
                	     { text: 'SL#', sortable: false, filterable: false,            
					      groupable: false, draggable: false, resizable: false,
					      datafield: 'sl', columntype: 'number', width: '3%',
					      cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					      }  
					     },      
					     { text: 'Doc No',  datafield: 'voc_no', width: '4%' },
					     { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' },
					     { text: 'Last Inv. Date', datafield: 'invdate', width: '7%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Name', datafield: 'client' },  
						 { text: 'Bill Rate',  datafield: 'rate', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
						 { text: 'Client Bill Rate',  datafield: 'clientrate', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
						 { text: 'Total Hrs',  datafield: 'tothrs', width: '6%', cellsformat: 'd0', cellsalign: 'right', align: 'right' },
						 { text: 'Days', datafield: 'days', width: '6%', cellsformat: 'd0', cellsalign: 'right', align: 'right'},
						 { text: 'Inv Total',  datafield: 'invtotal', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
						 { text: 'Client Inv Total',  datafield: 'clientinvtotal', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
						 { text: 'Curr',  datafield: 'curr', width: '6%'},
						 { text: 'Curr Rate',  datafield: 'currate', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
						 { text: 'type',  datafield: 'type', width: '10%',hidden:true },
						 { text: 'cldocno',  datafield: 'cldocno', width: '10%',hidden:true },
						 { text: 'brhid',  datafield: 'brhid', width: '10%',hidden:true },
						 { text: 'doc_no',  datafield: 'doc_no', width: '10%',hidden:true },   
						 { text: 'clacno',  datafield: 'clacno', width: '10%',hidden:true },    
						 { text: 'incomeacno',  datafield: 'incomeacno', width: '10%',hidden:true },
						 { text: 'nontax',  datafield: 'nontax', width: '10%',hidden:true },
						 { text: 'rowno',  datafield: 'rowno', width: '10%',hidden:true },  
						 { text: 'inctax',  datafield: 'inctax', width: '10%',hidden:true },     
						 { text: 'costtype',  datafield: 'costtype', width: '10%',hidden:true },       
				 ]
            });
                 $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxpinvGrid"></div>