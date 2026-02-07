<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<% String contextPath=request.getContextPath();%>
<%ClsProductDAO DAO= new ClsProductDAO(); String psrno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString(); String deptid=request.getParameter("deptid")==null?"0":request.getParameter("deptid").toString();String detachid=request.getParameter("detachid")==null?"":request.getParameter("detachid").toString();String id=request.getParameter("id")==null?"":request.getParameter("id").toString();%>
<script type="text/javascript">
		var specMastersdata;
		var detachid='<%=detachid%>';
		var deptid='<%=deptid%>';
		var psrno='<%=psrno%>';
		if(detachid!=='DET'){
			if(psrno>=0){
				specMastersdata='<%=DAO.specMastersGridLoad(session, psrno, deptid,id)%>'; 
			}
		} else {
			//alert("Entered SpecMastersGrid with det");
			specMastersdata='<%=DAO.specMastersGridLoadDetachDept(session, psrno, deptid,id)%>'; 
		}
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     							{name : 'sdoc_no', type: 'int'   },
     							{name : 'name', type: 'String'   },
     							{name : 'description', type: 'String'  }
                            ],
                         localdata: specMastersdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
           /*  $('#jqxspecMastersGrid').on('bindingcomplete', function (event) {
          		}); */
            	
            var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
            $("#jqxspecMastersGrid").jqxGrid(
            {
            	width: '100%',
                height: 300,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                columns:[
                		{text: 'SL#', datafield: 'sl', columntype:'number', width: '6%', cellsrenderer: function (row, column, value) {
                            return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                		}	},
						{ text: 'Name', datafield: 'name', editable: false,  width: '44%',cellsalign: 'left', align: 'left' },
						{ text: 'sdoc_no', datafield: 'sdoc_no',hidden:true,  width: '18%',cellsalign: 'center', align: 'center' },
						{ text: 'Description', datafield: 'description', width: '50%',editable: false,cellsalign: 'left', align: 'left' }
                ] 
            });
            
             $('#jqxspecMastersGrid').on('celldoubleclick', function (event) {
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	var sdocno=$('#jqxspecMastersGrid').jqxGrid('getcellvalue', rowBoundIndex, 'sdoc_no');  
            	if(datafield=="description")
 		    	   {
 		    	  	specMastersSearchContent('specMastersSearchGrid.jsp?rowno='+rowBoundIndex+'&sdocno='+sdocno+'&deptid='+deptid+'&detachid='+detachid);
 		    	   }
 		                 	  
                  }); 
            
            if($('#mode').val()=='view')
	         {
          	$("#jqxspecMastersGrid").jqxGrid({
   			disabled : true
   		});
	           }
            
            
        });
            
</script>
<div id = "jqxspecMastersGrid" ></div>