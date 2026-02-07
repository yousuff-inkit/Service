
<%@page import="com.dashboard.inkit.assignjobfollowup.AssignJobFollowupDAO" %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%AssignJobFollowupDAO DAO= new AssignJobFollowupDAO(); %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
 String cdtype =request.getParameter("cdtype")==null?"":request.getParameter("cdtype").toString();
 String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();
 String chkfromdate = request.getParameter("chkfromdate")==null?"0":request.getParameter("chkfromdate").trim();
 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
 String branchval = request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();
 String chktodate = request.getParameter("chktodate")==null?"0":request.getParameter("chktodate").trim();

 %>

 <script type="text/javascript">
 
 var areadata;

 var rowIndex='<%=rowIndex%>';
 

  
 areadata='<%=DAO.jobSearch(session,cdtype,clientid,chkfromdate,fromdate,date,branchval,chktodate)%>'; 
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'tr_no', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						
     						
     						
                          	],
                          	localdata: areadata,
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
            $("#jqxjobsearch").jqxGrid(
            {
                width: '100%',
                height: 420,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'tr_no', width: '21%' },
					{ text: 'Job', datafield: 'dtype', width: '75%' }
					
					 
					
					]
            });
    
            //$("#jqxjobsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxjobsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				              	document.getElementById("txtjob").value=$('#jqxjobsearch').jqxGrid('getcellvalue', rowindex1, "dtype");
		              	        document.getElementById("jobid").value=$('#jqxjobsearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
		              	       
				              
				                $('#job1').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       <%--  function addArea(){
        	
        	var formname='Service Settings';
        	var formcode='SERS';
        	var lblname='Service Area Settings';
        	var lbldrp='area';
        	var detName='Service Settings';
        	
        	 var url=document.URL;
		     var reurl=url.split("/com/");
		     var path1='com/controlcentre/settings/ServiceSettings/serviceSettings.jsp';
        	var path= path1+"?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"&mode=A";
			  
			   top.addTab( detName,reurl[0]+"/"+path);
        	
        	window.open("<%=contextPath%>/com/controlcentre/settings/ServiceSettings/serviceSettings.jsp?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"","Service Settings","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260");
      
        } --%>
        
                       
    </script>
<!--     <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div>
 -->    <div id="jqxjobsearch"></div>
    
    </body>
</html>