  <%@page import="com.realestate.tenancycontract.ClsTenancyContractDAO" %>
<%ClsTenancyContractDAO DAO=new ClsTenancyContractDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");%> 
<script type="text/javascript">
		 var data21;  
        $(document).ready(function () { 
           
            var temp='<%=docno%>';
             
             if(temp>0){   
            	 data21='<%=DAO.agentloading(docno)%>';  
           	 }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'agent', type: 'string'   },
     						{name : 'commperc', type: 'number' },
     						{name : 'commamount', type: 'number'   },
     						{name : 'salid', type: 'number'   }
                        ],
                         localdata: data21,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#agentGridId").jqxGrid(
            {
                width: '99.5%',
                height: 250,
                source: dataAdapter,
                disabled:true,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                handlekeyboardnavigation: function (event) {
                    var rows = $('#agentGridId').jqxGrid('getrows');
                     var rowlength= rows.length;
                       var cell = $('#agentGridId').jqxGrid('getselectedcell');
                       if (cell != undefined && cell.datafield == 'agent' && cell.rowindex == rowlength - 1) {
                           var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                           if (key == 114) {  
                        	   salespersonSearchContent('SearchSalesman.jsp?rowno='+cell.rowindex);
                           $('#agentGridId').jqxGrid('render');
                           }
                           if (key ==9) {                                                        
                               var commit = $("#agentGridId").jqxGrid('addrow', null, {});
                               rowlength++;                           
                           }
                       }
                       },
                    
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Agent', datafield: 'agent',  editable: false },	
							{ text: 'Agent', datafield: 'salid',  editable: false,width:'10%',hidden:true },	
							{ text: 'Commission %', datafield: 'commperc', cellsformat: 'd2', width: '25%', cellsalign: 'right', align: 'right'
								,
								cellbeginedit: function (row) {
									var temp=$('#agentGridId').jqxGrid('getcellvalue', row, "commamount");
								     if (parseFloat(temp)>0)
								    	 {
								    			    	 
								       return false; 
								    	 }
								      
								   
								  }
							},
							{ text: 'Commission Value', datafield: 'commamount', cellsformat: 'd2', width: '20%', cellsalign: 'right', align: 'right' 
								,
								cellbeginedit: function (row) {
									var temp=$('#agentGridId').jqxGrid('getcellvalue', row, "commperc");
								     if (parseFloat(temp)>0)
								    	 {
								    			    	 
								       return false; 
								    	 }
								      
								   
								  }
							}
						]
            });
            
            if ($("#mode").val() == "A" || $("#mode").val() == "E") {
            	
            	  $("#agentGridId").jqxGrid({ disabled: false});
            	
            }
            
            $('#agentGridId').on('celldoubleclick', function (event) {

            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	 
             
            	if(datafield=="agent")
         	   { 
            		  $("#agentGridId").jqxGrid('clearselection');
            		  salespersonSearchContent('SearchSalesman.jsp?rowno='+rowBoundIndex);
            		 $('#agentGridId').jqxGrid('render');
         	   }
                  });
          
        });

</script>
<div id="agentGridId"></div>
    