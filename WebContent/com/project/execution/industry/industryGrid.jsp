<%@page import="com.project.execution.industry.ClsIndustryDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%
 	ClsIndustryDAO DAO= new ClsIndustryDAO();        
 %>

    <script type="text/javascript">
    var data;  
    data='<%=DAO.indGridLoad(session)%>';    
    $(document).ready(function () {     	    
            var source =
            {
                datatype: "json",
                datafields: [      
                         	{name : 'date',type:'date'},
                        	{name : 'doc_no' , type: 'String' },
                          	{name : 'name',type:'String'},
                          	],
                 localdata: data,
                
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
            $("#indGridID").jqxGrid(
            {
                width: '100%', 
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                sortable: true,
                editable:true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{text: 'DOC_NO',datafield:'doc_no',editable:false, width: '15%'},
					{text: 'date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' ,editable:false },
					{text: 'Name',datafield:'name',editable:false},
					]
            });  
            $('#indGridID').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;  
  		                document.getElementById("docno").value= $('#indGridID').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		                $("#date").jqxDateTimeInput('val',$("#indGridID").jqxGrid('getcellvalue', rowindex1, "date"));
  		                $('#txtname').val($("#indGridID").jqxGrid('getcellvalue', rowindex1, "name")) ;
              		 });            
        });    
    </script>
    <div id="indGridID"></div>
