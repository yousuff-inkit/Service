<%@page import="com.it.staffingcontract.ClsStaffingContractDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<% ClsStaffingContractDAO DAO=new ClsStaffingContractDAO(); %>
<% String empname =request.getParameter("empname")==null?"0":request.getParameter("empname").toString().trim();
   String empid = request.getParameter("empid")==null?"0":request.getParameter("empid").trim();
   String id =request.getParameter("id")==null?"0":request.getParameter("id").toString().trim();
   String check =request.getParameter("check")==null?"0":request.getParameter("check").toString().trim();
%>
<script type="text/javascript">

        var empacount='<%=DAO.employeeDetailsSearch(empid,empname,check) %>'; 
        $(document).ready(function () { 	
        	                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                    {name : 'doc_no', type: 'int'},  
     		 		{name : 'codeno', type: 'string'},
     		 		{name : 'name', type: 'string'},
     		 		{name : 'costperhour', type: 'number'},
     				{name : 'desigid', type: 'String'  },
     				{name : 'desig', type: 'String'  },
     						
                 ],
                 localdata: empacount,
                
                
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
            
            $("#employeeDetailsSearchGridId").jqxGrid(
            {
                width: '99%',
                height: 303,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                       
                columns: [   
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
    								return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
								}   },
							{ text: 'DocNo', datafield: 'doc_no', editable: false, hidden:true },
							{ text: 'Code', datafield: 'codeno', width: '10%', editable: false },
							{ text: 'Name', datafield: 'name' , editable: false ,width:'65%'},
							{ text: 'Cost Per Hour', datafield: 'costperhour' , editable: false, width:'20%',cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'desigid', datafield: 'desigid', hidden:true },
							{ text: 'desig', datafield: 'desig', hidden:true }

			              ]
            });
            
            $('#employeeDetailsSearchGridId').on('rowdoubleclick', function (event) {
            	   	
        	 	var rowIndex =$('#rowindex').val();
       	    	var rowindex1=event.args.rowindex;
     	  
        	    $('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "empid",$('#employeeDetailsSearchGridId').jqxGrid('getcellvalue', rowindex1, "doc_no"));
        		$('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "description",$('#employeeDetailsSearchGridId').jqxGrid('getcellvalue', rowindex1, "name"));				
        		$('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "cost",$('#employeeDetailsSearchGridId').jqxGrid('getcellvalue', rowindex1, "costperhour"));
				$('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "desig",$('#employeeDetailsSearchGridId').jqxGrid('getcellvalue', rowindex1, "desig"));
				$('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "desigid",$('#employeeDetailsSearchGridId').jqxGrid('getcellvalue', rowindex1, "desigid"));
             	    
                $('#employeeowindow').jqxWindow('close'); 
             });  
            
        });
    </script>
    <div id=employeeDetailsSearchGridId></div>
 