<%@page import="com.dashboard.skips.invoicetodispatch.ClsInvoiceDispatchDAO" %>  
<%ClsInvoiceDispatchDAO cid=new ClsInvoiceDispatchDAO(); %>
       <script type="text/javascript">
  
	    var data1='<%=cid.contractDetailsSearch() %>';
		$(document).ready(function () { 	
        	/* var url=""; */
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'refname', type: 'string'  }, 
                            {name : 'tr_no', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'site', type: 'string'  }
                        ],
                		
                		//  url: url1,
                 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxContractSearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Tr NO', datafield: 'tr_no', width: '20%',hidden:true},
                              { text: 'Doc No', datafield: 'doc_no', width: '20%'},
                              { text: 'Name', datafield: 'refname', width: '50%' }, 
                              { text: 'Site', datafield: 'site', width: '30%' }, 
						]
            });
            
          $('#jqxContractSearch').on('rowdoubleclick', function (event) {    
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtcontract").value=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"); 
                document.getElementById("contrno").value=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex2, "tr_no");
               $('#contractDetailsWindow').jqxWindow('close');       
            }); 
        });
    </script>
    <div id="jqxContractSearch"></div>  