<%@ page import="com.dashboard.skips.tippingfeetariff.ClsTippingfeetariffDAO" %>   
<% ClsTippingfeetariffDAO DAO= new ClsTippingfeetariffDAO(); %>    
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
	  		    data='<%=DAO.tippingTariffGridLoading(check)%>';
	  		   <%-- dataExcelExport='<%=DAO.skipTariffGridExporting(branchval, uptodate, clientaccount, chkfollowup, followupdate, salesperson, category, amtrangefrm, amtrangeto, clientstatus,check)%>';--%>
	  	}
  	 
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					        {name : 'doc_no' , type:'int'},
							{name : 'skipsize' , type:'String'},
							{name : 'skiptypeid' , type:'int'},
							{name : 'wastetype' , type:'String'},
							{name : 'wastetypeid',type:'int'},
							{name : 'disposalfee' , type:'number'},
							{name : 'weight' , type:'number'},


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
            $("#tippingFeeTariff").jqxGrid(
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
							{ text: 'doc_no', datafield: 'doc_no',hidden:true},
							{ text: 'Waste Type', datafield: 'wastetype',align:'left'},
							{ text: 'wasteid',  datafield: 'wasteid',width: '8%' ,hidden:true },
							{ text: 'Skip Size', datafield: 'skipsize',align:'left'},
							{ text: 'skiptypeid',  datafield: 'skiptypeid',width: '8%' ,hidden:true },
							{ text: 'Disposal Fee', datafield:'disposalfee', width:'20%',cellsformat: 'd2',cellsalign: 'right',align:'right' },
							{ text: 'Weight In Kg', datafield:'weight', width:'20%',cellsformat: 'd2',cellsalign: 'right',align:'right' },

							]
            });
            
            if(temp=='NA'){
                $("#tippingFeeTariff").jqxGrid("addrow", null, {});
            }
            
			$("#overlay, #PleaseWait").hide();
			
            $('#tippingFeeTariff').on('rowdoubleclick', function (event) { 
          	  var rowindex1=event.args.rowindex;
          	 
          	  document.getElementById("txtskipsize").value=$('#tippingFeeTariff').jqxGrid('getcellvalue', rowindex1, "skipsize"); 
          	  document.getElementById("txtskipsizeid").value=$('#tippingFeeTariff').jqxGrid('getcellvalue', rowindex1, "skiptypeid");
          	  document.getElementById("txtwastetype").value=$('#tippingFeeTariff').jqxGrid('getcellvalue', rowindex1, "wastetype");
          	  document.getElementById("txtwastetypeid").value=$('#tippingFeeTariff').jqxGrid('getcellvalue', rowindex1, "wastetypeid");
          	  document.getElementById("txtdisposalfee").value=$('#tippingFeeTariff').jqxGrid('getcellvalue', rowindex1, "disposalfee");
          	  document.getElementById("txtweight").value=$('#tippingFeeTariff').jqxGrid('getcellvalue', rowindex1, "weight");
          	  document.getElementById("docno").value=$('#tippingFeeTariff').jqxGrid('getcellvalue', rowindex1, "doc_no");


             }); 
            
            
            

        });

</script>
<div id="tippingFeeTariff"></div>
