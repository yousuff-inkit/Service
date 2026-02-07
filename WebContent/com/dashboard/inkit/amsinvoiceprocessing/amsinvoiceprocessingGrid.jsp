<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.inkit.amsinvoiceprocessing.ClsAmsInvoiceProcessingDAO"%>  
<%
  ClsAmsInvoiceProcessingDAO DAO=new ClsAmsInvoiceProcessingDAO(); 
  String uptodate =request.getParameter("date")==null?"0":request.getParameter("date").toString();
  String branchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();
  String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString(); 
  int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
%>

 <script type="text/javascript">
 var perdata;
      perdata= '<%=DAO.loadContractData(uptodate, branchval, clientid, id)%>';       
        $(document).ready(function () { 	
            
            var num = 0; 
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'voc_no', type: 'String'  },
     						{name : 'date', type: 'date' },  
     						{name : 'client', type: 'String' },  
     						{name : 'site', type: 'String' },  
     						{name : 'supporthrs', type: 'number' },
     						{name : 'extrahrsrate', type: 'number' },
     						{name : 'fromdt', type: 'date' },
     						{name : 'todt', type: 'date' },
							{name : 'billfreq', type: 'String'  },
     						{name : 'supportedhrs', type: 'number' },
     						{name : 'extrahrs', type: 'number' },
     						{name : 'cf', type: 'String' },  
     						{name : 'amount', type: 'number' },    
     						{name : 'extrahramt', type: 'number' },    
     						{name : 'total', type: 'number' },   
     						
     						{name : 'doc_no', type: 'String'  }, 
							{name : 'brhid', type: 'String' },
							{name : 'cldocno', type: 'String' },
							{name : 'clacno', type: 'String' },
							{name : 'inctax', type: 'String' },
							{name : 'incomeacno', type: 'number' },
							{name : 'costtype', type: 'String' },
							{name : 'nontax', type: 'number' },   
							{name : 'rowno', type: 'int' },   
							{name : 'hidsupportedhrs', type: 'number' },   
							{name : 'billfrequency', type: 'int' },   
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
               	enabletooltips: true,
                editable:true,
                columns: [
                	     { text: 'SL#', sortable: false, filterable: false,            
					      groupable: false, draggable: false, resizable: false,
					      datafield: 'sl', columntype: 'number', width: '3%',
					      cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					      }  
					     },      
					     { text: 'Doc No', datafield: 'voc_no', width: '4%', editable:false },
					     { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy', editable:false },
						 { text: 'Name', datafield: 'client', editable:false,width: '9.5%' },  
						 { text: 'Site', datafield: 'site', width: '6%', editable:false },  
						 { text: 'Hours Agreed', datafield: 'supporthrs', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right', editable:false },
						 { text: 'Extra Rate', datafield: 'extrahrsrate', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right', editable:false },
					     { text: 'From Date', datafield: 'fromdt', width: '6%',cellsformat:'dd.MM.yyyy', editable:false },
					     { text: 'To Date', datafield: 'todt', width: '6%',cellsformat:'dd.MM.yyyy', editable:false },
						 { text: 'Billing', datafield: 'billfreq', editable:false, width: '5%' },  
						 { text: 'Hours Supported', datafield: 'supportedhrs', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
						 { text: 'Extra Hours', datafield: 'extrahrs', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right', editable:false },
						 { text: 'Contract C/F', datafield: 'cf', width: '6%', editable:false },  
						 { text: 'Billing Amt', datafield: 'amount', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right', editable:false },
						 { text: 'Extra Hrs Amt', datafield: 'extrahramt', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right', editable:false },
						 { text: 'Total Amt', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right', editable:false },
						 { text: 'doc_no', datafield: 'doc_no', hidden:true },   
						 { text: 'brhid', datafield: 'brhid', hidden:true },
						 { text: 'cldocno', datafield: 'cldocno', hidden:true },
						 { text: 'clacno', datafield: 'clacno', hidden:true },
						 { text: 'inctax', datafield: 'inctax', hidden:true },
						 { text: 'incomeacno', datafield: 'incomeacno', hidden:true },
						 { text: 'costtype', datafield: 'costtype', hidden:true },
						 { text: 'nontax', datafield: 'nontax', hidden:true },
						 { text: 'rowno', datafield: 'rowno', hidden:true },
						 { text: 'hidsupportedhrs', datafield: 'hidsupportedhrs', hidden:true },
						 { text: 'billfrequency', datafield: 'billfrequency', hidden:true },
						 
				 ]
            });
            
            $("#overlay, #PleaseWait").hide();
            
        });
    </script>
    <div id="jqxpinvGrid"></div>