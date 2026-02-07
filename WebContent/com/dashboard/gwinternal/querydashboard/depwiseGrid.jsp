<%-- <<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include> --%>
<%@page import="com.dashboard.gwinternal.querydashboard.*" %>
<%ClsQueryDashboardDAO DAO=new ClsQueryDashboardDAO();
%>
<style>
	.yellowClass{
		background-color:#FDFF79;
	}
	.greenClass{
		background-color:#79FFA0;
	}
	.blueClass{
		background-color:#79B6FF;
	}
	.redClass{
		background-color:#FF8579;
	}
</style>
<script type="text/javascript">
	var floordata='<%=DAO.loadSubGridData()%>';   

	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
     {name : 'count', type: 'String'},
	{name : 'type', type: 'String'},


             ],
             localdata: floordata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        $("#depstatusGrid").on("bindingcomplete", function (event) {
        	$('.page-loader').hide();
        }); 
        var cellclassname = function (row, column, value, data) {
        	/*if(data.z1.includes("P")){
            	return "redClass";
            }*/
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#depstatusGrid").jqxGrid(
                {
                	width: '99%',
                    height: 220,
                    source: dataAdapter,
                    showfilterrow: true,
                    sortable:true,
                    filterable: true,
                    selectionmode: 'singlecell',
                  	editable:true,
                  	enabletooltips: true,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '6%',cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   }, 
						{ text: 'Type', datafield: 'type' },
						{ text: 'Count', datafield: 'count', width: '18%',align:'right',cellsalign:'right' },

    	              ]
                });
				
				
	});
</script>
<div id="depstatusGrid"></div>