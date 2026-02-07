<%@page import="com.callibration.quotation.ClsQuotationDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsQuotationDAO DAO= new ClsQuotationDAO(); %>
 <%
 String nwdocnoss=request.getParameter("nwdocno")==null?"0":request.getParameter("nwdocno").trim();
 String master=request.getParameter("master")==null?"0":request.getParameter("master").trim().toString();
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 

 String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim().toString();
 String reviseno=request.getParameter("reviseno")==null?"0":request.getParameter("reviseno").trim().toString();
 String enqdoc=request.getParameter("enqdoc")==null?"0":request.getParameter("enqdoc").trim().toString();
 String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim().toString();
 String cond=request.getParameter("cond")==null?"0":request.getParameter("cond").trim().toString();
 String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim().toString();
 System.out.println("----master----"+master+"==reftype===="+reftype);
 %>
    <script type="text/javascript">
    var servdata;
    var gridload='<%=gridload%>';
    var docno='<%=master%>';
    var trno='<%=trno%>';
    var cond='<%=cond%>';
    if(cond=="1")
    {
    	  
    	servdata='<%=DAO.enqgridreload(session,enqdoc,reftype,dates)%>';  
     
    }
 
    if(docno>0){
		
    	servdata='<%=DAO.qotGridLoad(session,master) %>';
    	//alert("servdata====="+servdata);
  } 
   
    	  var rendererstring1=function (aggregates){
        	var value=aggregates['sum1'];
        	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
        }
    	  
    	  var cellclassname = function (row, column, value, data) {
        		/* if (data.qty==0) {
        			document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
                    return "redClass";
                }
        		else{
        			//document.getElementById("errormsg").innetText="";
        		} */
        		};
     
    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
    }
    
        $(document).ready(function () { 	
         var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'instdesc' , type: 'String' },
							{name : 'prdspecno' , type: 'String' },
							{name : 'prdpsrno' , type: 'String' },
							{name : 'make' , type: 'String' }, 
							{name : 'type' , type: 'String' }, 
                          	{name : 'model' , type: 'String' },
                          	{name : 'serial' , type: 'String' },
                        	{name : 'makeid' , type: 'String' }, 
                          	{name : 'modelid' , type: 'String' },
                          	{name : 'serialid' , type: 'String' },
                          	{name : 'rate' , type: 'String' },
                          	{name : 'qty', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						
     						
                          	],
                 localdata: servdata,
                
                
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
            $("#serviceGrid").jqxGrid(
            {
                width: '100%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:20,
             	 selectionmode: 'singlecell',
                 localization: {thousandsSeparator: ""},
                editable:true,
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Instrument Description', datafield: 'instdesc',editable:false },
					{ text: 'prdpsrno', datafield: 'prdpsrno',hidden:true },
					{ text: 'prdspecno', datafield: 'prdspecno',hidden:true },
					{ text: 'Make', datafield: 'make', width: '20%'},
					{ text: 'Model', datafield: 'model', width: '20%',editable:false },
					{ text: 'makeid', datafield: 'makeid',hidden:true },
					{ text: 'modelid', datafield: 'modelid',hidden:true },
                    { text: 'Type',  datafield: 'serial',width:'10%',columntype:'dropdownlist',
						
						createeditor: function (row, column, editor) {  
							
                           billmodelist1 = ["CALLIBRATION","REPAIR OR SERVICE","BOTH"];
                         
							editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist1 });
						
						},
				 	 initeditor: function (row, cellvalue, editor) {     
                          
						var terms = $('#serviceGrid').jqxGrid('getcellvalue', row, "status");
						
							editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist1 });
						
                        }, 
		    
		},
					{ text: 'Rate(AED)', datafield: 'rate', width: '10%'},
					{ text: 'Qty', datafield: 'qty', width: '5%' },
					{text: 'Total(AED)',datafield:'total',cellsformat: 'd2',editable:false, width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }
]
            });
            if($('#mode').val()=='view'){
       		 $("#serviceGrid").jqxGrid({ disabled: true});
       		
           }
            $('#serviceGrid').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = args.rowindex;
            	var datafield = event.args.datafield;
            	
            	$("#hidrowindex").val(rowBoundIndex);
 		    
 		    if(datafield=="instdesc")
	    	   {
	    	  prodSearchContent('instdesc.jsp');
	    	   }
 		    			
            		});
            
            $("#serviceGrid").on('cellvaluechanged', function (event) 
                    {
            	
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    
    		            	   
    		    if(datafield=="qty" || datafield=="rate" )
    		  {
    		    	
    		    	var qty= $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
               	    var amount= $('#serviceGrid').jqxGrid('getcellvalue', rowBoundIndex, "rate");
               		var total;
               		
               		if(qty==""||typeof(qty)=="undefined"|| qty=="NaN"){
               			qty=0;
               		}
               		
               		if(amount=="" || typeof(amount)=="undefined" || amount=="NaN"){
               			amount=0;
               		}		
               			
    		    		total=parseFloat(qty)*parseFloat(amount);
             			$('#serviceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
             			
    		    	 var summaryData3= $("#serviceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    	         //	document.getElementById("txtgrtotal").value=summaryData3.sum.replace(/,/g,''); 
    	         //	document.getElementById('txttotalamt').value=summaryData3.sum.replace(/,/g,''); 
    	         //	document.getElementById('txtnettotal').value=summaryData3.sum.replace(/,/g,''); 
    		  }
    		   
            	
                    });
            
            
            
            $("#popupWindow1").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu1").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#serviceGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu1").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#serviceGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#serviceGrid").offset();
                       $("#popupWindow1").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#serviceGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow1").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#serviceGrid").jqxGrid('getrowid', rowindex);
                       $("#serviceGrid").jqxGrid('deleterow', rowid);
                   }
               });
               
               $("#serviceGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#serviceGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               });
            
            
            $("#serviceGrid").jqxGrid('addrow', null, {});
      
        });
    </script>
    
    <div id='jqxWidget'>
   <div id="serviceGrid"></div>
    <div id="popupWindow1">

 <div id='Menu1'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
