<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.skips.invoice.ClsManualInvoiceDAO1"%>  
<%
ClsManualInvoiceDAO1 DAO= new ClsManualInvoiceDAO1();  
     
    String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
    String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
    int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
  %> 

 <script type="text/javascript">
 
 var crmdata;

 crmdata='<%=DAO.searchClient(session,clname,docno,id)%>';         
 
        $(document).ready(function () { 
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
	                	    {name : 'cldocno', type: 'String'  },
							{name : 'refname', type: 'String'  },
							{name : 'sal_id', type: 'String'  },
							{name : 'com_add1', type: 'String'  }, 
							{name : 'mob', type: 'String'  }, 
							{name : 'telno', type: 'String'  }, 
							{name : 'email', type: 'String'  }, 
                          	], 
                          	localdata: crmdata,
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
            $("#jqxClientSearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                enabletooltips:true,  
                //Add row method
                columns: [
							{ text: 'Name', datafield: 'refname'},
							{ text: 'mob', datafield: 'mob', width: '12%' }, 
							{ text: 'telno', datafield: 'telno', width: '12%' }, 
							{ text: 'email', datafield: 'email', width: '18%' },
						    { text: 'Salesman Id', datafield: 'sal_id', width: '5%',hidden:true },  
						    { text: 'CLIENT NO', datafield: 'cldocno', width: '5%',hidden:true },
						    { text: 'com_add1', datafield: 'com_add1', width: '5%',hidden:true},   
					]
            });  
			 $('#jqxClientSearch').on('rowdoubleclick', function (event) {     
				               var rowindex1=event.args.rowindex;  
				               document.getElementById("hidcldocno").value= $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				               document.getElementById("txtclient").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "refname");
							   $('#clientwindow').jqxWindow('close');            
		  });   	 
        
      }); 
    </script>
    <div id="jqxClientSearch"></div>     
    