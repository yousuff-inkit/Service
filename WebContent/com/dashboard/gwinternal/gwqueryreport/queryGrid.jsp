<%-- <<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include> --%>
<%@page import="com.dashboard.gwinternal.queryreport.*" %>
<%ClsQueryReportDAO floordao=new ClsQueryReportDAO();
String id=request.getParameter("id")==null?"1":request.getParameter("id");
String comprefid=request.getParameter("comprefid")==null?"":request.getParameter("comprefid");
String empdocno=request.getParameter("empdocno")==null?"":request.getParameter("empdocno");
String frmdate = request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

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
var id='<%=id%>';
var floordata=[];
if(id=="1"){
 	floordata='<%=floordao.getQueryData(id,comprefid,empdocno,frmdate,todate)%>';   
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'company' , type: 'string'},
 						{name : 'doc_no', type: 'number'},
 						{name : 'postdate', type: 'date'},
 						{name : 'username', type: 'string'},
 						{name : 'userid', type:'date'},
 						{name : 'usermail',type:'string'},
 						{name : 'usermobile',type:'string'},
 						{name : 'formname',type:'string'},
                      	{name : 'shortdesc', type: 'string'  },
                      	{name : 'querytext',type:'string'},
                      	{name : 'currentstatus',type:'string'},
                      	{name : 'processstatus',type:'string'},
                      	{name : 'comprefid',type:'string'},
                      	{name : 'priority',type:'string'},
                      	{name : 'assigneduser',type:'string'},
                      	{name : 'assignstatus',type:'string'},
                      	{name : 'priorityseqno',type:'string'}    	
             ],
             localdata: floordata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        $("#queryGrid").on("bindingcomplete", function (event) {
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



        $("#queryGrid").jqxGrid(
                {
                	width: '100%',
                    height: 320,
                    source: dataAdapter,
                    showfilterrow: true,
                    sortable:true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:true,
                  	enabletooltips: true,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   }, 
						{ text: 'Ticket No',datafield: 'doc_no', width: '4%',cellclassname: cellclassname},
    					{ text: 'Date',datafield: 'postdate', width: '8%',cellclassname: cellclassname,cellsformat:'dd.MM.yyyy HH:mm'},
    					{ text: 'Company',datafield: 'company', width: '10%',cellclassname: cellclassname},
    					
    					{ text: 'Form Name',datafield: 'formname', width: '10%',cellclassname: cellclassname},
    					{ text: 'Short Description',datafield: 'shortdesc',width: '13%',cellclassname: cellclassname},
    					{ text: 'Query', datafield: 'querytext',width:'15%',cellclassname: cellclassname},
    					{ text: 'Assigned Status',datafield: 'assignstatus',width:'8%' ,cellclassname: cellclassname},
    					{ text: 'Assigned User',datafield: 'assigneduser',width:'12%' ,cellclassname: cellclassname},
    					{ text: 'Priority',datafield: 'priority',width:'5%' ,cellclassname: cellclassname},
    					{ text: 'Seq.No',datafield: 'priorityseqno',width:'3%' ,cellclassname: cellclassname},
    					
    					{ text: 'Process Status',datafield: 'processstatus',width:'6%' ,cellclassname: cellclassname,hidden:true},
    					{ text: 'Company Ref Id',datafield: 'comprefid' ,cellclassname: cellclassname,hidden:true},
    					{ text: 'Username',datafield: 'username', width: '8%',cellclassname: cellclassname},
    					{ text: 'Current Status',datafield: 'currentstatus',width:'6%' ,cellclassname: cellclassname},
    					{ text: 'User Mobile',datafield: 'usermobile', width: '8%',cellclassname: cellclassname},
    					{ text: 'User Mail',datafield: 'usermail', width: '10%',cellclassname: cellclassname},
    	              ]
                });
				
				$('#queryGrid').on('rowdoubleclick', function (event) 
				{ 
				    var args = event.args;
				    // row's bound index.
				    var boundIndex = args.rowindex;
				    // row's visible index.
				    var visibleIndex = args.visibleindex;
				    // right click.
				    var rightclick = args.rightclick; 
				    // original event.
				    var ev = args.originalEvent;
				    
				 	$('#rowindex').val(boundIndex);
					var username=$('#queryGrid').jqxGrid('getcellvalue',boundIndex,'username');
					var formname=$('#queryGrid').jqxGrid('getcellvalue',boundIndex,'formname');
					$('#docno').val($('#queryGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
				 	$('.textpanel p').text(username+' - '+formname);
				 	var docno=$('#docno').val();
				 	$('.page-loader').show();
					$('#queryfollowupgriddiv').load('queryFollowupGrid.jsp?docno='+docno+'&id=1');
				});
	});
</script>
<div id="queryGrid"></div>