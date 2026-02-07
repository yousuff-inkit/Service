<%@page import="com.dashboard.gwinternal.querydashboard.*"%>
<%
ClsQueryDashboardDAO sd=new ClsQueryDashboardDAO();
String docno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String id=request.getParameter("id")==null?"0":request.getParameter("id").toString();
%>
 
<script type="text/javascript">
var followupdata=[];
var id='<%=id%>';
if(id=="1"){
	followupdata='<%=sd.getFollowupData(docno,id)%>';
}

        $(document).ready(function () { 

         var source = 
            {
                datatype: "json",
                datafields: [   
                 			{name : 'followupdocno', type: 'number' },
     						{name : 'rdocno', type: 'number'},
     						{name : 'remarks', type: 'String'},
     						{name : 'assignstatus', type: 'String'},
     						{name : 'entrydate' , type : 'date'},
     						{name : 'clientuser', type: 'String'},
     						{name : 'assigneduser', type: 'String'},
     						{name : 'entereduser', type: 'String'},
                          	],
                          	localdata: followupdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            $("#queryFollowupGrid").on("bindingcomplete", function (event) {
        		$('.page-loader').hide();
        	}); 
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#queryFollowupGrid").jqxGrid({ 
            	width: '100%',
                height: 150,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
                enabletooltips: true,
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    		return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
								}   
							},  
							{ text: 'Assigned User', datafield: 'assigneduser', width: '15%'},
							{ text: 'Entered User', datafield: 'entereduser', width: '10%' },
							{ text: 'Status', datafield: 'assignstatus', width: '15%'},	
							{ text: 'Date & Time', datafield: 'entrydate', width: '10%',cellsformat:'dd.MM.yyyy HH:mm' },
							{ text: 'Description', datafield: 'remarks',width:'46%'}
					]
            });
         
           
        });
                       
</script>
<div id="queryFollowupGrid"></div>