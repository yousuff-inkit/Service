<%@page import="com.seal.service.ClsServiceDAO" %>
<% ClsServiceDAO DAO= new ClsServiceDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<%
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String service = request.getParameter("service")==null?"0":request.getParameter("service");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 %>
 <script type="text/javascript">
 
 			var radata='<%=DAO.ServiceMainSearch(session, docno,date,service,check)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'voc_no', type: 'int' },
                            {name : 'docno', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'service', type: 'String' },
     						],
                          	localdata: radata,
                
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
            $("#searchservicegrid").jqxGrid(
            {
                width: '99%',
                height: 283,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
                             
							 { text: 'Doc No', datafield: 'voc_no', width: '15%' },
							 { text: 'Doc No', datafield: 'docno', width: '15%',hidden:true },
							 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '15%' },
							 { text: 'Service', datafield: 'service', width: '70%' },
							]
            });
             $('#searchservicegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                 document.getElementById("docno").value= $('#searchservicegrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
                document.getElementById("masterdoc_no").value= $('#searchservicegrid').jqxGrid('getcellvalue', rowindex1, "docno");
                document.getElementById("hiddate").value= $('#searchservicegrid').jqxGrid('getcellvalue', rowindex1, "date");
                document.getElementById("txtservice").value= $('#searchservicegrid').jqxGrid('getcellvalue', rowindex1, "service");
                 $("#txtdate").jqxDateTimeInput('val', $('#hiddate').val());
                 $('#frmservicemaster input').attr('disabled', false );
                funSetlabel();
                document.getElementById("frmservicemaster").submit();
                
               $('#window').jqxWindow('close');
            });   
            
        });       
            
 </script>           
     						
<div id="searchservicegrid"></div>

</head>
<body>

</body>
</html>