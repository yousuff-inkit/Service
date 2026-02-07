<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.management.departmentclassificationlinking.ClsDepartmentClassificationLinkingDAO"%>
 <%
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 System.out.println(accountno+"     "+accountname); 
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 ClsDepartmentClassificationLinkingDAO  ReportsDAO=new  ClsDepartmentClassificationLinkingDAO();
 
%> 

 <script type="text/javascript">
 
	var accountData='<%=ReportsDAO.deptSearch(session, accountname, accountno)%>';
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                         {name : 'doc_no', type: 'int'},
						 {name : 'department', type: 'string'}
						 
                    ],
            		localdata: accountData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#jqxAccountsSearch").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Department', datafield: 'department', width: '100%' },
			 
					]
        });
    	
    	//  acno accname accdocno
    	
         $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
            document.getElementById("deptno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
        	document.getElementById("deptname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "department");
 
        	// txttypeatype txttypetype
            $('#accountDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="jqxAccountsSearch"></div>
    