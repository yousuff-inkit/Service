<%@page import="com.it.staffingcontract.ClsStaffingContractDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsStaffingContractDAO DAO= new ClsStaffingContractDAO(); %>
 <%
 String enqid=request.getParameter("refno")==null?"0":request.getParameter("refno").trim().toString();
  String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String reftype=request.getParameter("reftype")==null?"DIR":request.getParameter("reftype").trim().toString();
 
 %>
    <script type="text/javascript">
    var sitedata;
    var enqid='<%=enqid%>';
    var reftype='<%=reftype%>';
    var docno='<%=docno%>';

    $(document).ready(function () { 
	
			if(reftype=='ENQ'){
				sitedata='<%=DAO.mainGridLoadFromEnq(session,enqid)%>'; 
			}else{
				sitedata='<%=DAO.mainGridLoad(session,docno)%>'; 
			}
			
            var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'desigid' , type: 'string' },
     						{name : 'type', type: 'String'  },
                          	{name : 'desig', type: 'String'  },
                          	{name : 'rate', type: 'int'  },
                          	{name : 'cost', type: 'int'  },
                          	{name : 'rowno', type: 'int'  },
                          	{name : 'rdocno', type: 'int'  },

							{name : 'services', type: 'string' },
							{name : 'discipline', type: 'string' },
							{name : 'commodity', type: 'string' },
							{name : 'comodityid', type: 'int' },
							{name : 'serviceid', type: 'int' },
							{name : 'tradeid', type: 'int' },
							
							{name : 'description', type: 'string' },
							{name : 'empid', type: 'int' },
							{name : 'clientbillrate', type: 'int'  },
							{name : 'costtype', type: 'String'  },
							{name : 'clientcost', type: 'int'  },
							
                          	],
                localdata: sitedata,
                
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
			
			var cellclassname = function (row, column, value, data) {
            	if(data.invtrno>0){
                	return "orangeClass";
                }
            };
			
			var cellsrenderer1 = function (row, columnfield, value, defaulthtml, columnproperties) {
            	  var val1="Hourly";
            	  var services= $('#jqxcontractDetails').jqxGrid('getcellvalue', row, "services");
				  var costtype= $('#jqxcontractDetails').jqxGrid('getcellvalue', row, "costtype");
            	  if((typeof(services)=="undefined" || typeof(services)=="NaN" || services=="") && (typeof(costtype)=="undefined" || typeof(costtype)=="NaN" || costtype=="")) { 
            		   return '<span style="margin: 4px; float: ' + columnproperties.cellsalign + '; color: #000000;">' + val1 + '</span>'; 
					} 
            }
			  
            $("#jqxcontractDetails").jqxGrid(
            {
                width: '100%',
                height: 340,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
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
									
					{ text: 'Services', datafield: 'services', width: '8%', editable: false },
					{ text: 'Discipline', datafield: 'discipline', width: '8%', editable: false },
					{ text: 'Skills', datafield: 'commodity', width: '10%', editable: false },
					{ text: 'Description ', datafield: 'description', width: '10%', editable: false },
					{ text: 'Designation', datafield: 'desig',editable:false },
					{ text: 'Bill Type',datafield:'type',width:'10%',cellclassname: cellclassname,columntype:'dropdownlist',					
						createeditor: function (row, column, editor) {
								
	                            billmodelist = ["Hourly", "Daily","Monthly"]; 
	                         // billmodelist = ["SERVICE"];
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
							
							},
						 	 initeditor: function (row, cellvalue, editor) {
	                          
								var terms = $('#jqxcontractDetails').jqxGrid('getcellvalue', row, "type");
								
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
								
						 	 },		
					},
					{ text: 'Bill Rate',datafield:'rate',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right'},
					{ text: 'Client Bill Rate',datafield:'clientbillrate',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right', editable: false},
					{ text: 'Cost Type',datafield:'costtype',width:'10%',cellclassname: cellclassname,columntype:'dropdownlist',cellsrenderer:cellsrenderer1,					
						createeditor: function (row, column, editor) {
								
	                            billmodelist = ["Hourly", "Daily","Monthly"]; 
	                         // billmodelist = ["SERVICE"];
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
							
							},
						 	 initeditor: function (row, cellvalue, editor) {
	                          
								var terms = $('#jqxcontractDetails').jqxGrid('getcellvalue', row, "type");
								
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
								
						 	 },		
					},
					{ text: 'Cost',datafield: 'cost',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right', editable: false },
					{ text: 'Client Cost',datafield: 'clientcost',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right', editable: false},
					{ text: 'rowno',datafield: 'rowno',hidden:true},
					{ text: 'rdocno',datafield: 'rdocno',hidden:true},
					{ text: 'desigid',datafield:'desigid',hidden:true},
					{ text: 'TradeId', datafield: 'tradeid',  hidden: true },
					{ text: 'ServiceId', datafield: 'serviceid', hidden: true },
					{ text: 'comodityId', datafield: 'comodityid', hidden: true }, 
					{ text: 'empId', datafield: 'empid', hidden: true }, 
					]
            });
			
			funCalculateClientRate(null);

            $('#jqxcontractDetails').on('celldoubleclick', function(event) {
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
				if(datafield=="desig"){
					getdesig(rowBoundIndex);
	    	    }
				
				if(datafield=="services" || datafield=="discipline" || datafield=="commodity"){
					document.getElementById("rowindex").value = rowBoundIndex
					getspec();
	    	    }
				
				if(datafield=="description"){
					document.getElementById("rowindex").value = rowBoundIndex
					getEmployee();
	    	    }
							
            });
			
			$("#jqxcontractDetails").on('cellvaluechanged', function (event) {
                var datafield = event.args.datafield;
                var rowBoundIndex = event.args.rowindex;
            	
				if(datafield=="rate" || datafield=="cost"){
					funCalculateClientRate(rowBoundIndex);
				}
            	
				if(datafield=="rate"){
					$("#jqxcontractDetails").jqxGrid('addrow', null, {});
				}
            });
            
            if($('#mode').val()=='view'){
                
          		 $("#jqxcontractDetails").jqxGrid({ disabled: true});
            }

            $("#jqxcontractDetails").jqxGrid('addrow', null, {});
        });
    </script>
    
    <div id="jqxcontractDetails"></div>
	
	<input type="hidden" id="rowindex"/>
 

     
