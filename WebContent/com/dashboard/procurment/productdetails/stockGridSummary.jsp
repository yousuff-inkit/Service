
 
 <%@page import="com.dashboard.procurment.productdetails.ClsProductDetailsDAO"%>
 <% ClsProductDetailsDAO searchDAO = new ClsProductDetailsDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	 
  	String psrno = request.getParameter("psrno")==null?"NA":request.getParameter("psrno").trim();
  	
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
  	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
  	String locid = request.getParameter("locid")==null?"0":request.getParameter("locid").trim();
  	String hidbrand = request.getParameter("hidbrand")==null?"0":request.getParameter("hidbrand").trim();
	String hidtype = request.getParameter("hidtype")==null?"0":request.getParameter("hidtype").trim();
	String hidproduct = request.getParameter("hidproduct")==null?"0":request.getParameter("hidproduct").trim();
	String hidcat = request.getParameter("hidcat")==null?"0":request.getParameter("hidcat").trim();
	String hidsubcat = request.getParameter("hidsubcat")==null?"0":request.getParameter("hidsubcat").trim();
	String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
	String hidept = request.getParameter("hidept")==null?"0":request.getParameter("hidept").trim();
	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
	String cldocno = request.getParameter("hidcldocno")==null?"0":request.getParameter("hidcldocno").trim();
	String acno = request.getParameter("hidacno")==null?"0":request.getParameter("hidacno").trim();
   
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
 var temp4='<%=barchval%>';
 
var datas;

 if(temp4!='NA')
{ 
	
	 datas='<%=searchDAO.stocklist(barchval,statusselect,psrno,load,locid,hidbrand,hidtype,hidproduct,hidcat,hidsubcat,branchid,hidept,type,cldocno,acno)%>'; 
	 
	<%-- datass='<%=searchDAO.stockExcellistqty(barchval,statusselect,psrno,load,locid,hidbrand,hidtype,hidproduct,hidcat,hidsubcat,branchid,hidept,type,cldocno,acno)%>'; --%>
		// alert(enqdata); --%>
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
	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	   {
		value=0.0;
	   }
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
                     
 
        
					 
						{name : 'qty', type: 'number'  },
						{name : 'foc', type: 'number'  },
						{name : 'extfoc', type: 'number'  },
						{name : 'psrno', type: 'number'  },
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
					 
	 
						
						{name : 'amount', type: 'number'  },
						
						{name : 'brandname', type: 'String'  },
						{name : 'expry', type: 'String'  },
						{name : 'price', type: 'String'  },
						
						{name : 'department', type: 'String'  },
						
						{name : 'stkqty', type: 'number'  },
						{name : 'reorderlevel', type: 'number'  },
						{name : 'reorderqty', type: 'number'  },
						
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
    
    
   
   
    
    $("#stocklistgrid").jqxGrid(
    {
        width: '98%',
        height: 550,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        sortable:true,
        editable:true,
        
 
        
        selectionmode: 'checkbox',
        filterable:true,
        showfilterrow: true,
        pagermode: 'default',
     
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
          
                    { text: 'Psrno', datafield: 'psrno',editable:false,  width: '6%',hidden:true }, 
           	         { text: 'Product Id', datafield: 'productid',editable:false,  width: '6%' }, 
           	         { text: 'Product Name', datafield: 'productname',editable:false   },
           	   	   {text: 'Brand Name', datafield: 'brandname', width: '10%',editable:false },
           	   	  { text: 'Stock Qty', datafield: 'stkqty',  width: '5%',cellsformat:'d2',cellsalign:'right',align:'right',editable:false  },
           	      { text: ' Reorder Level', datafield: 'reorderlevel',  width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'},
				  { text: ' Reorder Qty', datafield: 'reorderqty',  width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'},
           	      { text: ' Qty', datafield: 'qty',  width: '5%' ,cellsformat:'d2',cellsalign:'right',align:'right', cellclassname: 'advanceClass5' },
				  { text: ' Foc', datafield: 'foc',  width: '5%' ,cellsformat:'d2',cellsalign:'right',align:'right', cellclassname: 'advanceClass5' , hidden:true },
           	   	  { text: ' Ext_Foc', datafield: 'extfoc',  width: '5%' ,cellsformat:'d2',cellsalign:'right',align:'right' , cellclassname: 'advanceClass5',hidden:true },
           	      {text: 'Expiry', datafield: 'expry', width: '7%',editable:false ,hidden:true},
           	      {text: 'Price', datafield: 'price', width: '7%',cellsalign:'right',align:'right', },
        			{text: 'Department', datafield: 'department',editable:false, width: '10%' ,},
 
		       
					
					]
    
    });
    $("#overlay, #PleaseWait").hide();
    
    
});


</script>
<div id="stocklistgrid"></div>