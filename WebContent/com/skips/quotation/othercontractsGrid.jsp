<%@page import="com.skips.quotation.ClsQuotationDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 	ClsQuotationDAO DAO= new ClsQuotationDAO();
	String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno")==""?"0":request.getParameter("cldocno").trim().toString(); 
 %>   
 

 <script type="text/javascript">
 var othercntsdata;     
  othercntsdata='<%=DAO.otherContractsLoad(cldocno)%>';       
        $(document).ready(function () {  
        
             var num = 0; 
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
	                        	{name : 'date', type: 'date'  },
	                        	{name : 'startdt', type: 'date'  },
	                        	{name : 'enddt', type: 'date'  },
                          	],
                          	localdata: othercntsdata,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxotherContracts").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                enabletooltips:true,
                selectionmode: 'singlerow',
                editable:false,  
                columns: [
                	{ text: 'SL#', sortable: false, filterable: false, editable: false,
                        groupable: false, draggable: false, resizable: false,
                        datafield: 'sl', columntype: 'number', width: '4%',
                        cellsrenderer: function (row, column, value) {
                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        }  
                      },	
                        { text: 'Date', datafield: 'date', width: '7%' ,editable:false,cellsformat:'dd.MM.yyyy'},	
                        { text: 'Start Date', datafield: 'startdt', width: '7%' ,editable:false,cellsformat:'dd.MM.yyyy'},	
                        { text: 'End Date', datafield: 'enddt', width: '7%' ,editable:false,cellsformat:'dd.MM.yyyy'},     	
						{ text: 'Site', datafield: 'site', width: '10%'},  
						{ text: 'siteid',datafield:'siteid',width:'5%',editable:false,hidden:true},
						{ text: 'Waste Type', datafield: 'wastetype', width: '6%' ,editable:false},	
						{ text: 'Wastedoc',datafield:'wastedoc',width:'5%',editable:false,hidden:true},
						{ text: 'Skip Size', datafield: 'skiptype', width: '7%',editable:false },	
						{ text: 'Skipdoc',datafield:'skipdoc',width:'5%',editable:false,hidden:true},
						{ text: 'Spec', datafield: 'spec', width: '5%',editable:false },	
						{ text: 'Specid',datafield:'specid',width:'5%',editable:false,hidden:true},  
						{ text: 'Service By', datafield: 'serviceby', width: '6%',editable:false,hidden:true},
						{ text: 'Servicebyid',datafield:'servicebyid',width:'5%',editable:false,hidden:true},
						{ text: 'Ownership', datafield: 'ownership', width: '4%',editable:false},
						{ text: 'Ownershipid',datafield:'ownershipid',width:'5%',editable:false,hidden:true}, 
			            { text: 'Qty', datafield: 'nos', width: '2%'},
			            { text: 'Service Term', datafield: 'serviceterm', width: '6%',editable:false},  
						{ text: 'servicetermid',datafield:'servicetermid',width:'5%',editable:false,hidden:true},
						{ text: 'Nos', datafield: 'days', width: '2%' },   
						{ text: 'Trips in Month', datafield: 'tripsinmonth', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right',hidden:true },
						{ text: 'Rate per Colllection', datafield: 'rate', width: '3%',cellsformat:'d2',cellsalign:'right',align:'right' },	
						{ text: 'Rate per Colllection', datafield: 'tariffrate', width: '3%',cellsformat:'d2',cellsalign:'right',align:'right',hidden:true },	
						{ text: 'FOC / Restr. Trip', datafield: 'foc', width: '3%',hidden:true },
						{ text: 'Add.Rate', datafield: 'addrate', width: '3%',cellsformat:'d2',cellsalign:'right',align:'right' },
					    { text: 'Ctype', datafield: 'ctype', width: '4%',editable:false},    
						{ text: 'Ctypeid',datafield:'ctypeid',width:'4%',editable:false,hidden:true},  
						{ text: 'Skip Rent', datafield: 'rent', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' },
						{ text: 'Security', datafield: 'securityval', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' },
						{ text: 'T.Fee Method', datafield: 'tippingmethod', width: '7%',editable:false},    
						{ text: 'TippingMethodid',datafield:'tippingmethodid',width:'5%',editable:false,hidden:true},   
						{ text: 'T.Fee', datafield: 'tippingfee', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' },
						{ text: 'T.Fee Security', datafield: 'tippingsecurity', width: '6%',cellsformat:'d0',cellsalign:'right',align:'right' },
						{ text: 'Collection', datafield: 'collection', width: '6%',editable:false},  
						{ text: 'Collectionid',datafield:'collectionid',width:'5%',editable:false,hidden:true}, 
						{ text: 'Restricted', datafield: 'restricted', columntype: 'checkbox',width:'4%'},  
						{ text: 'rowno', datafield: 'rowno', width: '6%',editable:false,hidden:true},  
						{ text: 'Gate Fee', datafield: 'gatefee', width: '4%',cellsformat:'d2',cellsalign:'right',align:'right' },
 					]    
            });  
        });    
    </script>
    <div id="jqxotherContracts"></div>
    
    </body>
</html>