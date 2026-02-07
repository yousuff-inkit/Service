<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.skips.servicecontract.ClsServiceContractDAO"%>  
<%
ClsServiceContractDAO DAO= new ClsServiceContractDAO();
     
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
							{name : 'sal_name', type: 'String'  },
							{name : 'com_add1', type: 'String'  }, 
							{name : 'mob', type: 'String'  }, 
							{name : 'telno', type: 'String'  }, 
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
                //Add row method
                columns: [
							{ text: 'Name', datafield: 'refname', width: '25%'},   
							{ text: 'Contact Person', datafield: 'cperson', width: '15%' },     
							{ text: 'mob', datafield: 'mob', width: '15%' }, 
							{ text: 'telno', datafield: 'telno', width: '15%' }, 
							{ text: 'email', datafield: 'email', width: '15%' },
							{ text: 'groupcompanies', datafield: 'groupcompanies', width: '15%' }, 
							{ text: 'Salesman', datafield: 'sal_name', width: '10%' },   
						    { text: 'Salesman Id', datafield: 'sal_id', width: '5%',hidden:true },  
						    { text: 'CLIENT NO', datafield: 'cldocno', width: '5%',hidden:true },
						    { text: 'com_add1', datafield: 'com_add1', width: '5%',hidden:true}, 
						    { text: 'cpersonid', datafield: 'cpersonid', width: '5%',hidden:true }, 
					]
            });  
			 $('#jqxClientSearch').on('rowdoubleclick', function (event) {     
				               var rowindex1=event.args.rowindex;
				               document.getElementById("hidcldocno").value= $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				               document.getElementById("txtclient").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "refname");
				               document.getElementById("txtsalesmandocno").value= $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "sal_id");
							   document.getElementById("txtsalesman").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
							   document.getElementById("txtmail").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "email");
							   document.getElementById("txtaddress").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "com_add1");
							   document.getElementById("txtmob").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "mob");
							   document.getElementById("txttele").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "telno");  
							   document.getElementById("txtgroupcompanies").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "groupcompanies"); 
							   document.getElementById("txtcperson").value= $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "cperson");
				               document.getElementById("hidcpersonid").value=$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");   
							 
							   $('#clientsearch').jqxWindow('close');            
		  }); 	 
        
      }); 
    </script>
    <div id="jqxClientSearch"></div>     
    