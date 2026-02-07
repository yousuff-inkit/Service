 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.skips.enquiry.ClsEnquiryDAO" %>
 
<%
   ClsEnquiryDAO DAO=new ClsEnquiryDAO();   
   String act = request.getParameter("act")==null || request.getParameter("act").equals("")?"0":request.getParameter("act").trim();
 %>
 <script type="text/javascript">
 
 var radata; 
 var rowIndex = '<%=request.getParameter("rowBoundIndex")%>';
 var act = '<%=act%>';      
 
        $(document).ready(function () {
        	
        	 radata='<%=DAO.activitySearch(session)%>'; 
            
        	var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'aydocno', type: 'string'  },
     						{name : 'ay_name', type: 'String'  },
                          	],
                          	localdata: radata,
                          //	 url: url1,
          
				
                
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
            $("#jqxdesigsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '6%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'activityid', datafield: 'aydocno', width: '94%',hidden:true },
					{ text: 'Name', datafield: 'ay_name', width: '94%' },  
					]
            });
				            
			 $('#jqxdesigsearch').on('rowdoubleclick', function (event) { 
				              	var rowindex1=event.args.rowindex;
				              	if(parseInt(act)==1){     
				              		$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "activity",$('#jqxdesigsearch').jqxGrid('getcellvalue', rowindex1, "ay_name"));
			               			$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "activity_id",$('#jqxdesigsearch').jqxGrid('getcellvalue', rowindex1, "aydocno"));
			               			$('#activityinfowindow').jqxWindow('close');
				              	}else{
				              		document.getElementById("txtdesig").value=$('#jqxdesigsearch').jqxGrid('getcellvalue', rowindex1, "ay_name");
						            document.getElementById("activityid").value=$('#jqxdesigsearch').jqxGrid('getcellvalue', rowindex1, "aydocno");
						            $('#desiginfowindow').jqxWindow('close');
				              	}
				                 
			 }); 	 
           }); 
    </script>
    <div id="jqxdesigsearch"></div>
    </body>
</html>