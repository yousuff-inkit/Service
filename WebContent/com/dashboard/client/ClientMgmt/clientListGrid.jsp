<%@page import="com.dashboard.client.clientmgmt.ClsClientManagementDAO" %>
<%
ClsClientManagementDAO ccd=new ClsClientManagementDAO();
%>

<% String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<script type="text/javascript">
 var temp='<%=check%>';
 
 var data;
 	if(temp=="1") {  
	 	data = '<%=ccd.clientListGridLoading(check)%>';  
	}
 
        $(document).ready(function () { 
        	
        	var source =
            {
                localdata: data,
                datafields:
                [
                    { name: 'category', type: 'string' },
                    { name: 'refname', type: 'string' },
                    { name: 'per_mob', type: 'string' },
                    { name: 'sal_name', type: 'string' },
                    { name: 'address', type: 'string' },
                    { name: 'mail1', type: 'string' },
                    { name: 'crdprd', type: 'number' },
                    { name: 'crdlmt', type: 'number' },
                    { name: 'trnnumber', type: 'string' },
                    { name: 'date', type: 'date' },
                    { name: 'code', type: 'number' },
                    { name: 'acno', type: 'number' },
                    { name: 'accgroup', type: 'String' },
                    { name: 'crmaxdays', type: 'number' },
                    { name: 'tel', type: 'String' },
                    { name: 'area', type: 'String' },
                    { name: 'city', type: 'String' },
                    {name : 'cldocno', type: 'String'  },
                    {name : 'sal_id', type: 'String'  },
                    {name : 'brhid', type: 'String'  },
                    { name: 'country', type: 'String' }
                ],
                datatype: "json",
                updaterow: function (rowid, rowdata) {
                    // synchronize with the server - send update command   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            // initialize jqxGrid 
            $("#jqxClientGrid").jqxGrid(
            {
                width: '99.5%',
				height: 500,
                source: dataAdapter,
                selectionmode: 'singlerow',
                enabletooltips:true,
                filterable: true,
                showfilterrow: true,
                columnsresize: true,
                columns: [
				  { text: 'Date',  datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy' },   
				  { text: 'Code',  datafield: 'code', width: '4%' },
				  { text: 'Name',  datafield: 'refname', width: '17%' },
				  { text: 'A/c No',  datafield: 'acno', width: '5%' },
                  { text: 'Category',  datafield: 'category', width: '7%' },
                  { text: 'Acc. Group',  datafield: 'accgroup', width: '8%' },
                  { text: 'Salesman',  datafield: 'sal_name', width: '7%' },
                  { text: 'TRN No',  datafield: 'trnnumber', width: '6%' },    
                  { text: 'Credit Period Min',  datafield: 'crdprd', width: '7%',cellsalign:'right',align:'right' },
                  { text: 'Credit Period Max',  datafield: 'crmaxdays', width: '7%',cellsalign:'right',align:'right' },
                  { text: 'Credit Limit',  datafield: 'crdlmt', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right' },
                  { text: 'Address',  datafield: 'address', width: '16%' },   
                  { text: 'Telephone',  datafield: 'tel', width: '7%' },
                  { text: 'Mobile',  datafield: 'per_mob', width: '9%' },
                  { text: 'Email Id',  datafield: 'mail1', width: '13%' },
                  { text: 'Area',  datafield: 'area', width: '12%' },
                  { text: 'City',  datafield: 'city', width: '7%' },
                  { text: 'Country',  datafield: 'country', width: '7%' },
                  { text: 'cldocno',  datafield: 'cldocno', width: '7%',hidden:true },
                  { text: 'salesman',  datafield: 'sal_id', width: '7%',hidden:true },
                  { text: 'branchid',  datafield: 'brhid', width: '7%',hidden:true },
                  
                  
				  
                ],
				
				
            });
    
            $("#overlay, #PleaseWait").hide();
            $('#jqxClientGrid').on('rowdoubleclick', function (event) 
            		{ 
		               var rowindex1=event.args.rowindex;
		            
		               document.getElementById("creditmin").value=$('#jqxClientGrid').jqxGrid('getcellvalue', rowindex1, "crdprd");
		               document.getElementById("creditmax").value=$('#jqxClientGrid').jqxGrid('getcellvalue', rowindex1, "crmaxdays"); 
		               document.getElementById("txtcreditlimit").value=$('#jqxClientGrid').jqxGrid('getcellvalue', rowindex1, "crdlmt");
		               document.getElementById("cldocno").value=$('#jqxClientGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
		               document.getElementById("cmbsalesman").value=$('#jqxClientGrid').jqxGrid('getcellvalue', rowindex1, "sal_id");
		               document.getElementById("brhid").value=$('#jqxClientGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
		               
		               document.getElementById("lblname").value=$('#jqxClientGrid').jqxGrid('getcellvalue', rowindex1, "refname"); 
		               $('.textpanel p').text($('#jqxClientGrid').jqxGrid('getcellvalue', rowindex1, "refname"));    
            		 });       	           
}); 
				                              
</script>

<div id="jqxClientGrid"></div>