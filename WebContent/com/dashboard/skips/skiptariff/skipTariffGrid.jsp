<%@ page import="com.dashboard.skips.skiptariff.ClsSkiptariffDAO" %>   
<% ClsSkiptariffDAO DAO= new ClsSkiptariffDAO(); %>    
<%   String check = request.getParameter("check")==null?"0":request.getParameter("check");
    %> 
<style type="text/css">
  .advanceClass
  {
      background-color: #FBEFF5;
  }
  .balanceClass
  {
      background-color: #E0F8F1;
  }
  .unappliedClass
  {
     color: #FF0000;
  }
   .whiteClass
  {
     background-color: #FFF;
  }
  .currentClass
  {
     background-color: #CECEF6;
  }
  .salikClass
  {
     background-color: #DBEFEC;
  }
  .trafficClass
  {
     background-color: #D3E4B2;
  }
  
</style>
<script type="text/javascript">
      var data;
      var dataExcelExport;
      var temp=1;
      
	  	if(temp!='NA'){ 
	  		    data='<%=DAO.skipTariffGridLoading(check)%>';
	  		   <%-- dataExcelExport='<%=DAO.skipTariffGridExporting(branchval, uptodate, clientaccount, chkfollowup, followupdate, salesperson, category, amtrangefrm, amtrangeto, clientstatus,check)%>';--%>
	  	}
  	 
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					        {name : 'rowno' , type:'int'},
							{name : 'skipsize' , type:'String'},
							{name : 'from' , type:'int'},
							{name : 'to' , type:'int'},
							{name : 'client' , type:'number'},
							{name : 'own',type:'number'},
							{name : 'skiptypeid' , type:'int'},
							
	                      ],
                          localdata: data,
               
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
            $("#skipTariff").jqxGrid(
            {
                width: '100%',
                height: 670,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                
                //Add row method
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellclassname: 'whiteClass', pinned: true,
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }    
							},
							{ text: 'rowno', datafield: 'rowno',hidden:true},
							{ text: 'Skip Size', datafield: 'skipsize',align:'left'},
							{ text: 'skiptypeid',  datafield: 'skiptypeid',width: '8%' ,hidden:true },
							{ text: 'From', datafield: 'from',  width: '15%',cellsalign: 'right',align:'right' },
							{ text: 'To ',  datafield: 'to',  width: '15%' ,cellsalign: 'right',align:'right' },
							{ text: 'Client', datafield:'client', width:'20%',cellsformat: 'd2',cellsalign: 'right',align:'right' },
							{ text: 'Own', datafield:'own', width:'20%',cellsformat: 'd2',cellsalign: 'right',align:'right' },
							]
            });
            
            if(temp=='NA'){
                $("#skipTariff").jqxGrid("addrow", null, {});
            }
            
			$("#overlay, #PleaseWait").hide();
			
            $('#skipTariff').on('rowdoubleclick', function (event) { 
          	  var rowindex1=event.args.rowindex;
          	 
          	  document.getElementById("txtskipsize").value=$('#skipTariff').jqxGrid('getcellvalue', rowindex1, "skipsize"); 
          	  document.getElementById("txtskipsizeid").value=$('#skipTariff').jqxGrid('getcellvalue', rowindex1, "skiptypeid");
          	  document.getElementById("txtfrom").value=$('#skipTariff').jqxGrid('getcellvalue', rowindex1, "from");
          	  document.getElementById("txtto").value=$('#skipTariff').jqxGrid('getcellvalue', rowindex1, "to");
          	  document.getElementById("txtclient").value=$('#skipTariff').jqxGrid('getcellvalue', rowindex1, "client");
          	  document.getElementById("txtown").value=$('#skipTariff').jqxGrid('getcellvalue', rowindex1, "own");
          	  document.getElementById("txtrowno").value=$('#skipTariff').jqxGrid('getcellvalue', rowindex1, "rowno");


             }); 
            
            
            

        });

</script>
<div id="skipTariff"></div>
