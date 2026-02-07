<%@page import="com.workdetails.ClsWorkDetailsDAO" %>
<% ClsWorkDetailsDAO wd=new ClsWorkDetailsDAO();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String formname = request.getParameter("formname")==null?"0":request.getParameter("formname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String empname = request.getParameter("empname")==null?"0":request.getParameter("empname");
%> 

 <script type="text/javascript">
 
 			var data3='<%=wd.ewdMainSearch(docNo,date,formname,empname)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
      						{name : 'date', type: 'date'  },
                            {name : 'form_name', type: 'String' }, 
                            {name : 'emp_name', type: 'String' },
     						{name : 'correction_type', type: 'String' }
                          	],
                          	localdata: data3,
                
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
            $("#workDetailsMainSearch").jqxGrid(
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
					 { text: 'Form Name', datafield: 'form_name', width: '20%' },
					 { text: 'Emp. Name', datafield: 'emp_name', width: '50%' },
					 { text: 'Type', datafield: 'correction_type', width: '10%' },
					]
            });
            
			  $('#workDetailsMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;

                document.getElementById("txtformname").value= $('#workDetailsMainSearch').jqxGrid('getcellvalue', rowindex1, "form_name");
                document.getElementById("docno").value= $('#workDetailsMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmWorkDetails select').attr('disabled', false);
                $('#workDetailsDate').jqxDateTimeInput({disabled: false});
    			$('#startDate').jqxDateTimeInput({disabled: false});
    			$('#endDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmWorkDetails").submit();
                $('#frmWorkDetails select').attr('disabled', true);
                $('#workDetailsDate').jqxDateTimeInput({disabled: true});
    			$('#startDate').jqxDateTimeInput({disabled: true});
    			$('#endDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="workDetailsMainSearch"></div>
    