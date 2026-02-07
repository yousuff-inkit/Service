<%@page import="com.dashboard.marketing.opaccounting.ClsOpAccountingDAO"%>   
<%
ClsOpAccountingDAO DAO=new ClsOpAccountingDAO();    
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
   
 <%
     String id=request.getParameter("id")==null?"":request.getParameter("id").toString();
     String divname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
     String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();  
 %>        
<script type="text/javascript">    
var data;
data='<%=DAO.presalesData(session,id,divname,brhid) %>';                               
$(document).ready(function(){           
    
    var source =
    {             
            datatype: "json",
            datafields: [ 
                        {name : 'docno',type:'string'},
                        {name : 'vocno' , type: 'string'},
 						{name : 'refname', type: 'string'},
 						{name : 'date', type:'date'},             
 						{name : 'sal_name', type: 'string'},
 						{name : 'brhid', type: 'String' },
 						{name : 'dtype', type: 'String' },
 						{name : 'cldocno', type: 'String' },
 						{name : 'branch', type: 'String' },
 						{name : 'site', type: 'String'},
 						{name : 'contractval', type: 'number' },  
 						
 						{name : 'terms', type: 'String'},
 						{name : 'duedate', type: 'date'},
 						{name : 'amount', type: 'number'},  
 						{name : 'payterms', type: 'String'},
 						{name : 'payservice', type: 'String'},
 						{name : 'paydesc', type: 'String'},
 						
 						{name : 'pdrowno', type: 'String'},
 						{name : 'reten', type: 'String'},
 						{name : 'invoiced', type: 'String'}, 
 						{name : 'ppivdocno', type: 'String'},
 						{name : 'certyper', type: 'number'},  
 						{name : 'certydesc', type: 'String'},
 						{name : 'pjivtrno', type: 'String'},
 						
 						{name : 'dueafser', type: 'String'},
 						{name : 'pstatus', type: 'String'},
 						{name : 'pinvno', type: 'String'},  
 						{name : 'invprog', type: 'String'}, 
 						{name : 'ccdocno', type: 'String'}, 
 						
 						{name : 'retbalamt', type: 'number'}, 
 						{name : 'retballegchrg', type: 'number'}, 
 						{name : 'retamount', type: 'number'}, 
 						{name : 'retlegalcharge', type: 'number'}, 
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



        $("#jqxopaccountGrid").jqxGrid(
                {
                	width: '100%',
                    height: 420,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    sortable: true,
                     columnsresize: true,
                    //Add row method
                    columns: [  
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
							    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							}   }, 
							{ text: 'DOCNO',datafield: 'docno', width: '6%',hidden:true},
							{ text: 'Doc No',datafield: 'vocno', width: '6%'},
							{ text: 'Date',datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy'},     
	    					{ text: 'Branch',datafield: 'branch', width: '12%'},   
							{ text: 'Client', datafield: 'refname', width: '18%'}, 
							{ text: 'brhid', datafield: 'brhid',width: '10%', hidden: true }, 
							{ text: 'dtype', datafield: 'dtype',width: '10%', hidden: true }, 
							{ text: 'cldocno', datafield: 'cldocno',width: '10%', hidden: true },
							{ text: 'Contract Value', datafield: 'contractval', width: '6%',cellsalign:'right',align:'right',cellsformat:'d2'},    
							{ text: 'Terms', datafield: 'terms', width: '9%'}, 
							{ text: 'Due Date', datafield: 'duedate', width: '5%',cellsformat:'dd.MM.yyyy'}, 
							{ text: 'Amount', datafield: 'amount', width: '6%',cellsalign:'right',align:'right',cellsformat:'d2'}, 
							{ text: 'Terms', datafield: 'payterms', width: '9%'}, 
							{ text: 'Service', datafield: 'payservice', width: '9%'}, 
							{ text: 'Description', datafield: 'paydesc', width: '14%'}, 
							{ text: 'Salesman', datafield: 'sal_name', width: '14%'}, 
							{ text: 'Site', datafield: 'site',width: '17%'},   
							{ text: 'pdrowno',datafield: 'pdrowno', width: '6%',hidden:true}, 
							{ text: 'reten',datafield: 'reten', width: '6%',hidden:true}, 
							{ text: 'invoiced',datafield: 'invoiced', width: '6%',hidden:true}, 
							{ text: 'ppivdocno',datafield: 'ppivdocno', width: '6%',hidden:true},
							{ text: 'certydesc',datafield: 'certydesc', width: '6%',hidden:true}, 
							{ text: 'certyper',datafield: 'certyper', width: '6%',hidden:true},
							{ text: 'pjivtrno',datafield: 'pjivtrno', width: '6%',hidden:true},  
							
							{ text: 'dueafser',datafield: 'dueafser', width: '6%',hidden:true},  
							{ text: 'pstatus',datafield: 'pstatus', width: '6%',hidden:true},  
							{ text: 'pinvno',datafield: 'pinvno', width: '6%',hidden:true},  
							{ text: 'invprog',datafield: 'invprog', width: '6%',hidden:true},  
							{ text: 'ccdocno',datafield: 'ccdocno', width: '6%',hidden:true},  
							
							{ text: 'retbalamt',datafield: 'retbalamt', width: '6%',hidden:true}, 
							{ text: 'retballegchrg',datafield: 'retballegchrg', width: '6%',hidden:true}, 
							{ text: 'retamount',datafield: 'retamount', width: '6%',hidden:true}, 
							{ text: 'retlegalcharge',datafield: 'retlegalcharge', width: '6%',hidden:true},   
					   ]                                                
                });  
                $("#overlay, #PleaseWait").hide();
                $('#jqxopaccountGrid').on('rowdoubleclick', function (event) {       
	                   var rowindex = event.args.rowindex;
	                   $('#btnproformacreate').attr('disabled', true);
	               	   $('#btnproformafollowup').attr('disabled', true);   
	               	   $('#btninvoiceprocessing').attr('disabled', true); 
	               	   $('#btnprogressiveinvoice').attr('disabled', true); 
	               	   $('#btnprojectinvoicereturn').attr('disabled', true);
	               	   $('#btnconfirm').attr('disabled', true);   
	                   document.getElementById("dtype").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "dtype");         
	                   document.getElementById("brhid").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "brhid"); 
	                   document.getElementById("jobvocno").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "vocno");   
	                   document.getElementById("jobdocno").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "docno"); 
	                   document.getElementById("pdrowno").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "pdrowno");  
	                   document.getElementById("cldocno").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "cldocno"); 
	                   document.getElementById("contractval").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "contractval");
	                   document.getElementById("reten").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "reten");
	                   document.getElementById("invoiced").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "invoiced");
	                   document.getElementById("ppivdocno").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "ppivdocno"); 
	                   document.getElementById("certydesc").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "certydesc");
	                   document.getElementById("certyper").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "certyper"); 
	                   document.getElementById("pjivtrno").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "pjivtrno"); 
	                   document.getElementById("invprog").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "invprog");   
	                   document.getElementById("ccdocno").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "ccdocno");
	                   document.getElementById("hidinvamount").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "amount");   
	                   document.getElementById("hidretbalamt").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "retbalamt");  
	                   document.getElementById("hidretballegchrg").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "retballegchrg");
	                   document.getElementById("hidretamount").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "retamount");  
	                   document.getElementById("hidretlegalcharge").value=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "retlegalcharge"); 
	                   
	                   var dueafser=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "dueafser"); 
	                   var pstatus=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "pstatus"); 
	                   var pinvno=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "pinvno");
	                   var invprog=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "invprog");
	                   var pjivtrno=$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "pjivtrno");
	                   
	                   if(pstatus=="1" && pinvno=="0" && dueafser=="98"){           
	       	    		   $('#btnproformacreate').attr('disabled', false);         
	       	    	   }else{  
	       	    		   $('#btnproformacreate').attr('disabled', true);              
	       	    	   }
	                   
	                   if(pstatus=="1" && pinvno!="0" && dueafser=="98"){              
	       	    		   $('#btnproformafollowup').attr('disabled', false);         
	       	    	   }else{  
	       	    		   $('#btnproformafollowup').attr('disabled', true);                
	       	    	   }
	                   
	                   if(invprog>0){                
	       	    		   $('#btnprogressiveinvoice').attr('disabled', false);         
	       	    	   }else{  
	       	    		   $('#btnprogressiveinvoice').attr('disabled', true);                  
	       	    	   }
	                   
	                   if(pjivtrno>0){                     
	       	    		   $('#btnprojectinvoicereturn').attr('disabled', false); 
	       	    		   $('#btnconfirm').attr('disabled', false);  
	       	    	   }else{  
	       	    		   $('#btnprojectinvoicereturn').attr('disabled', true); 
	       	    		   $('#btnconfirm').attr('disabled', true);    
	       	    	   }  
	                   invoicebtnenable();    
	                   $('.textpanel p').text('Doc No '+$('#jqxopaccountGrid').jqxGrid('getcellvalue',rowindex,'vocno')+' - '+$('#jqxopaccountGrid').jqxGrid('getcellvalue', rowindex, "refname"));
	                   $('.comments-container').html('');     
                });       
	});     
</script>
<div id="jqxopaccountGrid"></div>       