<%@page import="com.dashboard.skips.revenueanalysis.ClsRevenueAnalysisDAO" %>
<%ClsRevenueAnalysisDAO DAO=new ClsRevenueAnalysisDAO();%>
<% String fromdate =request.getParameter("fromdate")==null?"":request.getParameter("fromdate").toString();
String todate =request.getParameter("todate")==null?"":request.getParameter("todate").toString();
String brhid =request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
String groupby =request.getParameter("groupby")==null?"":request.getParameter("groupby").toString();
String id =request.getParameter("id")==null?"":request.getParameter("id").toString();  
String topclschk = request.getParameter("topclschk")==null || request.getParameter("topclschk")==""?"0":request.getParameter("topclschk").toString();
%>

 <script type="text/javascript"> 
 var downloaddata=[];
 var id='<%=id%>';
 if(id=="1"){
 	downloaddata='<%=DAO.getRevenueAnalysisSummary(fromdate, todate, brhid, groupby, id, topclschk)%>';
 }
        $(document).ready(function () { 	
        	 var rendererstring=function (aggregates){
              	var value=aggregates['sum'];
              	if(typeof(value) == "undefined"){
              		value=0.00;
              	}
              	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
              }
       	
            var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'refname', type: 'String'  },
                  	{name : 'amount', type: 'number'  },
                  	
                 ],
                 localdata: downloaddata,
                
                
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
            $("#summaryGrid").jqxGrid(
            {
                width: '100%',
                height: 510,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                editable:false,
                showfilterrow:true,
                enabletooltips:true,
                showaggregates:true,
                showstatusbar:true,
             	statusbarheight:25,
                
                columns: [
                	
					{ text: 'Ref Name', datafield: 'refname', width: '90%' },
					{ text: 'Amount',datafield:'amount',width:'10%',cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
					
	              ]
            }); 
           $('#overlay,#PleaseWait').hide();
        });
    </script>
    <div id="summaryGrid"></div>
