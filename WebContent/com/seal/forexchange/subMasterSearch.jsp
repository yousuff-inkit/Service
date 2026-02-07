<%@page import="com.seal.forexchange.ClsForExchangeDAO"%>
<% ClsForExchangeDAO DAO= new ClsForExchangeDAO(); %>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<%
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String adjdate = request.getParameter("adjdate")==null?"0":request.getParameter("adjdate");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 %>
 <script type="text/javascript">
 
 			var radata='<%=DAO.ServiceMainSearch(session, docno, date, adjdate, check)%>';  
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'voc_no', type: 'int' },
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'adjustdate', type: 'date' },
     						{name : 'remarks', type: 'string' },
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
            $("#submasterGrid").jqxGrid(
            {
                width: '99%',
                height: 283,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			enabletooltips:true,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
                             
							 { text: 'Doc No', datafield: 'voc_no', width: '15%' },
							 { text: 'Doc No', datafield: 'doc_no', width: '15%',hidden:true },
							 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '15%' },
							 { text: 'Adjust Date', datafield: 'adjustdate', cellsformat: 'dd.MM.yyyy' , width: '15%' },
							 { text: 'Remarks', datafield: 'remarks'},
							]
            });
             $('#submasterGrid').on('rowdoubleclick', function (event) {
                 var rowindex1=event.args.rowindex;
                 document.getElementById("docno").value= $('#submasterGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
                 document.getElementById("masterdoc_no").value= $('#submasterGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                 $("#forexDate").jqxDateTimeInput('val', $('#submasterGrid').jqxGrid('getcellvalue', rowindex1, "date"));
                 $("#forexAdjstDate").jqxDateTimeInput('val', $('#submasterGrid').jqxGrid('getcellvalue', rowindex1, "adjustdate"));
                 funSetlabel();
                 document.getElementById("forexExchangeMaster").submit();    
                 $('#window').jqxWindow('close');
            });   
        });       
            
 </script>           
<div id="submasterGrid"></div> 