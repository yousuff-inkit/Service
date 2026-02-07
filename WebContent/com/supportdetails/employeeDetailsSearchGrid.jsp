<%@page import="com.supportdetails.ClsSupportDetailsDAO" %>
<% ClsSupportDetailsDAO sd=new ClsSupportDetailsDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <script type="text/javascript">
 
	var data1='<%=sd.empNameLoading()%>';
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'int'   },
 						{name : 'name', type: 'string'   }
                    ],
            		localdata: data1, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#employeeSearch").jqxGrid(
        {
        	width: '100%',
        	height: 350,
            source: dataAdapter,
            selectionmode: 'singlerow',
            showfilterrow: true, 
            filterable: true, 
 			editable: false,
 			columnsresize: true,
            
            columns: [
						{  text: 'Sr. No.', sortable: false, filterable: false, editable: false,
						    groupable: false, draggable: false, resizable: false,datafield: '',
						    columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
						    cellsrenderer: function (row, column, value) {
							   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						   }  
						},  
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Name', datafield: 'name', width: '90%' },
					]
        });
        
	        $('#employeeSearch').on('rowdoubleclick', function (event) {
	            var rowindex1 = event.args.rowindex;
	        	document.getElementById("txtempname").value = $('#employeeSearch').jqxGrid('getcellvalue', rowindex1, "name");
	        	document.getElementById("txtempid").value = $('#employeeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	        	
	            $('#employeeDetailsWindow').jqxWindow('close');  
	        });  
    });
</script>

<div id="employeeSearch"></div>
    