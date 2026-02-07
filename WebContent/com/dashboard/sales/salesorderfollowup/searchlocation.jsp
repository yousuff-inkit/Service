<%@page import="com.dashboard.sales.salesorderfollowup.ClsSalesOrderFollowupDAO"%>
<%ClsSalesOrderFollowupDAO DAO = new ClsSalesOrderFollowupDAO();%>
<% 	String brhid = (request.getParameter("brhid")==null||request.getParameter("brhid")=="")?"0":request.getParameter("brhid").trim(); %>
<% 	String type = (request.getParameter("type")==null||request.getParameter("type")=="")?"0":request.getParameter("type").trim(); %>
<script type="text/javascript">

var type='<%=type%>';
var locdata= '<%=DAO.locationSearch(brhid) %>';   
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'doc_no', type: 'String'  },    
      						 {name : 'loc_name', type: 'String'  },
                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#locgrid").jqxGrid(
            {
                width: '100%',
                height: 335,
                source: dataAdapter,
                selectionmode: 'singlerow',
                columns: [
                          
          				{ text: 'ID', datafield: 'doc_no', width: '20%',hidden:true},
    					{ text: 'NAME', datafield: 'loc_name', width: '100%' }
										
						]
            });
            
             $('#locgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
 
            	if(type=="DEL"){
            		$('#txtlocationdel').val($('#locgrid').jqxGrid('getcellvalue',rowindex1,'loc_name'));
					$('#hidlocationiddel').val($('#locgrid').jqxGrid('getcellvalue',rowindex1,'doc_no'));
              	}else{
					$('#txtlocation').val($('#locgrid').jqxGrid('getcellvalue',rowindex1,'loc_name'));
					$('#hidlocationid').val($('#locgrid').jqxGrid('getcellvalue',rowindex1,'doc_no'));
              	}
            	
              	$('#locationwindow').jqxWindow('close');  
            }); 
             
        });
    </script>
    <div id="locgrid"></div>