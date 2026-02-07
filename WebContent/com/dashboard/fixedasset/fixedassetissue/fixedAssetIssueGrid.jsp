<%@page import="com.dashboard.fixedasset.fixedassetissue.ClsFixedAssetIssueDAO" %>
<%ClsFixedAssetIssueDAO cfld=new ClsFixedAssetIssueDAO(); %>

 <%
 String issue_stat=request.getParameter("issue_stat")==null?"NA":request.getParameter("issue_stat"); 
 String check=request.getParameter("check")==null?"":request.getParameter("check"); 
 String groupno=request.getParameter("groupno")==null?"":request.getParameter("groupno");
 %>


<script type="text/javascript">
var datagrid;
var ch='<%=check%>';
var issue_st='<%=issue_stat%>';
if(ch==1){
	datagrid='<%=cfld.getAssetList(issue_stat,groupno)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'assetid' , type: 'String' },
						{name : 'assetname', type: 'String'  },
						{name : 'assetgrp', type: 'String'    },
						{name : 'assetloc', type: 'String'  },
						{name : 'supplier', type: 'String'  },
						{name : 'prefno', type: 'String'  },
						{name : 'issuedt', type: 'date'  },
						{name : 'pdate', type: 'date'  },
						{name : 'totalpval', type: 'number'  },
						{name : 'fixedassetac',type:'String'},
						{name :'accdeprac',type:'String'},
						{name :'deprac',type:'String'},
						{name :'doc_no' ,type:'String'},
						{name :'srno' ,type:'String'},
						{name :'issue_status' ,type:'String'},
						{name :'type' ,type:'String'},
						{name :'type1' ,type:'String'},
						{name :'type_no' ,type:'String'},
						{name :'name' ,type:'String'},
						],
				    localdata: datagrid,
        
        
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
    
    $("#faIssueGrid").on("bindingcomplete", function (event) {
        
        // your code here.
       if(issue_st=="1"){
    	   $('#faIssueGrid').jqxGrid('setcolumnproperty','name','hidden',false);
    	   $('#faIssueGrid').jqxGrid('setcolumnproperty','type','hidden',false);
    	   $('#faIssueGrid').jqxGrid('setcolumnproperty','issuedt','hidden',false);
       } 
       });
    $("#faIssueGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        columnsresize: true,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:false,
        columns: [
{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
}   },
						{ text: 'Asset ID', datafield: 'assetid', width: '8%'  },
						{ text: 'Asset Name', datafield: 'assetname' ,width:'29%'},
						{ text: 'Asset Group', datafield: 'assetgrp', width: '15%' },
						{ text: 'Asset Location', datafield: 'assetloc', width: '15%',},
						{ text: 'Type', datafield: 'type', width: '10%',hidden:true},
						{ text: 'Type1', datafield: 'type1', width: '10%',hidden: true},
						{text:  'Issue To',datafield:'name',width:'10%',hidden:true},
						{text:  'Type no',datafield:'type_no',width:'10%',hidden: true},
						{ text: 'Supplier', datafield: 'supplier', width: '18%'},
						{ text: 'Pur Ref No', datafield: 'prefno', width: '10%'},
						{ text: 'Issued', datafield: 'issuedt', cellsformat: 'dd.MM.yyyy', width: '10%',hidden:true},
						{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true},
						{ text: 'Sr No', datafield: 'srno', width: '10%',hidden:true},
						{text:'Issue Stst',datafield:'issue_status',width:'10%',hidden:true}
						]
    });
    
    $('#faIssueGrid').on('rowdoubleclick', function (event) {
    	var rowindex1 = event.args.rowindex;  
    	 if(issue_st=="1"){
    			$("#txtgroup").attr("disabled",true);
				//$("#issue_ret").attr("disabled",true);
				$("#txtisssueto").attr("disabled",true);
				$("#txtaccount").attr("disabled",true);
				$('#issueddate').jqxDateTimeInput({disabled: false});
				$("#save").attr("disabled",false);  
				
				document.getElementById("txtisssueto").value=$('#faIssueGrid').jqxGrid('getcellvalue', rowindex1, "type1");
			   	document.getElementById("txtaccount").value=$('#faIssueGrid').jqxGrid('getcellvalue', rowindex1, "name");
			   	document.getElementById("hidaccount").value=$('#faIssueGrid').jqxGrid('getcellvalue', rowindex1, "type_no");
				document.getElementById("hidfixmsrno").value=$('#faIssueGrid').jqxGrid('getcellvalue', rowindex1, "srno");
			   	document.getElementById("hidissustatus").value=$('#faIssueGrid').jqxGrid('getcellvalue', rowindex1, "issue_status");
		 
    	 }	
    	 else{
 				$("#txtgroup").attr("disabled",false);
				//$("#issue_ret").attr("disabled",false);
				$("#txtisssueto").attr("disabled",false);
				$('#issueddate').jqxDateTimeInput({disabled: false});
				$("#txtaccount").attr("disabled",false);
				$("#save").attr("disabled",false);
 	 	}	
	   	     
    	document.getElementById("hidfixmsrno").value=$('#faIssueGrid').jqxGrid('getcellvalue', rowindex1, "srno");
	   	document.getElementById("hidissustatus").value=$('#faIssueGrid').jqxGrid('getcellvalue', rowindex1, "issue_status");
 });  
   
});

</script>
<div id="faIssueGrid"></div>