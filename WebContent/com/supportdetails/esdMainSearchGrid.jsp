<%@page import="com.supportdetails.ClsSupportDetailsDAO" %>
<% ClsSupportDetailsDAO sd=new ClsSupportDetailsDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String issuedStatus = request.getParameter("issuedstatus")==null?"0":request.getParameter("issuedstatus");
 String companyName = request.getParameter("companyname")==null?"0":request.getParameter("companyname");
 String issuedTime = request.getParameter("issuedtime")==null?"0":request.getParameter("issuedtime");
 String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
%> 

 <script type="text/javascript">
 			 
			$(document).ready(function () { 
				 
			var data4='<%=sd.esdMainSearch(docNo,date,issuedStatus,companyName,issuedTime,check)%>';
				 
        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
      						{name : 'date', type: 'date'  },
      						{name : 'time', type: 'String' }, 
                            {name : 'company', type: 'String' }, 
                            {name : 'issue_category', type: 'String' },
                            {name : 'issue_status', type: 'String' }
                          	],
                          	localdata: data4,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#supportDetailsMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '10%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
					 { text: 'Time', datafield: 'time', width: '10%' },
					 { text: 'Company', datafield: 'company', width: '40%' },
					 { text: 'Category', datafield: 'issue_category', width: '20%' },
					 { text: 'Status', datafield: 'issue_status', width: '10%' },
					]
            });
            
			  $('#supportDetailsMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;

                document.getElementById("docno").value= $('#supportDetailsMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmSupportDetails select').attr('disabled', false);
                $('#issueDate').jqxDateTimeInput({disabled: false});
                $('#issueTime').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmSupportDetails").submit();
                $('#frmSupportDetails select').attr('disabled', true);
                $('#issueTime').jqxDateTimeInput({disabled: true});
                $('#issueDate').jqxDateTimeInput({disabled: false});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="supportDetailsMainSearch"></div>
    