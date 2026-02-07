<%@page import="com.dashboard.inkit.assignjobfollowup.AssignJobFollowupDAO"%>
<%AssignJobFollowupDAO sd= new AssignJobFollowupDAO(); %>

<% String docno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String brchid =request.getParameter("brchid")==null?"0":request.getParameter("brchid").toString();
 String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();
 String srno =request.getParameter("srno")==null?"0":request.getParameter("srno").toString();

%>
 
 <script type="text/javascript">
 
 var data1 ='<%=sd.loadSubGridData(docno,brchid,dtype,srno) %>';
        $(document).ready(function () { 

         var source = 
            {
                datatype: "json",
                datafields: [   
							{name : 'srno', type: 'number' },
                 			{name : 'empgroup', type: 'String' },
     						{name : 'emp', type: 'String'},
     						{name : 'asgnmode', type: 'String'},
     						{name : 'plannedon' , type : 'date'},
     						{name : 'pltime', type: 'String'},
     						{name : 'description', type: 'String'},
     						{name : 'eedate', type: 'date'},

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
         
            $("#assignSubGridDetails").jqxGrid({ 
            	width: '99.5%',
                height: 150,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
               
                columns: [
							{ text: 'Sl No.', datafield: 'srno', width: '4%'},
							{ text: 'Assign Group', datafield: 'empgroup', width: '10%'},
							{ text: 'Employee', datafield: 'emp', width: '10%' },
							{ text: 'Assign Method', datafield: 'asgnmode', width: '10%'},	
							{ text: 'Planned Date', datafield: 'plannedon', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Planned Time', datafield: 'pltime', width: '10%' },
							{ text: 'Expected End Date', datafield: 'eedate', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Description', datafield: 'description', width: '36%' },

					]
            });
         
           
        });
                       
</script>
<div id="assignSubGridDetails"></div>