<%@page import="com.dashboard.procurment.purchasemgmnt.ClsPurchasemgmntDAO"%>
<%
   ClsPurchasemgmntDAO DAO= new ClsPurchasemgmntDAO();        
 %>
 <%
 
    String chk = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    String salesmanid = request.getParameter("salesmanid")==null?"0":request.getParameter("salesmanid").trim();
 	String branchval = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
  	String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
    String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
    String areaid =request.getParameter("areaid")==null?"0":request.getParameter("areaid").toString();
    String divname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
 %> 
           	  
<style type="text/css">
     .colorClass2 {  
       background-color: #7ffaa6;   
     }
    .colorClass1 {
       background-color: #B0E2FF; 
    }
</style>

<script type="text/javascript">
 var temp4='<%=chk%>';
 var grrdata,enqfollowupexcel;        
 if(temp4=="1"){
	  grrdata='<%=DAO.enquirylistsearch(session, branchval, fromdate, todate, chk, divname) %>'; 
 }else{
	
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
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [     
        	{name : 'productid', type: 'string'    },
    		{name : 'productname', type: 'string'    },
    		{name : 'unit', type: 'String'    },
				{name : 'qty', type: 'number'    },
				/* {name : 'unitprice', type: 'number'    },  
				{name : 'total', type: 'number'    },
				{name : 'discount', type: 'number'    },
			
				{name : 'nettotal', type: 'number'    }, */
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
				    localdata: grrdata,
        
        
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
    
    $("#grrgrid").jqxGrid(
    {
        width: '99%',
        height: 400,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        enabletooltips: true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '2%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }    
                    },
                    { text: 'Product', datafield: 'productid',columntype: 'custom', width: '20%',
                    	  
                    	
						    createeditor: function (row, cellvalue, editor, cellText, width, height) {
						     
						         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
						   
						        
						    },  
						 
                   
						 
					}, 
					{ text: 'Product Name', datafield: 'productname', width: '40%'  ,columntype: 'custom',
						
							
							createeditor: function (row, cellvalue, editor, cellText, width, height) {
						       
						         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
						     
						        
						    },  
					
					}, 
					{ text: 'Brand Name', datafield: 'brandname', width: '15%', editable:false },
					{ text: 'Unit', datafield: 'unit', width: '6%', editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
					
				
					{ text: 'Quantity', datafield: 'qty',  cellsalign: 'left', align:'left',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					{ text: 'FOC', datafield: 'foc', width: '10%' ,cellsalign: 'left', align:'left',cellsformat:'d2',hidden:true},
					
					
					/* { text: 'Unit Price', datafield: 'unitprice', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2',cellclassname: cellclassname },
					{ text: 'Total', datafield: 'total', width: '10%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2' ,cellclassname: cellclassname},
    				{ text: 'Discount', datafield: 'discount', width: '10%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
					{ text: 'Net Amount', datafield: 'nettotal', width: '10%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
					 */
					 {text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true },
					{text: 'unitdocno', datafield: 'unitdocno', width: '10%' ,hidden:true  },
					{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },
					
					
					{ text: 'oldqty', datafield: 'oldqty', width: '9%',cellsformat:'d2'  ,hidden:true },
					
			  	    {text: 'qutval', datafield: 'qutval', width: '10%' ,cellsformat:'d2',hidden:true  },
					{ text: 'pqty', datafield: 'pqty', width: '9%',cellsformat:'d2' ,hidden:true   },
					{text: 'saveqty', datafield: 'saveqty', width: '10%' ,cellsformat:'d2'  ,hidden:true }, 
					{text: 'stockid', datafield: 'stockid', width: '10%' ,cellsformat:'d2' ,hidden:true }, 
					
					
					{text: 'pid', datafield: 'proid', width: '10%'  ,hidden:true  }, 
						{text: 'pname', datafield: 'proname', width: '10%' ,hidden:true  }, 
					
					 
					{text: 'checktype', datafield: 'checktype', width: '10%'  ,hidden:true},    
					{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true },
					
					
					{ text: 'mainqty', datafield: 'mainqty',  cellsalign: 'left', align:'left',cellsformat:'d2' ,hidden:true},
					
					
					{ text: 'maxfoc', datafield: 'maxfoc',  cellsalign: 'left', align:'left',cellsformat:'d2' ,hidden:true},
					  
					{text: 'oldfoc', datafield: 'oldfoc', width: '10%' ,hidden:true  },
        			 

					
        			 

					]
    });
    $('.load-wrapp').hide();
  /*    $('#enqlistgrid').on('rowdoubleclick', function(event) {  
        var rowindex1 = event.args.rowindex;

        var cldoc = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
        document.getElementById("qotrevno").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qotrevno");
        document.getElementById("txtsource").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "source");
        document.getElementById("sourceid").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "sourceid");
        $("#hidqotstatus").val($('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qotstatus"));
        if (parseInt(cldoc) == 0) {
            $('#btncreateclient').attr("disabled", false);
            document.getElementById("txtclientnw").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name");
            document.getElementById("txtaddressnw").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "address");
            document.getElementById("txtmobnw").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "per_mob");
            document.getElementById("txtemailnw").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "mail1");
            document.getElementById("salmanid").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "sal_id");
        } else {
            $('#btncreateclient').attr("disabled", true);
        }

        document.getElementById("enqdocno").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
        document.getElementById("reftrno").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
        document.getElementById("qottrno").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qottrno");
        document.getElementById("qotchkno").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qotno");
        document.getElementById("surveydocno").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "surdoc");
        document.getElementById("reportdocno").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
        document.getElementById("brhid1").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
        document.getElementById("client").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name");
        document.getElementById("cldocno").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
        document.getElementById("address").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "address");
        document.getElementById("pertel").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "pertel");
        document.getElementById("per_mob").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "per_mob");
        document.getElementById("mail1").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "mail1");
        document.getElementById("salname").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "salm");
        document.getElementById("salid").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "sal_id");
        document.getElementById("hidcontrno").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "contrno");
        document.getElementById("hidpayterms").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "payterms");
        document.getElementById("hidgroupcompanies").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "groupcompanies");
        document.getElementById("hidbillingmethod").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "billingmethod");
        document.getElementById("hidcperson").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cperson");
        document.getElementById("hidcpersonid").value = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cpersonid");

     var enqdocno = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
        var qottrno = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qottrno");
        $("#detailDiv").load("detailGrid.jsp?doc=" + qottrno + "&enqdocno=" + enqdocno);


        var contrno = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "condocno");
        if (contrno != "" && contrno != "0") {
            $('#btnconfirm').attr("disabled", false);
        }
        document.getElementById('lblselectedrowdetail').innerHTML = $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name") + ' - ' + $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
        $('.comments-container').html('');
    }); */ 
});
</script>
<div id="grrgrid"></div>