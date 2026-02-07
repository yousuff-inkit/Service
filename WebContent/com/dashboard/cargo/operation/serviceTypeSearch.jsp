<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%> 
<%ClsOperationDAO DAO=new ClsOperationDAO(); 
String modeid = request.getParameter("modeid")==null?"0":request.getParameter("modeid").trim();
String shipid = request.getParameter("shipid")==null?"0":request.getParameter("shipid").trim();
String smodeid = request.getParameter("smodeid")==null?"0":request.getParameter("smodeid").trim();
String id = request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").trim();
%>       
<script type="text/javascript">
  var sertypedata=<%=DAO.serviceTypeSearch(modeid,smodeid,shipid)%>;         
  var id1=<%=id%>;            
  $(document).ready(function () { 	
	  var source =
	  {    
		datatype: "json",
		datafields: [   
						{name : 'service', type: 'string'  },
						{name : 'doc_no', type: 'int'  },  
						{name : 'tax', type: 'int'  },
						{name : 'vatper1', type: 'int'  },
						{name : 'inacno', type: 'int'  }
						
					],
        localdata: sertypedata,
        pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
        }
	  };   
	  var dataAdapter = new $.jqx.dataAdapter(source);
            $("#serTypeSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                          { text: 'Service Type', datafield: 'service', width: '98%'},           
                          { text: 'doc_no', datafield: 'doc_no', width: '2%',hidden: true },  
                          { text: 'tax', datafield: 'tax', width: '2%',hidden: true },
                          { text: 'vatper1', datafield: 'vatper1', width: '2%',hidden: true },
                          { text: 'inacno', datafield: 'inacno', width: '2%',hidden: true },
                ]
            });
            
          $('#serTypeSearch').on('rowdoubleclick', function (event) {
                var rowindex2 = event.args.rowindex;
                if(parseInt(id1)==1){
                	var rowindex1 = $('#rowindex').val();     
                	 $("#jqxRevenue").jqxGrid('setcellvalue', rowindex1, "sertype", $('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "service"));
                     $("#jqxRevenue").jqxGrid('setcellvalue', rowindex1, "srvdocno", $('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                     $("#jqxRevenue").jqxGrid('setcellvalue', rowindex1, "tax", $('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "tax"));
                     $("#jqxRevenue").jqxGrid('setcellvalue', rowindex1, "vatper", $('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "vatper1"));
                     $("#jqxRevenue").jqxGrid('setcellvalue', rowindex1, "inacno", $('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "inacno"));
                   //  alert($('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "vatper1"));
                }else if(parseInt(id1)==2){
                	 var rowindex1 = $('#rowindex2').val();        
	               	 $("#jqxExpense").jqxGrid('setcellvalue', rowindex1, "sertype", $('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "service"));
	                 $("#jqxExpense").jqxGrid('setcellvalue', rowindex1, "srvdocno", $('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	                 $("#jqxExpense").jqxGrid('setcellvalue', rowindex1, "tax", $('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "tax"));
	                 $("#jqxExpense").jqxGrid('setcellvalue', rowindex1, "vatper", $('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "vatper1"));
	                 //$("#jqxExpense").jqxGrid('setcellvalue', rowindex1, "inacno", $('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "inacno"));
	             //    alert($('#serTypeSearch').jqxGrid('getcellvalue', rowindex2, "vatper1"));
                }
                $('#sertypesearchwindow').jqxWindow('close');        
          }); 
        });
    </script>
    <div id="serTypeSearch"></div>