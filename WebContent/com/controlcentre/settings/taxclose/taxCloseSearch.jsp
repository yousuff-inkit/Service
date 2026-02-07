<%@page import="com.controlcentre.settings.taxclose.ClsTaxCloseDAO"%>
<%ClsTaxCloseDAO ctd=new ClsTaxCloseDAO(); %>

<%String branch=request.getParameter("branch")==null?"0":request.getParameter("branch").toString();%>
<script type="text/javascript">
    var data= '<%=ctd.getSearchDetails(branch)%>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          //	{name : 'doc_no' , type: 'number' },
     						{name : 'doc_no', type: 'String'  },
                          	{name : 'vdate', type: 'date'  },
                          	{name : 'vdateupto', type: 'date'  },
                          	{name : 'vtclosedate', type: 'date'  }
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
            $("#tcloseSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                //pageable: true,
                showfilterrow: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
               // sortable: true,
                //Add row method
                columns: [
					//{ text: 'Original Doc No',filtertype:'number', datafield: 'doc_no', width: '10%',hidden:true },
					{ text: 'Doc No',filtertype:'number',datafield: 'doc_no', width: '10%' },
					{ text: 'Date', datafield: 'vdate', width: '30%',columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy' },
					{ text: 'Date Upto', datafield: 'vdateupto', width: '30%',columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy' },
					{ text: 'Month Close Date', datafield: 'vtclosedate', width: '30%',columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy' }
	              ]
            });

            $('#tcloseSearch').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		               // document.getElementById("docno").value= $('#tcloseSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("docno").value= $('#tcloseSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
		                $("#date").jqxDateTimeInput('val', $("#tcloseSearch").jqxGrid('getcellvalue', rowindex1, "vdate")); 
		                $("#dateupto").jqxDateTimeInput('val', $("#tcloseSearch").jqxGrid('getcellvalue', rowindex1, "vdateupto")); 
		                $("#tclosedate").jqxDateTimeInput('val', $("#tcloseSearch").jqxGrid('getcellvalue', rowindex1, "vtclosedate")); 
		            	$('#window').jqxWindow('close');
		            	$("#btnPrint").attr('disabled', true );
		            	document.getElementById("btnEdit").disabled=true;
		            	
            		 }); 
        
        });
    </script>
    <div id="tcloseSearch"></div>
