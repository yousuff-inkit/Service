<%@page import="com.dashboard.it.presalesmanagementit.*"%>
     <%
     ClsPresalesmanagementDAO cmd= new ClsPresalesmanagementDAO();
     %>
<% String doc =request.getParameter("doc")==null?"0":request.getParameter("doc").toString();
String enqdocno =request.getParameter("enqdocno")==null?"0":request.getParameter("enqdocno").toString();%>
 

 <script type="text/javascript">
 
 var data1 ='<%=cmd.loadSubGridData(doc,enqdocno)%>';
        $(document).ready(function () { 

         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'detdate', type: 'date' },
                 			{name : 'rdtype', type: 'String'},
     						{name : 'user', type: 'String'},
     						{name : 'remk', type: 'String'},
     						{name : 'fdate' , type : 'date'}
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
							{ text: 'Doc Type', datafield: 'rdtype', width: '15%' },
							{ text: 'User', datafield: 'user', width: '18%' },
							{ text: 'Follow-Up Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy'},	
							{ text: 'Remarks', datafield: 'remk', width: '62%' },
					]
            });
         
           
        });
                       
</script>
<div id="amcfollowupGrid"></div>