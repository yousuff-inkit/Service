<%@page import="com.cargo.transportmasters.servicetype.ClsServiceTypeAction" %>
<%ClsServiceTypeAction csa=new ClsServiceTypeAction(); %>
<script type="text/javascript">
  		
  		var srvcdata= '<%=csa.searchDetails() %>';
        
  		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date' }, 
     						{name : 'srvtype', type: 'string'   },
     						{name : 'modename', type: 'string'  },
     						{name : 'submode', type: 'string'   },
     						{name : 'shipment', type: 'String'   },
     						{name : 'modeid', type: 'int'  },
     						{name : 'smodeid', type: 'int'  },
     						{name : 'shipid', type: 'int'  },
     						{name : 'inaccid', type: 'int'  },
     						{name : 'exaccid', type: 'int'  },
     						{name : 'indesc', type: 'string'   },
     						{name : 'exdesc', type: 'String'   },
     						{name : 'tax', type: 'String'   },
     						{name : 'seqno', type: 'int'   }
                          	],
               localdata: srvcdata,
        
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxServiceTypeSearch").jqxGrid(
            {
            	width: '100%',
                height: 300,
                source: dataAdapter,
	             showfilterrow: true,
	             filterable: true,
	             selectionmode: 'singlerow',
	             sortable: true,
	             altrows:true,
                
                columns: [
                      	{ text: 'Doc No', datafield: 'doc_no',filtertype: 'number', editable: false, width: '6%' },
                      	{ text: 'Seq No', datafield: 'seqno',filtertype: 'number', editable: false, width: '6%' },
                      	{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy',  editable: false, width: '8%' },	
						{ text: 'Service Type', datafield: 'srvtype', editable: false, width: '20%' },
						{ text: 'Mode', datafield: 'modename', editable: false, width: '20%' },
						{ text: 'Mode Id', datafield: 'modeid', width: '20%',hidden: true,editable: false },
						{ text: 'Submode', datafield: 'submode', editable: false, width: '20%' },
						{ text: 'SubMode Id', datafield: 'smodeid', width: '20%',hidden: true,editable: false },
						{ text: 'Shipment', datafield: 'shipment', width: '20%',editable: false },
						{ text: 'Shipment Id', datafield: 'shipid', width: '20%',hidden: true,editable: false },
						]
            });
            $('#jqxServiceTypeSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxServiceTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#servicedate").jqxDateTimeInput('val', $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("servicetype").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "srvtype");
                document.getElementById("hidcmbmode").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "modeid");
                document.getElementById("hidcmbsubmode").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "smodeid");
                document.getElementById("cmbsubmode").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "submode");
                document.getElementById("hidcmbshipment").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "shipid");
                document.getElementById("inaccid").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "inaccid");
                document.getElementById("inaccname").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "indesc");
                document.getElementById("exaccid").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "exaccid");
                document.getElementById("exaccname").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "exdesc");
                document.getElementById("seqno").value= $('#jqxServiceTypeSearch').jqxGrid('getcellvalue', rowindex1, "seqno");
                var chk = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "tax");
                if(parseFloat(chk)==1){
        			document.getElementById("chktaxable").checked = true;
        			document.getElementById("chktaxable").value=1; 
        		}else{
        			document.getElementById("chktaxable").checked = false;
        			document.getElementById("chktaxable").value=0; 
        		}
                getMode();getShipment();
               
                $('#window').jqxWindow('hide');
            }); 
         
        });
</script>
<div id="jqxServiceTypeSearch"></div>
