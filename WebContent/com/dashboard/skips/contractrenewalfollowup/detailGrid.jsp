<%@page import="com.dashboard.skips.contractrenewalfollowup.ClsContractRenewalFollowupDAO" %>   
     <%
     ClsContractRenewalFollowupDAO cmd= new ClsContractRenewalFollowupDAO();  
     %>
<% String rowno =request.getParameter("rowno")==null?"0":request.getParameter("rowno").toString();%>
 

 <script type="text/javascript">
 
 var data1 ='<%=cmd.loadSubGridData(rowno)%>';     
        $(document).ready(function () { 

         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'detdate', type: 'date' },
     						{name : 'user', type: 'String'},
     						{name : 'remk', type: 'String'},
     						{name : 'fdate' , type : 'date'},
     						/* {name : 'status', type: 'String'}, */ 
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#amcfollowupGrid").jqxGrid({ 
            	width: '99%',
                height: 160,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					
                columns: [
							{ text: 'Date', datafield: 'detdate', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'User', datafield: 'user', width: '15%' },
							{ text: 'Follow-Up Date', datafield: 'fdate', width: '8%',cellsformat:'dd.MM.yyyy'},	
							/* { text: 'Status', datafield: 'status', width: '15%' }, */  
							{ text: 'Remarks', datafield: 'remk' },
					]
            });
            $("#overlay, #PleaseWait").hide(); 
           
        });
                       
</script>
<div id="amcfollowupGrid"></div>