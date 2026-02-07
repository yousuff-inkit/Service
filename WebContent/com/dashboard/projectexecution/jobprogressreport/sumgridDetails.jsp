    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.projectexecution.jobprogressreport.ClsjobProgressReportDAO" %>
<%
ClsjobProgressReportDAO sd=new ClsjobProgressReportDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String type =request.getParameter("type")==null?"0":request.getParameter("type").toString();%>
 <% String summtype =request.getParameter("summtype")==null?"0":request.getParameter("summtype").toString();%>
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();%>
<% String clientid =request.getParameter("clientid")==null||request.getParameter("clientid")==""?"0":request.getParameter("clientid").toString();%>
 
 <script type="text/javascript">
 var data,projectstatusexcel;
 
 var bb='<%=rds%>';
	if(bb!='0'){
data= '<%= sd.sumloadGridData(fromdate,todate,rds,barchval,summtype,type) %>';
 projectstatusexcel= '<%= sd.sumloadGridExcel(fromdate,todate,rds,barchval,summtype,type) %>';
	}
	else{
		bb=1;
	}

	
	$(document).ready(function () { 	
		var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
   var rendererstring=function (aggregates){
   	var value=aggregates['sum'];
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							//{name : 'doc_no', type: 'number'  },
     						{name : 'sal_name', type: 'String'  },
     						{name : 'jdate', type: 'String' },
     						{name : 'branchname', type: 'String' },
     						{name : 'amount', type: 'number' },
							{name : 'discount', type: 'number' },
							{name : 'disper', type: 'number' },
     						{name : 'net', type: 'number' },
						
     						
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var cellclassname =  function (row, column, value, data) {

     	    	/* return "greyClass";
     	    	
     		        var element = $(defaultHtml);
     		        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
     		        return element[0].outerHTML;
     	*/

     		}
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxsumloaddataGrid").jqxGrid(
            {
                width: '99%',
                height: 550,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
				showfilterrow: true,
				showaggregates:true,
		        showstatusbar:true,
		        statusbarheight: 21,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
                          { text: 'Srno', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                            
					{ text: 'Reference Name', datafield: 'sal_name', width: '33%' },
					{ text: 'Branch', datafield: 'branchname', width: '15%' },
					{ text: 'Job Date', datafield: 'jdate', width: '46%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Job Amount', datafield: 'amount', width: '18%',cellsformat:'d2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname },
					{ text: 'Discount', datafield: 'discount', width: '17%',cellsformat:'d2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname },
					{ text: 'Discount %', datafield: 'disper', width: '13%',cellsformat:'d2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname },
					
					{ text: 'Net', datafield: 'net', width: '15%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname },
					
	              ]
            });

                 $("#overlay, #PleaseWait").hide();
                 funsumm();
        });
    </script>
    <div id="jqxsumloaddataGrid"></div>
