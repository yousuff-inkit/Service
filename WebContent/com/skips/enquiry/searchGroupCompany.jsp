<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.skips.enquiry.ClsEnquiryDAO"%>
<%
ClsEnquiryDAO searchDAO = new ClsEnquiryDAO();
%> 

 
<script type="text/javascript">


var locdata= '<%=searchDAO.searchGroupCompany(session) %>';     
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'docno', type: 'String'  },    
      						 {name : 'grpcmp', type: 'String'  },   
                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxgrpcmpGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
                
                columns: [
                          
          				{ text: 'ID', datafield: 'docno', width: '20%',hidden:true},
    					{ text: 'Group Company', datafield: 'grpcmp', width: '100%' }  
										
						]
            });
            
             $('#jqxgrpcmpGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
 
                 document.getElementById("errormsg").innerText="";   
                document.getElementById("hidgrpcmpid").value = $('#jqxgrpcmpGrid').jqxGrid('getcellvalue', rowindex1, "docno"); 
                document.getElementById("grpcmp").value = $('#jqxgrpcmpGrid').jqxGrid('getcellvalue', rowindex1, "grpcmp");

              $('#grpcmpinfowindow').jqxWindow('close');  
        
            }); 
             
        });
    </script>
    <div id="jqxgrpcmpGrid"></div> 