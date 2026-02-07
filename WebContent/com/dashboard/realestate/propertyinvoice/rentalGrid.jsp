<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.propertyinvoice.ClsPropertyInvoiceDAO"%>
<%
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    ClsPropertyInvoiceDAO DAO= new ClsPropertyInvoiceDAO();
%>
<script type="text/javascript">
       var rntldata;
       rntldata='<%=DAO.getRentalData(id)%>';                                

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'refname', type: 'String'  },
                        {name : 'totalval', type: 'number'  },
                        {name : 'fromdate', type: 'Date'  },
                        {name : 'todate', type: 'Date'  },
                        {name : 'remarks', type: 'String'  },   
                        {name : 'docno', type: 'String'  }, 
                        {name : 'propertyid', type: 'String'  }, 
                        {name : 'propertysub', type: 'String'  }, 
                        {name : 'name', type: 'String'  }, 
                        {name : 'pvocno', type: 'String'  }, 
                        {name : 'brhid', type: 'String'  }, 
                        {name : 'sub', type: 'String'  }, 
                        {name : 'voc_no', type: 'String'  },
                        {name : 'cldocno', type: 'String'  }, 
                        {name : 'rowno', type: 'String'  }, 
						],
				    localdata: rntldata,

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
    
    $("#jqxRentalGrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlerow',                 
       	showfilterrow: true,
        sortable:true,                                
        pagermode: 'default',
        enabletooltips:true,
        editable:true,
        columns: [   
					{ text: 'SL#', sortable: false, filterable: false, editable: false,            
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '4%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },  
				   { text: 'rowno', datafield: 'rowno', width: '6%', editable: false,hidden:true},
				   { text: 'cldocno', datafield: 'cldocno', width: '6%', editable: false,hidden:true},
				   { text: 'docno', datafield: 'docno', width: '6%', editable: false,hidden:true},
				   { text: 'brhid', datafield: 'brhid', width: '6%', editable: false,hidden:true},
				   { text: 'vocno', datafield: 'pvocno', width: '6%', editable: false,hidden:true},      
				   { text: 'propertyid', datafield: 'propertyid', width: '6%', editable: false,hidden:true},
				   { text: 'propertysub', datafield: 'propertysub', width: '6%', editable: false,hidden:true},
				   { text: 'Doc No', datafield: 'voc_no', editable: false, width: '6%'},          
				   { text: 'Property', datafield: 'name', editable: false, width: '16%'},
				   { text: 'Sub', datafield: 'sub', editable: false, width: '9%'},
	               { text: 'Client', datafield: 'refname', editable: false},       
	               { text: 'From Date', datafield: 'fromdate', width: '8%',cellsformat:'dd.MM.yyyy', editable: false},
	               { text: 'To Date', datafield: 'todate', width: '8%',cellsformat:'dd.MM.yyyy', editable: false},
	               { text: 'Total', datafield: 'totalval', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right', editable: false},  
	               { text: 'Description', datafield: 'remarks', width: '30%', editable: false},
	         ]    
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxRentalGrid').on('rowdoubleclick', function (event) {                            
        var rowindex2 = event.args.rowindex;    
        funRoundAmt($('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "totalval"),"txttotal");
        //document.getElementById("txttotal").value=$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "totalval");            
        document.getElementById("hidrowno").value=$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "rowno");          
        document.getElementById("hidcldocno").value=$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "cldocno"); 
        document.getElementById("hidrntldocno").value=$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "docno");
        document.getElementById("hiddocno").value=$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "propertyid");
        document.getElementById("hidsrno").value=$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "propertysub");
        document.getElementById("hidvocno").value=$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "voc_no");          
        document.getElementById("hidbrhid").value=$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "brhid");     
        document.getElementById("hidlblname").value=$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "voc_no")+" - "+$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "name")+" - "+$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "sub");
        document.getElementById("selectedrow").innerHTML=$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "name")+" - "+$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "sub");
        $('.comments-container').html('');     
    }); 
});
</script>
<div id="jqxRentalGrid"></div>    