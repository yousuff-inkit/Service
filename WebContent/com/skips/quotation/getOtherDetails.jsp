<%@page import="com.skips.quotation.ClsQuotationDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 	ClsQuotationDAO DAO= new ClsQuotationDAO();
 %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
 String type=request.getParameter("type")==null?"":request.getParameter("type").trim();%> 

 <script type="text/javascript">
 var otherdata;
 var rowIndex='<%=rowIndex%>';
 var type='<%=type%>';
 otherdata='<%=DAO.otherDetailSearch(session,type)%>'; 
        $(document).ready(function () { 
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'String'  },
     						{name : 'name', type: 'String'  },
     						{name : 'srno', type: 'String'  },
     						{name : 'tripsinmonth', type: 'number'  },  
                          	],
                          	localdata: otherdata,
                          //	 url: url1,
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
            $("#jqxotherdetailssearch").jqxGrid(
            {
                width: '100%',
                height: 420,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'doc_no', width: '20%',hidden:true },
					{ text: 'Doc No', datafield: 'srno', width: '20%' },
					{ text: 'Name', datafield: 'name', width: '72%' },
					{ text: 'tripsinmonth', datafield: 'tripsinmonth', width: '20%',hidden:true },  
					]
            });
			          $('#jqxotherdetailssearch').on('rowdoubleclick', function (event) {  
				              	var rowindex1=event.args.rowindex;
				              	if(type=="SERVICEBY"){  
				              		$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "ownership",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "name"));
			               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "ownershipid",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
			               			getTotals()
			               			var ownership= $('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "name");  
			     		        	var qty= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "nos"); 
			     		        	var days= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "days"); 
			     		        	var skipdoc=$('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "skipdoc"); 
			     		        	var tripsinmonth= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "tripsinmonth"); 
			     		        	if(typeof(skipdoc)=="undefined"){
			     		        		skipdoc="0";
			     		        	}
			     		        	if(typeof(days)=="undefined"){
			     		        		days="0";
			     		        	}
			     		        	if(typeof(tripsinmonth)=="undefined"){
			     		        		tripsinmonth="0";
			     		        	}
			     		        	getTariffRate(skipdoc,ownership,days,tripsinmonth,rowIndex);   
			     		        	var rate= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "rate");
			     		        	var security=0.0,skiprent=0.0;     
			     		        	if(qty==""){
		                     			qty=1;  
		                     		}
		                     		if(rate==""){
		                     			rate=1;  
		                     		}
		                     		if(ownership=="CLIENT SKIP"){        
			                     		$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "rent",skiprent);
			                     		$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "securityval",security);  
		                     		}
		                     		if(ownership=="OWN SKIP"){    
		                     			if(days==""){  
		                     				days=1;  
		                         		}
		                     			security=parseFloat(qty)*parseFloat(days)*parseFloat(rate)*3; 
		                     			if(tripsinmonth==""){         
		                         			tripsinmonth=1;  
		                         		}
		                     			skiprent=parseFloat(tripsinmonth)*parseFloat(days)*parseFloat(rate)*parseFloat(qty);
		                     			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "rent",skiprent);
		                     			security=skiprent*3;      
		                     			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "securityval",security); 
		                     		}
				              	}else if(type=="METHOD"){  
				              		$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "serviceby",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "name"));
			               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "servicebyid",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				              	}else if(type=="SCHEDULE"){    
				              		$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "serviceterm",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "name"));
			               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "servicetermid",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));  
			               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "tripsinmonth",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "tripsinmonth"));
			               			getTotals()
			               			var ownership= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "ownership");
			     		        	var days= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "days");  
			     		        	var skipdoc=$('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "skipdoc");    
			     		        	var tripsinmonth=$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "tripsinmonth");   
			     		        	if(typeof(skipdoc)=="undefined"){
			     		        		skipdoc="0";
			     		        	}
			     		        	if(typeof(days)=="undefined"){
			     		        		days="0";
			     		        	}
			     		        	if(typeof(ownership)=="undefined"){
			     		        		ownership="0";
			     		        	}
			     		        	getTariffRate(skipdoc,ownership,days,tripsinmonth,rowIndex);      
			     		        	
				              	}else if(type=="COLLECTION"){
				              		$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "collection",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "name"));
			               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "collectionid",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				              	}else if(type=="TIPPINGFEEMETHOD"){   
				              		$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "tippingmethod",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "name"));
			               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "tippingmethodid",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
			               			
			               			var wastedoc= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "wastedoc");  
			               			var skipdoc= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "skipdoc");
			               			var tippingmethod= $('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "name");   
			     		        	getTariffFee(tippingmethod,skipdoc,wastedoc,rowIndex);    
			     		        	
				              	}else if(type=="CTYPE"){ 
				              		$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "ctype",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "name"));
			               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "ctypeid",$('#jqxotherdetailssearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				              	}else{}            
				               	
				              	$("#jqxQuote").jqxGrid('addrow', null, {}); 
				                $('#otherdetailsinfowindow').jqxWindow('close');    
				        }); 	 
        
                  }); 
                       
    </script>
    <div id="jqxotherdetailssearch"></div> 
    
    </body>
</html>