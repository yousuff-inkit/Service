<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.schedulemanagement.ClsScheduleManagementDAO"%>
<%
ClsScheduleManagementDAO searchDAO = new ClsScheduleManagementDAO();
%>  

 
<script type="text/javascript">


var locdata= '<%=searchDAO.searchDump(session) %>';   
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'doc_no', type: 'String'  },      
      						 {name : 'dump', type: 'String'  },
                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#dumpGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
                
                columns: [
                          
          				{ text: 'Doc No', datafield: 'doc_no', width: '20%'},
    					{ text: 'Dump Site', datafield: 'dump', width: '80%',editable:false }
										
						]
            });
            
             $('#dumpGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
 
                document.getElementById("hiddumpsiteid").value = $('#dumpGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtdumpsite").value = $('#dumpGrid').jqxGrid('getcellvalue', rowindex1, "dump");

              $('#dumpsearchwndow').jqxWindow('close');  
        
            }); 
             
        });
    </script>
    <div id="dumpGrid"></div>