<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.propertymanagement.ClsPropertyManagementDAO"%>
<%
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
	String srno = request.getParameter("srno")==null?"0":request.getParameter("srno").trim();   
	ClsPropertyManagementDAO DAO= new ClsPropertyManagementDAO();
%>
<script type="text/javascript">
       var rntldata;
       rntldata='<%=DAO.getRentalCancelData(id,docno,srno)%>';               

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
                        {name : 'cancelbtn', type: 'String'  }, 
                        {name : 'docno', type: 'String'  }, 
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
        height: 250,
        source: dataAdapter,
        enableAnimations: true,
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlecell',                 
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
				   { text: 'docno', datafield: 'docno', width: '6%', editable: false,hidden:true},
	               { text: 'Client', datafield: 'refname', editable: false},       
	               { text: 'From Date', datafield: 'fromdate', width: '8%',cellsformat:'dd.MM.yyyy', editable: false},
	               { text: 'To Date', datafield: 'todate', width: '8%',cellsformat:'dd.MM.yyyy', editable: false},
	               { text: 'Total', datafield: 'totalval', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right', editable: false},  
	               { text: 'Description', datafield: 'remarks', width: '30%', editable: false},
	               { text: '', datafield: 'cancelbtn',columntype:'button', width: '7%'},            
	         ]    
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxRentalGrid').on('cellclick', function (event) {                
        var rowindex2 = event.args.rowindex; 
        var datafield = event.args.datafield; 
        var rntldocno=$('#jqxRentalGrid').jqxGrid('getcellvalue', rowindex2, "docno");
        if(datafield=="cancelbtn"){
    	  funcancelrental(rntldocno);      
        }
    }); 
});
</script>
<div id="jqxRentalGrid"></div>