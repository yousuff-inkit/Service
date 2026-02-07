  <%@page import="com.dashboard.project.jobwisedivision.ClsJobWiseDivisionDAO" %>
<%
ClsJobWiseDivisionDAO sd=new ClsJobWiseDivisionDAO();
%>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
  <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
  <% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString();%>

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
 
 
 var bb='<%=rds%>';
	if(bb!='0'){
        data= '<%= sd.loadGridData(fromdate,todate,rds,barchval,clientid,id)%>';        
	}
	else{
		bb=1;
	}
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'grpcode', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'sal_name', type: 'String' },
     						{name : 'cperson', type: 'String' },
     						{name : 'referno', type: 'number' },
     						{name : 'refert', type: 'String' },
     						{name : 'mobno', type: 'String' },
     						{name : 'sdate', type: 'date' },
     						{name : 'edate', type: 'date' },
     						{name : 'cval', type: 'number' },
     						{name : 'site', type: 'String' },
     						{name : 'lfee', type: 'number' },
     						{name : 'status', type: 'String' },
     						{name : 'tr_no', type: 'String'  },						
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
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '99%',
                height: 300,       
                source: dataAdapter,
                columnsresize: true,
                enabletooltips:true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow:true,
                filterable: true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '5%' },
					{ text: 'TR No', datafield: 'tr_no', width: '5%',hidden:true },
					{ text: 'Doc Type',  datafield: 'dtype', width: '6%' },
					{ text: 'Client', datafield: 'client', width: '20%' },
					{ text: 'Contact Person', datafield: 'cperson', width: '10%' },
					{ text: 'Salesperson', datafield: 'sal_name', width: '8%' },   
					{ text: 'Reference Type', datafield: 'refert', width: '5%' },
					{ text: 'Reference No.', datafield: 'referno', width: '5%' },
					{ text: 'Mobile No', datafield: 'mobno', width: '10%' },
					{ text: 'Start Date', datafield: 'sdate', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'End Date', datafield: 'edate', width: '6%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Contract Value',  datafield: 'cval', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
					{ text: 'Site',  datafield: 'site'},
	              ]   
            });
            if(bb==1)
        	{
        	 $("#jqxloaddataGrid").jqxGrid('addrow', null, {});
        	}
          $("#overlay, #PleaseWait").hide();
          $('#jqxloaddataGrid').on('rowdoubleclick', function (event){ 
		         var rowindex1=event.args.rowindex;
		         $("#jqxsubdivGrid").jqxGrid('clear');
		         document.getElementById("docno").value = $('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
		         var docno=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
		         $("#subgriddata").load("subdivisionGrid.jsp?docno="+docno+"&id="+1);                   
		   }); 	    
        });
    </script>
    <div id="jqxloaddataGrid"></div>
