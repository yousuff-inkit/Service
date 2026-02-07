<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%>
<% ClsOperationDAO DAO=new ClsOperationDAO(); %>     
<% String type1 = request.getParameter("atype")==null?"0":request.getParameter("atype"); %> 

<script type="text/javascript">
        var mspacc= '<%=DAO.multipleCashPurchaseGridSearch(type1) %>';
        $(document).ready(function () { 	   
                     
            // prepare the data   
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },   
     						{name : 'curr', type: 'string'  },  
     						{name : 'curid', type: 'int'  },
     						{name : 'gr_type', type: 'int'  },
     						{name : 'c_rate', type: 'number'  },
     						{name : 'type', type: 'string'  },
     						
                        ],
                		 localdata: mspacc, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxMainSearch").jqxGrid(
            {
            	width: '100%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			filterable: true,
     	        showfilterrow: true,    
     			localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '40%' },
							{ text: 'Currency', datafield: 'curr', width: '20%' },
							{ text: 'Currency ID', datafield: 'curid',  hidden:true, width: '20%' },
							{ text: 'Group Type', datafield: 'gr_type', hidden: true, width: '10%' },
							{ text: 'Rate', datafield: 'c_rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '20%' },
							{ text: 'Currency Type', datafield: 'type', hidden: true, width: '20%' },
							
						]
            });
            
            
            $('#jqxMainSearch').on('rowdoubleclick', function (event) {
	              var rowindex1 =$('#mcpaccrowindex').val();
	              var check =$('#mcpaccid').val();    
	              var rowindex2 = event.args.rowindex;
	              if(check==1){
	            	     $('#jqxMCPCash').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#jqxMainSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	                     $('#jqxMCPCash').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#jqxMainSearch').jqxGrid('getcellvalue', rowindex2, "account"));
	                     $('#jqxMCPCash').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#jqxMainSearch').jqxGrid('getcellvalue', rowindex2, "description"));
	                     $("#jqxMCPCash").jqxGrid('setcellvalue', rowindex1, "currency" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "curr"));
	                     $("#jqxMCPCash").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
	                     $("#jqxMCPCash").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "type"));
	                     $("#jqxMCPCash").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "gr_type"));
	                     $("#jqxMCPCash").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));
						 $("#jqxMCPCash").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
	              }else if(check==2){         
	            	     $('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex1, "docno" ,$('#jqxMainSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	                     $('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex1, "accounts" ,$('#jqxMainSearch').jqxGrid('getcellvalue', rowindex2, "account"));
	                     $('#jqxMCPCredit').jqxGrid('setcellvalue', rowindex1, "accountname1" ,$('#jqxMainSearch').jqxGrid('getcellvalue', rowindex2, "description"));
	                     $("#jqxMCPCredit").jqxGrid('setcellvalue', rowindex1, "currency" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "curr"));
	                     $("#jqxMCPCredit").jqxGrid('setcellvalue', rowindex1, "currencyid" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "curid"));
	                     $("#jqxMCPCredit").jqxGrid('setcellvalue', rowindex1, "currencytype" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "type"));
	                     $("#jqxMCPCredit").jqxGrid('setcellvalue', rowindex1, "grtype" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "gr_type"));
	                     $("#jqxMCPCredit").jqxGrid('setcellvalue', rowindex1, "rate" ,$("#jqxMainSearch").jqxGrid('getcellvalue', rowindex2, "c_rate"));
						 $("#jqxMCPCredit").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
	              }else{}       
	              $('#McpGridWindow').jqxWindow('close');      
            }); 
        });
    </script>
    <div id="jqxMainSearch"></div>
 