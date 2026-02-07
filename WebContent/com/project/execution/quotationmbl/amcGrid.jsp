<%@page import="com.project.execution.quotationmbl.ClsQuotationDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); %>
 <%
 
 String docno=request.getParameter("qotdoc")==null?"0":request.getParameter("qotdoc").trim().toString();
 
 %>
    <script type="text/javascript">
    var amcdata;


    
    $(document).ready(function () { 
    	
		
    		amcdata='<%=DAO.amcGridLoad(session,docno)%>';
    		
    	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'rowno' , type: 'number' },
                          	{name : 'desc1', type: 'String'  },
                          	{name : 'area', type: 'String'  },
                          	{name : 'unit', type: 'String'  },
                          	{name : 'unitid', type: 'String'  },
                          	],
                 localdata: amcdata,
                
                
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
            $("#amcGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
                //Add row method
	
                columns: [
					/* { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					}, */
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                        groupable: false, draggable: false, resizable: false,
                        datafield: '', columntype: 'number', width: '4%',
                        cellsrenderer: function (row, column, value) {
                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        }
				},
					{text: 'rowno',datafield:'rowno',width:'45%',hidden:true},
					{text: 'Description',datafield:'desc1',width:'45%',editable:true},
					{text: 'Area',datafield:'area',editable:true,hidden:false},
					{ text: 'Unit', datafield: 'unit', width: '5%',editable:false  },         
					{ text: 'Unitid', datafield: 'unitid', width: '10%',hidden:true},

					]
            });
            
            $('#amcGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	var checkid=1;
 		      
 		      if((datafield=="unit"))
	    	   {
 		    	 unitSearchContent('unitSearchGrid.jsp?rowno=' + rowBoundIndex+'&checkid='+checkid);
	    	   }
 		     /* if((datafield=="site"))
	    	   {
 		    	getsite(rowBoundIndex);
	    	   } */
		     
            			
            		});
            
            if($('#mode').val()=='view'){
                
          		 $("#amcGrid").jqxGrid({ disabled: true});
              }
            

        });
    </script>

    <div id="amcGrid"></div>

