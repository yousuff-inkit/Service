<%@page import="com.dashboard.seal.projectlist.ClsProjectListDAO" %>
<%
ClsProjectListDAO sd=new ClsProjectListDAO();  
%>

    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


<% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String branchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();%>
 <% int id = request.getParameter("id")==null || request.getParameter("id").equals("")?0:Integer.parseInt(request.getParameter("id").trim());%>
 
 <script type="text/javascript">
 var data,amcexpiryexcel;
 var temp='<%=rds%>';
 var bb='<%=branchval%>';
	
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
        	data= '<%= sd.loadDetailData(fromdate,todate,rds,branchval,cldocno,id)%>';     
        	var curdec = window.parent.curdec.value;  
        	var amtdec = window.parent.amtdec.value;  
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                	    {name : 'sername', type: 'String' },
                	    {name : 'billmethodname', type: 'String' },
                	    {name : 'description', type: 'String' },
                	 	{name : 'doc_no', type: 'String'  },
						{name : 'dtype', type: 'String'  },
						{name : 'client', type: 'String' },
						{name : 'cperson', type: 'String' },
						{name : 'sdate', type: 'date' },
						{name : 'edate', type: 'date' },
						{name : 'sal_name',type:'String' },
						{name : 'amcno', type: 'String' },
						{name : 'currency',type:'String' },
						{name : 'rate', type: 'number' },
						{name : 'type', type: 'String' },
                     {name : 'totalyr', type: 'number' },
                     {name : 'totalot', type: 'number' },

     						
     					     		 				
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
            $("#jqxloaddetailGrid").jqxGrid(
            {
                width: '99%',
                height: 515,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '5%' },
					{ text: 'Doc Type',  datafield: 'dtype', width: '5%' },
					{ text: 'AMC No.',  datafield: 'amcno', width: '8%',hidden:true },
					{ text: 'Client', datafield: 'client', width: '8%' },
					{ text: 'Contact Person', datafield: 'cperson', width: '10%' },
					{ text: 'Sales Man',datafield:'sal_name',width:'9%'},
					{ text: 'Currency', datafield: 'currency', width: '5%' },               
					{ text: 'Rate',  datafield: 'rate', width: '5%',cellsalign:'right',cellsformat:'d'+curdec,align:'right' },
					{ text: 'Type', datafield: 'type', width: '6%' },
					{ text: 'Bill Method', datafield: 'billmethodname', width: '6%' },
					{ text: 'Service Name', datafield: 'sername', width: '10%' },
					{ text: 'Description', datafield: 'description', width: '10%' },
					{ text: 'Start Date', datafield: 'sdate', width: '6%',cellsformat:'dd.MM.yyyy' },   
					{ text: 'End Date', datafield: 'edate', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Amount(Yearly)', datafield: 'totalyr', width: '8%',cellsalign:'right',cellsformat:'d'+amtdec,align:'right'  },
					{ text: 'Amount(One Time)',  datafield: 'totalot', width: '8%',cellsalign:'right',cellsformat:'d'+amtdec,align:'right'  }
	              ]   
            });
            if(bb==5)
        	{
        	 $("#jqxloaddetailGrid").jqxGrid('addrow', null, {});
        	}

                 $("#overlay, #PleaseWait").hide();
                 if(temp=="RE")  //not invo
         		{
             	
         		   $('#jqxloaddetailGrid').jqxGrid('showcolumn', 'amcno');
         		   
         		}
                 
                
        });
    </script>
    <div id="jqxloaddetailGrid"></div>
