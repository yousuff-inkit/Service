 <%@page import="com.dashboard.procurment.trademarginreport.ClstrademarginreportDAO"%>
 <% ClstrademarginreportDAO searchDAO = new ClstrademarginreportDAO(); 
	String hidbrand = request.getParameter("hidbrand")==null?"0":request.getParameter("hidbrand").trim();
	String hidtype = request.getParameter("hidtype")==null?"0":request.getParameter("hidtype").trim();
	String hidproduct = request.getParameter("hidproduct")==null?"0":request.getParameter("hidproduct").trim();
	String hidcat = request.getParameter("hidcat")==null?"0":request.getParameter("hidcat").trim();
	String hidsubcat = request.getParameter("hidsubcat")==null?"0":request.getParameter("hidsubcat").trim();
	 
	String hidept = request.getParameter("hidept")==null?"0":request.getParameter("hidept").trim();
	
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	String acno = request.getParameter("acno")==null?"NA":request.getParameter("acno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
  	
	
  	String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();
	String invdocnomaster = request.getParameter("invdocnomaster")==null?"0":request.getParameter("invdocnomaster").trim();
	
	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
 	
	
	
	
	
 %> 
       
 
<script type="text/javascript">
 var temp4='<%=barchval%>';
 
 var temps='<%=type%>'; 
 
var datas;
var rendererstring2;
var len=0;
 if(temp4!='NA')
{ 

 
	 datas='<%=searchDAO.listsearch(barchval,fromdate,todate,statusselect,acno,psrno,invdocnomaster,hidbrand,hidtype,hidproduct,hidcat,hidsubcat,hidept,load,type)%>'; 
 
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
        datafields: [   // refname crsale chsale totalsale cost_price profit profit
                     
        	            {name : 'slno', type: 'number'    },
                        {name : 'name', type: 'string'  },
                        {name : 'productid', type: 'string'  },
                        {name : 'brandname', type: 'string'  },
                        
                    	{name : 'qty', type: 'number'  }, 
                    	{name : 'foc', type: 'number'  }, 
                    	{name : 'totalsales', type: 'number'  },
						{name : 'netsale', type: 'number'  },   
						{name : 'salesreturn', type: 'number'  },
						{name : 'netcost', type: 'number'  },
						{name : 'profit', type: 'number'  },
						{name : 'profitper', type: 'number'  },
						
						
 
						
			 
						
						],
				    localdata: datas,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
 
    $("#invlist").on("bindingcomplete", function (event) {
    	var rows = $('#invlist').jqxGrid('getrows');
  	    len = rows.length;
    });
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    rendererstringavg=function (aggregates){
 	   	var value=aggregates['avg'];
 	   	if(typeof(value)!='undefined' && typeof(value)!='NaN' && value!="" && value!=null){
 	   		return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 	   	}
 	   	else{
 	   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + 0.0 + '</div>';
 	   	}
 	   }
    
   
    
    $("#invlist").jqxGrid(
    {
        width: '98%',
        height: 550,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        
        showaggregates:true,
        showstatusbar:true,
        showfilterrow: true,
        selectionmode: 'singlerow', 
        statusbarheight: 21,
        enabletooltips:true,
        columnsresize: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  
        	        { text: 'Sr.No', datafield: 'slno', width: '3%' }, 
                    { text: 'Productid',datafield: 'productid', width: '13%'  },
         			 { text: 'Name',datafield: 'name'   },
         			 { text: 'Brand',datafield: 'brandname', width: '12%'  },
         			 
         			 { text: 'Qty',datafield: 'qty', width: '7%' ,cellsformat:'d2',cellsalign: 'right', align:'right'},
         		 
         			{ text: 'Foc',datafield: 'foc', width: '7%' ,cellsformat:'d2',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellsalign: 'right', align:'right'},
            		 
         		
                     
                     { text: 'Net Sale', datafield: 'netsale', width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
                    
                     
                     { text: 'Sale Return', datafield: 'salesreturn', width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},

                     { text: 'Total Sales', datafield: 'totalsales', width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
                     
		           	 { text: 'Cost of Sales', datafield: 'netcost',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
		            { text: 'Profit', datafield: 'profit',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							
		            { text: ' Profit %', datafield: 'profitper',  width: '5%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['avg'],aggregatesrenderer:rendererstringavg},
					
 
			    
		          
					
					]
   
    });
	 // alert($("#invlistinvlist").jqGrid('getGridParam', 'reccount'));

    
    if(temp4=='NA')
    { 
    	
		$("#invlist").jqxGrid('addrow', null, {});
    }
    
    if(temps=='PR' || temps=='0' || temps=='')
    { 
    	  $('#invlist').jqxGrid('showcolumn', 'productid');
    	  $('#invlist').jqxGrid('showcolumn', 'brandname');
	 
    }
    else
    	{
    	$('#invlist').jqxGrid('hidecolumn', 'productid');
  	  $('#invlist').jqxGrid('hidecolumn', 'brandname');
    	}
    
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="invlist"></div>