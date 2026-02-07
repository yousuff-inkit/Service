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
 <style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
    
</style>      
<script type="text/javascript">    
var prosdata;
prosdata='<%=DAO.prospectiveData(session,id,brhid) %>';                                       
$(document).ready(function(){           
    
    var source =
    {             
            datatype: "json",
            datafields: [ 
                        {name : 'tr_no',type:'string'},
                        {name : 'doc_no' , type: 'string'},
                      	{name : 'mob' , type: 'string'},  
                    	{name : 'email' , type: 'string'},
 						{name : 'name', type: 'string'},
 						{name : 'date', type:'date'},             
 						{name : 'sal_name', type: 'string'},
 						{name : 'brhid', type: 'String' },
 						{name : 'description', type: 'String' },
 						{name : 'branch', type: 'String' },
 						{name : 'clientacid', type: 'String' },
						{name : 'tel', type: 'String' }, 
						{name : 'fax', type: 'String' },   
             ],                    
             localdata: prosdata,    
              
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
       var cellclassname = function (row, column, value, data) {
    	
  		 if (data.clientacid>0) {  
              return "orangeClass";
          };
        };
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#jqxProspectiveGrid").jqxGrid(
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
						{ text: 'Sr. No.',datafield: '',columntype:'number',cellclassname:cellclassname, width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   }, 
						{ text: 'DOCNO',datafield: 'tr_no', width: '6%',hidden:true},
						{ text: 'Doc No',datafield: 'doc_no', width: '6%',cellclassname:cellclassname},
						{ text: 'Date',datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},   
						{ text: 'Branch', datafield: 'branch', width: '12%',cellclassname:cellclassname},       
						{ text: 'Name', datafield: 'name', width: '20%',cellclassname:cellclassname}, 
						{ text: 'Mob.No.', datafield: 'mob', width: '8%',cellclassname:cellclassname}, 
						{ text: 'Email', datafield: 'email', width: '12%',cellclassname:cellclassname}, 
						{ text: 'Salesman', datafield: 'sal_name', width: '10%',cellclassname:cellclassname},   
						{ text: 'brhid', datafield: 'brhid',width: '10%', hidden: true },    
						{ text: 'Description', datafield: 'description',cellclassname:cellclassname},
						{ text: 'clientacid', datafield: 'clientacid',width: '10%', hidden: true }, 
						{ text: 'cl tel',datafield: 'tel', width: '6%',hidden:true}, 
						{ text: 'fax',datafield: 'fax', width: '6%',hidden:true},   
					   ]                                              
                });  
                $("#overlay, #PleaseWait").hide();
                $('#jqxProspectiveGrid').on('rowdoubleclick', function (event) {         
	                   var rowindex = event.args.rowindex;
	                   document.getElementById("brhid").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "brhid"); 
	                   document.getElementById("enqvocno").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "doc_no");     
	                   document.getElementById("enqdocno").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "tr_no"); 
	                   document.getElementById("clientacid").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "clientacid");  
	                   
	                   document.getElementById("hidrefname").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "name");
	                   document.getElementById("hidclmob").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "mob");
	                   document.getElementById("hidcltel").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "tel");
	                   document.getElementById("hidmail").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "email");
	                   document.getElementById("hidfax").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "fax");     
	                   document.getElementById("hidcldocno").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "clientacid");        
	                   document.getElementById("hidsalid").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "sal_id");   
	                   document.getElementById("hidsalesman").value=$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "sal_name");   
	             	  
	                   $('.textpanel p').text('Doc No '+$('#jqxProspectiveGrid').jqxGrid('getcellvalue',rowindex,'doc_no')+' - '+$('#jqxProspectiveGrid').jqxGrid('getcellvalue', rowindex, "name"));
	                   $('.comments-container').html('');     
                });     
	});     
</script>
<div id="jqxProspectiveGrid"></div>  