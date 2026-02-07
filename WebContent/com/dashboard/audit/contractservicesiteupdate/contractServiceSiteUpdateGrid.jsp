<%@page import="com.dashboard.audit.contractservicesiteupdate.ClsContractServiceSiteUpdateDAO" %>
<% ClsContractServiceSiteUpdateDAO DAO=new ClsContractServiceSiteUpdateDAO(); %>    
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <% String branch =request.getParameter("branch")==null?"0":request.getParameter("branch").toString();
    String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();
    String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();
    String contracttype =request.getParameter("contracttype")==null?"0":request.getParameter("contracttype").toString();   
    String contract =request.getParameter("contract")==null?"0":request.getParameter("contract").toString();
    String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString(); %>

 <script type="text/javascript">
 var data;
 
 var rendererstring=function (aggregates){
	  	var value=aggregates['sum'];
	  	
	  	if(typeof(value)=='undefined'){
	  		value=0;
	  	}
	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
		}
	  	var rendererstring1=function (aggregates){
	  	var value1=aggregates['sum1'];
	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
	  }
 
 	var bb='<%=contracttype%>';
	if(bb!='0'){
 		data= '<%= DAO.contractServiceSiteUpdateGridLoading(branch,fromdate,todate,contracttype,contract,clientid)%>';
	}
	else{
		bb=1;
	}
   
        $(document).ready(function () { 	
            
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'sal_name', type: 'String' },
     						{name : 'cperson', type: 'String' },
     						{name : 'referno', type: 'number' },
     						{name : 'refert', type: 'String' },
     						{name : 'mobno', type: 'String' },
     						{name : 'sdate', type: 'date' },
     						{name : 'edate', type: 'date' },
     						{name : 'cval', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'lfee', type: 'String' },
     						{name : 'tr_no', type: 'int' },
     						{name : 'cldocno', type: 'int' }
     					     						
                 ],
                 localdata: data,
                
                
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
            $("#contractServiceSiteUpdateGridID").jqxGrid(
            {
            	width: '98%',
    	        height: 360,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                showfilterrow:true,
                filterable: true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
                
                columns: [
						{ text: 'Doc No', datafield: 'doc_no', width: '5%' },
						{ text: 'Doc Type',  datafield: 'dtype', width: '6%' },
						{ text: 'Client', datafield: 'client', width: '18%' },
						{ text: 'Contact Person', datafield: 'cperson', width: '10%' },
						{ text: 'Salesperson', datafield: 'sal_name', width: '10%' },
						{ text: 'Reference Type', datafield: 'refert', width: '5%' },
						{ text: 'Reference No.', datafield: 'referno', width: '5%' },
						{ text: 'Mobile No', datafield: 'mobno', width: '8%' },
						{ text: 'Start Date', datafield: 'sdate', width: '8%',cellsformat:'dd.MM.yyyy' },
						{ text: 'End Date', datafield: 'edate', width: '8%',cellsformat:'dd.MM.yyyy',aggregates: ['sum1'],aggregatesrenderer:rendererstring1  },
						{ text: 'Contract Value',  datafield: 'cval', width: '5%',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
						{ text: 'Legal Fees',  datafield: 'lfee', width: '10%',aggregates: ['sum'],aggregatesrenderer:rendererstring ,hidden:true },
						{ text: 'Site',  datafield: 'site', width: '12%' },
						{ text: 'Contract Trno',  datafield: 'tr_no', hidden: true },
						{ text: 'Client Doc',  datafield: 'cldocno', hidden: true },
	              ]
            });
            
            if(bb==1) {
        	 	$("#contractServiceSiteUpdateGridID").jqxGrid('addrow', null, {});
        	}

            $("#overlay, #PleaseWait").hide();	
            
            $('#contractServiceSiteUpdateGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
        		
                document.getElementById("txtselectedcontract").value = $('#contractServiceSiteUpdateGridID').jqxGrid('getcellvalue', rowindex1, "tr_no");
                document.getElementById("txtselectedcontractdtype").value = $('#contractServiceSiteUpdateGridID').jqxGrid('getcellvalue', rowindex1, "dtype");
                document.getElementById("txtselectedcontractclient").value = $('#contractServiceSiteUpdateGridID').jqxGrid('getcellvalue', rowindex1, "cldocno");
        		
            	if(parseInt($('#txtselectedcontract').val())>0){
            		$("#overlay, #PleaseWait").show();
       			 	$("#serviceSiteDiv").load("serviceSiteGrid.jsp?docno="+$('#txtselectedcontract').val()+"&dtype="+$('#txtselectedcontractdtype').val());
       			}
            	
            });  
        
        });
    </script>
    <div id="contractServiceSiteUpdateGridID"></div>
