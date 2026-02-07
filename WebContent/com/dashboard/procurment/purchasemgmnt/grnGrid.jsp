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
    String reftype="PO";
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
 var grndata,enqfollowupexcel;        
 if(temp4=="1"){
	  grndata='<%=DAO.enquirylistsearch(session, branchval, fromdate, todate, chk, divname) %>'; 
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
        	{name : 'brhid', type: 'string'    },    
            
   		 {name : 'branchname', type: 'string'    },    
          	{name : 'doc_no', type: 'number'    },
          	{name : 'voc_no', type: 'number'    },
       	{name : 'acno', type: 'number'    },
       	{name : 'account', type: 'String'  },      
			{name : 'acname', type: 'String'  }, 
       	 {name : 'productid', type: 'string'    },
    		{name : 'productname', type: 'string'    },
    		{name : 'unit', type: 'String'    },
				{name : 'qty', type: 'number'    },
				{name : 'prodoc', type: 'number'    },
				{name : 'unitdocno', type: 'number'    },
				{name : 'psrno', type: 'number'    },
				
			  	{name : 'qutval', type: 'number' },
				{name : 'saveqty', type: 'number'},  
				
				{name : 'checktype', type: 'number' },
		        {name : 'pqty', type: 'number'    },  
		     	{name : 'proid', type: 'string'    },
    		{name : 'proname', type: 'string'    },
    		{name : 'specid', type: 'string'  },
    		
    		 {name : 'foc', type: 'number'    },  
    		 
    			{name : 'stockid', type: 'string'  },
    			
    			 {name : 'oldqty', type: 'number'    },  
    			 
    			 {name : 'pqty', type: 'number'    },  
    			 {name : 'mainqty', type: 'number'    },  
    			 {name : 'maxfoc', type: 'number'    },  
    			 
    			 {name : 'oldfoc', type: 'number'  },  
    			 {name : 'locid', type: 'number'  },  
    			 {name : 'brandname', type: 'string'  },
			
			
						],
				    localdata: grndata,
        
        
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
    $("#grngrid").jqxGrid(
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
                 	{text: 'Doc No', datafield: 'voc_no', width: '6%'  }, 
                	{text: 'acno', datafield: 'acno', width: '10%'  ,hidden:true }, 
                	 { text: 'BranchId', datafield: 'brhid', width: '9%',hidden:true},  
					  { text: 'Branch', datafield: 'branchname', width: '9%'},  
				   { text: 'Account', datafield: 'account',  width: '5%', hidden:true },
                     { text: 'Account Name', datafield: 'acname',  width: '10%' , },
       	       
                  	{ text: 'Product', datafield: 'productid',width: '9%',}, 
						{ text: 'Product Name', datafield: 'productname', }, 
						{ text: 'Brand Name', datafield: 'brandname', width: '8%', editable:false },
						{ text: 'Unit', datafield: 'unit', width: '6%', editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
						
					
						{ text: 'Quantity', datafield: 'qty', width: '5%', cellsalign: 'left', align:'left',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'FOC', datafield: 'foc', width: '10%' ,cellsalign: 'left', align:'left',cellsformat:'d2',hidden:true},
					    {text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true},
						{text: 'unitdocno', datafield: 'unitdocno', width: '10%' ,hidden:true },
						{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true},
						
						
						{ text: 'oldqty', datafield: 'oldqty', width: '9%',cellsformat:'d2'  ,hidden:true},
						
				  	    {text: 'qutval', datafield: 'qutval', width: '10%' ,cellsformat:'d2',hidden:true },
						{ text: 'pqty', datafield: 'pqty', width: '9%',cellsformat:'d2' ,hidden:true  },
						{text: 'saveqty', datafield: 'saveqty', width: '10%' ,cellsformat:'d2'  ,hidden:true}, 
						{text: 'stockid', datafield: 'stockid', width: '10%' ,cellsformat:'d2' ,hidden:true}, 
						
						
						{text: 'pid', datafield: 'proid', width: '10%'  ,hidden:true }, 
						{text: 'pname', datafield: 'proname', width: '10%' ,hidden:true }, 
						
						 
						{text: 'checktype', datafield: 'checktype', width: '10%'  ,hidden:true},    
						{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true},
						
						
						{ text: 'mainqty', datafield: 'mainqty',  cellsalign: 'left', align:'left',cellsformat:'d2' ,hidden:true},
						
						
						{ text: 'maxfoc', datafield: 'maxfoc',  cellsalign: 'left', align:'left',cellsformat:'d2' ,hidden:true},
						  
						{text: 'oldfoc', datafield: 'oldfoc', width: '10%' ,hidden:true },
					
        			 

					]
    });
    $('.load-wrapp').hide();
    $('#grngrid').on('rowselect', function (event) {
    	var ven='';
        var temp='';
        var tempbr='';
        var br='';
    	var datafield = event.args.datafield;
	    var rowBoundIndex = event.args.rowindex;
	    //alert("asd");
	    var rowsCount = $('#grngrid').jqxGrid('getrows').length;
	    var selectedIndexes = $('#grngrid').jqxGrid('getselectedrowindexes');
	    var selectedRowCount = selectedIndexes.length;
        ven= $('#grngrid').jqxGrid('getcellvalue', rowBoundIndex, "account");
        br= $('#grngrid').jqxGrid('getcellvalue', rowBoundIndex, "brhid");
        if(temp=='' || selectedRowCount==0 ){
        	temp=ven;
        }else{
        	if(temp!=ven){
        		 $.messager.alert('Message','Please Select Same Vendor  ','warning');  
             	$('#grngrid').jqxGrid('unselectrow', rowBoundIndex);
             	
        	}
        }
        
        if(tempbr=='' || selectedRowCount==0){
        	tempbr=br;
        }else{
        	 if(tempbr!=br){
       		 $.messager.alert('Message','Please Select Same Branch  ','warning');  
            	$('#grngrid').jqxGrid('unselectrow', rowBoundIndex);
            	
       		}
        }
        
    	var invalidarray=new Array();
    	var invalidbrarray=new Array();

        if(selectedRowCount>1){
        	var firstvendor='';
        	for(var i=0;i<selectedIndexes.length;i++){
        		if(i==0){
        			firstvendor=$('#grngrid').jqxGrid('getcellvalue', selectedIndexes[i], "account");
        		}
        		else{
        			
        			var currentvendor=$('#grngrid').jqxGrid('getcellvalue', selectedIndexes[i], "account");
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
        			firstbrch=$('#grngrid').jqxGrid('getcellvalue', selectedIndexes[i], "brhid");
        		}
        		else{
        			
        			var currentbrch=$('#grngrid').jqxGrid('getcellvalue', selectedIndexes[i], "brhid");
        			if(firstbrch!=currentbrch){
        				invalidbrarray.push(selectedIndexes[i]);
            		}	
        		}
        		
        	}
        }
        if(invalidarray.length>0){
			$.messager.alert('Message','Please Select Same Vendor  ','warning');

        	for(var i=0;i<invalidarray.length;i++){
            	
            	$('#grngrid').jqxGrid('unselectrow', invalidarray[i]);
            }
        }
        if(invalidbrarray.length>0){
			$.messager.alert('Message','Please Select Same Branch  ','warning');

        	for(var i=0;i<invalidbrarray.length;i++){
            	
            	$('#grngrid').jqxGrid('unselectrow', invalidbrarray[i]);
            }
        }
        
        ven='';
      	temp='';
      	br='';
      	tempbr='';
    });
    
  
});
</script>
<div id="grngrid"></div>