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
		data= '<%= sd.loadGridData(fromdate,todate,rds,barchval,type,summtype) %>';
	 	<%-- projectstatusexcel= '<%= sd.loadGridExcel(fromdate,todate,rds,barchval,type,summtype) %>'; --%>
	}
	else{
		bb=1;
	}
    //alert("==================loadSalikData");
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
     						{name : 'srno', type: 'number'  },
     						{name : 'cname', type: 'number'  },
     						{name : 'jobno', type: 'number'  },
     						{name : 'refno', type: 'string'  },
     						{name : 'jdate', type: 'date' },
     						{name : 'site', type: 'string' },
     						{name : 'salesman', type: 'string' },
     						{name : 'branchname', type: 'string' },
     						{name : 'total', type: 'number' },
     						{name : 'cdate', type: 'date' },
     						{name : 'amount', type: 'number' },
     						{name : 'disper', type: 'number' },
     						{name : 'discount', type: 'number' },
     						{name : 'net', type: 'number' },
     						{name : 'installper', type: 'number' },
     						{name : 'installamt', type: 'number' },
     						{name : 'currentmnth', type: 'number' },
     						{name : 'prevmonth', type: 'number' },
     						{name : 'curmnthinstlamt', type: 'number' },
     						{name : 'prevmnthinstlamt', type: 'number' },
     						{name : 'longitude', type: 'string' },
     						{name : 'latittude', type: 'string' },
     						
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
            $("#jqxloaddataGrid").jqxGrid(
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
		        enabletooltips: true,
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
                            
                   //        Srno, Customer name,JOB NO, job date,Job Amount, Discount %,Dis Amt,Net, install % , Installed amount
					//{ text: 'Srno', datafield: 'srno', width: '6%' },
					{ text: 'Customer name', datafield: 'cname', width: '15%' },
					{ text: 'Job No', datafield: 'jobno', width: '5%' },
					{ text: 'Ref No', datafield: 'refno', width: '6%' },
					{ text: 'Site', datafield: 'site', width: '12%' },
					
					{ text: 'Job Date', datafield: 'jdate', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Branch', datafield: 'branchname', width: '6%' },
					{ text: 'Salesman', datafield: 'salesman', width: '12%' },
					{ text: 'Longitude', datafield: 'longitude', width: '7%' },
					{ text: 'Latitude', datafield: 'latittude', width: '7%' },    
					{ text: 'Complete date', datafield: 'cdate', width: '7%',cellsformat:'dd.MM.yyyy'  },
					{ text: 'Job Amount', datafield: 'amount', width: '7%',cellsformat:'d2',cellsalign:'right' ,align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
					{ text: 'Discount %', datafield: 'disper', width: '5%',cellsalign:'right' ,align:'right',cellclassname: cellclassname},
					{ text: 'Disc Amt',  datafield: 'discount', width: '6%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
					{ text: 'Net Total', datafield: 'net', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
					{ text: 'Install %',  datafield: 'installper', width: '5%',cellsalign:'right',align:'right',cellclassname: cellclassname},
					{ text: 'Curr Mnth %',  datafield: 'currentmnth', width: '5%',cellsalign:'right',cellsformat:'d2',align:'right',cellclassname: cellclassname},
					{ text: 'Prev Mnth %',  datafield: 'prevmonth', width: '5%',cellsalign:'right',cellsformat:'d2',align:'right',cellclassname: cellclassname},
					{ text: 'Curr Mnth Installed Amt',  datafield: 'curmnthinstlamt', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring},
					{ text: 'Prev Mnth Installed Amt',  datafield: 'prevmnthinstlamt', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring},
					{ text: 'Installed Amt',  datafield: 'installamt', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname },
					
	              ]
            });

            var summ='<%=summtype%>';
            if(summ=="job"){
            	$("#jqxloaddataGrid").jqxGrid('setcolumnproperty','currentmnth','hidden',false);
            	$("#jqxloaddataGrid").jqxGrid('setcolumnproperty','prevmonth','hidden',false);
            	$("#jqxloaddataGrid").jqxGrid('setcolumnproperty','curmnthinstlamt','hidden',false);
            	$("#jqxloaddataGrid").jqxGrid('setcolumnproperty','prevmnthinstlamt','hidden',false);
            }
            else{
            	$("#jqxloaddataGrid").jqxGrid('setcolumnproperty','currentmnth','hidden',true);
            	$("#jqxloaddataGrid").jqxGrid('setcolumnproperty','prevmonth','hidden',true);
            	$("#jqxloaddataGrid").jqxGrid('setcolumnproperty','curmnthinstlamt','hidden',true);
            	$("#jqxloaddataGrid").jqxGrid('setcolumnproperty','prevmnthinstlamt','hidden',true);
            }
                 $("#overlay, #PleaseWait").hide();

                 
        });
    </script>
    <div id="jqxloaddataGrid"></div>
