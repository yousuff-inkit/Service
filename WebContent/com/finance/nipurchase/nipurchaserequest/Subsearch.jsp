<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.nipurchase.nipurchaserequest.ClsnipurchaserequestDAO" %>
	
<%
ClsnipurchaserequestDAO viewDAO=new ClsnipurchaserequestDAO();

String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String requestedbyss = request.getParameter("requestedbyss")==null?"NA":request.getParameter("requestedbyss");
String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
String descriptions = request.getParameter("descriptions")==null?"NA":request.getParameter("descriptions"); 
String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
%>
<script type="text/javascript">
 
var nipurreqmain= '<%=viewDAO.mainsearch(session,docnoss,requestedbyss,datess,descriptions,aa) %>'; 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            {name : 'voc_no', type: 'int'   },
                            {name : 'date', type: 'date'   },
     						{name : 'description', type: 'string'   },
     						{name : 'requestedby', type: 'string'   },
     						{name : 'desc1', type: 'string'   },
                        ],
                		localdata: nipurreqmain, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mainsearshgrid").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
                          	{ text: 'master', datafield: 'doc_no', width: '6%' ,hidden:true},
                            { text: 'Doc No', datafield: 'voc_no', width: '6%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Requested By', datafield: 'requestedby', width: '32%' },
							{ text: 'Remark', datafield: 'description' },
						]
            });
            
             $('#mainsearshgrid').on('rowdoubleclick', function (event) {
             
            	var rowindex1 = event.args.rowindex;
           	 	$('#hidnipurchaserequestdate').jqxDateTimeInput({ disabled: false});
        	 	document.getElementById("masterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
             	document.getElementById("docno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
                $('#hidnipurchaserequestdate').val($("#mainsearshgrid").jqxGrid('getcellvalue', rowindex1, "date")) ;
                document.getElementById("requestedby").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "requestedby");
                document.getElementById("purdesc").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "description");
                
              	$('#window').jqxWindow('close');  
         	 	$('#hidnipurchaserequestdate').jqxDateTimeInput({ disabled: false});

        	 	funSetlabel();
            	document.getElementById("frmNipurchaseRequest").submit();
            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>