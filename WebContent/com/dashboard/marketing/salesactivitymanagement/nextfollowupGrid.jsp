<%@page import="com.dashboard.marketing.salesactivitymanagement.ClsSalesActivityManagementDAO"%>   
<%
ClsSalesActivityManagementDAO DAO=new ClsSalesActivityManagementDAO();  
%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
   
 <%
     String id=request.getParameter("id")==null?"":request.getParameter("id").toString(); 
     String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();  
 %>        
<script type="text/javascript">    
var nfdata;
nfdata='<%=DAO.nextflwupData(session,id,docno) %>';                               
$(document).ready(function(){           
    
    var source =
    {             
                   datatype: "json",
                   datafields: [ 
		                	   {name : 'flwuptype',type:'string'},
		                       {name : 'date' , type: 'date'},
							   {name : 'time', type: 'string'},
							   {name : 'meetdate', type:'date'}, 
							   {name : 'meettime', type: 'string'},
							   {name : 'remarks', type: 'String' },
							   {name : 'user', type: 'String' },  
                 ],                  
                localdata: nfdata,    
              
            
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



        $("#jqxnextflwup").jqxGrid(
                {
                	width: '100%',
                    height: 250,
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
						{ text: 'Date',datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy'},  
						{ text: 'Time',datafield: 'time', width: '8%'}, 
						{ text: 'Follow Up Type', datafield: 'flwuptype', width: '10%'}, 
						{ text: 'Old Date',datafield: 'meetdate', width: '12%',cellsformat:'dd.MM.yyyy'}, 
						{ text: 'Old Time',datafield: 'meettime', width: '8%'},   
						{ text: 'User',datafield: 'user', width: '15%'},    
						{ text: 'Description',datafield: 'remarks'},
					   ]                                                
                });  
                $("#overlay, #PleaseWait").hide();  
	});     
</script>
<div id="jqxnextflwup"></div>  