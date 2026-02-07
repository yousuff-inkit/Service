
<%@page import="com.dashboard.gwinternal.internalcomments.ClsInternalCommentsDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsInternalCommentsDAO DAO= new ClsInternalCommentsDAO(); %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>

 <script type="text/javascript">
 
 var inddata;

 var rowIndex='<%=rowIndex%>';
 

 
 inddata='<%=DAO.searchCompany(session)%>'; 
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                	{ name: 'doc_no', type: 'string' },
					{ name: 'cldoc_no', type: 'string' },
					{ name: 'comp_id', type: 'string' },
					{ name: 'company', type: 'string' },
					{ name: 'comment', type: 'string' },

     						
     						
                          	],
                          	localdata: inddata,
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
            $("#jqxcompsearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'doc_no', editable:false,hidden:true,width: '7%' },
					{ text: 'CL Doc No', datafield: 'cldoc_no', editable:false,hidden:true,width: '7%' },
					{ text: 'Company Id', datafield: 'comp_id', editable:false, width: '24%'},
					{ text: 'Company', datafield: 'company',editable:false, width:'70%'},
					{ text: 'Comment', datafield: 'comment', editable:false, hidden:true, width: '50%' },
					 
					
					]
            });
    
            //$("#jqxindsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxcompsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				                
				               // document.getElementById("docno").value= $('#jqxcompsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				                document.getElementById("txtname").value= $('#jqxcompsearch').jqxGrid('getcellvalue', rowindex1, "company");
				               // document.getElementById("comment").value= $('#jqxcompsearch').jqxGrid('getcellvalue', rowindex1, "comment");
				                document.getElementById("cldocno").value= $('#jqxcompsearch').jqxGrid('getcellvalue', rowindex1, "cldoc_no");
				              
				                $('#companylistwindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
        
                       
    </script>
    <div id="jqxcompsearch"></div>
    
    </body>
</html>