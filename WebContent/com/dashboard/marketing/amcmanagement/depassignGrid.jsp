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
 		var depdata;
 
 		depdata= '<%= DAO.assignGridLoading(session,trno,check) %>';      
    
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
     						  {name : 'budget', type: 'String' },
     						  {name : 'dtype', type: 'String'  },
      						  {name : 'refdocno', type: 'String'  },
      						  {name : 'site', type: 'String' },
                 ],
                 localdata: depdata,
                
                
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
            $("#jqxdepassignGrid").jqxGrid(
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

                columns: [
                    { text: 'Sch.No', datafield: 'tr_no', width: '16%' },
                    { text: 'Planned Date',  datafield: 'pldate', width: '16%' },
                    { text: 'Planned Time',  datafield: 'pltime', width: '16%' },  
                    { text: 'Assign Group', datafield: 'asgngrp', width: '16%' },
                    { text: 'Employee', datafield: 'emp'}, 
                    { text: 'Status', datafield: 'status', width: '16%' },   
                    { text: 'Site Name', width: '8%', datafield: 'site'},
                    { text: 'Dtype' ,datafield: 'dtype', width: '4%', hidden: true},  
                    { text: 'Doc No', datafield: 'refdocno', width: '5%', hidden: true},   
                    { text: 'Budget',  datafield:'budget', hidden: true, width: '10%' },  
	              ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxdepassignGrid').on('rowdoubleclick', function (event) {     
          	  var rowindex1=event.args.rowindex;
          	  
          	  $("#deployTechnicianDetailsGridId").jqxGrid({ disabled: false});  
        		
        		  $("#manPowerAssignedGridID").jqxGrid('clear');
        		  $("#manPowerAssignedGridID").jqxGrid("addrow", null, {"consumed":"View"}); 
        		  $("#manPowerAssignedGridID").jqxGrid({ disabled: false});

        		  var costtype =$('#jqxdepassignGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
        		  var costcode =$('#jqxdepassignGrid').jqxGrid('getcellvalue', rowindex1, "refdocno");
        		  var budget =$('#jqxdepassignGrid').jqxGrid('getcellvalue', rowindex1, "budget");
        		 
        		  document.getElementById("dtype").value = costtype;  
        		  document.getElementById("trno").value = costcode;  
        		  document.getElementById("site").value = $('#jqxdepassignGrid').jqxGrid('getcellvalue', rowindex1, "site");  
        		  document.getElementById("srno").value = $('#jqxdepassignGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");    
        		  $('#btndeploysave').attr('disabled', false);
        		  $("#depdetaildiv").load("depDetailsGrid.jsp?costtype="+costtype+'&costcode='+costcode+'&check=1');  
        		  
        		  funRoundAmt(budget,"budget");  
        		  getManPowerConsumed(costtype,costcode);   
          });
        });
    
</script>
<div id="jqxdepassignGrid"></div>  
