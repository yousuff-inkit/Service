<%@page import="com.dashboard.project.dailysalesreport.ClsDailySalesReportDAO"%>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
ClsDailySalesReportDAO sd=new ClsDailySalesReportDAO();
%>  
    <%   String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();
     String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();
     String fromdate=request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();
     String todate=request.getParameter("todate")==null?"0":request.getParameter("todate").toString();
         %>
 <script type="text/javascript">        
	  var data12,exceldata12;  
	  var flchk='<%=check%>';
	if(flchk!='0'){      
		  data12='<%= sd.loadJobsGridData(session,fromdate,todate,barchval)%>'; 
		  <%-- exceldata12='<%= sd.loadJobsExcelData(session,fromdate,todate,barchval)%>'; --%>   
	  }             
	  else{   
		  data12; 
	  }              
	var rendererstring=function (aggregates){
	 	var value=aggregates['sum'];
	 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	 }      
	  $(document).ready(function () {            

       var source = 
          {
                datatype: "json",    
                datafields: [
                 			{name : 'jobno', type: 'String' },
                 			{name : 'dtype', type: 'String' },
                 			{name : 'refname', type: 'String' },
     						{name : 'brch', type: 'String'},
     						{name : 'salname', type: 'String' },
     						{name : 'date', type: 'date' },
     						{name : 'netamount', type: 'number' },
     					    {name : 'targetval', type: 'number'  },     
                          	],
                          	localdata: data12,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
         
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#jqxjobsgrid").jqxGrid({ 
            	width: '99%',      
                height: 450,
                editable: false,
                source: dataAdapter,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:20,
                selectionmode: 'singlerow',
                columnsresize:true,
                filterable:true,
                showfilterrow:true,  
                sortable: true,
     					
                columns: [
							{ text: 'JOB NO', datafield: 'jobno',width: '8%'},
							{ text: 'Type', datafield: 'dtype',width: '8%'},
							{ text: 'JOB DATE', datafield: 'date',width: '8%',cellsformat:'dd.MM.yyyy'},
							{ text: 'CUSTOMER', datafield: 'refname'},
							{ text: 'BRANCH', datafield: 'brch',width: '12%'},
							{ text: 'SALES MAN', datafield: 'salname',width: '16%'},  
							{ text: 'JOB AMOUNT', datafield: 'netamount',width: '8%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					        { text: 'Target Total', datafield: 'targetval', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right' },
					]
            });  
            $("#overlay, #PleaseWait").hide();
        });
                       
</script>
<div id="jqxjobsgrid"></div>