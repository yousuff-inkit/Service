<%@page import="com.finance.interbranchtransactions.ibjournalvouchers.ClsIbJournalVouchersDAO" %>
<%  ClsIbJournalVouchersDAO DAO=new ClsIbJournalVouchersDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo").toString();
String dates = request.getParameter("dates")==null?"0":request.getParameter("dates");
String descriptions = request.getParameter("descriptions")==null?"0":request.getParameter("descriptions");
String refNo = request.getParameter("refNo")==null?"0":request.getParameter("refNo");
String amounts = request.getParameter("amounts")==null?"0":request.getParameter("amounts");
%> 
 <script type="text/javascript">
   
     var data4='<%=DAO.ijvMainSearch(session,docNo,dates,descriptions,refNo,amounts)%>'; 
        $(document).ready(function () { 
        	
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'description', type: 'String' }, 
     						{name : 'refno', type: 'String' },
     						{name : 'drtot', type: 'number'  },
     						{name : 'tr_no', type: 'int'  }
                          	],
                          	localdata: data4,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxIbJournalVoucherMainSearch").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
					{ text: 'Description', datafield: 'description', width: '50%' }, 
					{ text: 'Reference', datafield: 'refno', width: '15%' },
					{ text: 'Amount', datafield: 'drtot', cellsformat: 'd2', width: '15%' },
					{ text: 'Tr No', datafield: 'tr_no', hidden: true, width: '15%' }
					]
            });
    
            $('#jqxIbJournalVoucherMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxIbJournalVoucherMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: false});
                $("#jqxIbJournalVouchersDate").jqxDateTimeInput('val', $("#jqxIbJournalVoucherMainSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                $('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: true});
                $("#maindate").jqxDateTimeInput('val', $("#jqxIbJournalVoucherMainSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("txtdescription").value= $('#jqxIbJournalVoucherMainSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("txtrefno").value= $('#jqxIbJournalVoucherMainSearch').jqxGrid('getcellvalue', rowindex1, "refno");
                funRoundAmt($('#jqxIbJournalVoucherMainSearch').jqxGrid('getcellvalue', rowindex1, "drtot"),"txtdrtotal");
                funRoundAmt($('#jqxIbJournalVoucherMainSearch').jqxGrid('getcellvalue', rowindex1, "drtot"),"txtcrtotal");
                document.getElementById("txttrno").value= $('#jqxIbJournalVoucherMainSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
                
                var indexVal = document.getElementById("docno").value;
   			    if(indexVal>0){
   	             $("#jqxJournalVoucherGrid").load("ibJournalVoucherGrid.jsp?txtjournalvouchersdocno2="+indexVal); 
   			     }
                $('#window').jqxWindow('close');
                });  	 
				           
}); 
</script>
<div id="jqxIbJournalVoucherMainSearch"></div>
    