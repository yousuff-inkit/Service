<%@page import="com.skips.servicecontract.ClsServiceContractDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsServiceContractDAO DAO= new ClsServiceContractDAO();  
 %>
 <%
 String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno").trim().toString(); 
 String typeid=request.getParameter("typeid")==null || request.getParameter("typeid")==""?"0":request.getParameter("typeid").trim().toString();     
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());  
 String revisionno=request.getParameter("revisionno")==null || request.getParameter("revisionno")==""?"0":request.getParameter("revisionno").trim().toString(); 
 %> 
    <script type="text/javascript">
    var termsdata;  
    var id='<%=id%>';  
    $(document).ready(function () {     
    	 
    		 termsdata='<%=DAO.termsDetails(session,trno,typeid,id)%>';
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'terms', type: 'String'  },  
                          	{name : 'conditions', type: 'String'  },
                          	{name : 'rowno', type: 'String'  },    
                          	],
                 localdata: termsdata,
                
                
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
            $("#jqxtermsGrid").jqxGrid(
            {
                width: '100%',
                height: 170,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell', 
                sortable: true,
                editable:true,
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                //Add row method
	            handlekeyboardnavigation: function (event) {
            	    //var rows=$('#jqxtermsGrid').jqxGrid('getrows');
                    var cell = $('#jqxtermsGrid').jqxGrid('getselectedcell');
    				if (cell != undefined && cell.datafield == 'conditions' ) {      
                      var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                      if (key == 13 || key == 9) {
	                      	$("#jqxtermsGrid").jqxGrid('addrow', null, {});	 
                      	    return true;
                      }     
                  }
                },
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Terms', datafield: 'terms',width:'45%'},
					{ text: 'Conditions',datafield:'conditions',width:'50%'},  
					{ text: 'rowno', datafield: 'rowno',width:'5%',hidden:true},
					]
            });
        	$("#jqxtermsGrid").on('cellendedit', function (event) {    
        	    var args = event.args;
        	    var columnDataField = event.args.datafield;
        	    var rowIndex = event.args.rowindex;
        	    var cellValue = event.args.value;
        	    var oldValue = event.args.oldvalue;         
        	    if(columnDataField=="conditions"){              
        	    	$('#jqxtermsGrid').jqxGrid('setcellvalue', rowIndex, "conditions",cellValue);        
        	    }
        	});
            if($('#mode').val()=='view'){
          		 $("#jqxtermsGrid").jqxGrid({ disabled: true});
            }else{
            	 $("#jqxtermsGrid").jqxGrid({ disabled: false});
            }
            $("#jqxtermsGrid").jqxGrid('addrow', null, {});
        });  
    </script>
    <div id="jqxtermsGrid"></div>  