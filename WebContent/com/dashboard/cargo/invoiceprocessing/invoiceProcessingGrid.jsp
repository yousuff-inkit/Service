<%@page import="com.dashboard.cargo.invoiceprocessing.ClsInvoiceProcessing"%>
<%
ClsInvoiceProcessing DAO=new ClsInvoiceProcessing();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String cldocno=request.getParameter("client")==null?"0":request.getParameter("client");
String jobno=request.getParameter("jobno")==null?"0":request.getParameter("jobno");
String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
%>
<% String contextPath=request.getContextPath();%>
<script type="text/javascript">
var griddata,clnttmp="";
var id='<%=id%>';
var temp4='<%=barchval%>';
$(document).ready(function () {
	if(id=='1'){
		griddata='<%=DAO.gridData(cldocno,barchval)%>';
	}
	var rendererstring1=function (aggregates){
       	var value=aggregates['sum1'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
       }
 
	var rendererstring=function (aggregates){
		var value=aggregates['sum'];
		return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">'  + value + '</div>';
	}
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'doc_no', type: 'String'  },
						{name : 'cdifdno', type: 'String'  },
						{name : 'jobno', type: 'String'  },
						{name : 'descdoc', type: 'String'  },
						{name : 'client', type: 'String'  },
						{name : 'cldocno', type: 'String'  },
						{name : 'qotno', type: 'String'  },
						{name : 'pol', type: 'String'  },
						{name : 'pod', type: 'String'  },
						{name : 'description', type: 'String'  },
						
						{name : 'type', type: 'string'  },
						{name : 'account', type: 'string'    },
						{name : 'accname', type: 'string'    },
						{name : 'qty', type: 'int'    },
						{name : 'unitprice', type: 'number'    },
						{name : 'total', type: 'number'    },
						{name : 'discount', type: 'number'    },
						{name : 'nettotal', type: 'number'    },
						{name : 'costtype', type: 'string'    },
						{name : 'costgroup', type: 'string'    },
						
						{name : 'costcode', type: 'number'    },
						{name : 'nuprice', type: 'number'    },
						{name : 'remarks', type: 'string'    },
						{name : 'confdate', type: 'date'  },
						{name : 'confno', type: 'String'  },
						{name : 'confrefno', type: 'String'  },
						{name : 'headdoc', type: 'number'    },
						{name : 'qutval', type: 'number'    },
						{name : 'grtype', type: 'number'    },
						 {name : 'taxper', type: 'number'  },  
    					 {name : 'taxamount', type: 'number'  },
    					{name : 'taxperamt', type: 'number'  },
    					
    					
    					{name : 'idno', type: 'number'  },
						],
				    localdata: griddata,
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
    
    $("#jqxInvProcessing").jqxGrid(
    {
        width: '100%',
        height: 250,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        sortable:true,
        columnsresize: true,
        ready: function()
        {
            $("#jqxInvProcessing").find('.jqx-grid-column-header:first').children().hide();
        },
        selectionmode: 'checkbox',
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
         			 { text: 'JOB NO', datafield: 'jobno', width: '5%'},
         			 { text: 'CLIENT', datafield: 'client',  width: '22%'},
         			 { text: 'QUOT NO', datafield: 'qotno', width: '5%'},
         			 { text: 'POL', datafield: 'pol', width: '8%'},
         			 { text: 'POD',datafield: 'pod', width: '8%' },
         			  { text: 'Confirm No ',datafield: 'confno', width: '6%'},
                      { text: 'Confirm RefNo ',datafield: 'confrefno', width: '7%'},
                      { text: 'Confirm Date ',datafield: 'confdate', width: '7%',cellsformat:'dd.MM.yyyy'},
         			 { text: 'Description', datafield: 'description',  width: '19%'},
         			 { text: 'Qty', datafield: 'qty', width: '3%', cellsalign: 'left', align:'left',editable: true, hidden: true},
         			 { text: 'Unit Price', datafield: 'unitprice', width: '5%',cellsalign: 'right', align:'right',cellsformat:'d2',editable: true, hidden: true },
         			 { text: 'doc_no', datafield: 'doc_no',  width: '4%', hidden: true},
         			 { text: 'cdifdno', datafield: 'cdifdno',  width: '4%', hidden: true},
         			{ text: 'descdoc', datafield: 'descdoc',  width: '4%', hidden: true},
         			{ text: 'cldocno', datafield: 'cldocno',  width: '4%', hidden: true},
					/* { text: 'Total', datafield: 'total', width: '5%',cellsformat:'d2',cellsalign: 'right', align:'right', editable:false},
					{ text: 'Discount', datafield: 'discount', width: '4%',cellsalign: 'right', align:'right',cellsformat:'d2',editable: true ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
					{ text: 'Net Total', datafield: 'nettotal', width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,editable:false},
					{ text: 'Tax %', datafield: 'taxper', width: '3%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,editable: true},
					{ text: 'Tax Amount', datafield: 'taxperamt', width: '6%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right'  ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring}, */
					{ text: 'Net Total', datafield: 'taxamount', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
					
					/* { text: 'Type', datafield: 'type', width: '6%', cellsalign: 'center',align: 'center'}, 
					{ text: 'Account', datafield: 'account', width: '4%' ,editable: false,cellsalign: 'center', align:'center'},
					{ text: 'Account Name', datafield: 'accname'  ,editable: false},
					{ text: 'Remarks', datafield: 'remarks', width: '19%' ,editable: true}, */
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxInvProcessing').on('rowdoubleclick', function (event){
    	var rowindextemp = event.args.rowindex;
    	var docno=$('#jqxInvProcessing').jqxGrid('getcellvalue',rowindextemp,'doc_no');
    	var trno=$('#jqxInvProcessing').jqxGrid('getcellvalue',rowindextemp,'tr_no');
    	$("#enquirydiv").load("enquiryGrid.jsp?docno="+trno);
    	$("#srvcdiv").load("estmgrid.jsp?docno="+trno);
    });
    
    $('#jqxInvProcessing').on('rowselect', function (event){
    	  var rowindex2=event.args.rowindex;
    	  var g=0;
    	  var client=$("#jqxInvProcessing").jqxGrid('getcellvalue', rowindex2, "cldocno"); 
    	  var rows = $("#jqxInvProcessing").jqxGrid('getrows');
    		var selectedrows = $("#jqxInvProcessing").jqxGrid('selectedrowindexes');
    		 for(var i=0 ; i < rows.length ; i++){
    		for(var j=0 ; j < selectedrows.length ; j++){
    			if(selectedrows[j]==i)	{	
    			var clnttmp=rows[i].cldocno;
    			if((clnttmp!=client) && (g==0)){
    				g++;
    	   			 $.messager.alert('Message','Diffrent Client Not Allowed....!','warning');
    	   			 $('#jqxInvProcessing').jqxGrid('unselectrow', rowindex2);
    	   			 //clnttmp="";
    	   			 break;
    	   		}else{
    	   			
    	   		}
    			}
    		 }
    		 }
    	//alert("in cell click");
    		
   		
    	
    	
    });
    $('#jqxInvProcessing').on('cellclick', function (event){
    	
	    var datafield=event.args.datafield;
	    var rowindex1=event.args.rowindex;
    	if(datafield=="attach"){
			var brchid=$("#jqxInvProcessing").jqxGrid('getcellvalue', rowindex1, "branch"); 
			var docno=$("#jqxInvProcessing").jqxGrid('getcellvalue', rowindex1, "jobno");
			var frmdet="SJOB";
			if ($("#docno").val()!="") {
		   		var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brchid,
				   "_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				myWindow.focus();
		
			} else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
		    }
			 
	    }
    });
   
});


</script>
<div id="jqxInvProcessing"></div>