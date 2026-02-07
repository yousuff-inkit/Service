<%@page import="com.dashboard.skips.dispatch.ClsDispatchDAO"%>
<%   
ClsDispatchDAO sd=new ClsDispatchDAO();                   
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();  
String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();  
 %>           
 <script type="text/javascript">
 var data; 
 var id ='<%=check %>'; 
 
 if(id!=0){
	  data ='<%=sd.disflwupgridsummary(docno,check) %>'; 
	  //alert(data);
 }else{
	 data;  
	 //alert(data);
 }
 
                         
         $(document).ready(function () {          
      
         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'rdocno', type: 'String' },  
     						{name : 'rdtype', type: 'String'},
     						{name : 'asuser', type: 'String'},
     						{name : 'status', type: 'String'},
     						{name : 'date', type: 'date'},
     						{name : 'receivedby', type: 'String'},
     						{name : 'ackdate', type: 'date'},
     						{name : 'remarks', type: 'String'},
     						{name : 'userid', type: 'String'},
     						{name : 'edate', type: 'String'},

                          	],
                          	localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
         
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#disfollowupGrid2").jqxGrid({ 
            	width: '100%',
                height: 120,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                enabletooltips:true,
                filterable: true,
                sortable: true,
                editable:false,
     					  
                columns: [
							{ text: 'Doc_no', datafield: 'rdocno', width: '10%' },
							{ text: 'Dtype', datafield: 'rdtype', width: '10%' },
							{ text: 'User', datafield: 'asuser', width: '15%' },
							{ text: 'Status', datafield: 'status', width: '12%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Received By', datafield: 'receivedby', width: '8%' },
							{ text: 'Acknowledged Date', datafield: 'ackdate', width: '8%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Remarks', datafield: 'remarks' },
							{ text: 'UserId', datafield: 'userid', width: '10%' },
					]
            });
            $("#overlay, #PleaseWait").hide();
           
        });
                       
</script>
<div id="disfollowupGrid2"></div>