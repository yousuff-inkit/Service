<%@page import="com.it.enquiryit.ClsEnquiryDAO"%>
<% ClsEnquiryDAO DAO=new ClsEnquiryDAO();
   int enqdocno =request.getParameter("enqdocno")==null?0:Integer.parseInt(request.getParameter("enqdocno").trim());
%>
<script type="text/javascript">

	    var data;
        var enqdocno='<%=enqdocno%>'; 
        $(document).ready(function () { 	
        	
            if(enqdocno>0) {     
            	data='<%=DAO.jobdetGridLoad(enqdocno)%>';   
           	}
        	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'services', type: 'string' },
							{name : 'discipline', type: 'string' },
							{name : 'commodity', type: 'string' },
							{name : 'area', type: 'string' },
							{name : 'qty', type: 'int' },
							{name : 'rate', type: 'int' },
							{name : 'expyrs', type: 'int' },
							{name : 'refid', type: 'int' },
							{name : 'description', type: 'string' },
							{name : 'startdate', type: 'date' },
							{name : 'enddate', type: 'date' },
							{name : 'frequency', type: 'string' },
							{name : 'comodityid', type: 'int' },
							{name : 'serviceid', type: 'int' },
							{name : 'tradeid', type: 'int' },
							{name : 'areaid', type: 'int' },
							{name : 'frequencyid', type: 'int' }
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
            
            var cr_frequency = function (row, columnfield, value, defaulthtml, columnproperties) {
          	  var val="MONTHLY";
			  var frequencyid= $('#jqxJobDetails').jqxGrid('getcellvalue', row, "frequencyid");
          	  if(typeof(frequencyid)=="undefined" || typeof(frequencyid)=="NaN" || frequencyid=="") { 
          	  	return '<span style="margin: 4px; float: ' + columnproperties.cellsalign + '; color: #000000;">' + val + '</span>'; 
          	  }
            }   
            
            var cr_frequencyid = function (row, columnfield, value, defaulthtml, columnproperties) {
          	  var val=1;
			  var frequencyid= $('#jqxJobDetails').jqxGrid('getcellvalue', row, "frequencyid");
          	  if(typeof(frequencyid)=="undefined" || typeof(frequencyid)=="NaN" || frequencyid=="") { 
          	  	return '<span style="margin: 4px; float: ' + columnproperties.cellsalign + '; color: #000000;">' + val + '</span>'; 
          	  }
            }   
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxJobDetails").jqxGrid(
            {
            	
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                
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
                        	getareas2();
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
							{  text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							   groupable: false, draggable: false, resizable: false,datafield: '',
							   columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							   cellsrenderer: function (row, column, value) {
							   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							   }  
							},  
							{ text: 'Services', datafield: 'services', width: '8%', editable: false },
							{ text: 'Discipline', datafield: 'discipline', width: '8%', editable: false },
							{ text: 'Skills', datafield: 'commodity', width: '10%', editable: false },
							{ text: 'Area', datafield: 'area', width: '10%', editable: false },
							{ text: 'Qty', datafield: 'qty', width: '5%' },
							{ text: 'Bill Rate', datafield: 'rate', width: '5%' },
							{ text: 'Exp.Yrs', datafield: 'expyrs', width: '5%' },
							{ text: 'Ref.Id', datafield: 'refid', width: '5%' },
							{ text: 'Description', datafield: 'description', width: '18%' },
							{ text: 'Start Date', datafield: 'startdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '8%' },
							{ text: 'End Date', datafield: 'enddate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '8%' },
							{ text: 'Frequency', datafield: 'frequency', width: '6%', editable: false, cellsrenderer : cr_frequency },
							{ text: 'TradeId', datafield: 'tradeid', width: '10%', hidden: true },
							{ text: 'ServiceId', datafield: 'serviceid', width: '10%', hidden: true },
							{ text: 'comodityId', datafield: 'comodityid', width: '10%', hidden: true },
							{ text: 'areaid', datafield: 'areaid', width: '10%', hidden: true },
							{ text: 'Frequencyid', datafield: 'frequencyid', width: '10%', hidden: true, cellsrenderer : cr_frequencyid }
							
						]
            });
            
            if(document.getElementById("mode").value=='view') {
				$('#jqxJobDetails').jqxGrid({ disabled: true});
			}
			
			$("#jqxJobDetails").jqxGrid('addrow', null, {});
			
			            		
	   		$('#jqxJobDetails').on('celldoubleclick', function (event) {
	   			if(event.args.columnindex == 1 || event.args.columnindex == 2 || event.args.columnindex == 3) {
	           			var rowindextemp = event.args.rowindex;
	           			document.getElementById("rowindex").value = rowindextemp;
	           			getspec();
	              } 
	           	  
	           	  if(event.args.columnindex == 4){
	       	           var rowindextemp = event.args.rowindex;
	       	           document.getElementById("rowindex").value = rowindextemp;
	       	           getareas2();
	              } 
	           	  
	           	if(event.args.columnindex == 12){
	       	           var rowindextemp = event.args.rowindex;
	       	           document.getElementById("rowindex").value = rowindextemp;
	       	           getfrequency();
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