  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.management.storemanagement.ClsStoremanagementDAO"%>
<% ClsStoremanagementDAO searchDAO = new ClsStoremanagementDAO(); %> 
 

<%String load=request.getParameter("load")==null?"NA":request.getParameter("load").trim();
String brhid = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();%> 
  <style type="text/css">
  .advanceClass
  {
      color: #FF0000;
  }
  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        
        }
</style>


<script type="text/javascript">

      var descdata1; 

        $(document).ready(function () { 
        
        
             var rendererstring1=function (aggregates){
             var value=aggregates['sum1'];
             return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
               }    
            
             var rendererstring=function (aggregates){
         	 var value=aggregates['sum'];
         	 return '<div style="margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
             }
             var temp4='<%=brhid%>';
             
            descdata1='<%=searchDAO.pendingGRN(load,brhid)%>';  

            var cellclassname =  function (row, column, value, data) {


           	  var ss= $('#pendinggrnGriddet').jqxGrid('getcellvalue', row, "qty");
           		          if(parseFloat(ss)<=0)
           		  		{
           		  		
           		  		return "yellowClass";
           		  	
           		  		}
           	    
           	   }


            var source =
            {
                datatype: "json",
                datafields: [  
                	 {name : 'brhid', type: 'string'    },    
                     
            		 {name : 'branchname', type: 'string'    },    
                   	{name : 'doc_no', type: 'number'    },
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
             			 {name : 'brandname', type: 'string'  },
             	
            		 
            		 
            		 
            		 
                    		
                 ],
              
                 localdata: descdata1,
                
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

            
            
            $("#pendinggrnGriddet").jqxGrid(
            {
            	 width: '99.5%',
                 height: 500,
                 source: dataAdapter,
                showaggregates:true,
                columnsresize: true,
                showstatusbar:true,
                statusbarheight: 21,
                selectionmode: 'checkbox',
                pagermode: 'default',
                showaggregates:true,
                showstatusbar:true,
                filterable:true,
                showfilterrow:true,

                  columns: [
                
				
      					
					 { text: 'SL#', sortable: false, filterable: false, editable: false,
                        groupable: false, draggable: false, resizable: false,
                        datafield: 'sl', columntype: 'number', width: '5%',cellclassname: cellclassname,
                        cellsrenderer: function (row, column, value) {
                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        }  
                      },
                  	{text: 'Doc No', datafield: 'doc_no', width: '6%'  }, 
                	{text: 'acno', datafield: 'acno', width: '10%'  ,hidden:true }, 
                	 { text: 'BranchId', datafield: 'brhid', width: '9%',cellclassname: cellclassname,hidden:true},  
					  { text: 'Branch', datafield: 'branchname', width: '9%',cellclassname: cellclassname},  
				   { text: 'Account', datafield: 'account',  width: '5%' ,cellclassname: cellclassname },
                     { text: 'Account Name', datafield: 'acname',  width: '20%' ,cellclassname: cellclassname },
       	       
                  	{ text: 'Product', datafield: 'productid',width: '15%',cellclassname: cellclassname}, 
						{ text: 'Product Name', datafield: 'productname', width: '20%'  ,cellclassname: cellclassname}, 
						{ text: 'Brand Name', datafield: 'brandname', width: '8%',cellclassname: cellclassname, editable:false },
						{ text: 'Unit', datafield: 'unit', width: '6%',cellclassname: cellclassname, editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
						
					
						{ text: 'Quantity', datafield: 'qty',  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'FOC', datafield: 'foc', width: '10%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2',hidden:true},
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
						
						
						{ text: 'mainqty', datafield: 'mainqty',  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2' ,hidden:true},
						
						
						{ text: 'maxfoc', datafield: 'maxfoc',  cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2' ,hidden:true},
						  
						{text: 'oldfoc', datafield: 'oldfoc', width: '10%' ,hidden:true },
          			 
				
	                			 
						
	              ],
            });
           
            $('.load-wrapp').hide();
            
        });
     
 </script>       
           
           
           
          
 <div id="pendinggrnGriddet"></div>
       