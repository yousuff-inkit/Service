<%@page import="com.dashboard.cargo.operationmanagement.ClsOperationManagementDAO"%>
<%
ClsOperationManagementDAO assignment=new ClsOperationManagementDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<style type="text/css">   
    .bbbClass      
    {
        background-color: #fbb111;            
    }
    
    .yellowClass
    {
        background-color: #CCFF00;
    }
       
     .orangeClass
    {
        background-color: #15f4ee;
    }
     .greenClass
    {
        background-color: #83f52c;
    }
</style>
<script type="text/javascript">
var datas;  
var id='<%=id%>';
$(document).ready(function () {
	if(id=='1'){
		datas='<%=assignment.gridDataLoad(id)%>';
	}
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'voc_no', type: 'String'  },
						{name : 'tr_no', type: 'String'  },  
                        {name : 'enqno', type: 'String'  },
						{name : 'client', type: 'String'  },
						{name : 'refno', type: 'String'  },
						{name : 'brhid', type: 'String'  },
						{name : 'confrmno', type: 'String'  },
						{name : 'confrmdate', type: 'date'  },    
						{name : 'adocno', type: 'String'  },
						{name : 'assigned', type: 'String'  },
						{name : 'status', type: 'String'  },
						{name : 'substatus', type: 'String'  },
						{name : 'pol', type: 'String'  },
						{name : 'pod', type: 'String'  },
						{name : 'mode', type: 'String'  },
						{name : 'smode', type: 'String'  },
						{name : 'shipment', type: 'String'  },
						{name : 'cpvamount', type: 'number'  },
						{name : 'cpvtrno', type: 'String'  },
						{name : 'mcptrno', type: 'String'  },
						{name : 'mcpdocno', type: 'String'  },  
						{name : 'jvtrno', type: 'String'  },
						{name : 'mcpcashacno', type: 'String'  },
						{name : 'mcpposted', type: 'String'  },
						{name : 'cpudocno', type: 'String'  },
						{name : 'subdesc', type: 'String'  },
						{name : 'mcpcredit', type: 'String'  },
						{name : 'docstatus', type: 'String'  },
						{name : 'modeid', type: 'String'  },
						{name : 'smodeid', type: 'String'  },        
						{name : 'shipid', type: 'String'  },
						{name : 'enqdocno', type: 'String'  },
						{name : 'qotdocno', type: 'String'  },
						{name : 'cficonfirm', type: 'String'  },
						{name : 'jobposted', type: 'String'  },
						{name : 'confrefno', type: 'String'  },
						{name : 'salesman', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'jobdate', type: 'date'  },
						{name : 'cfidocno', type: 'String'  },
						{name : 'qvocno', type: 'String'  },
						{name : 'expcashacno', type: 'String'  },
						],              
				    localdata: datas,     
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
    cellclassname = function (row, column, value, data) {
   	   if (data.status =="BOOKED") {   
   	       return "bbbClass";
   	   }
   	   if (data.status =="TRANSIT") {      
	       return "yellowClass";
	   }
   	   if (data.status =="DELIVERED") {
	       return "orangeClass";
	   }
   	   if (data.status =="COMPLETED") {   
	       return "greenClass";     
	   }
    }; 
    $("#jqxAssignmentgrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        sortable:true,
        enabletooltips: true,
        columnsresize: true,
        selectionmode: 'singlerow',    
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }     
                    },	
                     { text: 'ENQ NO',datafield: 'enqno', width: '4%',cellclassname:cellclassname },
                     { text: 'QUOTE NO', datafield: 'qvocno', width: '4%',cellclassname:cellclassname},
                     { text: 'JOBNO',datafield: 'confrmno', width: '4%',cellclassname:cellclassname },
                     { text: 'SUB JOB NO', datafield: 'voc_no', width: '4%',cellclassname:cellclassname},    
        			 { text: 'SUB JOB DATE',datafield: 'jobdate', width: '5%',cellclassname:cellclassname ,cellsformat:'dd.MM.yyyy' },
        			 { text: 'CLIENT',datafield: 'client', width: '14%',cellclassname:cellclassname},
        			 { text: 'MODE', datafield: 'mode',  width: '6%',cellclassname:cellclassname }, 
         	         { text: 'SUB MODE', datafield: 'smode',  width: '8%',cellclassname:cellclassname },
         	         { text: 'SHIPMENT', datafield: 'shipment',  width: '8%',cellclassname:cellclassname },   
         	         { text: 'POL', datafield: 'pol',  width: '6%',cellclassname:cellclassname  },
                     { text: 'POD', datafield: 'pod',  width: '6%',cellclassname:cellclassname  },
                        
                     
                     { text: 'JOB REF NO',datafield: 'confrefno', width: '4%',cellclassname:cellclassname },   
                     { text: 'JOB DATE',datafield: 'confrmdate', width: '5%',cellclassname:cellclassname,cellsformat:'dd.MM.yyyy' },
         			 { text: 'SALESMAN',datafield: 'salesman', width: '8%',cellclassname:cellclassname},
         			 { text: 'DOCUMENT STATUS',datafield: 'docstatus', width: '8%',cellclassname:cellclassname },
         			 { text: 'ADVANCE AMOUNT',datafield: 'cpvamount', width: '7%',cellsformat:'d4',cellsalign:'right',align:'right',cellclassname:cellclassname },   
         			 { text: 'ASSIGNED TO',datafield: 'assigned', width: '10%',cellclassname:cellclassname },
         			 { text: 'STATUS',datafield: 'status', width: '6%',cellclassname:cellclassname },
         			 { text: 'SUB STATUS',datafield: 'substatus', width: '8%',cellclassname:cellclassname },
         			 { text: 'DESCRIPTION',datafield: 'subdesc', width: '8%',cellclassname:cellclassname },
         			 { text: 'REMARKS',datafield: 'remarks', width: '8%',cellclassname:cellclassname },
         			 { text: 'REF NO', datafield: 'refno', width: '6%',cellclassname:cellclassname},
         	                                   
         	         { text: 'Job tr_no', datafield: 'tr_no',  width: '6%' , hidden: true},                         
           	         { text: 'brhid', datafield: 'brhid',  width: '6%', hidden: true},                     
         	         { text: 'adocno', datafield: 'adocno',  width: '6%' , hidden: true}, 
         	         { text: 'cpvtrno', datafield: 'cpvtrno',  width: '6%' , hidden: true},
         	         { text: 'jvtrno', datafield: 'jvtrno',  width: '6%' , hidden: true},
         	         { text: 'mcptrno', datafield: 'mcptrno',  width: '6%' , hidden: true},
         	         { text: 'mcpdocno', datafield: 'mcpdocno',  width: '6%' , hidden: true},   
         	         { text: 'mcpcashacno', datafield: 'mcpcashacno',  width: '6%' , hidden: true},
         	         { text: 'mcpposted', datafield: 'mcpposted',  width: '6%' , hidden: true},
         	         { text: 'cpudocno', datafield: 'cpudocno',  width: '6%' , hidden: true},
         	         { text: 'mcpcredit', datafield: 'mcpcredit',  width: '6%' , hidden: true},
         	         { text: 'modeid', datafield: 'modeid',  width: '6%' , hidden: true},
         	         { text: 'smodeid', datafield: 'smodeid',  width: '6%' , hidden: true},
         	         { text: 'shipid', datafield: 'shipid',  width: '6%' , hidden: true},
         	         { text: 'enqdocno', datafield: 'enqdocno',  width: '6%' , hidden: true},
         	         { text: 'qotdocno', datafield: 'qotdocno',  width: '6%' , hidden: true},
         	         { text: 'cficonfirm', datafield: 'cficonfirm',  width: '6%' , hidden: true},
         	         { text: 'jobposted', datafield: 'jobposted',  width: '6%' , hidden: true},
         	         { text: 'cfidocno', datafield: 'cfidocno',  width: '6%' , hidden: true},
         	         { text: 'expcashacno', datafield: 'expcashacno',  width: '6%' , hidden: true},
					]                             
    });
    $("#overlay, #PleaseWait").hide();    
    $('#jqxAssignmentgrid').on('rowdoubleclick', function (event) {            
        var rowindex2 = event.args.rowindex;
        document.getElementById("rowindex").value=rowindex2;       
        document.getElementById("hidcmbexpcash").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "expcashacno");
        document.getElementById("hidcfidocno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "cfidocno");
        document.getElementById("hidjobposted").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "jobposted");
        document.getElementById("hidcficonfirm").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "cficonfirm");
        document.getElementById("hidenqdocno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "enqdocno");
        document.getElementById("hidqotdocno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "qotdocno");
        document.getElementById("hidmodeid").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "modeid");
        document.getElementById("hidsmodeid").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "smodeid");
        document.getElementById("hidshipid").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "shipid");
        document.getElementById("hidcpudocno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "cpudocno");  
        document.getElementById("hidmcpposted").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "mcpposted");     
        document.getElementById("hidjvtrno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "jvtrno");    
        document.getElementById("hidmcpcashacno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "mcpcashacno");
        document.getElementById("hidmcptrno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "mcptrno");
        document.getElementById("hidmcpdocno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "mcpdocno");   
        document.getElementById("hidcpvamount").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "cpvamount");
        document.getElementById("hidcpvtrno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "cpvtrno");
        document.getElementById("hidadocno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "adocno");
        document.getElementById("hiddocno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "tr_no");    
        document.getElementById("hidvocno").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "voc_no");
        document.getElementById("hidbrhid").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "brhid");
        document.getElementById("selectedrow").innerHTML=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "voc_no")+" - "+$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "client");
        document.getElementById("hidlblname").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "voc_no")+" - "+$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "client");
        document.getElementById("hidjvdesc").value=$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "voc_no")+" - "+$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "client")+" - "+$('#jqxAssignmentgrid').jqxGrid('getcellvalue', rowindex2, "mode");
        $('.comments-container').html('');                                        
    });
});
</script>
<div id="jqxAssignmentgrid"></div>
<input type="hidden" id="rowindex"/>   