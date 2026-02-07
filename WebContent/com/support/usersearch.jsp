<%@page import="com.support.ClsSupport" %>
<%ClsSupport cs=new ClsSupport(); %> 
 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <style>
.column
{
   background-color: #ECF8E0;
   color: red;
   font-weight: bold;            
}

.jqx-grid-cell
    {
        border: none;
    }
    
  .supportClass
     {
             color: #FE2E2E;
             background-color: #ECF8E0;
            font-size:12px;
            font-style: bold;
     }
    .clientClass
     {
             color: #2E2EFE;
             background-color: #ECF8E0;
            font-size:12px;
            font-style: bold;
     }

        .column:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected), .jqx-widget .column:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected) {
            color:#142fa8;
            background-color:#e6eafc;
        }
</style>


<% 
 String comp_id=request.getParameter("comp_id")==null?"0":request.getParameter("comp_id").toString().trim();
String msgcnt=request.getParameter("msgcnt")==null?"0":request.getParameter("msgcnt").toString().trim();

//System.out.println("==msgcnt==="+msgcnt+"----comp_id-----"+comp_id);

%>

 <script type="text/javascript">
 
 var dtype;
 var comp_id='<%=comp_id%>';
 var msgcnt='<%=msgcnt%>';
 
 if(msgcnt>=1){
	 
	 dtype='<%=cs.userSearch(session)%>';
 }
 else if(comp_id>=1){
	 
	 dtype='<%=cs.userList(session,comp_id)%>';
 }
 else{
	 dtype='<%=cs.userSearch(session)%>';
 }
 
        $(document).ready(function () { 
         	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     				
     						{name : 'user', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						{name : 'is_read', type: 'String'  },
     						
     						
                          	],
                          	localdata: dtype,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var cellclassname = function (row, column, value, data) {
        		if (data.is_read =='0') {
                    return "supportClass";
                }else{
                	return "clientClass";
                };
            };
     	  
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            
            
            
            );
            $("#jqxusersearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                //autoheight:true,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                rowsheight:25,
                theme: 'energyblue',
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,cellclassname:'column',hidden:true,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'CONTACTS', datafield: 'user', width: '100%',cellclassname: cellclassname},
					{ text: 'Doc_no', datafield: 'doc_no', width: '8%',hidden:true,cellclassname:'column'},
					{ text: 'Read', datafield: 'is_read', width: '8%',hidden:true,cellclassname: cellclassname}
					 
					
					]
            });
    
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
				           $('#jqxusersearch').on('rowdoubleclick', function (event) 
				            		{ 
		
				              	var rowindex1=event.args.rowindex;
				               	document.getElementById("usertoid").value=$('#jqxusersearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				               			//alert("dtype====="+document.getElementById("usertoid").value);
				            	getMsgHistory();
				              
				                //$('#userinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxusersearch"></div>
    
    </body>
</html>