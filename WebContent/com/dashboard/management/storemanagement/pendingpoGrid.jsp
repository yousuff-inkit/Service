 <%@page import="com.dashboard.management.storemanagement.ClsStoremanagementDAO" %>
<%ClsStoremanagementDAO cpd=new ClsStoremanagementDAO(); %>
 
<% String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
String brhid = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();%> 
   
 
<script type="text/javascript">
 
var  enqdatas;
	
 $(document).ready(function () {
	  var rendererstring1=function (aggregates){
       	var value=aggregates['sum1'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
       }    
    
   var rendererstring=function (aggregates){
 	var value=aggregates['sum'];
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
   var temp4='<%=brhid%>';
  	 enqdatas='<%=cpd.pendingpogrid(load,brhid)%>'; 
 
	 var source =
	    {
	        datatype: "json",
	        datafields: [   
	                     
	 
						 {name : 'doc_no', type: 'int'  },
							
						   {name : 'voc_no', type: 'int'  },
							{name : 'date', type: 'date'  },
							{name : 'refno', type: 'String'  },
							{name : 'dtype', type: 'String'  },
							{name : 'acno', type: 'number'  },
							{name : 'productid', type: 'string'    },
                    		{name : 'productname', type: 'string'    },
                    		{name : 'account', type: 'String'  },      
							{name : 'acname', type: 'String'  }, 
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
                    		 
                    		 {name : 'unitprice', type: 'string'    },   
                    		 
                    		 {name : 'refrowno', type: 'int'    },  
                    		 
                    		 {name : 'discount', type: 'number'    },  
                    		 
                    		 {name : 'disper', type: 'number'    },  
                    		 {name : 'brandname', type: 'string'    },    
                    		 {name : 'brhid', type: 'string'    },    
                             
                    		 {name : 'branchname', type: 'string'    },    
                             
							
							],
					    localdata: enqdatas,
	        
	        
	        pager: function (pagenum, pagesize, oldpagenum) {
	            // callback called when a page or page size is changed.
	        }
	    };
	  
	    var cellclassname =  function (row, column, value, data) {


	   	  var ss= $('#orderlistdet').jqxGrid('getcellvalue', row, "clstatus");
	   		          if(parseInt(ss)>0)
	   		  		{
	   		  		
	   		  		return "yellowClass";
	   		  	
	   		  		}
	   		}

	    
	    var dataAdapter = new $.jqx.dataAdapter(source,
	    		 {
	        		loadError: function (xhr, status, error) {
	                alert(error);    
	                }
			            
		            }		
	    );
	    
	    
	   
	   
	    
	    $("#orderlistdet").jqxGrid(
	    {
	    	width: '99.5%',
	        height: 500,
            source: dataAdapter,
	        showaggregates:true,
	        enableAnimations: true,
	        filtermode:'excel',
	        filterable: true,
	        sortable:true,
	        columnsresize:true,
			showfilterrow: true,
	        showaggregates:true,
	        showstatusbar:true,
	        columnsresize: true,
	        enabletooltips: true,
	        statusbarheight: 21,
	        selectionmode: 'checkbox',
	        pagermode: 'default',
	        editable:false,
	        columns: [   
	                  { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
	                      groupable: false, draggable: false, resizable: false,
	                      datafield: 'sl', columntype: 'number', width: '4%',
	                      cellsrenderer: function (row, column, value) {
	                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	                      }  
	                    },	
	            
	    	 
						 
						   { text: 'DocNO',datafield: 'doc_no', width: '4%' ,cellclassname: cellclassname,hidden:true},
			         		
						   { text: 'Doc No',datafield: 'voc_no', width: '4%' ,cellclassname: cellclassname},
		         			 { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
		         			 { text: 'BranchId', datafield: 'brhid', width: '9%',cellclassname: cellclassname,hidden:true},  
							    { text: 'Branch', datafield: 'branchname', width: '9%',cellclassname: cellclassname},  
						     { text: 'ACNO', datafield: 'acno',  width: '5%' ,cellclassname: cellclassname,hidden:true},
		         			 { text: 'Account', datafield: 'account',  width: '4%' ,cellclassname: cellclassname },
			                  { text: 'Account Name', datafield: 'acname',  width: '18%' ,cellclassname: cellclassname },
		           	         { text: 'Ref No',datafield: 'refno', width: '8%',cellclassname: cellclassname,hidden:true},
		         			 { text: 'Type',datafield: 'dtype', width: '5%',cellclassname: cellclassname,hidden:true},
                     	    { text: 'Product', datafield: 'productid', width: '10%',cellclassname: cellclassname},  
					     	{ text: 'Product Name', datafield: 'productname'   ,width: '25%',cellclassname: cellclassname , },  
							{ text: 'Brand Name', datafield: 'brandname', width: '9%',cellclassname: cellclassname, editable:false },
							{ text: 'Unit', datafield: 'unit', width: '4%',cellclassname: cellclassname , editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							{ text: 'Quantity', datafield: 'qty',cellsalign: 'left', align:'left',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'FOC', datafield: 'foc', width: '10%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
					     	 { text: 'Unit Price', datafield: 'unitprice', width: '10%'   ,cellclassname: cellclassname ,hidden:true},
							 { text: 'discount', datafield: 'discount', width: '10%'   ,cellclassname: cellclassname ,hidden:true},
							{ text: 'disper', datafield: 'disper', width: '10%'   ,cellclassname: cellclassname ,hidden:true},
							{text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true},
							{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true},
							{text: 'refrowno', datafield: 'refrowno', width: '10%',hidden:true },
					  	   {text: 'qutval', datafield: 'qutval', width: '10%' ,cellsformat:'d2'    ,hidden:true},
							{ text: 'pqty', datafield: 'pqty', width: '9%',cellsformat:'d2'  ,hidden:true },
							{text: 'saveqty', datafield: 'saveqty', width: '10%' ,cellsformat:'d2'  ,hidden:true}, 
							{text: 'pid', datafield: 'proid', width: '10%' ,hidden:true}, 
							{text: 'pname', datafield: 'proname', width: '10%'  ,hidden:true}, 
							{text: 'checktype', datafield: 'checktype', width: '10%'  ,hidden:true},    
							{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true},
							
				 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 ]
	   
	    });
    $('.load-wrapp').hide();
    
   
   
});


</script>
<div id="orderlistdet"></div>