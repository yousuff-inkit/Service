 
  <%@page import="com.realestate.tenancycontract.ClsTenancyContractDAO" %>
<%ClsTenancyContractDAO DAO=new ClsTenancyContractDAO();
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
            var list1 = ['Self', 'Owner'];
            
            $("#paymentDistributionGridId").jqxGrid(
            {
                width: '99.5%',
                height: 150,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                disabled:true,         
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Description', datafield: 'description', width: '15%' },	
							{ text: 'Date', datafield: 'date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '10%'
								,
								  createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
						               editor.jqxDateTimeInput({ enableBrowserBoundsDetection: true});
						               
						             
						           }},	
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' },
							{ text: 'Notes', datafield: 'notes', width: '15%' }, 
							{ text: 'Cheque No', datafield: 'chqno', width: '10%' },
							{ text: 'Paid To', datafield: 'paidto', width: '15%' ,columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                    editor.jqxDropDownList({ autoDropDownHeight: true, source: list1 });
              }
          },
							{ text: 'Payment', datafield: 'paymentmethod', width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
							{ text: 'Bank', datafield: 'bankaccount', width: '13%' },
						]
            });
          
            if ($("#mode").val() == "A" || $("#mode").val() == "E") {
            	
            	  $("#paymentDistributionGridId").jqxGrid({ disabled: false});
            	
            }
            
            
            
            $('#paymentDistributionGridId').on('cellvaluechanged', function (event) 
             		{ 
               
                  
            var rows = $('#paymentDistributionGridId').jqxGrid('getrows');
            var rowlength= rows.length;
            var rowindex1=event.args.rowindex;
            
            if(rowindex1 == rowlength - 1)
            	{  
            $("#paymentDistributionGridId").jqxGrid('addrow', null, {});
            	} 
             		 });
        });

</script>
<div id="paymentDistributionGridId"></div>
    