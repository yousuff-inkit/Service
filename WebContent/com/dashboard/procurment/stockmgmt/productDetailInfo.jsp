<%@page import="com.dashboard.procurment.stockmgmt.ClsStockMgmtDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.stockLedger.ClsStockLedger" %>
<%   
	String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
	String fromDate = request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").trim();
	String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	
	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
	
	System.out.println("====load======"+request.getParameter("load"));
	System.out.println("====load======"+load);
	ClsStockMgmtDAO dao= new ClsStockMgmtDAO();
%>
<style type="text/css">

 .op
  {
      background-color:#FCEFCE;
  }
  
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .greyClass
    {
        background-color: #e6e6e6;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
  .sl
  {
      background-color:#FCEFCE;
  }
  
 .prd
  {
      background-color:#ffe0cc;
  }
  
 .pr
  {
      background-color:#EBEBC1;
  }
  
    
   .advanceClass5
  {
      background-color: #FCC4F7;
  }
   .advanceClass4
  {
       background-color: #efd4f7;
  }
   .advanceClass3
  {
     
      background-color: #C4F3F5        ;
  }
   .advanceClass2
  {
      background-color:/*  #bed9f4; */ #CFECF1    ;  
  }
   .advanceClass1
  {
      background-color:   #eff4be;  ;
  }
    .balanceClass
  {
      background-color: #E0F8F1;
  }
    
</style>
<script type="text/javascript">
    
       var detinfodata;
       var load='<%=load %>';
 
	  	if(load=='yes'){ 
	  	<%-- 	 dat2='<%=dao.stockLedgerDetail2(session,hidbrand,fromDate,toDate,hidtype,hidcat,hidsubcat,hidproduct,branchid,hidept,load)%>'; --%>  
	  	detinfodata='<%= dao.stockDetailInfo(session, fromDate, toDate, branchid, load) %>'
	  	} 
		else{
			detinfodata;
	}
console.log('data : '+detinfodata)
$(document).ready(function () {
	 
	  var rendererstring1=function (aggregates){
       	var value=aggregates['sum1'];
       	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
       }    
    
 var rendererstring=function (aggregates){
 	var value=aggregates['sum'];
	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	   {
		value=0.0;
	   }
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
     var rendererstring2=function (aggregates){
	 	var value=aggregates['sum'];
		if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
		   {
			value=0.0;
		   }
	 	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	 }
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     
                  
                     
                        /* {name : 'pno', type: 'String'  },
                        {name : 'pname', type: 'String'  },
                        {name : 'date', type: 'String'  },
                        {name : 'docno', type: 'String'  },
                        {name : 'trans_type', type: 'String'  },
                        {name : 'opnqty', type: 'number'  },
                        {name : 'opnval', type: 'number'  },
						{name : 'inqty', type: 'number'  },
						{name : 'inval', type: 'number'  },
						{name : 'isqty', type: 'number'  },
						{name : 'isval', type: 'number'  },
						{name : 'balqty', type: 'number'  },
						{name : 'balval', type: 'number'  },
						{name : 'stv', type: 'number'  },
						{name : 'cpu', type: 'number'  },
						{name : 'cpu', type: 'number'  },
						{name : 'sl', type: 'String'},
						{name : 'specid', type: 'String'},
						{name : 'trtype', type: 'String'},
						{name : 'desc1', type: 'String'},
						{name : 'branchname', type: 'String'},
						{name : 'loc_name', type: 'String'}, */
						{name : 'description', type: 'String'},
						{name : 'dtype', type: 'String'},
						{name : 'inqty', type: 'number'},
						{name : 'inval', type: 'number'},
						{name : 'account', type: 'number'},
						{name : 'difference', type: 'number'},
						//{name : 'diff', type: 'String'},
						
						],
				    localdata: detinfodata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    /* var cellclassname = function (row, column, value, data) {
    	
		 if (data.trtype=='in') {
            return "advanceClass4";
        }
		 else if(data.trtype=='OP')
			 {
			 return "op";
			 }
		 else
			 {
			 return "balanceClass";
			 }
		 
		 
		 ;
    }; */

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#jqxStockInfoDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 350,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        showaggregates:true,
        showstatusbar:true,
        
        statusbarheight: 21,
        pagermode: 'default',
        editable:false,
        columns: [   
                   { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false, pinned: true,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    } ,
                     
                     { text: 'Description', datafield: 'description',hidden:false }, 
                     { text: 'Dtype', datafield: 'dtype',hidden:false,width: '10%',aggregates:['sum1'],aggregatesrenderer:rendererstring1 }, 
                     { text: 'Inventory Details', datafield: 'inqty',  width: '15%',hidden:true,cellsalign: 'right', cellsformat: 'd2' }, 
                     { text: 'Inventory Value', datafield: 'inval',  width: '20%',hidden:false,cellsalign: 'right', cellsformat: 'd2',aggregates:['sum'],aggregatesrenderer:rendererstring }, 
                     { text: 'Accounts Details', datafield: 'account',  width: '20%',hidden:false,cellsalign: 'right', cellsformat: 'd2',aggregates:['sum'],aggregatesrenderer:rendererstring }, 
                     { text: 'Difference', datafield: 'difference',  width: '20%',hidden:false,cellsalign: 'right', cellsformat: 'd2',aggregates:['sum'],aggregatesrenderer:rendererstring } 
                     //{ text: 'Difference', datafield: 'diff',  width: '10%',hidden:false } 
           	   ]
    });

    $("#overlay, #PleaseWait").hide();
    $('.load-wrapp').hide();
});


</script>
<div id="jqxStockInfoDetailGrid"></div>