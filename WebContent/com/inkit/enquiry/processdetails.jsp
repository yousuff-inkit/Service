<%@page import="com.inkit.enquiry.ClsEnquiryDAO"%>
<%
 ClsEnquiryDAO DAO=new ClsEnquiryDAO();
 String edocno =request.getParameter("edocno")==null?"0":request.getParameter("edocno").trim();
%>

<script type="text/javascript">

		var edocno;
		edocno='<%=edocno%>';
        var procdata;
        $(document).ready(function () { 	
        	    
        	procdata='<%=DAO.processGridLoad(edocno) %>';   
        	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'user', type: 'string' },
							{name : 'status', type: 'string' },
							{name : 'statusid', type: 'int' },
							{name : 'date', type: 'date' },,
							{name : 'remarks', type: 'string' },
                        ],
                		    localdata: procdata, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxProcessdet").jqxGrid(
            {
                width: '95%',
                height: 300,
                source: dataAdapter,
                editable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable: true,
                showfilterrow: true,
                
                columns: [
							{  text: 'SL#', sortable: false, filterable: false, editable: false,
							   groupable: false, draggable: false, resizable: false,datafield: '',
							   columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							   cellsrenderer: function (row, column, value) {
							   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							   }  
							},
							{ text: 'Status', datafield: 'status', width: '20%', editable: false},
							{ text: 'User', datafield: 'user', width: '20%', editable: false},
							{ text: 'Date and Time', datafield: 'date', width: '15%', cellsformat: 'dd.MM.yyyy H:mm', editable: false},
							{ text: 'Remarks', datafield: 'remarks', width: '40%', editable: false},
							{ text: 'status_id', datafield: 'status_id', width: '10%',hidden: true}
						]
            });
            
            /* if(document.getElementById("mode").value=='view')
			{
			$('#jqxGuidelines').jqxGrid({ disabled: true});
			}
            $("#jqxGuidelines").jqxGrid('addrow', null, {}); */
            
        });

</script>
<div id="jqxProcessdet"></div>
<input type="hidden" id="rowindex"/>