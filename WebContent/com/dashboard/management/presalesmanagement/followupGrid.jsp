<%@page import="com.dashboard.management.presalesmanagement.ClsPresalesManagementDAO"%>  
     <%
     ClsPresalesManagementDAO cmd= new ClsPresalesManagementDAO();
     %>
<% String reftype =request.getParameter("reftype")==null?"0":request.getParameter("reftype").toString();
String docno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString();%>
 

 <script type="text/javascript">
 
        $(document).ready(function () { 
         var data2 ='<%=cmd.loadSubGridData(reftype,docno)%>';          
         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'date', type: 'date' },
     						{name : 'user', type: 'String'},
     						{name : 'remarks', type: 'String'},
     						{name : 'fdate' , type : 'date'},
                          	],
                          	localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#jqxFlwpGrid").jqxGrid({ 
            	width: '100%',
                height: 120,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					
                columns: [
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},    
							{ text: 'User', datafield: 'user', width: '15%' },  
							{ text: 'Follow-Up Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy'},	
							{ text: 'Remarks', datafield: 'remarks'},        
					]
            });
        });
                       
</script>
<div id="jqxFlwpGrid"></div>   