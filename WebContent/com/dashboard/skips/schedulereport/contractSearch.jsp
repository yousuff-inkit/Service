<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.schedulereport.ClsScheduleReportDAO" %>
<%
ClsScheduleReportDAO DAO= new ClsScheduleReportDAO(); 
int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
  %> 
 <script type="text/javascript">
 
 var contdata;
 contdata='<%=DAO.contractSearch(session,id)%>';           
 
        $(document).ready(function () {    
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
	                	     {name : 'doc_no', type: 'String'  },
							 {name : 'refname', type: 'String'  },
							 {name : 'site', type: 'String'  },
							 {name : 'tr_no', type: 'String'  },
							 {name : 'srno', type: 'String'  },
                          	], 
                          	localdata: contdata,
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
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '10%'},    
							{ text: 'Client', datafield: 'refname' },
							{ text: 'Site', datafield: 'site', width: '20%'},
							{ text: 'tr_no', datafield: 'tr_no', width: '10%',hidden:true},  
							{ text: 'srno', datafield: 'srno', width: '10%',hidden:true},  
					]
            });  
			 $('#jqxContractSearch').on('rowdoubleclick', function (event) {            
				               var rowindex1=event.args.rowindex;
				               document.getElementById("hidcntsrno").value= $('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "srno");
				               document.getElementById("hidcnttrno").value= $('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");  
				               document.getElementById("txtcontract").value=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
							   $('#contractWindow').jqxWindow('close');        
		  }); 	 
      }); 
    </script>
    <div id="jqxContractSearch"></div>     