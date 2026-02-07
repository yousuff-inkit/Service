<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@include file = "enquiryStatus.jsp" %>
<%ClsStatusDAO sd= new ClsStatusDAO(); 

 %>
   <%@ taglib prefix="s" uri="/struts-tags"%>  
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 
 <% String rds =request.getParameter("check")==null?"0":request.getParameter("check").toString();%>
<% String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim().toString();
String jobno=request.getParameter("jobno")==null?"0":request.getParameter("jobno").trim().toString();
String enqno=request.getParameter("enqno")==null?"0":request.getParameter("enqno").trim().toString();
String from =request.getParameter("from")==null?"0":request.getParameter("from").toString();
String to=request.getParameter("to")==null?"0":request.getParameter("to").toString();
System.out.println("grid=="+cldocno);
%>
 
 <script type="text/javascript">
//  var data,projectstatusexcel;
 
 var bb='<%=rds%>';
	if(bb!='0'){
	var data= '<%= sd.loadGridData(session,cldocno,jobno,enqno,from,to,request) %>';
<%-- data= '<%= sd.loadGridData(cldocno) %>'; --%>
	}
	else{
		bb=1;
	}
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							//{name : 'doc_no', type: 'number'  },
     						{name : 'enqno', type: 'number'  },
     						{name : 'qotno', type: 'number'  },
     						{name : 'jobno', type: 'number'  },
     						{name : 'client', type: 'String' },
     						{name : 'process', type: 'date' },
     						{name : 'fromdate', type: 'datetime' },
     						{name : 'fromuser', type: 'String' },
     						{name : 'todate', type: 'datetime' },
     						{name : 'touser', type: 'String' },
     						{name : 'totaltime', type: 'String' },
     						{name : 'remarks', type: 'String' },
						
     						
                 ],
                 localdata: data,
                
                
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
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '100%',
                height: 450,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
				showfilterrow: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                   //         Enq No , Client name , Process name , from date(indatetime) , from User , to date (outdatetime) , to user , total time , 
					{ text: 'Enq No', datafield: 'enqno', width: '4%' },
					{ text: 'Quotation No', datafield: 'qotno', width: '7%' },
					{ text: 'Job No', datafield: 'jobno', width: '6%' },
					{ text: 'Client', datafield: 'client', width: '15%' },
					{ text: 'Process Name', datafield: 'process', width: '15%' },
					{ text: 'From Date', datafield: 'fromdate', width: '10%',cellsformat:'dd.MM.yyyy HH:mm:ss' },
					{ text: 'From User',  datafield: 'fromuser', width: '7%' },
					{ text: 'To Date', datafield: 'todate', width: '11%',cellsformat:'dd.MM.yyyy HH:mm:ss' },
					{ text: 'To User',  datafield: 'touser', width: '7%' },
					{ text: 'Total Time',  datafield: 'totaltime', width: '9%' },
					{ text: 'Remarks',  datafield: 'remarks', width: '10%' },
					
	              ]
            });
//         

                 $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxloaddataGrid" style="margin-left: 20px;display:none"></div>
    <div align="center">
	<table id="maintbl" width="100%" border="1" cellpadding="4" style="border-collapse:collapse; border: 1px solid black;">
  <tr>
    <th width="5%" align="left">Sr No</th>
    <th  width="10%"align="left">Enq No</th>
    <th  width="10%"align="left">Quotation No</th>
    <th  width="10%"align="left">Job No</th>
    <th  width="10%"align="left">Client</th>
    <th width="10%" align="center">Process Name</th>
    <th width="10%" align="center">From Date</th>
    <th width="10%" align="right">From User</th>
    <th width="10%" align="right">To Date</th>
    <th width="10%" align="right">To User</th>
    <th width="10%" align="right">Total Time</th>
    <th width="10%" align="right">Remarks</th>
   
  </tr>
  <s:iterator var="stat" value='#request.prcslgsts' >
<tr>   
<%int i=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des">   
    <%
    if(i>0 && i<=3){%>
    
  <td  align="right" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
    
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr> 
</s:iterator> 
 
</table>
</div>