  <%@page import="com.dashboard.skips.presalesanalysis.*"%>
     <%
     ClsPresalesanalysisDAO cmd= new ClsPresalesanalysisDAO();
     %>   
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
 <%
     int id=request.getParameter("id")==null || request.getParameter("id").equals("")?0:Integer.parseInt(request.getParameter("id").toString());
	 String brhid = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
	 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();            
 %>                
<script type="text/javascript">              
var slmdata;    
  slmdata='<%=cmd.salesmanwiseData(id, brhid, fromdate, todate) %>';                                      
     
$(document).ready(function(){

        var source =
        {
            datatype: "json",    
            datafields: [
                      	{name : 'sal_name' , type: 'string'},
 						{name : 'enqcnt', type: 'string'},
 						{name : 'quotcnt', type: 'string'},
 						{name : 'amccnt', type: 'string'},
             ],
             localdata: slmdata,
            
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

        $("#jqxSalesmanGrid").jqxGrid(   
                {
                	width: '100%',
                    height: 300,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '5%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Salesman',datafield: 'sal_name'},      
    					{ text: 'Enquiry',datafield: 'enqcnt', width: '10%'},  
    					{ text: 'Quotation',datafield: 'quotcnt',  width: '10%'},
    					{ text: 'Contract',datafield: 'amccnt', width: '10%'},        
    	              ]                 
                }); 
        $('.load-wrapp').hide();  
	});
</script>
<div id="jqxSalesmanGrid"></div>  