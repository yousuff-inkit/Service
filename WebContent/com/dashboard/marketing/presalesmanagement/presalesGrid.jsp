<%@page import="com.dashboard.marketing.presalesmanagement.ClsPresalesManagementDAO"%>   
<%
ClsPresalesManagementDAO sd=new ClsPresalesManagementDAO();  
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
data='<%=sd.presalesData(session,id,divname,brhid) %>';                             
$(document).ready(function(){           
    
    var source =
    {             
            datatype: "json",
            datafields: [ 
                        {name : 'docno',type:'string'},
                        {name : 'vocno' , type: 'string'},
                      	{name : 'contrtype' , type: 'string'},           
 						{name : 'refname', type: 'string'},
 						{name : 'date', type:'date'},             
 						{name : 'age',type:'number'},
 						{name : 'sal_name', type: 'string'},
 						{name : 'estno', type: 'string'},
 						{name : 'qotno', type: 'string'},
 						{name : 'surno', type: 'string'},
 						{name : 'schtrno', type: 'String' },
 						{name : 'brhid', type: 'String' },
 						{name : 'address', type: 'String' },
 						{name : 'cldocno', type: 'String' },
 						{name : 'surtrno', type: 'String' },
 						
 						{name : 'pertel', type: 'String'},
 						{name : 'per_mob', type: 'String' },
 						{name : 'mail1', type: 'String' },
 						{name : 'salid', type: 'String' },
 						{name : 'cpersonid', type: 'int' },
 						{name : 'cperson', type: 'String' },
 						{name : 'contactdet', type: 'String' },
 						{name : 'sjobtype', type: 'int' },
 						{name : 'esttrno', type: 'number' },
 						{name : 'taxper', type: 'number' },
 						{name : 'cpersonmob', type: 'String'},  
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
    					{ text: 'Contract Type',datafield: 'contrtype', width: '6%'}, 
    					{ text: 'Survey No',datafield: 'surno', width: '6%'},
    					{ text: 'Est.No',datafield: 'estno', width: '6%'},
    					{ text: 'Quote No',datafield: 'qotno', width: '6%'},  
						{ text: 'Client', datafield: 'refname'}, 
						{ text: 'Salesman', datafield: 'sal_name', width: '14%'}, 
						{ text: 'Age', datafield: 'age', width: '6%',cellsalign:'right',align:'right'}, 
						{ text: 'schtrno', datafield: 'schtrno',width: '10%', hidden: true },
						{ text: 'brhid', datafield: 'brhid',width: '10%', hidden: true },  
						{ text: 'address', datafield: 'address',width: '10%', hidden: true },
						{ text: 'cldocno', datafield: 'cldocno',width: '10%', hidden: true },
						{ text: 'surtrno', datafield: 'surtrno',width: '10%', hidden: true },
						
						{ text: 'Contact Person Id', datafield: 'cpersonid',width: '10%', hidden: true },
						{ text: 'Contact Person', datafield: 'cperson',width: '10%', hidden: true },
						{ text: 'Contact Person Details', datafield: 'contactdet',width: '10%', hidden: true },
						{ text: 'sjobtype', datafield: 'sjobtype',width: '10%', hidden: true },
						{ text: 'esttrno', datafield: 'esttrno',width: '10%', hidden: true },
						{ text: 'Tax Per', datafield: 'taxper',width: '10%', cellsformat: 'd2', hidden: true },
						{ text: 'pertel', datafield: 'pertel',width: '10%', hidden: true },
						{ text: 'per_mob', datafield: 'per_mob',width: '10%', hidden: true },
						{ text: 'mail1', datafield: 'mail1',width: '10%', hidden: true },
						{ text: 'salid', datafield: 'salid',width: '10%', hidden: true },
						{ text: 'cpersonmob', datafield: 'cpersonmob',width: '10%', hidden: true }, 
					   ]                                              
                });  
                $("#overlay, #PleaseWait").hide();
                $('#jqxEnquiryGrid').on('rowdoubleclick', function (event) {       
	                   var rowindex = event.args.rowindex;
	                   document.getElementById("brhid").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "brhid"); 
	                   document.getElementById("schtrno").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "schtrno");    
	                   document.getElementById("enqvocno").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "vocno");   
	                   document.getElementById("enqdocno").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "docno");
	                   
	                   document.getElementById("client").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "refname");
	             	   document.getElementById("cldocno").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "cldocno");
	             	   document.getElementById("address").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "address"); 
	             	   document.getElementById("surtrno").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "surtrno");
	             	   
	             	  document.getElementById("pertel").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "pertel");
	            	  document.getElementById("per_mob").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "per_mob");
	            	  document.getElementById("mail1").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "mail1");
	            	  document.getElementById("salname").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "sal_name");
	            	  document.getElementById("salid").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "salid"); 
	            	  document.getElementById("esttrno").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "esttrno");
	            	  document.getElementById("txtcpersonid").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "cpersonid");
	            	  document.getElementById("txtcperson").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "cperson");
	            	  document.getElementById("txtcpersondet").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "contactdet");
	            	  document.getElementById("txtsjobtype").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "sjobtype");
	            	  document.getElementById("txtclienttaxper").value=$('#jqxEnquiryGrid').jqxGrid('getcelltext', rowindex, "taxper"); 
	            	  document.getElementById("contrtype").value=$('#jqxEnquiryGrid').jqxGrid('getcelltext', rowindex, "contrtype");
	            	  document.getElementById("cpersonmob").value=$('#jqxEnquiryGrid').jqxGrid('getcelltext', rowindex, "cpersonmob");
	             	  
	                   $('.textpanel p').text('ENQ No '+$('#jqxEnquiryGrid').jqxGrid('getcellvalue',rowindex,'vocno')+' - '+$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "refname"));
	                   $('.comments-container').html('');     
                });     
	});     
</script>
<div id="jqxEnquiryGrid"></div>  