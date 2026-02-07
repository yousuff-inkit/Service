<%@page import="com.dashboard.marketing.salesactivitymanagement.ClsSalesActivityManagementDAO"%>   
<%
ClsSalesActivityManagementDAO DAO=new ClsSalesActivityManagementDAO();  
%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
   
 <%
     String id=request.getParameter("id")==null?"":request.getParameter("id").toString();
 %>        
<script type="text/javascript">    
var apdata;
apdata='<%=DAO.appointmentData(session,id) %>';                               
$(document).ready(function(){           
    
    var source =
    {             
                   datatype: "json",
                   datafields: [ 
		                	   {name : 'appnttime',type:'string'},
		                       {name : 'commmode' , type: 'string'},
							   {name : 'refname', type: 'string'},
							   {name : 'appntdate', type:'date'}, 
		                       {name : 'meetdate', type:'date'},						
							   {name : 'meettime', type: 'string'},
							   {name : 'venue', type: 'String' },
							   {name : 'description', type: 'String' },
		                       {name : 'cperson', type: 'String' },
							   {name : 'doc_no', type: 'String' },
							   {name : 'mob', type: 'String' },
							   {name : 'tel', type: 'String' },
							   
							   {name : 'clmob', type: 'String' },
							   {name : 'cltel', type: 'String' },
							   {name : 'mail', type: 'String' },
							   {name : 'fax', type: 'String' },
							   {name : 'cldocno', type: 'String' },   
							   {name : 'address', type: 'String' },   
							   {name : 'ppctrno', type: 'String' },  
							   {name : 'sal_id', type: 'String' },
							   {name : 'sal_name', type: 'String' },
                 ],                  
                localdata: apdata,    
              
            
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



        $("#jqxAppointmentGrid").jqxGrid(
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
						{ text: 'DOCNO',datafield: 'doc_no', width: '6%',hidden:true},    
						{ text: 'Date',datafield: 'appntdate', width: '6%',cellsformat:'dd.MM.yyyy'},  
						{ text: 'Time',datafield: 'appnttime', width: '6%'}, 
						{ text: 'Client', datafield: 'refname'}, 
						{ text: 'Contact Person',datafield: 'cperson', width: '12%'},   
						{ text: 'Mobile', datafield: 'mob', width: '8%'},
						{ text: 'Telephone', datafield: 'tel', width: '8%'},  
						{ text: 'Comm. Mode', datafield: 'commmode', width: '8%'},
						{ text: 'Meeting Date',datafield: 'meetdate', width: '6%',cellsformat:'dd.MM.yyyy'}, 
						{ text: 'Meeting Time',datafield: 'meettime', width: '6%'}, 
						{ text: 'Venue',datafield: 'venue', width: '9%'}, 
						{ text: 'Description',datafield: 'description', width: '15%'}, 
						
						{ text: 'cl mob',datafield: 'clmob', width: '6%',hidden:true}, 
						{ text: 'cl tel',datafield: 'cltel', width: '6%',hidden:true}, 
						{ text: 'mail',datafield: 'mail', width: '6%',hidden:true}, 
						{ text: 'fax',datafield: 'fax', width: '6%',hidden:true}, 
						{ text: 'cldocno',datafield: 'cldocno', width: '6%',hidden:true},     
						{ text: 'address',datafield: 'address', width: '6%',hidden:true}, 
						{ text: 'ppctrno',datafield: 'ppctrno', width: '6%',hidden:true},    
						{ text: 'sal_id',datafield: 'sal_id', width: '6%',hidden:true},    
						{ text: 'sal_name',datafield: 'sal_name', width: '6%',hidden:true},      
					   ]                                                
                });  
                $("#overlay, #PleaseWait").hide();
                $('#jqxAppointmentGrid').on('rowdoubleclick', function (event) {       
	                   var rowindex = event.args.rowindex;     
	                   document.getElementById("enqdocno").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "doc_no");    
	             	  
	                   document.getElementById("hidrefname").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "refname");
	                   document.getElementById("hidclmob").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "clmob");
	                   document.getElementById("hidcltel").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "cltel");
	                   document.getElementById("hidmail").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "mail");
	                   document.getElementById("hidfax").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "fax");     
	                   document.getElementById("hidcpname").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "cperson");
	                   document.getElementById("hidcpmob").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "mob");
	                   document.getElementById("hidcptel").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "tel"); 
	                   document.getElementById("hidcldocno").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "cldocno");    
	                   document.getElementById("hidaddress").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "address"); 
	                   document.getElementById("hidppctrno").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "ppctrno");   
	                   document.getElementById("hidsalid").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "sal_id");   
	                   document.getElementById("hidsalesman").value=$('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "sal_name");     
	                   $('.textpanel p').text($('#jqxAppointmentGrid').jqxGrid('getcellvalue', rowindex, "refname"));
	                   $('.comments-container').html('');       
                });     
	});     
</script>
<div id="jqxAppointmentGrid"></div>  