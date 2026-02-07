
 
 <%@page import="com.dashboard.sales.consolidatedsales.ClsConsolidatedSalesDAO" %>

<%ClsConsolidatedSalesDAO DAO= new ClsConsolidatedSalesDAO();
    String check=request.getParameter("check")==null?"0":request.getParameter("check");
    String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
   	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
   	String groupby = request.getParameter("groupby")==null?"0":request.getParameter("groupby").trim();
   	String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
   	String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
   	String salesman = request.getParameter("salesman")==null?"0":request.getParameter("salesman").trim();

 %> 
       
 
<script type="text/javascript">
var check='<%=check%>';

	 
$(document).ready(function () {

    // prepare the data
	var datas;


			   datas='<%=DAO.groupbygrid(fromdate,todate,groupby,check,cldocno,category,salesman)%>'; 
			   
			   var rendererstring=function (aggregates){
				   	var value=aggregates['sum'];
				   	if(typeof(value) == "undefined"){
		    			value=0.00;
		    		}
				   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
			 }  
		 
    var source =
    {
        datatype: "json",
        datafields: [   
                     

        	            {name : 'slno', type: 'number'    },
                        {name : 'refno', type: 'number'  },
						{name : 'refname', type: 'string'  },
					    {name : 'netamount', type: 'number'  },
					    {name : 'retamount', type: 'number'  },
					    {name : 'salesinv', type: 'number'  },
					    {name : 'workshopinv', type: 'number'  },
						
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
    
    
   
   
    
    $("#groupbyGrid").jqxGrid(
    {
    	width: '98%',
        height: 515,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow:true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  	
        	      { text: 'Sr.No', datafield: 'slno', width: '4%' }, 
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                  { text: 'Ref No',datafield: 'refno', width: '15%' },
         		  { text: 'Ref.Name', datafield: 'refname', width: '25%'},
         		  { text: 'Sales Invoice', datafield: 'workshopinv', width: '14%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
         		  { text: 'Workshop Sales ', datafield: 'salesinv', width: '14%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
         		 { text: 'Retrun Amount',datafield: 'retamount', width: '14%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
 				{ text: 'Total Amount',datafield: 'netamount', width: '14%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    //fungroup();
    });  
   



</script>
<div id="groupbyGrid"></div>