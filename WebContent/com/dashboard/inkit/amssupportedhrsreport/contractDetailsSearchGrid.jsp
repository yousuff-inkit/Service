<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.inkit.amssupportedhrsreport.ClsAmsSupportedHrsDAO"%>  
<% ClsAmsSupportedHrsDAO DAO=new ClsAmsSupportedHrsDAO(); %>
 <%
 String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); 
 String type = request.getParameter("type")==null?"1":request.getParameter("type");
 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate");
 %>
 
<script type="text/javascript">
		var type=<%=type%>;
        var contractData= '<%=DAO.contractDetailsSearch(session,contractno,type,todate,check)%>';  
        $(document).ready(function () { 
            // prepare the datad
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'brhid', type: 'int' },
							{name : 'doc_no', type: 'int' },
							{name : 'voc_no', type: 'int' },
     						{name : 'client', type: 'string' },
     						{name : 'partnerclient', type: 'string' },
     						{name : 'refno', type: 'string' },
                        ],
                		 localdata: contractData,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#contractDetailsSearch").jqxGrid(
            {
                width: '99.5%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                columns: [
							{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Client', datafield: 'client', width: '40%' },
							{ text: 'Partner Client', datafield: 'partnerclient', width: '40%' },
							{ text: 'Ref No', datafield: 'refno', width: '10%' },
							{ text: 'brhid', datafield: 'brhid', hidden:true },
							{ text: 'doc_no', datafield: 'doc_no', hidden:true },
						]
            });
            
             $('#contractDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                if(type=='1'){
                	document.getElementById("txtcontract").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
                	document.getElementById("txtcontracttrno").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                }else{
                	document.getElementById("txtcontractvocno").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
                	document.getElementById("hidcontractdocno").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                	document.getElementById("txtcontractdet").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "client");
                	document.getElementById("hidbrhid").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "brhid");
                }
            	
                $('#contractDetailsWindow').jqxWindow('close'); 
            });  
        });
 
</script>
<div id="contractDetailsSearch"></div>
 