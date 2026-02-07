<%@page import="com.dashboard.skips.revenueanalysisv2.ClsRevenueAnalysisDAO" %>  
<%ClsRevenueAnalysisDAO DAO=new ClsRevenueAnalysisDAO();%>
<% String fromdate =request.getParameter("fromdate")==null?"":request.getParameter("fromdate").toString();
String todate =request.getParameter("todate")==null?"":request.getParameter("todate").toString();
String brhid =request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
String groupby =request.getParameter("groupby")==null?"":request.getParameter("groupby").toString();
String id =request.getParameter("id")==null?"":request.getParameter("id").toString();  
String topclschk = request.getParameter("topclschk")==null || request.getParameter("topclschk")==""?"0":request.getParameter("topclschk").toString();
%>
<style type="text/css">
        .headClass
        {
            background-color: #FFEBC2;
        }
        .redClass
        {
            background-color: #FFEBEB;
        }
        .violetClass
        {
            background-color: #EBD6FF;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        .greenClass
        {
           background-color: #CEFFCE;
        }
        
</style>
 <script type="text/javascript"> 
 
 
 var groupval='<%=groupby%>';
 var data=[];
 var id='<%=id%>';
 if(id=="1"){
	 data='<%=DAO.getRevenueAnalysisSummary(fromdate, todate, brhid, groupby, id, topclschk)%>';
 }
 console.log(data);  
        $(document).ready(function () { 	
            var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'refname', type: 'String'  },
                  	{name : 'amount', type: 'number'  },
                  	{ name: 'nooftrips', type: 'number' }, 
                  	{ name: 'count', type: 'number' }, 
                  	{ name: 'grouppp', type: 'number' }, 
                  	{ name: 'id', type: 'string' },
                  	{ name: 'id', type: 'string' },
               	    { name: 'parentid', type: 'string' },    
                 ],
                 hierarchy:
                 {
                     keyDataField: { name: 'id' },
                     parentDataField: { name: 'parentid' }
                 },
                 id: 'id',
                 localData: data
            };
            var dataAdapter = new $.jqx.dataAdapter(source, {
                loadComplete: function () {
                	
             

                }
            });
            
            var cellclassname = function (row, column, value, data) {
            	//console.log(data.parentid);
            	
            	if (data.parentid == null && (data.refname == "Sub Total" || data.refname == "Grand Total")) { 
           	    	console.log(data.parentid+"==2=="+data.refname);
	                return "greenClass";
	            }
            	
           	    if (data.parentid == null) {
                    return "headClass";
                } 
           	    
           	    if (data.parentid != null) {      
                    return "redClass";
                }    
            };  
     $("#summaryGrid").on('bindingComplete', function (event) {  
            	
        if ( groupval=="AT" || groupval=="TF" ){
       	  $("#summaryGrid").jqxTreeGrid('hideColumn', 'count');
       	  $("#summaryGrid").jqxTreeGrid('hideColumn', 'grouppp'); 
        }else if ( groupval=="SS" || groupval=="OW" ){
       	  $("#summaryGrid").jqxTreeGrid('hideColumn', 'nooftrips');
       	  $("#summaryGrid").jqxTreeGrid('hideColumn', 'grouppp');
       }else if( groupval=="CL" ){
       	  $("#summaryGrid").jqxTreeGrid('hideColumn', 'nooftrips');
       	  $("#summaryGrid").jqxTreeGrid('hideColumn', 'count'); 
       }else if( groupval=="AC" || groupval=="CT" || groupval=="SM" || groupval=="WT" ){
       	  $("#summaryGrid").jqxTreeGrid('hideColumn', 'nooftrips');
       	  $("#summaryGrid").jqxTreeGrid('hideColumn', 'count'); 
       	  $("#summaryGrid").jqxTreeGrid('hideColumn', 'grouppp');
       }else{
       	
       }

            });  
          
                
            $("#summaryGrid").jqxTreeGrid(
            {
                width: '100%',
                height: 510,
                source: dataAdapter,    
             	ready: function() 
                 {
                 	var rows = $("#summaryGrid").jqxTreeGrid('getRows');  
                 	for(var i=1;i <= rows.length; i++){
                 		$("#summaryGrid").jqxTreeGrid('expandRow',rows[i-1].id);
                 		
                 		
                 	}
                 }, 
                columns: [   
                	
                ,

                            { text: 'ID',  datafield: 'id', width:'5%',hidden:true}, 
		          	        { text: 'Parent ID',  datafield: 'parentid', width:'5%',hidden:true},
							{ text: 'Ref Name', datafield: 'refname',cellclassname: cellclassname },
							{ text: 'No of Trips',  datafield: 'nooftrips', width:'8%',cellsalign:'right',align:'right', cellclassname: cellclassname },
							{ text: 'Count',  datafield: 'count', width:'8%',cellsalign:'right',align:'right', cellclassname: cellclassname },
							{ text: 'Group',  datafield: 'grouppp', width:'8%',cellsalign:'right',align:'right', cellclassname: cellclassname },
							{ text: 'Amount',datafield:'amount',width:'10%',cellsformat:'d2',cellsalign:'right',align:'right', cellclassname: cellclassname },
	              ]
            }); 
            $('#overlay,#PleaseWait').hide();   
           
        });
    </script>
    <div id="summaryGrid"></div>