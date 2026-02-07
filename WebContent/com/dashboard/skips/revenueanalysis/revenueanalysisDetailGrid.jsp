<%@page import="com.dashboard.skips.revenueanalysis.ClsRevenueAnalysisDAO" %>
<%ClsRevenueAnalysisDAO DAO=new ClsRevenueAnalysisDAO();%>
<% String fromdate =request.getParameter("fromdate")==null?"":request.getParameter("fromdate").toString();
String todate =request.getParameter("todate")==null?"":request.getParameter("todate").toString();
String brhid =request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
String id =request.getParameter("id")==null?"":request.getParameter("id").toString();
%>

 <script type="text/javascript">
 var downloaddata=[];
 var id='<%=id%>';
 if(id=="1"){
 	downloaddata='<%=DAO.getRevenueAnalysisDetails(fromdate, todate, brhid, id)%>';
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
                	{name : 'invno', type: 'String'  },
                	{name : 'invdate', type: 'date'  },
                	{name : 'account', type: 'String'  },
                	{name : 'contracttype', type: 'String'  },
                  	{name : 'sal_name', type: 'String'  },
       	       	    {name : 'skipsize', type: 'String'  },
       	       	    {name : 'wastetype', type: 'String'  },
                  	{name : 'ownership', type: 'String'  },
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
            $("#detailGrid").jqxGrid(
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
                	
                	{ text: 'Inv No', datafield: 'invno', width: '6%' },  
					{ text: 'Inv Date', datafield: 'invdate', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Account', datafield: 'account', width: '18%' },
					{ text: 'Contract Type', datafield: 'contracttype', width: '8%' },
					{ text: 'Salesman', datafield: 'sal_name', width: '15%' },
					{ text: 'Skip Size', datafield: 'skipsize', width: '12%' },
					{ text: 'Waste Type', datafield: 'wastetype', width: '18%' },
					{ text: 'Ownership', datafield: 'ownership', width: '10%' },
					{ text: 'Amount',datafield:'amount',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
					
	              ]
            }); 
           $('#overlay,#PleaseWait').hide();
        });
    </script>
    <div id="detailGrid"></div>
