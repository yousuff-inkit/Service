<%@page import="com.inkit.enquiry.ClsEnquiryDAO" %>
<%ClsEnquiryDAO DAO= new ClsEnquiryDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String clientsname = request.getParameter("clientsname")==null?"0":request.getParameter("clientsname");
 String clientdetails = request.getParameter("clientdetails")==null?"0":request.getParameter("clientdetails");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
        
       var data= '<%=DAO.clientDetailsSearch(clientsname, clientdetails, chk)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'clientname', type: 'String'  },
     						{name : 'clientdet', type: 'String'  },
     						{name : 'clientid', type: 'int'  },
     						{name : 'clientcur_id', type: 'int'  }
                        ],
                		 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxclientsearch").jqxGrid(
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
							{ text: 'Name', datafield: 'clientname', width: '50%' },
							{ text: 'Contact', datafield: 'clientdet', width: '45%' },
							{ text: 'ClientId', datafield: 'clientid', width: '25%',hidden: true },
							{ text: 'ClientCurId', datafield: 'clientcur_id', width: '25%',hidden: true }
						]
            });
            
             $('#jqxclientsearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("txtclientname").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "clientname");
	            document.getElementById("txtclientdet").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "clientdet");
	            document.getElementById("clientid").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "clientid");
	            document.getElementById("clientcurid").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "clientcur_id");
       
         		$('#clientinfowindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="jqxclientsearch"></div>
 