 <%@page import="com.dashboard.cargo.quotationfollowup.*"%>
 <% ClsQuotationFollowupDAO searchDAO = new ClsQuotationFollowupDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate1")==null?"0":request.getParameter("fromdate1").trim();
  	String todate = request.getParameter("todate1")==null?"0":request.getParameter("todate1").trim();
  	String reqdocno = request.getParameter("reqdocno")==null?"NA":request.getParameter("reqdocno").trim();
  	String load = request.getParameter("load")==null?"NA":request.getParameter("load").trim();
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
	String cmbinfo = request.getParameter("cmbinfo")==null?"0":request.getParameter("cmbinfo").trim();
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
 var templd='<%=load%>';
 <%-- var tempcmb='<%=cmbinfo%>'; --%>
var datas;

 if(temp4!='NA')
{ 
 <%--  datasex='<%=searchDAO.listsearchex(barchval,fromdate,todate,statusselect,reqdocno)%>';   --%>
  datas='<%=searchDAO.listsearch(barchval,fromdate,todate,statusselect,reqdocno,load)%>'; 
		 
} 
else
{ 
	
	datas;
	
	}  

$(document).ready(function () {
	  var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }    
      
   var rendererstring=function (aggregates){
   	var value=aggregates['sum'];
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     {name : 'doc_no', type: 'String'  },
                        {name : 'voc_no', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'confdate', type: 'date'  },
						{name : 'refno', type: 'String'  },
						{name : 'desc1', type: 'String'  }, 
						{name : 'brhid', type: 'String'  }, 
						{name : 'fdate', type: 'date'  }, 
						{name : 'enqno', type: 'String'  },
						{name : 'jobno', type: 'String'  },
						{name : 'confno', type: 'String'  },
						{name : 'confrefno', type: 'String'  },
						{name : 'salesman', type: 'String'  }, 
						{name : 'client', type: 'String'  }, 
						{name : 'qty', type: 'number'  },
						{name : 'out_qty', type: 'number'  },
						{name : 'srvtype', type: 'String'  },
						{name : 'pol', type: 'String'  },
						{name : 'pod', type: 'String'  },
						{name : 'mode', type: 'String'  },
						{name : 'enqdetdocno', type: 'String'  },
						{name : 'modeid', type: 'int'   },
						{name : 'smodeid', type: 'int'   },
						{name : 'shipid', type: 'string'  },
						{name : 'qotdoc', type: 'string'  },
						
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
    
    $("#orderlistgrid").jqxGrid(
    {
        width: '100%',
        height: 300,              
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        showfilterrow: true,
        filterable: true,
        sortable:true,
        columnsresize: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false, 
        enabletooltips:true,            
        columns: [   
                 	 { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '3%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                     },	
                     { text: ' No',datafield: 'doc_no', width: '3%',hidden:true },
                     { text: 'Qot No',datafield: 'voc_no', width: '4%' },
         			 { text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'},       
         			 { text: 'Enquiry No ',datafield: 'enqno', width: '5%' },
         			 { text: 'Client ',datafield: 'client'},
         			 { text: 'Job No ',datafield: 'jobno', width: '6%',hidden:true },
         			 { text: 'Salesman ',datafield: 'salesman', width: '11%' },
         			 { text: 'POL', datafield: 'pol',  width: '7%'  },
                     { text: 'POD', datafield: 'pod',  width: '7%'  },
                     { text: 'MODE', datafield: 'mode',  width: '4%' }, 
                     { text: 'Job No ',datafield: 'confno', width: '5%'},
                     { text: 'Job RefNo ',datafield: 'confrefno', width: '6%'},
                     { text: 'Job Date ',datafield: 'confdate', width: '7%',cellsformat:'dd.MM.yyyy'},
         			 { text: 'srvtype ',datafield: 'srvtype', width: '15%' ,hidden:true},
                     { text: 'Description', datafield: 'desc1',width:'10%'   },
                	 { text: 'Follow up Date', datafield: 'fdate', width: '7%',cellsformat:'dd.MM.yyyy',hidden:true},
                	 { text: 'QTY',datafield: 'qty', width: '3%'},
          			 { text: 'OUT_QTY',datafield: 'out_qty', width: '5%',hidden:true},
          			 { text: 'QOTDOC',datafield: 'qotdoc', width: '5%',hidden:true},
					]
    });
    
    $('#orderlistgrid').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
        var cmbinfo = document.getElementById("cmbinfo").value;
        var type=$("#cmbgridfilter").val()
        //alert("tempcmb==="+cmbinfo);
        disitems(cmbinfo);
    	var docno=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
    	var enqdetdocno=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "enqdetdocno");
    	document.getElementById("brhid").value=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
	    document.getElementById("masterdocno").value=docno;
	    document.getElementById("hidqty").value=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "qty");
	    document.getElementById("hidoutqty").value=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "out_qty");
	    document.getElementById("enqdetdocno").value=enqdetdocno;
	    document.getElementById("showdet").innerHTML=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+" - "+$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "client");
	    var modeid=$("#orderlistgrid").jqxGrid('getcellvalue',rowindex1,'modeid');
    	var smodeid=$("#orderlistgrid").jqxGrid('getcellvalue',rowindex1,'smodeid');
    	var shipid=$("#orderlistgrid").jqxGrid('getcellvalue',rowindex1,'shipid');
    	var qotdoc=$("#orderlistgrid").jqxGrid('getcellvalue',rowindex1,'qotdoc');
    	var outqty=$("#orderlistgrid").jqxGrid('getcellvalue',rowindex1,'out_qty');
    	$("#smodeid").val(smodeid);
    	$("#modeid").val(modeid);
    	$("#shipid").val(shipid);
    	$("#hidqotdoc").val(qotdoc);
    	$("#hidoutqty").val(outqty);
		$('#cmbinfo').attr("disabled",false);   
 	    $("#estdiv").load("estmgrid.jsp?docno="+docno+"&id="+1+"&load="+type);       
    }); 
    $("#overlay, #PleaseWait").hide();
});
</script>
<div id="orderlistgrid"></div>