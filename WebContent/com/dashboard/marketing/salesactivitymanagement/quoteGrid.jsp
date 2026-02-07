<%@page import="com.dashboard.marketing.salesactivitymanagement.ClsSalesActivityManagementDAO"%>   
<%
ClsSalesActivityManagementDAO DAO=new ClsSalesActivityManagementDAO();  
%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
   
 <%
     String id=request.getParameter("id")==null?"":request.getParameter("id").toString();
     String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();  
 %>        
<script type="text/javascript">    
var qotdata;
qotdata='<%=DAO.quoteData(session,id,brhid) %>';                               
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
             ],                  
             localdata: qotdata,    
              
            
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



        $("#jqxQuoteGrid").jqxGrid(
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
                     enabletooltips:true,
                    //Add row method
                    columns: [  
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   }, 
						{ text: 'DOCNO',datafield: 'docno', width: '6%',hidden:true},
						{ text: 'Doc No',datafield: 'vocno', width: '6%'},
						{ text: 'Date',datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},   
						{ text: 'Branch', datafield: 'branch', width: '14%'}, 
						{ text: 'Client', datafield: 'refname'}, 
						{ text: 'Salesman', datafield: 'sal_name', width: '14%'}, 
						{ text: 'brhid', datafield: 'brhid',width: '10%', hidden: true },  
						{ text: 'cldocno', datafield: 'cldocno',width: '10%', hidden: true },  
					   ]                                              
                });  
                $("#overlay, #PleaseWait").hide();
                $('#jqxQuoteGrid').on('rowdoubleclick', function (event) {       
	                   var rowindex = event.args.rowindex;
	                   document.getElementById("brhid").value=$('#jqxQuoteGrid').jqxGrid('getcellvalue', rowindex, "brhid"); 
	                   document.getElementById("enqvocno").value=$('#jqxQuoteGrid').jqxGrid('getcellvalue', rowindex, "vocno");   
	                   document.getElementById("enqdocno").value=$('#jqxQuoteGrid').jqxGrid('getcellvalue', rowindex, "docno");  
	                   
	                   $('.textpanel p').text('Doc No '+$('#jqxQuoteGrid').jqxGrid('getcellvalue',rowindex,'vocno')+' - '+$('#jqxQuoteGrid').jqxGrid('getcellvalue', rowindex, "refname"));
	                   $('.comments-container').html('');     
                });     
	});     
</script>
<div id="jqxQuoteGrid"></div>  