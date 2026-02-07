<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.search.ClsContractSearch"%>  
<%
    ClsContractSearch DAO= new ClsContractSearch();   
     
    String clname = request.getParameter("clname")==null?"":request.getParameter("clname");
    String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
    int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
    String type = request.getParameter("type")==null || request.getParameter("type")==""?"0":request.getParameter("type"); 
    
    String refno = request.getParameter("refno")==null?"":request.getParameter("refno");
    String qty = request.getParameter("qty")==null?"":request.getParameter("qty");
    String site = request.getParameter("site")==null?"":request.getParameter("site");
    String area = request.getParameter("area")==null?"":request.getParameter("area");
    String skipsize = request.getParameter("skipsize")==null?"":request.getParameter("skipsize");     
  %> 

 <script type="text/javascript"> 
 var type = '<%=type%>';
 var cntdata;
 cntdata='<%=DAO.contractSearch(session, clname, docno, refno, qty, site, area, skipsize, id)%>';               
 
        $(document).ready(function () { 
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
		                	 {name : 'doc_no', type: 'String'  },
							 {name : 'refname', type: 'String'  },
							 {name : 'site', type: 'String'  },
							 {name : 'tr_no', type: 'String'  },
							 {name : 'srno', type: 'String'  },
							 {name : 'wastetype', type: 'String'  }, 
							 {name : 'refno', type: 'String'  }, 
							 {name : 'oldcntno', type: 'String'  }, 
							 {name : 'brhid', type: 'String'  },  
							 {name : 'area', type: 'String'  },  
							 {name : 'skipsize', type: 'String'  },  
							 {name : 'qty', type: 'String'  },  
                          	], 
                          	localdata: cntdata,
                          //	 url: url1,
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxContractSearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
		                	{ text: 'Doc No', datafield: 'doc_no', width: '10%'},  
		                	{ text: 'Ref No', datafield: 'refno', width: '10%'},    
		                	{ text: 'Old Cnt. No', datafield: 'oldcntno', width: '10%'},    
							{ text: 'Client', datafield: 'refname' },
							{ text: 'Site', datafield: 'site', width: '20%'},
							{ text: 'Area', datafield: 'area', width: '12%'},
							{ text: 'Waste Type', datafield: 'wastetype', width: '12%'},
							{ text: 'Skip size', datafield: 'skipsize', width: '12%'},
							{ text: 'Qty', datafield: 'qty', width: '7%'},       
							{ text: 'tr_no', datafield: 'tr_no', width: '10%',hidden:true},  
							{ text: 'srno', datafield: 'srno', width: '10%',hidden:true}, 
							{ text: 'brhid', datafield: 'brhid', width: '10%',hidden:true},    
					]
            });  
			 $('#jqxContractSearch').on('rowdoubleclick', function (event) {     
				               var rowindex1=event.args.rowindex;
				               if(parseInt(type)==1){
				            	   document.getElementById("hidcntsrno").value= $('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "srno");
					               document.getElementById("hidcnttrno").value= $('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");  
					               document.getElementById("txtcontract").value=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
					               document.getElementById("lblotherdetails4").innerHTML=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no")+" - "+$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "refname")+", Site - "+$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "site")+", Waste Type - "+$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "wastetype")+", Skip size - "+$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "skipsize");      
					               getDeliveries(); 
				               }else  if(parseInt(type)==2){         
				            	   document.getElementById("hidpocntbrhid").value= $('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "brhid");
				            	   document.getElementById("hidpocntsrno").value= $('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "srno");
					               document.getElementById("hidpocnttrno").value= $('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");  
					               document.getElementById("pocontract").value=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
					               document.getElementById("lblotherdetails5").innerHTML=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no")+", Waste Type - "+$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "wastetype");     
					               getDeliveriesPO();
				               }else  if(parseInt(type)==3){
				            	   document.getElementById("hidrpcntbrhid").value= $('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "brhid");
				            	   document.getElementById("hidrpcntsrno").value= $('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "srno");
					               document.getElementById("hidrpcnttrno").value= $('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");  
					               document.getElementById("rpcontract").value=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
					               document.getElementById("lblotherdetails6").innerHTML=$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "doc_no")+", Waste Type - "+$('#jqxContractSearch').jqxGrid('getcellvalue', rowindex1, "wastetype");     
					               getDeliveriesRP();    
				               }     
				            	   
				               $('#contractWindow').jqxWindow('close');                
		  }); 	 
      }); 
    </script>
    <div id="jqxContractSearch"></div>       