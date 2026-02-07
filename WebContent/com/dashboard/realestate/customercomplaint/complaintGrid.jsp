<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.customercomplaint.ClsCustomerComplaintDAO"%>
<%
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    ClsCustomerComplaintDAO DAO= new ClsCustomerComplaintDAO();
%>       
<script type="text/javascript">
       var rntldata;
       rntldata='<%=DAO.getComplaintData(id)%>';                                

$(document).ready(function () {   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'name', type: 'String'  },
                        {name : 'docno', type: 'String'  }, 
                        {name : 'mob', type: 'String'  }, 
                        {name : 'complaint', type: 'String'  }, 
                        {name : 'description', type: 'String'  },   
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
	               { text: 'Mobile', datafield: 'mob', editable: false, width: '12%'},       
	               { text: 'Room No', datafield: 'roomno', width: '8%', editable: false},
	               { text: 'Complaint', datafield: 'complaint', width: '30%', editable: false},
	               { text: 'Description', datafield: 'description', width: '30%', editable: false}, 
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