<%@page import="com.dashboard.skips.tippingdetails.ClsTippingDetailsDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsTippingDetailsDAO DAO= new ClsTippingDetailsDAO();   
 %>
 <%
 String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno").trim().toString(); 
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 int rad=request.getParameter("rad")==null || request.getParameter("rad")==""?0:Integer.parseInt(request.getParameter("rad").trim().toString());            
 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

 %> 
    <script type="text/javascript">
    var ccdata;  
    var id='<%=id%>';
    var fromdate='<%=fromdate%>';
    var todate='<%=todate%>';

    $(document).ready(function () { 
    	 var rendererstring=function (aggregates){
         	var value=aggregates['sum'];
         	if(typeof(value) == "undefined"){
         		value=0.00;
         	}
         	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
         }
  	
      var rendererstring1=function (aggregates){
          var value1=aggregates['sum1'];
          return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
         }
  	
    	ccdata='<%=DAO.tippingSummaryData(session,id,fromdate,todate)%>';  
    	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
		                	{name : 'doc_no', type: 'String'  },
		                	{name : 'remarks', type: 'string'  },
			      		    {name : 'dno', type: 'string'  },
		      	       	    {name : 'ddate', type: 'date'  },
		            	    {name : 'total', type: 'number'  },
		            	    {name : 'qty', type: 'number'  },
		                  	{name : 'wastetype', type: 'string'  },
		                  	{name : 'skipsize', type: 'string'  },
		                	{name : 'invno', type: 'String'  },
		                	{name : 'refno', type: 'String'  },
		                	{name : 'weight', type: 'number'  },
			            	{name : 'price', type: 'number'  },
			            	
			            	{name : 'billingmethod', type: 'string'  },
			            	{name : 'advinvmethod', type: 'string'  },
			            	{name : 'tippingfee', type: 'number'  },

                          	],
                 localdata: ccdata,
                
                
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
            $("#jqxsummarygrid").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
                filterable: true, 
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                showfilterrow:true,
                showaggregates:true,
                showstatusbar:true,
             	statusbarheight:25,
                //Add row method
	          
                columns: [{ text: 'SL#', sortable: false, filterable: false, editable: false,
                    groupable: false, draggable: false, resizable: false,
                    datafield: '', columntype: 'number', width: '4%',
                    cellsrenderer: function (row, column, value) {
                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                    }
					},
					{ text: 'Cont No', datafield: 'doc_no', width: '5%',editable:false },	
					{ text: 'Old Cont No', datafield: 'remarks', width: '10%',editable:false},
					{ text: 'Ref No', datafield: 'refno', width: '7%',editable:false},
					{ text: 'Billing Method', datafield: 'billingmethod', width: '6%',editable:false},
					{ text: 'Advance Invoice', datafield: 'advinvmethod', width: '4%',editable:false},
					{ text: 'DNO', datafield: 'dno', width: '12%',editable:false },
					{ text: 'DNO Date', datafield: 'ddate', width: '5%',editable:false , cellsformat:'dd.MM.yyyy'},	
					{ text: 'Qty', datafield: 'qty', width: '3%',editable:false,cellsalign:'right',align:'right'},
					{ text: 'Tipping Fee', datafield: 'tippingfee', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring},
					{ text: 'Total',datafield:'total',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring }, 
					{ text: 'Weight', datafield: 'weight', width: '3%',editable:false,cellsalign:'right',align:'right'},
					{ text: 'Price',datafield:'price',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },  
					{ text: 'Waste Type', datafield: 'wastetype',editable:false },   
					{ text: 'Skip Size', datafield: 'skipsize', width: '8%',editable:false },
					{ text: 'Inv No', datafield: 'invno', width: '6%',editable:false },
				
					]    
            });
       	    $("#overlay, #PleaseWait").hide();
            $("#jqxsummarygrid").jqxGrid('addrow', null, {});
          });  
    </script>
    <div id="jqxsummarygrid"></div>  