<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.gwinternal.queryanalysis.ClsQueryAnalysisDAO"%>
<% ClsQueryAnalysisDAO DAO=new ClsQueryAnalysisDAO(); %>  
 <% 
	String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
	String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
	String type = request.getParameter("type")==null?"":request.getParameter("type").trim();   
	String comprefid = request.getParameter("comprefid")==null?"":request.getParameter("comprefid").trim();    
%>
<style type="text/css">
.vioClass {
	background-color: #D8D8FF;
}
</style> 
<script type="text/javascript">

var schedata;  
		 schedata= '<%=DAO.serCountgrid(session,fromdate,todate,id,type,comprefid) %>';             

$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	
     	if(typeof(value)=='undefined'){
     		value=0;
     	}
     	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:10px; overflow: hidden;">' + " Total" + '</div>';
     }
     	
			
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'status', type: 'string'  },
					{name : 'doc_no', type: 'string'  },
                 	{name : 'count', type: 'string'  }	
						],
				    localdata: schedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, schedata) {
     	
    	if(typeof(schedata.status) != "undefined" && typeof(schedata.status) != "NaN" && schedata.status != "" && schedata.status=="ALL"){
              return "vioClass";
          };           	   
       };
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#jqxSerCount").jqxGrid(
    {
        width: '100%',
        height: 175,
        source: dataAdapter,
        rowsheight:16,
        showaggregates:true,
        showstatusbar:false,
        statusbarheight: 17,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'status', width: '70%' ,cellclassname:cellclassname,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',cellclassname:cellclassname, cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Doc No', datafield: 'doc_no',hidden:true,width: '30%',cellclassname:cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring},
					]
    
    });
    $("#overlay, #PleaseWait").hide();  
    $('#jqxSerCount').on('rowdoubleclick', function (event){ 
    		    var rowindex = event.args.rowindex;
    		    var barchval = document.getElementById("cmbbranch").value;  
    			var fromdate= $("#fromdate").val();
    			var todate= $("#todate").val();
    			var type= $("#cmbtype").val();
    			var statusdocno= $('#jqxSerCount').jqxGrid('getcellvalue', rowindex, "doc_no");      
    			var comprefid='<%=session.getAttribute("COMPANYREFID").toString().trim()%>'; 
    			$("#overlay, #PleaseWait").show();
    			$("#querydiv").load("queryanalysisGrid.jsp?id="+1+"&fromdate="+fromdate+"&todate="+todate+"&type="+type+"&statusdocno="+statusdocno+"&comprefid="+comprefid);    
    		});
});
</script>
<div id="jqxSerCount"></div>  