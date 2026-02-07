<%@page import="com.inkit.enquiry.ClsEnquiryDAO"%>
<% ClsEnquiryDAO DAO=new ClsEnquiryDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <script type="text/javascript">
 
 	var fredata;
 	fredata='<%=DAO.frequencySearch(session)%>';
        $(document).ready(function () { 
          
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'frequencyid', type: 'int'  },
     						{name : 'frequency', type: 'String'  },
                          	],
                          	localdata: fredata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            
            $("#jqxfrequencysearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable: true,
                showfilterrow: true,
            
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'frequencyid', width: '30%', hidden: true },
					{ text: 'Frequency', datafield: 'frequency', width: '92%' }
					]
            });
    
				            
	           $('#jqxfrequencysearch').on('rowdoubleclick', function (event) { 
	        	        var rowIndex =$('#rowindex').val();
	              	    var rowindex1=event.args.rowindex;
	            	  
	               	    $('#jqxJobDetails').jqxGrid('setcellvalue', rowIndex, "frequency",$('#jqxfrequencysearch').jqxGrid('getcellvalue', rowindex1, "frequency"));
	               		$('#jqxJobDetails').jqxGrid('setcellvalue', rowIndex, "frequencyid",$('#jqxfrequencysearch').jqxGrid('getcellvalue', rowindex1, "frequencyid"));
	              
	               		var rows = $('#jqxJobDetails').jqxGrid('getrows');
	      	            var rowlength= rows.length;
	      	            var rowindex2 = rowlength - 1;
	      	          	var serviceid=$("#jqxJobDetails").jqxGrid('getcellvalue', rowindex2, "serviceid");
	      	          	if(typeof(serviceid) != "undefined" && serviceid != ""){
	      	          		$("#jqxJobDetails").jqxGrid('addrow', null, {});
	      	          	}
	      	          	
	                    $('#frequencyinfowindow').jqxWindow('close');
	            
	           }); 	 
				           
        
}); 
				                              
</script>
<div id="jqxfrequencysearch"></div>
    
</body>
</html>