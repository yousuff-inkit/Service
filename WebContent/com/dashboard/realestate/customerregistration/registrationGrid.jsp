<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.customerregistration.ClsCustomerRegistrationDAO"%>
<%
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    ClsCustomerRegistrationDAO DAO= new ClsCustomerRegistrationDAO();    
    String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

%>
<script type="text/javascript">
       var rntldata;
       rntldata='<%=DAO.getRegistrationData(id,fromdate,todate)%>';                                   
   
$(document).ready(function () {
    // prepare the data  
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'name', type: 'String'  },
                        {name : 'date', type: 'Date'  },
                        {name : 'time', type: 'String'  },   
                        {name : 'docno', type: 'String'  }, 
                        {name : 'mob', type: 'String'  }, 
                        {name : 'email', type: 'String'  }, 
                        {name : 'purpose', type: 'String'  }, 
                        {name : 'type', type: 'String'  }, 
                        {name : 'status', type: 'String'  },   
                        {name : 'roomno', type: 'String'  }, 
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
    
    $("#jqxCusRegGrid").jqxGrid(
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
				   { text: 'docno', datafield: 'docno', width: '6%', editable: false,hidden:true},
				   { text: 'Name', datafield: 'name', editable: false},          
				   { text: 'date', datafield: 'date', editable: false, width: '5%',cellsformat:'dd.MM.yyyy'},
				   { text: 'time', datafield: 'time', editable: false, width: '5%',cellsformat:'HH.mm.ss'},   
	               { text: 'Email', datafield: 'email', editable: false, width: '12%'},       
	               { text: 'Room No', datafield: 'roomno', width: '8%', editable: false},
	               { text: 'Purpose Of Visit', datafield: 'purpose', width: '30%', editable: false}, 
	               { text: 'Status', datafield: 'status', width: '8%', editable: false}, 
	         ]       
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxCusRegGrid').on('rowdoubleclick', function (event) {                            
        var rowindex2 = event.args.rowindex;    
         document.getElementById("hiddocno").value=$('#jqxCusRegGrid').jqxGrid('getcellvalue', rowindex2, "docno");
        document.getElementById("hidlblname").value=$('#jqxCusRegGrid').jqxGrid('getcellvalue', rowindex2, "name");
        document.getElementById("selectedrow").innerHTML=$('#jqxCusRegGrid').jqxGrid('getcellvalue', rowindex2, "name");        
        $('.comments-container').html('');          
    }); 
});
</script>
<div id="jqxCusRegGrid"></div>    