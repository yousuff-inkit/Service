<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.skips.invoice.ClsManualInvoiceDAO1"%>  
<%
ClsManualInvoiceDAO1 DAO= new ClsManualInvoiceDAO1();
     
    String clname = request.getParameter("clname")==null?"":request.getParameter("clname");
    String cntdocno = request.getParameter("cntdocno")==null?"":request.getParameter("cntdocno");
    int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id"));  
  %> 

 <script type="text/javascript">
 
 var cldata;

 cldata='<%=DAO.searchContract(session,clname,cntdocno,id)%>';        
 
        $(document).ready(function () { 
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
	                	    {name : 'cldocno', type: 'String'  },
							{name : 'refname', type: 'String'  },
							{name : 'tr_no', type: 'String'  },
							{name : 'doc_no', type: 'String'  },  
                          	], 
                          	localdata: cldata,
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
            $("#jqxContractSearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                enabletooltips:true,  
                //Add row method
                columns: [
			                { text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
			                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
			                 }   },
							{ text: 'Doc No', datafield: 'doc_no', width: '10%' },  
							{ text: 'Client', datafield: 'refname' },
						    { text: 'tr_no', datafield: 'tr_no', width: '5%',hidden:true },
						    { text: 'CLIENT NO', datafield: 'cldocno', width: '5%',hidden:true },
					]
            });  
			 $('#jqxContractSearch').on('rowdoubleclick', function (event) {     
				               var rowindex1=event.args.rowindex;  
				               document.getElementById("hidcldocno").value= $('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				               document.getElementById("txtclient").value=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "refname");
				               document.getElementById("txtcontract").value=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				               document.getElementById("hidcntrno").value=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
							   
							   $('#contractnowindow').jqxWindow('close');        
		  }); 	 
        
      }); 
    </script>
    <div id="jqxContractSearch"></div>  
    