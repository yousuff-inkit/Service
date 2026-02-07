<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.marketing.amcmanagement.ClsAmcManagementDAO"%>   
<% ClsAmcManagementDAO DAO=new ClsAmcManagementDAO(); %> 
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
 		var asdata;
 
 		asdata= '<%= DAO.assignGridLoading(session,trno,check) %>';      
    
        $(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                	          {name : 'tr_no', type: 'String' },
                	          {name : 'status', type: 'String' },
       						  {name : 'pltime', type: 'String' }, 
       						  {name : 'pldate', type: 'String' },
       						  {name : 'asgngrp', type: 'String' },
     						  {name : 'emp', type: 'String' }, 
     						  {name : 'refdocno', type: 'String' },
     						  {name : 'workper', type: 'number' },
     						
                 ],
                 localdata: asdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var cellclassname = function (row, column, value, data) {
          		 if (data.workper==100) {
                      return "orangeClass";
                  };
               };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxassignGrid").jqxGrid(
            {
                width: '99.5%',
                height: 180,  
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'checkbox',  
                filtermode:'excel',
                showfilterrow:true,
                filterable: true,
                sortable: true,

                columns: [
                    { text: 'Sch.No', datafield: 'tr_no', width: '16%',cellclassname:cellclassname },
                    { text: 'Planned Date',  datafield: 'pldate', width: '16%',cellclassname:cellclassname },
                    { text: 'Planned Time',  datafield: 'pltime', width: '16%',cellclassname:cellclassname },  
                    { text: 'Assign Group', datafield: 'asgngrp', width: '16%',cellclassname:cellclassname },
                    { text: 'Employee', datafield: 'emp',cellclassname:cellclassname}, 
                    { text: 'Status', datafield: 'status', width: '16%',cellclassname:cellclassname },   
                    { text: 'refdocno', datafield: 'refdocno', width: '16%',hidden:true }, 
                    { text: 'workper', datafield: 'workper', width: '16%',hidden:true },
	              ]
            });
             
            $("#overlay, #PleaseWait").hide();
            
        });
    
</script>
<div id="jqxassignGrid"></div>  
