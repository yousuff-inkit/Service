<%@ page import="com.dashboard.client.customercomplaint.ClsCustomerComplaintDAO" %>
<% ClsCustomerComplaintDAO DAO=new ClsCustomerComplaintDAO();%>

<% String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
  String type = request.getParameter("type")==null?"0":request.getParameter("type");%>
    

 <script type="text/javascript">
 
var data;

	data='<%=DAO.GridLoading(check,type)%>';
	
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                   
 						{name : 'rowno', type: 'int' },
 						{name : 'edate', type: 'date' },
 						{name : 'name', type: 'String' },
 						{name : 'mob', type: 'String' },
 						{name : 'roomno', type: 'String' },
 						{name : 'complaint', type: 'String' },
 						{name : 'description', type: 'date' },
 						{name : 'status', type: 'int' },
 						{name : 'rdocno', type: 'int' },
 						],
				    localdata: data,
        
        
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
   
    $("#custcomp").jqxGrid(
    {
        width: '99%',
        height: 300,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow:true,
        sortable:true,
        columnsresize:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'Sr No', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                    
					{ text: 'Row No',  datafield: 'rowno', width: '10%',hidden:true },
					 { text: 'Date', datafield: 'edate', width: '10%',cellsformat: 'dd.MM.yyyy hh:mm'},
					  { text: 'Name', datafield: 'name', width: '20%'},
					 { text: 'Mobile No', width: '15%', datafield: 'mob' },
					 { text: 'Room No',  datafield: 'roomno', width: '6%' },
					 { text: 'Complaint', width: '15%', datafield: 'complaint' },
					 { text: 'Description', width: '30%', datafield: 'description' },
					 { text: 'Doc No', width: '30%', datafield: 'rdocno',hidden:true },
						{ text: 'Status', width: '6%', datafield: 'status',hidden:true },
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    $('#custcompDiv').on('rowdoubleclick', function (event) { 
   	 var rowindex1=event.args.rowindex;
   	
         $('#rdocno').val($('#custcomp').jqxGrid('getcellvalue', rowindex1, "rowno"));
         
		  var check = 1;
  		
         $("#docdetailsDiv").load("FollowUpGrid.jsp?rdocno="+$('#custcomp').jqxGrid('getcellvalue', rowindex1, 'rowno')+'&check='+check);
         }); 
    
   
});


</script>
<div id="custcomp"></div>

