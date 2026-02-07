<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractreview.ClsContractReviewDAO" %>
<% ClsContractReviewDAO DAO= new ClsContractReviewDAO(); 
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 

 <style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.yellowClass {
	background-color: #FFFF00;
}

.orangeClass {
	background-color: #FFEBC2;
}
</style>  

<script type="text/javascript">

$(document).ready(function () {   	
             var num = 1; 
             var griddata='<%=DAO.contractrevisionGrid(session,docno)%>';
             
            // prepare the data
             var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	if(typeof(value) == "undefined"){
                		value=0.00;
                	}
                	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
                }
         	
           var rendererstring1=function (aggregates){
                 var value1=aggregates['sum1'];
                 return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
                }
            var source =
            {
                datatype: "json",
                datafields: [
		                	{name : 'site', type: 'String'  },
		                  	{name : 'area', type: 'String'  },
							{name : 'skiptype', type: 'string'  },
	                  		{name : 'skipdoc', type: 'String'  },
							{name : 'nos', type: 'int'   },
							{name : 'wastetype', type: 'string'   },
	                  		{name : 'wastedoc', type: 'String'  },
							{name : 'serviceby', type: 'String'  },
							{name : 'servicebyid', type: 'String'  },
							{name : 'ownership', type: 'String'  },
							{name : 'ownershipid', type: 'String'  },
		                  	{name : 'serviceterm', type: 'String'  },
		                	{name : 'servicetermid', type: 'String'  },
		                	{name : 'collection', type: 'String'  },
                        	{name : 'collectionid', type: 'String'  },
		                  	{name : 'days', type: 'String'  },
		                	{name : 'spec', type: 'string'  },
		                  	{name : 'specid', type: 'String'  },
		                  	{name : 'tippingfee', type: 'number'  },
		                  	{name : 'rate', type: 'number'  },
		                  	{name : 'tariffrate', type: 'number'  }, 
		                  	{name : 'rent', type: 'number'  },
		                  	{name : 'foc', type: 'number'  },
	                        {name : 'siteid', type: 'String'  }, 
	                    	{name : 'securityval', type: 'number'  }, 
	                    	{name : 'tippingmethod', type: 'String'  },
                        	{name : 'tippingmethodid', type: 'String'  }, 
                        	{name : 'restricted', type: 'bool'  },  
                        	{name : 'tippingsecurity', type: 'number'  },  
                        	{name : 'rowno', type: 'number'  }, 
                        	{name : 'tripsinmonth', type: 'number'  },   
                        	{name : 'gatefee', type: 'number'  },
                        	{name : 'ctype', type: 'String'  },
                        	{name : 'ctypeid', type: 'String'  }, 
                        	{name : 'addrate', type: 'number'  },
                        	{name : 'revision_no', type: 'string'  },
     											
                 ],
                 localdata: griddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
         		 if (data.ctype=="TRIP BASIS") {  
                     return "orangeClass";
                 };
              };
              
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );
            
            $("#contractrevisiongrid").jqxGrid(
            {
                width: '99.8%',
                height: 250,
                source: dataAdapter,
                altRows: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                editable:false ,
            	/* showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25, */  
       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
							{ text: 'Revision No', datafield: 'revision_no', width: '5%' },	
                        	{ text: 'Site', datafield: 'site' },   
                        	{ text: 'siteid',datafield:'siteid',width:'5%',hidden:true},
							{ text: 'Waste Type', datafield: 'wastetype', width: '8%' },	
							{ text: 'Wastedoc',datafield:'wastedoc',width:'5%',hidden:true},
							{ text: 'Skip Size', datafield: 'skiptype', width: '7%' },	
							{ text: 'Skipdoc',datafield:'skipdoc',width:'5%',hidden:true},
							{ text: 'Spec', datafield: 'spec', width: '5%' },	
							{ text: 'Specid',datafield:'specid',width:'5%',hidden:true},  
							{ text: 'Service By', datafield: 'serviceby', width: '6%',hidden:true},
							{ text: 'Servicebyid',datafield:'servicebyid',width:'5%',hidden:true},
							{ text: 'Ownership', datafield: 'ownership', width: '4%'},
							{ text: 'Ownershipid',datafield:'ownershipid',width:'5%',hidden:true}, 
				            { text: 'Qty', datafield: 'nos', width: '2%'},
				            { text: 'Service Term', datafield: 'serviceterm', width: '6%'},  
							{ text: 'servicetermid',datafield:'servicetermid',width:'5%',hidden:true}, 
							{ text: 'Nos', datafield: 'days', width: '2%' },   
							{ text: 'Trips in Month', datafield: 'tripsinmonth', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },
							{ text: 'Rate per Colllection', datafield: 'rate', width: '3%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },	
							{ text: 'Rate per Colllection', datafield: 'tariffrate', width: '3%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },	
						    { text: 'Add.Rate', datafield: 'addrate', width: '3%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						    { text: 'Ctype', datafield: 'ctype', width: '4%'},    
							{ text: 'Ctypeid',datafield:'ctypeid',width:'4%',hidden:true},   
							{ text: 'Skip Rent', datafield: 'rent', width: '5%',cellsformat:'d0',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
							{ text: 'Security', datafield: 'securityval', width: '5%',cellsformat:'d0',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'T.Fee Method', datafield: 'tippingmethod', width: '6%'},    
							{ text: 'TippingMethodid',datafield:'tippingmethodid',width:'5%',hidden:true},   
							{ text: 'T.Fee', datafield: 'tippingfee', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'T.Fee Security', datafield: 'tippingsecurity', width: '6%',cellsformat:'d0',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Collection', datafield: 'collection', width: '5%'},  
							{ text: 'Collectionid',datafield:'collectionid',width:'5%',hidden:true},   
							{ text: 'Restricted', datafield: 'restricted', columntype: 'checkbox',width:'4%'},  
							{ text: 'rowno', datafield: 'rowno', width: '6%',hidden:true},  
							{ text: 'Gate Fee', datafield: 'gatefee', width: '4%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							]  
            });

        });
     
    </script>
    <div id="contractrevisiongrid"></div> 