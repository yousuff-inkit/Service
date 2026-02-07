<%@page import="com.skips.dispatch.ClsDispatchDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsDispatchDAO DAO= new ClsDispatchDAO();   
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
  	
    	ccdata='<%=DAO.SummaryData(session,id,fromdate,todate)%>';  
    	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
		                	{name : 'invno', type: 'String'  },
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
				      		{name : 'dispatch', type: 'String'  },
     						{name : 'asuser', type: 'String'},
     						{name : 'receivedby', type: 'String'},


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
                height: 450,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
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
                    datafield: '', columntype: 'number', width: '2%',
                    cellsrenderer: function (row, column, value) {
                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                    }
					},
					{ text: 'Doc Type', datafield: 'dtype', width: '3%',editable:false },  
					{ text: 'Inv No', datafield: 'invno', width: '3%',editable:false },
					{ text: 'Inv Date', datafield: 'invdate', width: '5%',editable:false },	
					{ text: 'Cont No', datafield: 'cntno', width: '3%',editable:false },	
					{ text: 'Ref No', datafield: 'refno', width: '3%',editable:false },
					{ text: 'Old Cont No', datafield: 'oldcntno', width: '6%',editable:false },	
					{ text: 'Site', datafield: 'site', width: '7%' ,editable:false},
					{ text: 'Skipsize', datafield: 'skipsize', width: '4%' ,editable:false},	
					{ text: 'Group Company', datafield: 'groupcompany', width: '7%' ,editable:false},	
					{ text: 'Email Status', datafield: 'emailstatus', width: '4%',editable:false },
					{ text: 'Dispatch',datafield:'dispatch',width:'10%' },
					{ text: 'User', datafield: 'asuser', width: '5%' },
					{ text: 'Received By', datafield: 'receivedby', width: '5%' },
					{ text: 'Client', datafield: 'client',width: '11%' ,editable:false },	
					{ text: 'Status', datafield: 'status', width: '4%',editable:false },
					{ text: 'Mail User',datafield:'mailuser',width:'5%',editable:false,hidden:true },
					{ text: 'Emailed to ',datafield:'email',width:'7%',editable:false,hidden:true },
					{ text: 'Contract Email',datafield:'cntemail',width:'7%',editable:false},
					{ text: 'Mobile', datafield: 'per_mob', width: '7%'},
					{ text: 'Tel',datafield:'per_tel',editable:false,width: '7%'},
					{ text: 'Salesman',datafield:'sal_name',editable:false,width: '7%'},   
					{ text: 'Total Invoice',datafield:'totinv',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Waste Coll.',datafield:'wscoll',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Tipping Fee',datafield:'tip',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Gate Fee',datafield:'gate',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Add. Waste Coll.',datafield:'addsk',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'Skip Rental',datafield:'skiprent',width:'5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
     			
					{ text: 'Doc No', datafield: 'doc_no', width: '5%',editable:false,hidden:true },
					{ text: 'brhid', datafield: 'brhid', width: '5%',editable:false,hidden:true  },
					]
            });
       	 $("#overlay, #PleaseWait").hide();
            $("#jqxsummarygrid").jqxGrid('addrow', null, {});
            $('#jqxsummarygrid').bind('click', function (event) {   
      	   	  
      	  
           });
            $('#jqxsummarygrid').on('rowdoubleclick', function (event) {       
                
                var rowindex1 = event.args.rowindex;                      
                $("#overlay, #PleaseWait").show();
                document.getElementById("hiddoc_no").value=$('#jqxsummarygrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 

            	$('#disflwupdiv2').load('dispatchfollowupGrid2.jsp?docno='+$('#jqxsummarygrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+'&check='+1);    
            });
        });  
   
    </script>
    
    <div id="jqxsummarygrid"></div>  
