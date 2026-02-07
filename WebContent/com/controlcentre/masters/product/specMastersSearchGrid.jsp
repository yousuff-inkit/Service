<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO(); String rowIndex=request.getParameter("rowno").toString(); String sdocno=request.getParameter("sdocno").toString();  String deptid=request.getParameter("deptid");String detachid=request.getParameter("detachid");%>
<script type="text/javascript">
	 var rowIndex='<%=rowIndex%>';
	 var sdocno='<%=sdocno%>';
	 var deptid='<%=deptid%>';
	 var detachid='<%=detachid%>';
	if(detachid==='DET'){
		var specMasterssearch = '<%=DAO.specMastersSearchDetachDept(session, sdocno, deptid)%>';	
	}else{
    	var specMasterssearch= '<%=DAO.specMastersSearch(session,sdocno,deptid)%>';
	} 
	
	
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'name', type: 'string'  },
                              {name : 'description', type:'string'}
                            ],
                       localdata: specMasterssearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#specMasterssearch").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'docno', hidden:true ,datafield: 'doc_no', width: '50%'},
                              { text: 'Name',hidden:true ,datafield: 'name', width: '50%' },
                              { text: 'description', datafield: 'description',width:'100%'}
						]
            });
            
         	
          $('#specMasterssearch').on('cellclick', function (event) {
                var rowindex1= event.args.rowindex;
                $("#jqxspecMastersGrid").jqxGrid('setcellvalue',rowIndex, 'description',$('#specMasterssearch').jqxGrid('getcellvalue', rowindex1, "description"));
                
              $('#specmasterssearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="specMasterssearch"></div> 