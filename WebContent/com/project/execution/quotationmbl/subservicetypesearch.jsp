<%@page import="com.project.execution.quotationmbl.ClsQuotationDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); %>
 <%
 int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
  int id=request.getParameter("servid")==null || request.getParameter("servid").equalsIgnoreCase("servid")?0:Integer.parseInt(request.getParameter("servid").trim());   
/*  int id=request.getParameter("servid")==null?0:Integer.parseInt(request.getParameter("servid").trim()); */  
 %>

 <script type="text/javascript">
 
 var serviceType;

 var rowIndex='<%=rowIndex%>';
 
   serviceType='<%=DAO.subServiceType(session,id)%>';
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'doc_no', type: 'String'  },
							{name : 'name', type: 'String'  },
     						
     						
                          	],
                          	localdata: serviceType,
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
            $("#jqxsubstypesearch").jqxGrid(
            {
                width: '100%',
                height: 420,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            filterable:true,
            showfilterrow:true,
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'doc_no', width: '19%' },
					{ text: 'Sub Service Type', datafield: 'name', width: '75%' }
					
					 
					
					]
            });
    		            
				           $('#jqxsubstypesearch').on('rowdoubleclick', function (event) { 
				              	var rowindex1=event.args.rowindex;
				            	 		
				              	$('#serviceGrid').jqxGrid('setcellvalue', rowIndex, "subservname",$('#jqxsubstypesearch').jqxGrid('getcellvalue', rowindex1, "name"));
				              	$('#serviceGrid').jqxGrid('setcellvalue', rowIndex, "subservid",$('#jqxsubstypesearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				              
				              	var rows = $('#serviceGrid').jqxGrid('getrows');
				            	var rowlength= rows.length;
				            	var rowindex1 = rowlength - 1;
				          	    var typeId=$("#serviceGrid").jqxGrid('getcellvalue', rowindex1, "subservid");
				          	    if(typeof(typeId) != "undefined"){
				                	$("#serviceGrid").jqxGrid('addrow', null, {});
				          	    }
				                   
				                $('#subsertypefowindow').jqxWindow('close');
				               
				            
				            }); 	 
				           
        
                  }); 

      
        
                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxsubstypesearch"></div>
    
    </body>
</html>