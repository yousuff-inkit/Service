<%@page import="com.inkit.enquiry.ClsEnquiryDAO" %>
<%ClsEnquiryDAO DAO= new ClsEnquiryDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String projectsownername = request.getParameter("projectsownername")==null?"0":request.getParameter("projectsownername");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
        
       var podata= '<%=DAO.projectOwnerDetailsSearch(projectsownername, chk)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'owner', type: 'String'  },
     						{name : 'ownerid', type: 'int'  }
                        ],
                		 localdata: podata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxownersearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
							},
							{ text: 'Name', datafield: 'owner', width: '94%' },
							{ text: 'Doc No', datafield: 'ownerid', width: '10%',hidden: true }
						]
            });
            
             $('#jqxownersearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("txtprojectowner").value=$('#jqxownersearch').jqxGrid('getcellvalue', rowindex1, "owner");
	            document.getElementById("projectownerid").value=$('#jqxownersearch').jqxGrid('getcellvalue', rowindex1, "ownerid");
       
         		$('#ownerinfowindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="jqxownersearch"></div>
 