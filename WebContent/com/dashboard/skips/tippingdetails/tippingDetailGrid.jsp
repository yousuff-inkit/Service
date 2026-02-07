<%@page import="com.dashboard.skips.tippingdetails.ClsTippingDetailsDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsTippingDetailsDAO DAO= new ClsTippingDetailsDAO();   
 %>
 <%
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 int rad=request.getParameter("rad")==null || request.getParameter("rad")==""?0:Integer.parseInt(request.getParameter("rad").trim().toString());            
 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 %> 
 <style type="text/css">  
  .blueClass {
       background-color: #cafaee; 
    }
</style>
    <script type="text/javascript">
    var cdata;  
    var id='<%=id%>';
    var fromdate='<%=fromdate%>';
    var todate='<%=todate%>';
    $(document).ready(function () { 
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
 	
    	cdata='<%=DAO.tippingDetailData(session,id,fromdate,todate)%>';    
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
	                	{name : 'doc_no', type: 'String'  },
	                	{name : 'remarks', type: 'string'  },
		      		    {name : 'dno', type: 'string'  },
	      	       	    {name : 'ddate', type: 'date'  },
	            	 	{name : 'qty', type: 'number'  },
	                  	{name : 'rate' , type: 'number' },
					    {name : 'total', type: 'number'  },
	                  	{name : 'wastetype', type: 'string'  },
	                 	{name : 'skipsize', type: 'string'  },
	                	{name : 'invno', type: 'String'  },
	                    {name : 'tipdetsrno', type: 'number'  },
	                    {name : 'refno', type: 'String'  },
	                    {name : 'wasteid', type: 'String'  },
	                    {name : 'skipsizeid', type: 'String'  },
	                    {name : 'dodate', type: 'date'  },
	                    {name : 'contrno', type: 'String'  }, 
	                    {name : 'weight', type: 'number'  },
		            	{name : 'price', type: 'number'  },
		            	
		            	{name : 'billingmethod', type: 'string'  },
		            	{name : 'advinvmethod', type: 'string'  },
		            	{name : 'tippingfee', type: 'number'  },
                  ], 
                 localdata: cdata,
                
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
            var cellclassname =  function (row, column, value, data) {
                var valid= $('#jqxdetailgrid').jqxGrid('getcellvalue', row, "invno");
         	    if(parseInt(valid)>0) { 
         		    return "blueClass";    
         	    } 
             } 
            $("#jqxdetailgrid").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                sortable: true,
                editable:false,
                filterable: true, 
                enabletooltips:true,
                columnsresize: true,
                showfilterrow:true,
                showaggregates:true,
                showstatusbar:true,
             	statusbarheight:25,
                //Add row method
	          
                columns: [{ text: 'SL#', sortable: false, filterable: false, editable: false,
                    groupable: false, draggable: false, resizable: false,cellclassname:cellclassname,
                    datafield: '', columntype: 'number', width: '4%',
                    cellsrenderer: function (row, column, value) {
                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                    }
					},  
					{ text: 'Cont No', datafield: 'doc_no', width: '5%',editable:false,cellclassname:cellclassname },	
					{ text: 'Old Cont No', datafield: 'remarks',editable:false,cellclassname:cellclassname},
					{ text: 'Ref No', datafield: 'refno', width: '7%',editable:false,cellclassname:cellclassname},
					{ text: 'Billing Method', datafield: 'billingmethod', width: '6%',editable:false,cellclassname:cellclassname},
					{ text: 'Advance Invoice', datafield: 'advinvmethod', width: '4%',editable:false,cellclassname:cellclassname},
					{ text: 'DNO', datafield: 'dno', width: '7%',editable:false,cellclassname:cellclassname},
					{ text: 'DNO Date', datafield: 'ddate', width: '5%',editable:false, cellsformat:'dd.MM.yyyy',cellclassname:cellclassname },	
					{ text: 'Qty', datafield: 'qty', width: '3%',editable:false,cellsalign:'right',align:'right',cellclassname:cellclassname},
					{ text: 'Tipping Fee', datafield: 'tippingfee', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname},
					{ text: 'Rate', datafield: 'rate', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',cellclassname:cellclassname},
					{ text: 'Total',datafield:'total',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },  
					{ text: 'Weight', datafield: 'weight', width: '3%',editable:false,cellsalign:'right',align:'right',cellclassname:cellclassname},
					{ text: 'Price',datafield:'price',width:'7%',cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },  
					{ text: 'Waste Type', datafield: 'wastetype', width: '7%',editable:false,cellclassname:cellclassname },
					{ text: 'Skip Size', datafield: 'skipsize', width: '7%',editable:false,cellclassname:cellclassname },
					{ text: 'Inv No', datafield: 'invno', width: '7%',editable:false,cellclassname:cellclassname },  
					{ text: 'tipdetsrno', datafield: 'tipdetsrno', width: '10%',editable:false,hidden:true },  
					{ text: 'skipsizeid', datafield: 'skipsizeid', width: '10%',editable:false,hidden:true },
					{ text: 'wasteid', datafield: 'wasteid', width: '10%',editable:false,hidden:true }, 
					{ text: 'dodate', datafield: 'dodate', width: '10%',editable:false,hidden:true }, 
					{ text: 'contrno', datafield: 'contrno', width: '10%',editable:false,hidden:true }, 
					]
            });
       	    $("#overlay, #PleaseWait").hide();
            $("#jqxdetailgrid").jqxGrid('addrow', null, {});
            $('#jqxdetailgrid').on('rowdoubleclick', function (event) {               
             	  var rowindex1=event.args.rowindex;          
             	    
             	  $("#dodate").val(new Date($('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "dodate"))); 
             	  document.getElementById("wasteid").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "wasteid"); 
             	  document.getElementById("skipsizeid").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "skipsizeid");
             	  document.getElementById("txtqty").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "qty"); 
             	  document.getElementById("hidcontrno").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "contrno");
             	  document.getElementById("txttipdno").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "dno");
             	  //document.getElementById("txtdno").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "dno");
             	  document.getElementById("jqxwastetype").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "wastetype");
                  document.getElementById("jqxskipesize").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "skipsize"); 
                  document.getElementById("jqxcontractno").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                  
                  document.getElementById("txtweight").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "weight"); 
                  document.getElementById("txtprice").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "price"); 
             
             	  document.getElementById("hidinvno").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "invno");  
             	  document.getElementById("hidtipdetsrno").value=$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "tipdetsrno");
             	  document.getElementById("lblname").value="AMC - "+$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+", DNO - "+$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "dno");  
             	  $('.textpanel p').text($('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+' - '+$('#jqxdetailgrid').jqxGrid('getcellvalue', rowindex1, "remarks"));
             	  //$('.comments-container').html('');      
            });
        });
    </script>
    <div id="jqxdetailgrid"></div>  