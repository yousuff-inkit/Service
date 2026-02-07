
  <%@page import=" com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO" %>
<%ClsTenancyContractPostingDAO DAO=new ClsTenancyContractPostingDAO();
 
 
 
 %>
<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");%> 
<script type="text/javascript">
		 var data311;  
        $(document).ready(function () { 
           
            var temp='<%=docno%>';
             
             if(temp>0){   
            	 data311='<%=DAO.paymentloading(docno)%>';  
           	 }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
{name : 'doc_no', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'date', type: 'date' },
     						{name : 'amount', type: 'number'   },
     						{name : 'notes', type: 'string'   },
     						{name : 'chqno', type: 'string'   },
     						{name : 'paidto', type: 'string'   },
     						{name : 'paymentmethod', type: 'string'   },
     						{name : 'bankaccount', type: 'string'   }
                        ],
                         localdata: data311,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['Bank', 'Cash'];
            var list1 = ['Owner', 'Self'];
            
            $("#paymentDistributionGridId").jqxGrid(
            {
                width: '99.5%',
                height: 250,
                source: dataAdapter,
                editable: false,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
               
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '8%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							}, 
							{ text: 'docno', datafield: 'doc_no', width: '15%',hidden:true  },	
							{ text: 'Description', datafield: 'description', width: '15%'  },	
							{ text: 'Date', datafield: 'date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '15%'
								 },	
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right' },
							{ text: 'Notes', datafield: 'notes', width: '15%',hidden:true }, 
							{ text: 'Cheque No', datafield: 'chqno' },
				  { text: 'Paid To', datafield: 'paidto', width: '15%'   ,hidden:true    },
							{ text: 'Payment', datafield: 'paymentmethod', width: '7%'      ,hidden:true          },
							{ text: 'Bank', datafield: 'bankaccount', width: '13%',hidden:true },  
						]
            });
          
  
            
   
        });

</script>
<div id="paymentDistributionGridId"></div>
    