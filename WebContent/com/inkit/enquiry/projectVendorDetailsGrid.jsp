<%@page import="com.inkit.enquiry.ClsEnquiryDAO" %>
<%ClsEnquiryDAO DAO= new ClsEnquiryDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 int vendortype =request.getParameter("vendortype")==null?0:Integer.parseInt(request.getParameter("vendortype").trim());
 String projectsvendorname = request.getParameter("projectsvendorname")==null?"0":request.getParameter("projectsvendorname");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
        
	   var value = '<%=vendortype%>';
       var pvdata= '<%=DAO.projectVendorDetailsSearch(projectsvendorname, chk)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'vendor', type: 'String'  },
     						{name : 'vendorid', type: 'int'  }
                        ],
                		 localdata: pvdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxvendorsearch").jqxGrid(
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
							{ text: 'Name', datafield: 'vendor', width: '94%' },
							{ text: 'Doc No.', datafield: 'vendorid', width: '10%',hidden: true }
						]
            });
            
             $('#jqxvendorsearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                if(value==0){	
		    	      document.getElementById("txtvendor").value=$('#jqxvendorsearch').jqxGrid('getcellvalue', rowindex1, "vendor");
				      document.getElementById("vendorid").value=$('#jqxvendorsearch').jqxGrid('getcellvalue', rowindex1, "vendorid");   
		    	}
		    	
                if(value==1){	
		    	      document.getElementById("txtsubsupplier").value=$('#jqxvendorsearch').jqxGrid('getcellvalue', rowindex1, "vendor");
				      document.getElementById("subvendorid").value=$('#jqxvendorsearch').jqxGrid('getcellvalue', rowindex1, "vendorid");   
		    	}
				      
		        $('#vendorinfowindow').jqxWindow('close'); 
            });  
             
        });
</script>
<div id="jqxvendorsearch"></div>
 