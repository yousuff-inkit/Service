<%@page import="com.dashboard.purchases.purchaseorderfollowupnew.ClsPurchaseOrderFollowupNewDAO"%>
<%ClsPurchaseOrderFollowupNewDAO DAO = new ClsPurchaseOrderFollowupNewDAO();%>
 
<%
 	String brhid = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
 	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
%> 

<script type="text/javascript">

var gridData;

gridData = '<%=DAO.mainGridLoad(session, brhid, load) %>';

$(document).ready(function() {
    // prepare the data
    var source = {
        datatype: "json",
        datafields: [

            { name: 'voc_no', type: 'String' },
            { name: 'date', type: 'date' },
            { name: 'account', type: 'String' },
            { name: 'acname', type: 'String' },
            { name: 'dtype', type: 'String' },
            { name: 'netamt', type: 'number' },
            { name: 'description', type: 'String' },
            { name: 'doc_no', type: 'String' },
            { name: 'brhid', type: 'String' },
            { name: 'cldocno', type: 'String' },

        ],
        localdata: gridData,


        pager: function(pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function(xhr, status, error) {
            alert(error);
        }

    });
 
    $("#poGrid").jqxGrid({
        width: '99%',
        height: 300,
        source: dataAdapter,
        showaggregates: true,
        enableAnimations: true,
        filtermode: 'excel',
        filterable: true,
        showfilterrow: true,
        sortable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
        editable: false,
        columnsresize: true,
        enabletooltips: true,
        columns: [{
                text: 'SL#',
                sortable: false,
                filterable: false,
                editable: false,
                groupable: false,
                draggable: false,
                resizable: false,
                datafield: 'sl',
                columntype: 'number',
                width: '4%',
                cellsrenderer: function(row, column, value) {
                    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }
            },
            
            { text: 'Doc No', datafield: 'voc_no', width: '8%' },
            { text: 'Date', datafield: 'date', width: '8%', cellsformat:'dd.MM.yyyy' },
            { text: 'Account', datafield: 'account', width: '8%' },
            { text: 'Account Name', datafield: 'acname', width: '25%' },
            { text: 'Ref Type', datafield: 'dtype', width: '8%' },
            { text: 'Net Amount', datafield: 'netamt', width: '8%', cellsalign: 'right',align: 'right', cellsformat:'d2' },
            { text: 'Description', datafield: 'description' },
           
        ]

    });
    
    $('.load-wrapp').hide();

});

</script>
<div id="poGrid"></div>

