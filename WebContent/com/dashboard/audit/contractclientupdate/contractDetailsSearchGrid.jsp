<%@page import="com.dashboard.audit.contractclientupdate.ClsContractClientUpdateDAO" %>
<% ClsContractClientUpdateDAO DAO=new ClsContractClientUpdateDAO(); %>  
 <%
 String contracttype = request.getParameter("contracttype")==null?"NA":request.getParameter("contracttype");
 String id = request.getParameter("id")==null?"0":request.getParameter("id"); 
 String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno"); 
 %>
 
<script type="text/javascript">
        $(document).ready(function () { 
        	var data5= '<%=DAO.contractDetailsSearch(contracttype, contractno, id)%>';    
            // prepare the datad
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'refno', type: 'string'   },
     						{name : 'tr_no', type: 'int'   }
                        ],
                		 localdata: data5,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#contractDetailsSearch").jqxGrid(
            {
                width: '99.5%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '30%' },
							{ text: 'Ref No', datafield: 'refno', width: '70%' },
							{ text: 'Tr No',  datafield: 'tr_no', width: '5%' },
						]
            });
            
             $('#contractDetailsSearch').on('rowdoubleclick', function (event) {
            	 
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcontract").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	document.getElementById("txtcontracttrno").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
    	       	
            	$('#contractDetailsWindow').jqxWindow('close'); 
            });  
        });
 
</script>
<div id="contractDetailsSearch"></div>
 