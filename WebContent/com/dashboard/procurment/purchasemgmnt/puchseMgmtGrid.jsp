<%@page import="com.dashboard.procurment.purchasemgmnt.ClsPurchasemgmntDAO"%>
<%
   ClsPurchasemgmntDAO DAO= new ClsPurchasemgmntDAO();        
 %>
 <%
 
    String chk = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    String salesmanid = request.getParameter("salesmanid")==null?"0":request.getParameter("salesmanid").trim();
 	String branchval = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
  	String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
    String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
    String areaid =request.getParameter("areaid")==null?"0":request.getParameter("areaid").toString();
    String divname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
 %> 
           	  
<style type="text/css">
     .colorClass2 {  
       background-color: #7ffaa6;   
     }
    .colorClass1 {
       background-color: #B0E2FF; 
    }
</style>

<script type="text/javascript">
 var temp4='<%=chk%>';
 var enqdata,enqfollowupexcel;        
 if(temp4=="1"){
	  enqdata='<%=DAO.enquirylistsearch(session, branchval, fromdate, todate, chk, divname) %>'; 
 }else{
	
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
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [     
        	  {name : 'doc_no', type: 'int'  },
              {name : 'voc_no', type: 'int'  },
				{name : 'date', type: 'date'  },
			 
				{name : 'qty', type: 'number'  },
				
				{name : 'productid', type: 'String'  },
				{name : 'productname', type: 'String'  },
				{name : 'unit', type: 'String'  },
				{name : 'unitdoc', type: 'String'  },
				{name : 'specid', type: 'String'  },
				{name : 'taxdocno', type: 'String'  },
				{name : 'refno', type: 'String'  },
				
				
				{name : 'dtype', type: 'String'  },
				
				{name : 'out_qty', type: 'number'  },
				
				{name : 'balqty', type: 'number'  },
				
				{name : 'amount', type: 'number'  },
				
				{name : 'total', type: 'number'  },
				
				{name : 'disper', type: 'number'  },
				{name : 'discount', type: 'number'  },
				{name : 'nettotal', type: 'number'  },
				
				{name : 'account', type: 'String'  },      
				{name : 'acname', type: 'String'  }, 
				
				 
				
				
				{name : 'clstatus', type: 'Int'  }, 
				
				
				
				{name : 'hidtax', type: 'number'  },
				{name : 'taxper', type: 'number'  },
				{name : 'taxamount', type: 'number'  }, 
				{name : 'nettaxamount', type: 'number'  }, 
				{name : 'psrno', type: 'number'  }, 
				{name : 'brhid', type: 'number'  }, 
				{name : 'branchname', type: 'String'  }, 
			
			
						],
				    localdata: enqdata,
        
        
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
    /* $("#enqlistgrid").on('bindingcomplete', function (event) {  
    	 var divname = $("#divname").val();
		   if(divname!=""){   */
			   /* if(divname=="amc"){     
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'voc_no');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'date');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'branchname');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'details');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'status');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'fdate');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'fstatus');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'age');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cperson');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qntvalue');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeee');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'ratee');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'designation');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'source');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'remarks');
				   
		       }else{
		    	   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdate');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'condocno');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'clienttype');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'site');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'area');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cbillmethod');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contctype');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contperiod');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipsize');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqty');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisit');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rate');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rent');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfee');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntvalue');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'ucalc');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdocstatus');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'email1');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'user1'); 
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'groupcompanies'); 
		       }  */ 
		   //}
    // }); 
 	/*  var cellclassname =  function (row, column, value, data) {
           //var cldocno = $('#enqlistgrid').jqxGrid('getcellvalue', row, "cldocno");
          // var qotstatus = $('#enqlistgrid').jqxGrid('getcellvalue', row, "qotstatus");
      	   /* if(parseInt(cldocno) == 0) {   
    		    return "colorClass1";  
    	   }   
    	   if(parseInt(qotstatus) == 0) {        
      		   return "colorClass2";  
      	   } */   
     //} */   
    $("#enqlistgrid").jqxGrid(
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
    	selectionmode: 'checkbox',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        enabletooltips: true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '2%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }    
                    },
                    { text: 'PR No', datafield: 'voc_no',  width: '5%', editable: false },
                    { text: 'docno', datafield: 'doc_no',  width: '5%', editable: false,hidden:true },
          	         { text: 'Product Id', datafield: 'productid',width: '15%', editable: false }, 
          	         { text: 'Product Name', datafield: 'productname', editable: false },
          	         { text: 'Branch Name', datafield: 'branchname', editable: false },
          	         { text: 'Unit', datafield: 'unit',  width: '5%' , editable: false},
          	         { text: 'Qty', datafield: 'qty',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right', editable: true,aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: true},
		           	 { text: 'Unit Price', datafield: 'amount',  width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: true,hidden:true},
		           	 { text: 'Total', datafield: 'total',  width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: false,hidden:true},
		             { text: 'Net Total', datafield: 'nettotal',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: false,hidden:true},
		             
		             
		             { text: 'Tax %', datafield: 'taxper',  width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right', editable: false,hidden:true},
		             { text: 'Tax Amount', datafield: 'taxamount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: false,hidden:true},
		             { text: ' Total Amount', datafield: 'nettaxamount',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, editable: false,hidden:true},
		             { text: 'Tax %', datafield: 'hidtax',  width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right', editable: false,hidden:true,hidden:true},
							

			 ]
    });
    $('.load-wrapp').hide();
    $('#enqlistgrid').on('rowselect', function (event) {
    	var ven='';
        var temp='';
        var tempbr='';
        var br='';
        var invalidarray=new Array();
    	var invalidbrarray=new Array();
    	var datafield = event.args.datafield;
	    var rowBoundIndex = event.args.rowindex;
	    //alert("asd");
	    var rowsCount = $('#enqlistgrid').jqxGrid('getrows').length;
	    var selectedIndexes = $('#enqlistgrid').jqxGrid('getselectedrowindexes');
	    var selectedRowCount = selectedIndexes.length;
        ven= $('#enqlistgrid').jqxGrid('getcellvalue', rowBoundIndex, "account");
        br= $('#enqlistgrid').jqxGrid('getcellvalue', rowBoundIndex, "brhid");
        if(temp=='' || selectedRowCount==0 ){
        	temp=ven;
        }else{
        	if(temp!=ven){
        		 $.messager.alert('Message','Please Select Same Vendor  ','warning');  
             	$('#enqlistgrid').jqxGrid('unselectrow', rowBoundIndex);
             	
        	}
        }
        
        if(tempbr=='' || selectedRowCount==0){
        	tempbr=br;
        }else{
        	 if(tempbr!=br){
       		 $.messager.alert('Message','Please Select Same Branch  ','warning');  
            	$('#enqlistgrid').jqxGrid('unselectrow', rowBoundIndex);
            	
       		}
        }
        
        
        if(selectedRowCount>1){
        	var firstvendor='';
        	for(var i=0;i<selectedIndexes.length;i++){
        		if(i==0){
        			firstvendor=$('#enqlistgrid').jqxGrid('getcellvalue', selectedIndexes[i], "account");
        		}
        		else{
        			
        			var currentvendor=$('#enqlistgrid').jqxGrid('getcellvalue', selectedIndexes[i], "account");
        			if(firstvendor!=currentvendor){
            			invalidarray.push(selectedIndexes[i]);
            		}	
        		}
        		
        	}
        }
        if(selectedRowCount>1){
        	var firstbrch='';
        	for(var i=0;i<selectedIndexes.length;i++){
        		if(i==0){
        			firstbrch=$('#enqlistgrid').jqxGrid('getcellvalue', selectedIndexes[i], "brhid");
        		}
        		else{
        			
        			var currentbrch=$('#enqlistgrid').jqxGrid('getcellvalue', selectedIndexes[i], "brhid");
        			if(firstbrch!=currentbrch){
        				invalidbrarray.push(selectedIndexes[i]);
            		}	
        		}
        		
        	}
        }
        if(invalidarray.length>0){
			$.messager.alert('Message','Please Select Same Vendor  ','warning');

        	for(var i=0;i<invalidarray.length;i++){
            	
            	$('#enqlistgrid').jqxGrid('unselectrow', invalidarray[i]);
            }
        }
        if(invalidbrarray.length>0){
			$.messager.alert('Message','Please Select Same Branch  ','warning');

        	for(var i=0;i<invalidbrarray.length;i++){
            	
            	$('#enqlistgrid').jqxGrid('unselectrow', invalidbrarray[i]);
            }
        }
        
        ven='';
      	temp='';
      	br='';
      	tempbr='';
    });
   
});
</script>
<div id="enqlistgrid"></div>