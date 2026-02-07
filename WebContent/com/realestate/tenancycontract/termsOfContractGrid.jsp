
  <%@page import="com.realestate.tenancycontract.ClsTenancyContractDAO" %>
<%ClsTenancyContractDAO DAO=new ClsTenancyContractDAO();
 
 String load = request.getParameter("load")==null?"0":request.getParameter("load"); 
  String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");%> 
 
 
  
<script type="text/javascript">
		 var data111;  
        $(document).ready(function () { 
           
            var load='<%=load%>';
            var docno='<%=docno%>';
            
            
            
             if(load>0){   
            	  data111='<%=DAO.termsloading()%>';  
           	 }
             else if(docno>0)
            	 {
            	 data111='<%=DAO.termsloading(docno)%>';  
            	 }
             var rendererstring=function (aggregates){
            	   	var value=aggregates['sum'];
            	   	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
            		   {
            			value=0.0;
            		   }
            		
            	   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
            	   }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'description', type: 'string'   },
     						{name : 'amount', type: 'number' },
     						{name : 'account', type: 'string'   },
     						{name : 'docno', type: 'string'   },
     						
     					 
     						
     						
                        ],
                         localdata: data111,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#termsOfContractGridId").jqxGrid(
            {
                width: '99.5%',
                height: 250,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                disabled:true,
                editable:true ,
              
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc', datafield: 'docno',  editable: false , width: '25%',hidden:true },	
							{ text: 'Description', datafield: 'description',  editable: false  },	
							{ text: 'Value', datafield: 'amount', cellsformat: 'd2', width: '25%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Account', datafield: 'account', editable: false, width: '20%',hidden:true },
							 
						]
            });
            
            if ($("#mode").val() == "A" || $("#mode").val() == "E") {
            	
          	  $("#termsOfContractGridId").jqxGrid({ disabled: false});
          	
          }
          
          
       
            
          
        });

</script>
<div id="termsOfContractGridId"></div>
    