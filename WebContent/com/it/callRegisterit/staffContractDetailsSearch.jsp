<%@page import="com.it.callRegisterit.ClsCallRegisterDAO"%>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
%>
<script type="text/javascript">
      	
       var data5= '<%=DAO.staffContractDetailsSearch (cldocno)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'refno', type: 'string'   },
       						{name : 'refname', type: 'string'   },
     						
                        ],
                		 localdata: data5,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#staffContractDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 340,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
							{ text: 'Ref No', datafield: 'refno', width: '20%' },
							{ text: 'Cleint', datafield: 'refname' },
							]
            });
            
             $('#staffContractDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcontractno").value = $('#staffContractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	document.getElementById("txtcontracttrno").value = $('#staffContractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "refno");
                document.getElementById("txtcontractdetails").value = $('#staffContractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "refname");
				
            	document.getElementById("txtsiteid").value = "0";
            	document.getElementById("txtsite").value = "";
            					
            	$("#callRegisterPendingDiv").load("callRegisterPendingGrid.jsp?contractno="+$('#staffContractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "refno")+"&contracttype="+$("#cmbcontracttype").val());
				
            	$('#contractDetailsWindow').jqxWindow('close'); 
            });  
        });
 
</script>
<div id="staffContractDetailsSearch"></div>
 