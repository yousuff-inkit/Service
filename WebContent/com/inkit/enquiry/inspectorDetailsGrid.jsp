<%@page import="com.inkit.enquiry.ClsEnquiryDAO" %>
<%ClsEnquiryDAO DAO= new ClsEnquiryDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String specdocno = request.getParameter("specdocno")==null?"0":request.getParameter("specdocno");
 String inspectorname = request.getParameter("inspectorname")==null?"0":request.getParameter("inspectorname");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
        
       var insdata= '<%=DAO.inspectorDetailsSearch(inspectorname, specdocno, chk)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'inspdocno', type: 'String'  },
							{name : 'insp', type: 'String'  },
                        ],
                		 localdata: insdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxinspsearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
							},
							{ text: 'Doc No', datafield: 'inspdocno', width: '19%' },
							{ text: 'Inspector', datafield: 'insp', width: '75%' }
						]
            });
            
             $('#jqxinspsearch').on('rowdoubleclick', function (event) {
            	 var rowIndex =$('#rowindexes').val();
                 var rowindex1 = event.args.rowindex;
                
                 $('#jqxFieldPersonDetails').jqxGrid('setcellvalue', rowIndex, "inspname",$('#jqxinspsearch').jqxGrid('getcellvalue', rowindex1, "insp"));
       			 $('#jqxFieldPersonDetails').jqxGrid('setcellvalue', rowIndex, "insp_id",$('#jqxinspsearch').jqxGrid('getcellvalue', rowindex1, "inspdocno"));
				      
       			 var rows = $('#jqxFieldPersonDetails').jqxGrid('getrows');
  	             var rowlength= rows.length;
  	             var rowindex2 = rowlength - 1;
  	          	 var inspid=$("#jqxFieldPersonDetails").jqxGrid('getcellvalue', rowindex2, "insp_id");
  	          	 if(typeof(inspid) != "undefined" && inspid != ""){
  	          		$("#jqxFieldPersonDetails").jqxGrid('addrow', null, {});
  	          	 }
  	          	
		         $('#inspinfowindow').jqxWindow('close'); 
            });  
             
        });
</script>
<div id="jqxinspsearch"></div>
 