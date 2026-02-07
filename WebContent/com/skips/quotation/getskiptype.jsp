<%@page import="com.skips.quotation.ClsQuotationDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 	ClsQuotationDAO DAO= new ClsQuotationDAO();
 %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>

 <script type="text/javascript">
 
 var skiptype;

 var rowIndex='<%=rowIndex%>';
 
 skiptype='<%=DAO.skipSearch(session)%>';
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'skiptype', type: 'String'  },
     						{name : 'skipdoc', type: 'String'  },
     						{name : 'value', type: 'String'  },
                          	],
                          	localdata: skiptype,
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
            $("#jqxskipsearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'skipdoc', width: '20%' },
					{ text: 'Skip Size', datafield: 'skiptype', width: '72%' },
					{ text: 'value', datafield: 'value', width: '5%',hidden:true },
					]
            });
    
            $("#jqxskipsearch").jqxGrid('addrow', null, {});
				           $('#jqxskipsearch').on('rowdoubleclick', function (event) {     
				              	        var rowindex1=event.args.rowindex;
				               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "skiptype",$('#jqxskipsearch').jqxGrid('getcellvalue', rowindex1, "skiptype"));
				               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "skipdoc",$('#jqxskipsearch').jqxGrid('getcellvalue', rowindex1, "skipdoc"));
				               			$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "gatefee",$('#jqxskipsearch').jqxGrid('getcellvalue', rowindex1, "value"));
				               			var ownership= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "ownership");
				     		        	var days= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "days");  
				     		        	var tripsinmonth= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "tripsinmonth");   
				     		        	var skipdoc=$('#jqxskipsearch').jqxGrid('getcellvalue', rowindex1, "skipdoc");
				     		        	if(typeof(tripsinmonth)=="undefined"){
				     		        		tripsinmonth="0";   
				     		        	}
				     		        	if(typeof(days)=="undefined"){
				     		        		days="0";
				     		        	}
				     		        	if(typeof(ownership)=="undefined"){
				     		        		ownership="0";
				     		        	}    
				     		        	getTotals()
				     		        	getTariffRate(skipdoc,ownership,days,tripsinmonth,rowIndex);      
				     		        	var wastedoc= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "wastedoc");   
				     		        	var tippingmethod= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "tippingmethod");
				     		        	getTariffFee(tippingmethod,skipdoc,wastedoc,rowIndex);  
				               			$("#jqxQuote").jqxGrid('addrow', null, {});
				                        $('#skipinfowindow').jqxWindow('close');
				            		 }); 	 
				           
                  }); 
                       
    </script>
    <div id="jqxskipsearch"></div>
    
    </body>
</html>