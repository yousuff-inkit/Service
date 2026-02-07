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
       var rntlhisdata;
       rntlhisdata='<%=DAO.getRentalData(id,docno,srno)%>';        

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
						],
				    localdata: rntlhisdata,
        
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
    
    $("#jqxrntlHistoryGrid").jqxGrid(
    {
        width: '100%',
        height: 250,
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
        editable:false,
        columns: [   
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '4%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },  
	               { text: 'Client', datafield: 'refname'},       
	               { text: 'From Date', datafield: 'fromdate', width: '8%',cellsformat:'dd.MM.yyyy'},
	               { text: 'To Date', datafield: 'todate', width: '8%',cellsformat:'dd.MM.yyyy'},
	               { text: 'Total', datafield: 'totalval', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right'},  
	               { text: 'Description', datafield: 'remarks', width: '30%'},
	         ] 
    });
    $("#overlay, #PleaseWait").hide();           
});
</script>
<div id="jqxrntlHistoryGrid"></div>