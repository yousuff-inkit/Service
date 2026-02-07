<%@page import="com.dashboard.marketing.amcmanagement.ClsAmcManagementDAO"%>   
<% ClsAmcManagementDAO DAO=new ClsAmcManagementDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
   
 <%
     String id=request.getParameter("id")==null?"":request.getParameter("id").toString();
     String divname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
     String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
     String fromdate=request.getParameter("fromdate")==null || request.getParameter("fromdate")==""?"0":request.getParameter("fromdate").toString();
	 String todate=request.getParameter("todate")==null || request.getParameter("todate")==""?"0":request.getParameter("todate").toString();  
	 String fdatechk=request.getParameter("fdatechk")==null || request.getParameter("fdatechk")==""?"0":request.getParameter("fdatechk").toString();   
 %>        
<script type="text/javascript">    
var data;
data='<%=DAO.projectData(session,id,divname,brhid,fromdate,todate,fdatechk) %>';                                     
$(document).ready(function(){           
    
    var source =
    {             
            datatype: "json",
            datafields: [ 
                        {name : 'docno',type:'string'},
                        {name : 'vocno' , type: 'string'},
 						{name : 'refname', type: 'string'},
 						{name : 'date', type:'date'},             
 						{name : 'brhid', type: 'String' },
 						{name : 'cldocno', type: 'String' },
 						{name : 'site', type: 'String'},
 						{name : 'dtype', type: 'String'  },
 						{name : 'refdocno', type: 'number'  },
 						{name : 'tr_no', type: 'String' },
 						{name : 'acno', type: 'String' }, 
 						{name : 'code', type: 'String' },  
 						{name : 'sitecount', type: 'String' },
 						{name : 'servicecount', type: 'String' },
 						{name : 'schedulecount', type: 'String' },  
 						{name : 'compschcountcount', type: 'String' },
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



        $("#jqxProjectGrid").jqxGrid(
                {
                	width: '100%',
                    height: 430,
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
							
							{ text: 'CNT NO',datafield: 'vocno', width: '6%'},
							{ text: 'CNT DATE',datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy'},      
	    					{ text: 'BRANCH',datafield: 'code', width: '4%'},   
							{ text: 'CLIENT', datafield: 'refname'}, 
							{ text: 'SITES',datafield: 'sitecount', width: '6%'},  
							{ text: 'SERVICE',datafield: 'servicecount', width: '6%'},   
							{ text: 'SCHEDULE',datafield: 'schedulecount', width: '6%'},  
							{ text: 'COMPLETE SCHEDULE',datafield: 'compschcountcount', width: '6%'},
							{ text: 'SITE', datafield: 'site',width: '17%'},  
							
							{ text: 'DOC NO',datafield: 'docno', width: '6%',hidden:true}, 
							{ text: 'brhid', datafield: 'brhid',width: '10%', hidden: true },  
							{ text: 'cldocno', datafield: 'cldocno',width: '10%', hidden: true },
							{ text: 'tr_no', datafield: 'tr_no', hidden: true },
							{ text: 'dtype', datafield: 'dtype', hidden: true },
							{ text: 'refdocno', datafield: 'refdocno', hidden: true },
							{ text: 'acno', datafield: 'acno', hidden: true },  
					   ]                                                  
                });  
                $("#overlay, #PleaseWait").hide();
                $('#jqxProjectGrid').on('rowdoubleclick', function (event) {       
	                   var rowindex = event.args.rowindex;
	                         
	                   document.getElementById("brhid").value=$('#jqxProjectGrid').jqxGrid('getcellvalue', rowindex, "brhid"); 
	                   document.getElementById("jobvocno").value=$('#jqxProjectGrid').jqxGrid('getcellvalue', rowindex, "vocno");   
	                   document.getElementById("jobdocno").value=$('#jqxProjectGrid').jqxGrid('getcellvalue', rowindex, "docno");
	                   document.getElementById("srno").value=$('#jqxProjectGrid').jqxGrid('getcellvalue', rowindex, "tr_no");
	                   document.getElementById("dtype").value=$('#jqxProjectGrid').jqxGrid('getcellvalue', rowindex, "dtype");
	                   document.getElementById("trno").value=$('#jqxProjectGrid').jqxGrid('getcellvalue', rowindex, "refdocno");  
	                   document.getElementById("cldocno").value=$('#jqxProjectGrid').jqxGrid('getcellvalue', rowindex, "cldocno");    
		               document.getElementById("acno").value = $('#jqxProjectGrid').jqxGrid('getcellvalue', rowindex, "acno");    
		               document.getElementById("lblname").value = $('#jqxProjectGrid').jqxGrid('getcellvalue',rowindex,'vocno')+' - '+$('#jqxProjectGrid').jqxGrid('getcellvalue', rowindex, "refname");  
	                   $('.textpanel p').text('Doc No '+$('#jqxProjectGrid').jqxGrid('getcellvalue',rowindex,'vocno')+' - '+$('#jqxProjectGrid').jqxGrid('getcellvalue', rowindex, "refname"));
	                   $('.comments-container').html('');     
                });       
	});     
</script>
<div id="jqxProjectGrid"></div>    