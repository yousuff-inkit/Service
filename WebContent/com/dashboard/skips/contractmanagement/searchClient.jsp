<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractmanagement.ClsContractManagementDAO" %>
<%
ClsContractManagementDAO DAO= new ClsContractManagementDAO();  
     
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
							{name : 'mob', type: 'String'  }, 
							{name : 'email', type: 'String'  }, 
							{name : 'groupcompanies', type: 'String'  },
							{name : 'cperson', type: 'String'  }, 
							{name : 'cpersonid', type: 'String'  }, 
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
							{ text: 'Contact Person', datafield: 'cperson', width: '15%' },     
							{ text: 'mob', datafield: 'mob', width: '15%' }, 
							{ text: 'email', datafield: 'email', width: '15%' },
							{ text: 'groupcompanies', datafield: 'groupcompanies', width: '15%' }, 
						    { text: 'CLIENT NO', datafield: 'cldocno', width: '5%',hidden:true },
						    { text: 'cpersonid', datafield: 'cpersonid', width: '5%',hidden:true }, 
					]
            });  
			 $('#jqxClientSearch').on('rowdoubleclick', function (event) {     
				               var rowindex1=event.args.rowindex;
				               document.getElementById("hidcntcldocno").value= $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				               document.getElementById("cntclient").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "refname");
							   document.getElementById("cntemail").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "email");
							   document.getElementById("cntmobile").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "mob");
							   document.getElementById("cntgrpcompany").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "groupcompanies"); 
							   document.getElementById("cntcperson").value= $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "cperson");
				               document.getElementById("hidcntcpersonid").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");   
							 
							   $('#clientsearch').jqxWindow('close');            
		  }); 	 
        
      }); 
    </script>
    <div id="jqxClientSearch"></div>     
    