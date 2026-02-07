<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.dumpmaster.route.ClsRouteDAO"%>
<%
ClsRouteDAO searchDAO = new ClsRouteDAO();
String count=request.getParameter("count")==null?"0":request.getParameter("count").toString();

%>  

 
<script type="text/javascript">


var locdata= '<%=searchDAO.searchHelper(session) %>';   
        $(document).ready(function () { 
                     
    		var count='<%=count%>';

        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'helperid', type: 'String'  },    
      						{name : 'helper', type: 'String'  },
                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#helperGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
                
                columns: [
                          
          				{ text: 'Doc No', datafield: 'helperid', width: '20%'},
    					{ text: 'Helper Name ', datafield: 'helper', width: '80%',editable:false }
										
						]
            });
            
             $('#helperGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
 
              //   txtlocationid
              if(count==0)
            	  {
                 document.getElementById("errormsg").innerText="";
                document.getElementById("helperid").value = $('#helperGrid').jqxGrid('getcellvalue', rowindex1, "helperid");
                document.getElementById("txthelper").value = $('#helperGrid').jqxGrid('getcellvalue', rowindex1, "helper");
            	  }
              else
            	  {
            	  document.getElementById("errormsg").innerText="";
                  document.getElementById("helperid2").value = $('#helperGrid').jqxGrid('getcellvalue', rowindex1, "helperid");
                  document.getElementById("txthelper2").value = $('#helperGrid').jqxGrid('getcellvalue', rowindex1, "helper");
              	
            	  }
              $('#helpersearchwndow').jqxWindow('close');  
        
            }); 
             
        });
    </script>
    <div id="helperGrid"></div>