<%@page import="com.dashboard.skips.contractlpofollowup.ClsContractLPOFollowupDAO" %>   
     <%
     ClsContractLPOFollowupDAO cmd= new ClsContractLPOFollowupDAO();  
     %>
<% String contrno =request.getParameter("contrno")==null?"0":request.getParameter("contrno").toString();%>
 

 <script type="text/javascript">
 
 var data1 ='<%=cmd.loadSubGridData(contrno)%>';     
        $(document).ready(function () { 

         var source = 
            {
                datatype: "json",
                datafields: [
						{name : 'contrno', type: 'String'},
 						{name : 'contdet', type: 'int'},
 						{name : 'edate', type: 'date'},
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
            	width: '100%',
                height: 200,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					
                columns: [
					        { text: 'Contr.No', datafield: 'contrno', width: '15%',hidden:true },
					        { text: 'Contract Details', datafield: 'contdet', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true},
							{ text: 'Date', datafield: 'edate', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'User', datafield: 'user', width: '15%' },
							{ text: 'Follow-Up Date', datafield: 'fdate', width: '8%',cellsformat:'dd.MM.yyyy'},	
							{ text: 'Remarks', datafield: 'remk' },
					]
            });
            $("#overlay, #PleaseWait").hide(); 
           
        });
                       
</script>
<div id="amcfollowupGrid"></div>