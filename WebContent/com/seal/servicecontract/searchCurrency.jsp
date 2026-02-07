<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.seal.servicecontract.ClsServiceContractDAO" %>
<%
 ClsServiceContractDAO DAO = new ClsServiceContractDAO();     
 String date = request.getParameter("date")==null?"":request.getParameter("date");
 String brhid = request.getParameter("brhid")==null || request.getParameter("brhid").trim().equals("")?"":request.getParameter("brhid");
 String type = request.getParameter("type")==null?"0":request.getParameter("type");
 String rowBoundIndex = request.getParameter("rowBoundIndex")==null?"0":request.getParameter("rowBoundIndex");
%> 

 <script type="text/javascript">  
 
 var currdata;
var type = '<%=type%>';
var rowindex2 = '<%=rowBoundIndex%>';
 currdata='<%=DAO.currencySearch(date,brhid)%>';   
        $(document).ready(function () { 
        
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
	     						{name : 'curid', type: 'String'  },  
	     						{name : 'code', type: 'String'  },
	     						{name : 'rate', type: 'number'  },
                          	],  
                          	localdata: currdata,
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
            $("#jqxCurrencyGrid").jqxGrid(
            {
                width: '99%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                //Add row method
     					
                columns: [
						{ text: 'Currency', datafield: 'code', width: '60%'  },  
						{ text: 'curid', datafield: 'curid', width: '0%',hidden:true },
						{ text: 'Rate', datafield: 'rate', width: '40%' },
					]
            });  
				            
				           $('#jqxCurrencyGrid').on('rowdoubleclick', function (event)   
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	if(type=="1"){  
				            		$('#jqxServiceYearlyGrid').jqxGrid('setcellvalue', rowindex2, "curr",$('#jqxCurrencyGrid').jqxGrid('getcellvalue', rowindex1, "code"));
				            		$('#jqxServiceYearlyGrid').jqxGrid('setcellvalue', rowindex2, "curid",$('#jqxCurrencyGrid').jqxGrid('getcellvalue', rowindex1, "curid"));
				            		$('#jqxServiceYearlyGrid').jqxGrid('setcellvalue', rowindex2, "rate",$('#jqxCurrencyGrid').jqxGrid('getcellvalue', rowindex1, "rate"));
				            	}else if(type=="2"){  
				            		$('#jqxServiceOneGrid').jqxGrid('setcellvalue', rowindex2, "curr",$('#jqxCurrencyGrid').jqxGrid('getcellvalue', rowindex1, "code"));
				            		$('#jqxServiceOneGrid').jqxGrid('setcellvalue', rowindex2, "curid",$('#jqxCurrencyGrid').jqxGrid('getcellvalue', rowindex1, "curid"));
				            		$('#jqxServiceOneGrid').jqxGrid('setcellvalue', rowindex2, "rate",$('#jqxCurrencyGrid').jqxGrid('getcellvalue', rowindex1, "rate"));
				            	}else{}
				                $('#currinfowindow').jqxWindow('close');
				          }); 	 
                  }); 
    </script>
    <div id="jqxCurrencyGrid"></div> 