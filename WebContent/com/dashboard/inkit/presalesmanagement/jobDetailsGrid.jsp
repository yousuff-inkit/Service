  <%@page import="com.dashboard.inkit.presalesmanagement.*"%>
     <%
     ClsPresalesmanagementDAO cmd= new ClsPresalesmanagementDAO();
    
   int enqdocno =request.getParameter("enqdocno")==null?0:Integer.parseInt(request.getParameter("enqdocno").trim());
	String branchval = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
  	%>
<script type="text/javascript">

	    var data;
        var enqdocno='<%=enqdocno%>'; 
        $(document).ready(function () { 	
        	
                
            	data='<%=cmd.jobdetGridLoad(enqdocno,fromdate,todate,branchval)%>';   
           	
        	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'type', type: 'string' },
                	{name : 'enqtype', type: 'string' },
                	{name : 'status', type: 'string' },
                	{name : 'jobdetno', type: 'string' },
                	{name : 'enq_id', type: 'string' },
                	{name : 'doc_no', type: 'string' },
					{name : 'voc_no', type: 'string' },
					{name : 'date', type: 'date' },
					{name : 'name', type: 'string' },
					{name : 'brch', type: 'string' },
					{name : 'services', type: 'string' },
					{name : 'discipline', type: 'string' },
					{name : 'commodity', type: 'string' },
					{name : 'area', type: 'string' },
					{name : 'qty', type: 'int' },
					{name : 'description', type: 'string' },
					{name : 'startdate', type: 'date' },
					{name : 'enddate', type: 'date' },
					{name : 'frequency', type: 'string' },
					{name : 'jobno', type: 'string' },
					{name : 'comodityid', type: 'int' },
					{name : 'serviceid', type: 'int' },
					{name : 'tradeid', type: 'int' },
					{name : 'areaid', type: 'int' },
					{name : 'frequencyid', type: 'int' },
					{name : 'empid', type: 'int' },
					{name : 'employee', type: 'String' },
							
					{name : 'clientid' , type: 'String' },					
                   	{name : 'details' , type: 'String' },
                 	{name : 'contmob' , type: 'String' },
                    {name : 'cpersonid' , type: 'String' },
                    {name : 'cperson' , type: 'String' }, 
					{name : 'telno', type: 'String'	},
					{name : 'email', type: 'String'	},
					{name : 'sal_name', type: 'String' },
					{name : 'sal_id' , type: 'number' },
					{name : 'curid' , type: 'number' },
					{name : 'brhid' , type: 'number' },
					{name : 'statupdt' , type: 'int' },
					{name : 'lpoattach' , type: 'int' },
							
                        ],
                		    localdata: data, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#jqxJobDetails").on("bindingcomplete", function (event) {
            	var tempspecdocno="";
            	var rows = $("#jqxJobDetails").jqxGrid('getrows');
			    for(var i=0 ; i < rows.length ; i++){
			    	if(i==0){
    		    		tempspecdocno=rows[i].comodityid;
					}
					else{
						tempspecdocno=tempspecdocno+","+rows[i].comodityid;
					}
			    	$('#txttempspecdocno').val(tempspecdocno);
			    }
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxJobDetails").jqxGrid(
            {
            	
                width: '99%',
                height: 400,
                source: dataAdapter,
				showaggregates:true,
				enableAnimations: true,
				filtermode:'excel',
				filterable: true,
				showfilterrow: true,
				sortable:true,
				selectionmode: 'singlerow',
				pagermode: 'default',
				editable:false,
				columnsresize: true,
				enabletooltips: true,
                
				handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#jqxJobDetails').jqxGrid('getselectedcell');
                    if ((cell1 != undefined && cell1.datafield == 'services') || (cell1 != undefined && cell1.datafield == 'discipline') || (cell1 != undefined && cell1.datafield == 'commodity')) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var rowindexestemp =cell1.rowindex;
                        	$('#rowindex').val(rowindexestemp);
                        	getspec(); 
                        	$('#jqxJobDetails').jqxGrid('render');
                          }
                    }
                    
                    var cell2 = $('#jqxJobDetails').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'area') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	if (key == 114) { 
                    		var rowindexestemp =cell2.rowindex;
                        	$('#rowindex').val(rowindexestemp);
                        	getareas();
                        	$('#jqxJobDetails').jqxGrid('render');
                          }
                    }
                    
                    var cell3 = $('#jqxJobDetails').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'frequency') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	if (key == 114) { 
                    		var rowindexestemp =cell3.rowindex;
                        	$('#rowindex').val(rowindexestemp);
                        	getfrequency();
                        	$('#jqxJobDetails').jqxGrid('render');
                          }
                    }
                },
                
                columns: [
							{  text: 'Sr. No.', sortable: false, filterable: false,
							   groupable: false, draggable: false, resizable: false,datafield: '',
							   columntype: 'number', width: '3%',cellsalign: 'center', align: 'center',
							   cellsrenderer: function (row, column, value) {
							   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							   }  
							},  
							{ text: 'Doc No.', datafield: 'enq_id', width: '3%' },
							{ text: 'doc_no', datafield: 'doc_no', width: '3%',hidden:true },
							{ text: 'Date', datafield: 'date', width: '5%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'Branch', datafield: 'brch', width: '8%' },
							{ text: 'Name', datafield: 'name', width: '10%' },
							{ text: 'Type', datafield: 'type', width: '4%'},
							{ text: 'Enq Type', datafield: 'enqtype', width: '4%'  },
							{ text: 'Status', datafield: 'status', width: '5%' },
							{ text: 'Employee', datafield: 'employee', width: '8%'},
							{ text: 'Services', datafield: 'services', width: '7%'},
							{ text: 'Discipline', datafield: 'discipline', width: '5%' },
							{ text: 'Skills', datafield: 'commodity', width: '8%' },
							{ text: 'Area', datafield: 'area', width: '7%'},
							{ text: 'Qty', datafield: 'qty', width: '3%',cellsalign:'right',align:'right' },
							{ text: 'Description', datafield: 'description',width: '10%'},
							{ text: 'Start Date', datafield: 'startdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '5%'  },
							{ text: 'End Date', datafield: 'enddate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '5%' },
							{ text: 'Frequency', datafield: 'frequency', width: '5%' },
							{ text: 'Job No.', datafield: 'jobno', width: '5%' },
							{ text: 'TradeId', datafield: 'tradeid', width: '10%', hidden: true },
							{ text: 'ServiceId', datafield: 'serviceid', width: '10%', hidden: true },
							{ text: 'comodityId', datafield: 'comodityid', width: '10%', hidden: true },
							{ text: 'areaid', datafield: 'areaid', width: '10%', hidden: true },
							{ text: 'Frequencyid', datafield: 'frequencyid', width: '8%', hidden: true },
							{ text: 'jobdetno', datafield: 'jobdetno', width: '10%', hidden: true },
							{ text: 'empid', datafield: 'empid',hidden: true },
							{ text: 'clientid', datafield: 'clientid',hidden: true },
							{ text: 'details', datafield: 'details',hidden: true },
							{ text: 'contmob', datafield: 'contmob',hidden: true },
							{ text: 'cpersonid', datafield: 'cpersonid',hidden: true },
							{ text: 'cperson', datafield: 'cperson',hidden: true },
							{ text: 'telno', datafield: 'telno',hidden: true },
							{ text: 'email', datafield: 'email',hidden: true },
							{ text: 'sal_name', datafield: 'sal_name',hidden: true },
							{ text: 'sal_id', datafield: 'sal_id',hidden: true },
							{ text: 'curid', datafield: 'curid',hidden: true },
							{ text: 'brhid', datafield: 'brhid',hidden: true },
							{ text: 'statupdt', datafield: 'statupdt',hidden: true },
							{ text: 'lpoattach', datafield: 'lpoattach',hidden:true },
							
						]
            });
            $('.load-wrapp').hide();			
					         		
	   		$('#jqxJobDetails').on('celldoubleclick', function (event) {
	   			if(event.args.columnindex == 8){
	       	        getEmployee();
				} 	  
			});
			  
	   		$('#jqxJobDetails').on('rowdoubleclick', function (event) {
	   			var rowBoundIndex = event.args.rowindex;
				document.getElementById("rowindex").value = rowBoundIndex;
	   			document.getElementById("reftrno").value=$('#jqxJobDetails').jqxGrid('getcellvalue', rowBoundIndex, "doc_no");
	   			document.getElementById("hidjobdetno").value=$('#jqxJobDetails').jqxGrid('getcellvalue', rowBoundIndex, "jobdetno");
	   		 	$('.textpanel p').text('ENQ - '+$('#jqxJobDetails').jqxGrid('getcellvalue', rowBoundIndex, "enq_id"));	
				
	   		 	var statupdt = parseInt($('#jqxJobDetails').jqxGrid('getcellvalue', rowBoundIndex, "statupdt"))
	   		 	var jobno = parseInt($('#jqxJobDetails').jqxGrid('getcellvalue', rowBoundIndex, "jobno"))
	   		 	var lpoattach = parseInt($('#jqxJobDetails').jqxGrid('getcellvalue', rowBoundIndex, "lpoattach"))
	   		 	//alert(jobno+"==="+statupdt+"======="+lpoattach);
				if(jobno > 0 || statupdt != 4 || lpoattach == 0){
					$('#btncontractcreate').attr("disabled",true);
				}
				else{
					$('#btncontractcreate').attr("disabled",false);
				}
	        });
			
			$("#jqxJobDetails").on('cellvaluechanged', function (event) {
	         	   var rowindexestemp = event.args.rowindex;
	         	   $('#rowindex').val(rowindexestemp);
	        });
           
        });

</script>
<div id="jqxJobDetails"></div>
<input type="hidden" id="rowindex"/>