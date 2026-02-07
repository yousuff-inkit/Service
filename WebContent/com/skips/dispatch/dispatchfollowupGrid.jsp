<%@page import="com.skips.dispatch.ClsDispatchDAO"%>
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
	  data ='<%=sd.disflwupgrid(docno,check) %>';
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
                 			{name : 'date', type: 'date' },  
     						{name : 'user', type: 'String'},
     						{name : 'asuser', type: 'String'},
     						{name : 'remark', type: 'String'},
     						{name : 'status', type: 'String'},
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
         
            $("#disfollowupGrid").jqxGrid({ 
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
							{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy HH:mm'},
							{ text: 'User', datafield: 'user', width: '18%' },
							{ text: 'Assigned To', datafield: 'asuser', width: '18%' },
							{ text: 'Status', datafield: 'status', width: '18%' },
							{ text: 'Remarks', datafield: 'remark'},   
					]
            });
            $("#overlay, #PleaseWait").hide();
           
        });
                       
</script>
<div id="disfollowupGrid"></div>