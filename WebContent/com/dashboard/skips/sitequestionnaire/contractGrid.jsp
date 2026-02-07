<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.sitequestionnaire.ClsSiteQuestionnaireDAO" %>
<%
        ClsSiteQuestionnaireDAO DAO= new ClsSiteQuestionnaireDAO();           
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
 %> 
 <style type="text/css">
  .redClass {
       background-color: #ABFCDC; 
    }
</style>  
<script type="text/javascript"> 
  
var quotedata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 quotedata='<%=DAO.contractGridLoad(session,id)%>';              
            // prepare the data
             
            var source =
            {
                datatype: "json",
                datafields: [
		                	{name : 'site', type: 'String'  },
		                  	{name : 'cldocno', type: 'String'  },
                        	{name : 'refname', type: 'String'  }, 
                        	{name : 'count', type: 'number'  }, 
                 ],
                 localdata: quotedata,  
                
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
            var cellclassname =  function (row, column, value, data) {
                var count = $('#jqxContractGrid').jqxGrid('getcellvalue', row, "count");
         	    if(parseInt(count)>0) {
         		    return "redClass";  
         	    } 
          }  
            $("#jqxContractGrid").jqxGrid(  
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                editable: false, 
                altRows: true,
                selectionmode: 'singlerow', 
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
            	 
                columns: [
							 { text: 'SL#', sortable: false, filterable: false ,cellclassname:cellclassname,
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Client', datafield: 'refname',cellclassname:cellclassname },
                            { text: 'Site', datafield: 'site' ,width:'50%',cellclassname:cellclassname},   
                        	{ text: 'cldocno',datafield:'cldocno',width:'5%' ,hidden:true},
                        	{ text: 'count',datafield:'count',width:'5%' ,hidden:true}, 
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxContractGrid').on('rowdoubleclick', function (event) {       
             	  var rowindex1=event.args.rowindex; 
             	  var cldocno = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
             	  var site = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site");
             	  $("#hidcldocno").val(cldocno);
             	  $("#hidsite").val(site);  
             	  $('#qstiv').load('qstnaireGrid.jsp?cldocno='+cldocno+"&site="+encodeURIComponent(site));     
             	  $('.textpanel p').text($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site"));
            });
        });
    </script>
    <div id="jqxContractGrid"></div> 