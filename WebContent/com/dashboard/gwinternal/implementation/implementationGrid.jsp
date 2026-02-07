<%@page import="com.dashboard.gwinternal.implementation.ClsImplementationDAO"%>   
<% ClsImplementationDAO DAO=new ClsImplementationDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
   
 <%
     String id=request.getParameter("id")==null?"":request.getParameter("id").toString();
     String comp=request.getParameter("comps")==null?"":request.getParameter("comps").toString();
       
 %>        
<script type="text/javascript">    
var data;
data='<%=DAO.projectData(session,id,comp) %>';                                              
$(document).ready(function(){           
    
    var source =
    {             
            datatype: "json",
            datafields: [ 
                        {name : 'seqid',type:'string'},
                        {name : 'details' , type: 'string'},
 						{name : 'checked', type: 'string'},
 						{name : 'company', type: 'string'},
 						{name : 'remarks', type: 'String' }  
 						
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
                    selectionmode: 'singlecell',
                  	editable:true,
                    altrows:true,
                    sortable: true,
                     columnsresize: true,
                    //Add row method
                    columns: [  
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',editable:false,cellsrenderer: function (row, column, value) {
							    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							}   }, 
							
							{ text: 'Seq.No',datafield: 'seqid', width: '8%',editable:false},
	    					{ text: 'Details',datafield: 'details',editable:false},   
	    					{ text: 'Checked',  datafield: 'checked',width:'6%',columntype:'dropdownlist',
	    						
								createeditor: function (row, column, editor) {
									
		                           billmodelist = ["YES",  "NO"];
		                         
									editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
								
								},
						 	 initeditor: function (row, cellvalue, editor) {
		                          
								var terms = $('#jqxProjectGrid').jqxGrid('getcellvalue', row, "checked");
								
									editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
								
		                        }, 
				
				            },
							{ text: 'Remarks',datafield: 'remarks',editable:true}, 
							{ text: 'company',datafield: 'company',hidden:true}, 
					   ]                                                  
                });  
                $('.load-wrapp').hide(); 
                $('#jqxProjectGrid').on('celldoubleclick', function (event) {          
	                   var rowindex = event.args.rowindex;
	                   document.getElementById("rowindex").value=rowindex;      
                });       
	});     
</script>
<div id="jqxProjectGrid"></div>  
<input type='hidden' id='rowindex' name='rowindex'>  