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
   		
    	servdata='<%=DAO.prodGridLoad(session) %>';
    	//alert("servdata====="+servdata);
  
   
    	 
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
                          	//{name : 'rate' , type: 'String' },
                          	{name : 'qty', type: 'number'  },
     						//{name : 'total', type: 'number'  },
     						
     						
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
            $("#prodGrid").jqxGrid(
            {
                width: '100%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
             	 selectionmode: 'singlerow',
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
					{ text: 'Make', datafield: 'make', width: '20%'},
					{ text: 'Model', datafield: 'model', width: '20%',editable:false },
					//{ text: 'Serial', datafield: 'serial', width: '10%'},
					//{ text: 'Rate(AED)', datafield: 'rate', width: '10%'},
					//{ text: 'Qty', datafield: 'qty', width: '5%' }
					//{text: 'Total(AED)',datafield:'total',cellsformat: 'd2',editable:false, width: '10%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }
]
            });
            
            $('#prodGrid').on('rowdoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	var product=$('#prodGrid').jqxGrid('getcellvalue', rowBoundIndex, "instdesc");
                 var prodspec=$('#prodGrid').jqxGrid('getcellvalue', rowBoundIndex, "prdspecno");
                var prodpsrno=$('#prodGrid').jqxGrid('getcellvalue', rowBoundIndex, "prdpsrno");
                var make=$('#prodGrid').jqxGrid('getcellvalue', rowBoundIndex, "make");
                var makeid=$('#prodGrid').jqxGrid('getcellvalue', rowBoundIndex, "makeid");
                 var model=$('#prodGrid').jqxGrid('getcellvalue', rowBoundIndex, "model");
                 var modelid=$('#prodGrid').jqxGrid('getcellvalue', rowBoundIndex, "modelid");
               //  var type=$('#prodGrid').jqxGrid('getcellvalue', rowBoundIndex, "serial");
                // var qty=$('#prodGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                 
                 
                 var rowindex1=$("#hidrowindex").val();
            	 $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "instdesc" ,product);
                 $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "prdspecno" ,prodspec);   
                 
                 $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "prdpsrno" ,prodpsrno);
                 
                 $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "make" ,make);
                 $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "makeid" ,makeid);       
                  
                 $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "model" ,model);
                 
                 $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "modelid" ,modelid);
                // $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "serial" ,type);
                 // $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,qty);
                // $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
                 //$('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
                // $('#serviceGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
 		    
                 $('#prodsearchwindow').jqxWindow('close'); 
            		});
            
           
           
            
            
          
      
        });
    </script>
    
   
   <div id="prodGrid"></div>
    

 
       </div>
       </div>
