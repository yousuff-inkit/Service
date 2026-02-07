<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.marketing.projectmanagement.ClsProjectManagementDAO"%>   
<% ClsProjectManagementDAO DAO=new ClsProjectManagementDAO(); %> 
<% 
String trno =request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno").toString().trim();
String check =request.getParameter("check")==null?"0":request.getParameter("check").toString().trim();
 %>
<style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.yellowClass {
	background-color: #FFFF00;
}

.orangeClass {
	background-color: #FFEBC2;
}
</style>
<script type="text/javascript">
 		var data7;
 
 		data7= '<%= DAO.serviceGridLoading(session,trno,check) %>';     
    
        $(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                	          {name : 'status', type: 'String' },
       						  {name : 'pltime', type: 'String' }, 
       						  {name : 'pldate', type: 'String' },
       						  {name : 'asgngrp', type: 'String' },
     						  {name : 'emp', type: 'String' },  
     						  
     						  {name : 'srtrno', type: 'String' },
      						  {name : 'srdocno', type: 'String' },
      						  {name : 'sheduleno', type: 'String' },
      					 	  {name : 'serdocno', type: 'String' },
      						  {name : 'areaid', type: 'String' },	
      						  {name : 'siteid', type: 'String' },	
      						  {name : 'reftrno', type: 'String' },
      						  {name : 'workper', type: 'number' },
     						
                 ],
                 localdata: data7,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
 
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxserviceGrid").jqxGrid(
            {
                width: '99.5%',
                height: 180,  
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',  
                filtermode:'excel',
                showfilterrow:true,
                filterable: true,
                sortable: true,
                enabletooltips:true,

                columns: [
                    { text: 'Planned Date',  datafield: 'pldate', width: '14%' },
                    { text: 'Planned Time',  datafield: 'pltime', width: '13%' },  
                    { text: 'Assign Group', datafield: 'asgngrp', width: '14%' },
                    { text: 'Employee', datafield: 'emp'}, 
                    { text: 'Status', datafield: 'status', width: '14%' },   
                    { text: 'SRVC No', datafield: 'srdocno', width: '14%' },  
                    { text: 'Completed%', datafield: 'workper', width: '14%' },  
                    
                    { text: 'srtrno', datafield: 'srtrno', hidden: true },   					
					{ text: 'sheduleno', datafield: 'sheduleno', hidden: true }, 
					{ text: 'serdocno', datafield: 'serdocno', hidden: true }, 
					{ text: 'areaid', datafield: 'areaid', hidden: true }, 
					{ text: 'siteid', datafield: 'siteid', hidden: true }, 
					{ text: 'reftrno', datafield: 'reftrno', hidden: true },   
	              ]
            });
            $("#overlay, #PleaseWait").hide();  
            $('#jqxserviceGrid').on('rowdoubleclick', function (event) {     
            	   var rowindex=event.args.rowindex; 

            	   document.getElementById("srtrno").value = $('#jqxserviceGrid').jqxGrid('getcellvalue', rowindex, "srtrno");  												
	               document.getElementById("srdocno").value = $('#jqxserviceGrid').jqxGrid('getcellvalue', rowindex, "srdocno");  											
	               document.getElementById("sheduleno").value = $('#jqxserviceGrid').jqxGrid('getcellvalue', rowindex, "sheduleno");  												
	               document.getElementById("serdocno").value = $('#jqxserviceGrid').jqxGrid('getcellvalue', rowindex, "serdocno");  						
	               document.getElementById("areaid").value = $('#jqxserviceGrid').jqxGrid('getcellvalue', rowindex, "areaid");  												
	               document.getElementById("siteid").value = $('#jqxserviceGrid').jqxGrid('getcellvalue', rowindex, "siteid");  												
	               document.getElementById("reftrno").value = $('#jqxserviceGrid').jqxGrid('getcellvalue', rowindex, "reftrno");    
	               
          		   var srdocno= $('#jqxserviceGrid').jqxGrid('getcellvalue', rowindex, "srdocno");
	               var workper= $('#jqxserviceGrid').jqxGrid('getcellvalue', rowindex, "workper");     
	           	   
	               if(srdocno>0){
	                	document.getElementById("txtper").value=workper;
                   }else{
		                document.getElementById("txtper").value="";
        	       }
	               
        	       if(workper!=0) {
				 		$('#btnserviceattach').attr("disabled",false);
    	    	   }else{
				 		$('#btnserviceattach').attr("disabled",true);  
    	     	   }   
        	       
        	       if(workper==100){ 
            	    	 $('#txtper').attr("readonly",true);
            	    	 $('#btnserupdate').attr("disabled",true);  
        				 $('#btnserviceconfirm').attr("disabled",false);    
        	    	 }else{
            	    	 $('#txtper').attr("readonly",false);
            	    	 $('#btnserupdate').attr("disabled",false);
        				 $('#btnserviceconfirm').attr("disabled",true);  
        	       }  
            });
        });
    
</script>
<div id="jqxserviceGrid"></div>    
