<%@page import="com.inkit.enquiry.ClsEnquiryDAO"%>
<% ClsEnquiryDAO DAO=new ClsEnquiryDAO();
   String enqdocno =request.getParameter("enq_id")==null?"0":request.getParameter("enq_id").trim();%>
<script type="text/javascript">
        
        var detailsinspdata='<%=DAO.inspGridLoad(enqdocno)%>';

        $(document).ready(function () { 	
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'inspname', type: 'string' },
							{name : 'priority', type: 'string' },
							{name : 'insp_id', type: 'int' }
                        ],
                		    localdata: detailsinspdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxEnqInspectorDetails").jqxGrid(
            {
            	width: '95%',
                height: 300,
                source: dataAdapter,
                editable: false,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable: true,
                showfilterrow: true,
                    
                columns: [
							{  text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							   groupable: false, draggable: false, resizable: false,datafield: '',
							   columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
							   cellsrenderer: function (row, column, value) {
							   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							   }  
							},  
							{ text: 'Inspector', datafield: 'inspname', width: '70%', editable: false },
							{ text: 'Priority', datafield: 'priority', width: '20%' },
							//{ text: 'Available Date', datafield: 'avldate', width: '40%', editable: false },
							{ text: 'InspectorId', datafield: 'insp_id', width: '10%', editable: false, hidden: true }
						]
            });
            
            $('#jqxEnqInspectorDetails').on('rowdoubleclick', function (event) {
            	$('#inspdetailsinfowindow').jqxWindow('close');
	        });

        });
</script>
<div id="jqxEnqInspectorDetails"></div>