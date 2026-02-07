<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.inkit.amssupportedhrsreport.ClsAmsSupportedHrsDAO"%>  
<% ClsAmsSupportedHrsDAO DAO=new ClsAmsSupportedHrsDAO(); %>
<%
	String branch = request.getParameter("branch")==null?"NA":request.getParameter("branch").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String contract = request.getParameter("contract")==null?"0":request.getParameter("contract").trim();
	String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
%> 

 <style type="text/css">
    .redClass
    {
         background-color: #f0ffff;  
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .whiteClass
    {
        background-color: #fff;
    }
    
</style>

 <script type="text/javascript">
 var perdata;
      perdata= '<%=DAO.loadSupHrsGrid(branch,fromdate,todate,contract,check)%>';       
        $(document).ready(function () { 	
            
            var num = 0; 
            
            var cellclassname = function (row, column, value, data) {
        		if (data.invtrno>0) {
                	return "redClass";
            	}
        	};  
            
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'invtrno', type: 'int'  },
							{name : 'brhid', type: 'String'  },
							{name : 'doc_no', type: 'String'  },
							{name : 'voc_no', type: 'String'  },
     						{name : 'client', type: 'String' },  
     						{name : 'partnerclient', type: 'String' },  
     						{name : 'fromdt', type: 'date' },
     						{name : 'todt', type: 'date' },
     						{name : 'month', type: 'String' },  
     						{name : 'actual', type: 'number' },
     						{name : 'supportedhrs', type: 'number' },
     						{name : 'balance', type: 'number' },
     						{name : 'exthrs', type: 'number' },
     						{name : 'cfhrs', type: 'number' },  
     						{name : 'minbilling', type: 'number' },    
     						
     	                 ],
                 localdata: perdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed...tobeinvamt
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#amsSupHrsGrid").jqxGrid(
            {
                width: '100%',
                height: 510,    
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                filterable: true,
                showfilterrow: true,
                //pagermode: 'default', 
               	enabletooltips: true,
                columns: [
                	     { text: 'SL#', sortable: false, filterable: false,            
					      groupable: false, draggable: false, resizable: false,
					      datafield: 'sl', columntype: 'number', width: '3%',cellclassname: cellclassname,
					      cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					      }  
					     },      
					     { text: 'Doc No', datafield: 'voc_no', width: '4%' ,cellclassname: cellclassname },
						 { text: 'Client', datafield: 'client',  width: '17%' ,cellclassname: cellclassname },  
						 { text: 'Partner Client', datafield: 'partnerclient',  width: '13%' ,cellclassname: cellclassname },  
					     { text: 'From Date', datafield: 'fromdt', width: '6%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
					     { text: 'To Date', datafield: 'todt', width: '6%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
						 { text: 'Month', datafield: 'month',  width: '8%' ,cellclassname: cellclassname },  
						 { text: 'Actual Hrs', datafield: 'actual', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,cellclassname: cellclassname },
						 { text: 'Supported Hrs', datafield: 'supportedhrs', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,cellclassname: cellclassname },
						 { text: 'Balance Hrs', datafield: 'balance', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,cellclassname: cellclassname },
						 { text: 'Extra Hrs', datafield: 'exthrs', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,cellclassname: cellclassname },
						 { text: 'CF Hrs', datafield: 'cfhrs', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,cellclassname: cellclassname },
						 { text: 'Min Billing Hrs', datafield: 'minbilling', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,cellclassname: cellclassname },
						 { text: 'brhid', datafield: 'brhid',hidden:true },
						 { text: 'doc_no', datafield: 'doc_no',hidden:true },
					
				 ]
            });
                        
            $("#overlay, #PleaseWait").hide();
            
        });
    </script>
    <div id="amsSupHrsGrid"></div>