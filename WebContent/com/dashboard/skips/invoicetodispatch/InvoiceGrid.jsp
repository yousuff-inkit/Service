<%@page import="com.dashboard.skips.invoicetodispatch.ClsInvoiceDispatchDAO" %>  
<%ClsInvoiceDispatchDAO cid=new ClsInvoiceDispatchDAO(); %>
<% 
 String branchval = request.getParameter("branchval")==null?"":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"":request.getParameter("cldocno").trim();
 String contrno = request.getParameter("contrno")==null?"":request.getParameter("contrno").trim();
 String contractchk = request.getParameter("contractchk")==null?"":request.getParameter("contractchk").trim();    
  %>
<style type="text/css">
  .redClass {
       background-color: #FE9892; 
    }
    .blueClass {
       background-color: #FADBD8; 
    }
     .pinkClass {
       background-color: #FBC4EC; 
    }
</style>
<script type="text/javascript">
 var temp4='<%=branchval%>';
//alert(temp4);
var invoicedata;
if(temp4!='')
{ 
  invoicedata='<%= cid.invoicelist(branchval,fromDate,toDate,cldocno,contrno,contractchk)%>';     
}
else
{
	invoicedata;
} 
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Total" + '</div>';
     }

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                      	{name : 'doc_no' , type: 'int' },
                      	{name : 'voc_no',type:'int'},
                  		{name : 'rano' , type: 'int' },
                  		{name : 'contrno',type: 'int'},
						{name : 'dtype', type: 'string'    },
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'acno', type: 'String'  },
						{name : 'acname', type: 'string'  },
						{name : 'netamount', type: 'number'  },
						{name : 'cldocno',type:'String'},
						{name : 'btndispatch', type: 'string'  },
						{name : 'btnprint',type:'String'},
						{name : 'branch',type:'String'},
						{name : 'mail1',type:'String'},
						{name : 'brhid',type:'String'},
						{name : 'email',type:'String'},
						{name : 'mailsend',type:'number'}  
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#rentalInvoiceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	//$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
    	});
 /*    var cellclassname = function (row, column, value, data) {
        if(typeof(data.amount)=="undefined" || data.amount=="" ){
        	return "greyClass"; 
        }
        else{
        	//alert(data.amount);
        	return "greenClass";
        };
          }; */
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
  var cellclassname =  function (row, column, value, data) {
       	   if(parseInt(data.mailsend)>0) {    
       		    return "blueClass";  
       	   } 
        }   
    $("#rentalInvoiceGrid").jqxGrid(
    {
        width: '100%',
        height: 505,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
      	sortable:true,
        columns: [  
                  
						{ text: 'SL#', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false ,cellclassname: cellclassname ,
						    datafield: 'sl', columntype: 'number', width: '5%',
						    cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
						},
                        { text: 'Original Doc No', datafield: 'doc_no', width: '7.5%',hidden:true  ,cellclassname: cellclassname  },   
                        { text: 'Doc No', datafield: 'voc_no', width: '7.5%' ,cellclassname: cellclassname },
                        { text: 'Branch',datafield:'branch',width:'15%' ,cellclassname: cellclassname },
						{ text: 'Contract No', datafield: 'contrno', width: '7%'  ,cellclassname: cellclassname  },  
						{ text: 'From Date', datafield: 'fromdate', width: '7%',cellsformat:'dd.MM.yyyy'  ,cellclassname: cellclassname  },
						{ text: 'To Date', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy'  ,cellclassname: cellclassname  },
						{ text: 'Account', datafield: 'acno', width: '5%'  ,cellclassname: cellclassname   },
						{ text: 'Account Name', datafield: 'acname',aggregates: ['sum1'],aggregatesrenderer:rendererstring1  ,cellclassname: cellclassname },
					    { text: 'Email',datafield:'email',width:'15%' ,cellclassname: cellclassname },
						{ text: 'Amount', datafield: 'netamount', width: '9.5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname  },
						{ text: 'Cldocno', datafield: 'cldocno', width: '12%',cellsformat:'d2',hidden:true},	
                        { text: 'email', datafield: 'mail1', width: '12%',cellsformat:'d2',hidden:true},
						{ text: 'branch id', datafield: 'brhid', width: '12%',cellsformat:'d2',hidden:true},
						{ text: 'mailsend', datafield: 'mailsend', width: '12%',cellsformat:'d2',hidden:true},   
					]
    });
	$("#overlay, #PleaseWait").hide();
    $('#rentalInvoiceGrid').on('rowdoubleclick', function (event) {   
	   	  var rowindex1=event.args.rowindex;    
	   	  document.getElementById("hidvocno").value=$('#rentalInvoiceGrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
	   	  document.getElementById("hiddocno").value=$('#rentalInvoiceGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	   	  document.getElementById("hidbrhid").value=$('#rentalInvoiceGrid').jqxGrid('getcellvalue', rowindex1, "brhid"); 
	   	  document.getElementById("selectedlbl").innerHTML=$('#rentalInvoiceGrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+" - "+$('#rentalInvoiceGrid').jqxGrid('getcellvalue', rowindex1, "acname");
	   	
     });
    
});

	
</script>
<div id="rentalInvoiceGrid"></div>