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



        $("#jqxEnquiryGrid").jqxGrid(
                {
                	width: '100%',
                    height: 450,
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
							{ text: 'Date',datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},     
	    					{ text: 'Branch',datafield: 'branch', width: '12%'},   
							{ text: 'Client', datafield: 'refname', width: '18%'}, 
							{ text: 'Salesman', datafield: 'sal_name', width: '14%'}, 
							{ text: 'brhid', datafield: 'brhid',width: '10%', hidden: true },  
							{ text: 'cldocno', datafield: 'cldocno',width: '10%', hidden: true },
							{ text: 'Site', datafield: 'site',width: '17%'},  
							{ text: 'Contract Value', datafield: 'contractval', width: '6%',cellsalign:'right',align:'right'}, 
							
							{ text: 'Terms', datafield: 'terms', width: '9%'}, 
							{ text: 'Due Date', datafield: 'duedate', width: '6%',cellsformat:'dd.MM.yyyy'}, 
							{ text: 'Amount', datafield: 'amount', width: '6%',cellsalign:'right',align:'right'}, 
							{ text: 'Terms', datafield: 'payterms', width: '14%'}, 
							{ text: 'Service', datafield: 'payservice', width: '14%'}, 
							{ text: 'Description', datafield: 'paydesc', width: '14%'},     
					   ]                                                
                });  
                $("#overlay, #PleaseWait").hide();
                $('#jqxEnquiryGrid').on('rowdoubleclick', function (event) {       
	                   var rowindex = event.args.rowindex;
	                   document.getElementById("brhid").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "brhid"); 
	                   document.getElementById("jobvocno").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "vocno");   
	                   document.getElementById("jobdocno").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "docno");
	                   
	                   $('.textpanel p').text('Doc No '+$('#jqxEnquiryGrid').jqxGrid('getcellvalue',rowindex,'vocno')+' - '+$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "refname"));
	                   $('.comments-container').html('');     
                });       
	});     
</script>
<div id="jqxEnquiryGrid"></div>  