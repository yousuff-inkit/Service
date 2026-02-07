<%@page import="com.dashboard.skips.invoicelist.ClsInvoiceListDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsInvoiceListDAO DAO= new ClsInvoiceListDAO();   
 %>
 <%
 String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno").trim().toString(); 
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 int rad=request.getParameter("rad")==null || request.getParameter("rad")==""?0:Integer.parseInt(request.getParameter("rad").trim().toString());            
 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

 %>
 <style type="text/css">
     .pinkClass {
       background-color: #C1F884; 
    }
    .yellowClass {
       background-color: #F9C780; 
    }
</style> 
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
  	
    	ccdata='<%=DAO.SummaryData(session,id,fromdate,todate)%>';  
    	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
		                	{name : 'invno', type: 'String'  },
		                	{name : 'fromdate', type: 'String'  },
		                	{name : 'todate', type: 'String'  },
		                	{name : 'invdate', type: 'String'  },
		                	{name : 'cntno', type: 'string'  },
			      		    {name : 'oldcntno', type: 'string'  },
		      	       	    {name : 'site', type: 'String'  },
		            	 	{name : 'emailstatus', type: 'String'  },
		                  	{name : 'client' , type: 'string' },
						    {name : 'mailuser', type: 'String'  },
		                  	{name : 'email', type: 'string'  },
		                  	{name : 'cntemail', type: 'string'  },
		                  	{name : 'per_mob', type: 'string'  },
		                  	{name : 'per_tel', type: 'String'  },
		                  	{name : 'sal_name', type: 'String'  },
		                	{name : 'totinv', type: 'number'  },
		      	       	    {name : 'groupcompany', type: 'String'  },
		      	       	    {name : 'skipsize', type: 'String'  },
		      	       	    {name : 'doc_no', type: 'String'  },
		      	       	    {name : 'brhid', type: 'String'  },
		      	       	    {name : 'status', type: 'String'  }, 
		      	       	    {name : 'dtype', type: 'String'  },
		      	       	    {name : 'refno', type: 'String'  },
							{name : 'wscoll', type: 'number'  },
				      	    {name : 'tip', type: 'number'  },
				      	    {name : 'gate', type: 'number'  },
				      	  	{name : 'addsk', type: 'number'  },
				      		{name : 'skiprent', type: 'number'  },
				      		{name : 'verifyremarks', type: 'String'  },
			      	        {name : 'verifyuser', type: 'String'  },
			      	        {name : 'adftfeemsw', type: 'number'  },
			      	        {name : 'adftfee', type: 'number'  },  
			      	        {name : 'oth', type: 'number'  },  
			      	        {name : 'extcl', type: 'number'  },  
			      	        {name : 'skmnchrg', type: 'number'  },  
			      	        {name : 'fixrenval', type: 'number'  },  
			      	        {name : 'manualinv', type: 'number'  }, 
			      	        {name : 'datval', type: 'number'  }, 
			      	        {name : 'revision', type: 'String'  },
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
            var cellclassname =  function (row, column, value, data) {
         	    var datval = $('#jqxsummarygrid').jqxGrid('getcellvalue', row, "datval");
        	    if(parseInt(datval)==1) {     
        		    return "yellowClass";  //Revised Contracts        
        	    } 
            } 
            $("#jqxsummarygrid").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
                sortable: true,
                editable:false,
                filterable: true, 
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                showfilterrow:true,
                showaggregates:true,
                showstatusbar:true,
             	statusbarheight:25,
                //Add row method
	          
                columns: [{ text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname:cellclassname,
                    groupable: false, draggable: false, resizable: false,
                    datafield: '', columntype: 'number', width: '2%',
                    cellsrenderer: function (row, column, value) {
                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                    }
					},  
					{ text: 'Doc Type', datafield: 'dtype', width: '3%',editable:false,cellclassname:cellclassname },  
					{ text: 'Inv No', datafield: 'invno', width: '3%',editable:false,cellclassname:cellclassname },
					{ text: 'Inv Date', datafield: 'invdate', width: '5%',editable:false,cellclassname:cellclassname },	
					{ text: 'From Date', datafield: 'fromdate', width: '5%',editable:false,cellclassname:cellclassname },	
					{ text: 'To Date', datafield: 'todate', width: '5%',editable:false,cellclassname:cellclassname },	
					{ text: 'Cont No', datafield: 'cntno', width: '3%',editable:false,cellclassname:cellclassname },	
					{ text: 'Ref No', datafield: 'refno', width: '3%',editable:false,cellclassname:cellclassname },
					{ text: 'Old Cont No', datafield: 'oldcntno', width: '6%',editable:false,cellclassname:cellclassname },	
					{ text: 'Site', datafield: 'site', width: '7%' ,editable:false,cellclassname:cellclassname},
					{ text: 'Skipsize', datafield: 'skipsize', width: '4%' ,editable:false,cellclassname:cellclassname},	
					{ text: 'Group Company', datafield: 'groupcompany', width: '7%' ,editable:false,cellclassname:cellclassname},	
					{ text: 'Verified By',datafield:'verifyuser',width:'7%',editable:false,cellclassname:cellclassname},  
					{ text: 'Remarks', datafield: 'verifyremarks', width: '10%',editable:false,cellclassname:cellclassname }, 
					{ text: 'Email Status', datafield: 'emailstatus', width: '4%',editable:false,cellclassname:cellclassname },
					{ text: 'Client', datafield: 'client',width: '11%' ,editable:false,cellclassname:cellclassname },	
					{ text: 'Status', datafield: 'status', width: '4%',editable:false,hidden:true },
					{ text: 'Mail User',datafield:'mailuser',width:'5%',editable:false,cellclassname:cellclassname},
					{ text: 'Emailed to ',datafield:'email',width:'7%',editable:false,cellclassname:cellclassname},
					{ text: 'Contract Email',datafield:'cntemail',width:'7%',editable:false,cellclassname:cellclassname},
					{ text: 'Mobile', datafield: 'per_mob', width: '7%',cellclassname:cellclassname},
					{ text: 'Tel',datafield:'per_tel',editable:false,width: '7%',cellclassname:cellclassname},
					{ text: 'Salesman',datafield:'sal_name',editable:false,width: '7%',cellclassname:cellclassname},   
					{ text: 'Total Invoice',datafield:'totinv',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'Waste Coll.',datafield:'wscoll',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'Tipping Fee',datafield:'tip',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'Gate Fee',datafield:'gate',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'Add. Waste Coll.',datafield:'addsk',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'Skip Rental',datafield:'skiprent',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'ADF Tipping Fee MSW',datafield:'adftfeemsw',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'ADF Tipping Fee Cons.',datafield:'adftfee',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'Others',datafield:'oth',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'Extra Collection',datafield:'extcl',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'Skip Main.',datafield:'skmnchrg',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'Fixed Rental Value',datafield:'fixrenval',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
					{ text: 'Manual Invoices',datafield:'manualinv',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },  
					{ text: 'Doc No', datafield: 'doc_no', width: '5%',editable:false,hidden:true },
					{ text: 'brhid', datafield: 'brhid', width: '5%',editable:false,hidden:true  },
					{ text: 'datval', datafield: 'datval', width: '5%',editable:false,hidden:true  },
					{ text: 'To be reviewed', datafield: 'revision', width: '7%',cellclassname:cellclassname},
				 ]                   
            });
       	 $("#overlay, #PleaseWait").hide();
            $("#jqxsummarygrid").jqxGrid('addrow', null, {});
            $('#jqxsummarygrid').on('rowdoubleclick', function (event) {   
      	   	  var rowindex1=event.args.rowindex;    
      	   	  document.getElementById("hiddocno").value=$('#jqxsummarygrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
      	   	  document.getElementById("hidbrhid").value=$('#jqxsummarygrid').jqxGrid('getcellvalue', rowindex1, "brhid"); 
      	      document.getElementById("hiddtype").value=$('#jqxsummarygrid').jqxGrid('getcellvalue', rowindex1, "dtype");  
      	      document.getElementById("hidvocno").value=$('#jqxsummarygrid').jqxGrid('getcellvalue', rowindex1, "invno"); 
      	      document.getElementById("lblotherdetails1").innerHTML=$('#jqxsummarygrid').jqxGrid('getcellvalue', rowindex1, "invno")+" - "+$('#jqxsummarygrid').jqxGrid('getcellvalue', rowindex1, "client"); 
      	      $('.textpanel p').text($('#jqxsummarygrid').jqxGrid('getcellvalue', rowindex1, "invno")+" - "+$('#jqxsummarygrid').jqxGrid('getcellvalue', rowindex1, "client")); 
           });  
        });  
   
    </script>
    <div id="jqxsummarygrid"></div>  
