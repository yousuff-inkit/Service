 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.skips.clientallocation.ClsClientAllocationDAO"%>
 <% ClsClientAllocationDAO DAO = new ClsClientAllocationDAO();     
  String contextPath=request.getContextPath();
  String type=request.getParameter("type")==null || request.getParameter("type").trim()==""?"0":request.getParameter("type").trim();
   String id=request.getParameter("id")==null || request.getParameter("id").trim()==""?"0":request.getParameter("id").trim();%>
<script type="text/javascript">

	var rdata='<%=DAO.loadClientData(session,type,id)%>';        
        $(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						 {name : 'doc_no', type: 'number' }, 
     						 {name : 'mob', type: 'string'  },        
     						 {name : 'email', type: 'string'   },
     						 {name : 'grpcmp', type: 'string'   },
     						 {name : 'name', type: 'string'   },  
     						 {name : 'telno', type: 'string'   },   
     						 {name : 'telesales', type: 'string'   },    
                        ],
                         localdata: rdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            $("#jqxClientGrid").on('bindingcomplete', function (event) {
            	var type=$("#cmbload").val(); 
            	if(type=="2"){
            		$("#jqxClientGrid").jqxGrid('showcolumn', 'telesales');
            	}else{
            		$("#jqxClientGrid").jqxGrid('hidecolumn', 'telesales');
            	}
            	
            });
            $("#jqxClientGrid").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                editable: true,
                selectionmode: 'checkbox',    
                filterable:true,
                showfilterrow:true,
                enabletooltips:true,
                columnsresize: true,      
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                            }   },
							{ text: 'Doc No', datafield: 'doc_no', editable: false,  width: '5%'},
							{ text: 'Client', datafield: 'name', editable: false  },
							{ text: 'Mob No', datafield: 'mob', width: '15%', editable: false  },
							{ text: 'Tel No', datafield: 'telno', width: '15%', editable: false  },  
							{ text: 'Email', datafield: 'email', width: '15%', editable: false  },
							{ text: 'Group Company', datafield: 'grpcmp', width: '15%', editable: false  },  
							{ text: 'Telesales', datafield: 'telesales', width: '10%', editable: false  },  
						]
            });
            $('.load-wrapp').hide(); 
        });
</script>
<div id="jqxClientGrid"></div>
 