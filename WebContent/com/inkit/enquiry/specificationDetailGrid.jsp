<%@page import="com.inkit.enquiry.ClsEnquiryDAO"%>
 <%ClsEnquiryDAO DAO=new ClsEnquiryDAO(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String service = request.getParameter("service")==null?"0":request.getParameter("service");
 String discipline = request.getParameter("discipline")==null?"0":request.getParameter("discipline");
 String comodities = request.getParameter("comodities")==null?"0":request.getParameter("comodities");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
 
 	   var data= '<%=DAO.comodityDetailsSearch(docno,service,discipline,comodities,chk) %>';
   
        $(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'service', type: 'String'  },
     						{name : 'discipline', type: 'String'  },
     						{name : 'comodity', type: 'String'  },
     						{name : 'serid', type: 'int'  },
     						{name : 'tradeid', type: 'int'  }
                 ],
                 localdata: data,
                
                
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
            $("#jqxspecDetGrid").jqxGrid(
            {
                width: '100%',
                height: 336,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:true,
                
                columns: [
							{ text: 'Doc No',columntype: 'int',editable:false, filtertype: 'input', datafield: 'doc_no', width: '10%' },
							{ text: 'Service',columntype: 'String',editable:false, filtertype: 'input', datafield: 'service', width: '20%' },
							{ text: 'Discipline',columntype: 'String',editable:false, filtertype: 'input', datafield: 'discipline', width: '30%' },
							{ text: 'Commodities',columntype: 'String',editable:false, filtertype: 'input', datafield: 'comodity', width: '40%' },
							{ text: 'Tradeid',columntype: 'int',editable:false, filtertype: 'input',hidden: true, datafield: 'tradeid', width: '10%' },
							{ text: 'SerId',columntype: 'int',editable:false, filtertype: 'input',hidden: true, datafield: 'serid', width: '10%' }
	              		]
            });
            
            $("#jqxspecDetGrid").bind('cellendedit', function (event) {
                if (event.args.value) {
                    $("#jqxspecDetGrid").jqxGrid('selectrow', event.args.rowindex);
                }
                else {
                    $("#jqxspecDetGrid").jqxGrid('unselectrow', event.args.rowindex);
                }
            });

           /*  $('#jqxAccountsGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	document.getElementById("txtaccountname").value = $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "description");
		                document.getElementById("txtaccountid").value = $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		              $('#accountinfowindow').jqxWindow('close');
            		 }); */ 
           
            $('#jqxspecDetGrid').on('rowdoubleclick', function (event) 
            		{ 
            	
                    var rows = $("#jqxspecDetGrid").jqxGrid('selectedrowindexes');
                    var selectedRecords = new Array();
                    for (var m = 0; m < rows.length; m++) {
                        var row = $("#jqxspecDetGrid").jqxGrid('getrowdata', rows[m]);
                        //var rowlength=$("#jqxSpecification").jqxGrid('rows').records.length;
                        var countrows = $("#jqxJobDetails").jqxGrid('getrows');
                        rowlength = countrows.length;                    
                        if(rowlength==0) {
    	                    $('#jqxJobDetails').jqxGrid('setcellvalue',m,"comodityid",row.doc_no);
    	                    $('#jqxJobDetails').jqxGrid('setcellvalue',m,"services",row.service);
    	                    $('#jqxJobDetails').jqxGrid('setcellvalue',m,"discipline",row.discipline);
    	                    $('#jqxJobDetails').jqxGrid('setcellvalue',m,"commodity",row.comodity);
    	                    $('#jqxJobDetails').jqxGrid('setcellvalue',m,"tradeid",row.tradeid);
    	                    $('#jqxJobDetails').jqxGrid('setcellvalue',m,"serviceid",row.serid);
                        } else {
                        	var test=0;
                        	/* for (var n =0;n < rowlength; n++) {
                        		var rowspec = $("#jqxJobDetails").jqxGrid('getrowdata',n);
                        		
                        		if((row.doc_no==rowspec.doc_no)) {
                        				test=1;
                        				break;
                            	}
                        	} */
                        	if(test==0){
                            	var rowindex1 = rowlength - 1;
                          	    var comodityid=$("#jqxJobDetails").jqxGrid('getcellvalue', rowindex1, "comodityid");
                          	    if(typeof(comodityid) != "undefined" && comodityid!=null && comodityid!=""){
                                	$("#jqxJobDetails").jqxGrid('addrow', null, {});
                          	    }
                          	    var temprows=$("#jqxJobDetails").jqxGrid('getrows');
                          	    rowlength=(temprows.length)-1;
                          	    $('#jqxJobDetails').jqxGrid('setcellvalue',rowlength,"comodityid",row.doc_no);
                                $('#jqxJobDetails').jqxGrid('setcellvalue',rowlength,"services",row.service);
                                $('#jqxJobDetails').jqxGrid('setcellvalue',rowlength,"discipline",row.discipline);
                                $('#jqxJobDetails').jqxGrid('setcellvalue',rowlength,"commodity",row.comodity);
                                $('#jqxJobDetails').jqxGrid('setcellvalue',rowlength,"tradeid",row.tradeid);
                                $('#jqxJobDetails').jqxGrid('setcellvalue',rowlength,"serviceid",row.serid);
                        	}
                        	}
                        selectedRecords[selectedRecords.length] = row;
                    }
                    $('#specdetinfowindow').jqxWindow('close'); 
            	});
        });

</script>
<div id=jqxspecDetGrid></div>