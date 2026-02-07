<%@page import="com.dashboard.skips.contractlpofollowup.ClsContractLPOFollowupDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsContractLPOFollowupDAO DAO= new ClsContractLPOFollowupDAO();   
 %>
 <%
 String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno").trim().toString(); 
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 int exp=request.getParameter("exp")==null || request.getParameter("exp")==""?0:Integer.parseInt(request.getParameter("exp").trim().toString());            

 %> 
    <script type="text/javascript">
    var ccdata;  
    var id='<%=id%>';
    var exp='<%=exp%>';
    $(document).ready(function () { 
    	
    	ccdata='<%=DAO.clientConfirmData(session,id,exp)%>';   
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'contrno', type: 'String'  },
                	{name : 'contdet', type: 'number'  },
	      		    {name : 'cdate', type: 'date'  },
      	       	    {name : 'refname', type: 'String'  },
            	 	{name : 'cctype', type: 'String'  },

                  	{name : 'date' , type: 'Date' },
				    {name : 'pono', type: 'String'  },
                  	{name : 'validupto', type: 'Date'  },
                  	{name : 'amount', type: 'number'  },
                  	{name : 'description', type: 'String'  },
                  	{name : 'rowno', type: 'String'  },
                	{name : 'qty', type: 'number'  },
               	    {name : 'upload',type:'string'}, 
               	    {name : 'path',type:'String'},
               	    {name : 'skiptype', type: 'string'  },
              		{name : 'skipdoc', type: 'String'  },
              		{name : 'wastetype', type: 'string'   },
              		{name : 'wastedoc', type: 'String'  },
              		{name : 'startdt', type: 'Date'  }, 
                	{name : 'enddt', type: 'Date'  }, 
                  	{name : 'nos', type: 'String'  },

                          	],
                 localdata: ccdata,
                
                
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
            $("#jqxclientconfirmGrid").jqxGrid(
            {
                width: '100%',
                height: 370,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
                filterable: true, 
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                //Add row method
	          
                columns: [{ text: 'SL#', sortable: false, filterable: false, editable: false,
                    groupable: false, draggable: false, resizable: false,
                    datafield: '', columntype: 'number', width: '3%',
                    cellsrenderer: function (row, column, value) {
                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                    }
			},
			{ text: 'Contr.No', datafield: 'contrno', width: '3%',editable:false },	
			{ text: 'Contdet', datafield: 'contdet', width: '5%',editable:false,hidden:true },	
			{ text: 'Contr.Date', datafield: 'cdate', width: '5%',cellsformat:'dd.MM.yyyy',columntype: 'datetimeinput',editable:false },	
			{ text: 'Client', datafield: 'refname', width: '20%',editable:false },	
			{ text: 'Type', datafield: 'cctype', width: '5%',editable:false },	
			{ text: 'Waste Type', datafield: 'wastetype', width: '5%' ,editable:false},	
			{ text: 'Skip Size', datafield: 'skiptype', width: '5%',editable:false },
			{ text: 'No Of Skips', datafield: 'nos', width: '3%',editable:false },	
			{ text: 'Start Date', datafield: 'startdt',editable:false,width:'5%',cellsformat:'dd.MM.yyyy' },
        	{ text: 'End Date', datafield: 'enddt',editable:false,width:'5%',cellsformat:'dd.MM.yyyy' },
		//	{ text: 'Date', datafield: 'date',width:'5%',cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput',editable:false},  
			{ text: 'PO No',datafield:'pono',width:'3%',editable:false},
			{ text: 'Qty',datafield:'qty',width:'3%',editable:false},  
			{ text: 'Value', datafield: 'amount', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right',editable:false },
			{ text: 'Valid Upto', datafield: 'validupto', width: '5%',cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput',editable:false},
			{ text: 'Description',datafield:'description',editable:false},
			{ text: 'rowno',datafield:'rowno',hidden:true}, 
			{ text: 'path',datafield:'path',hidden:true},  
			
				
					]
            });
            $("#jqxclientconfirmGrid").on('cellendedit', function (event) {      
        	    var args = event.args;
        	    var columnDataField = event.args.datafield;
        	    var rowIndex = event.args.rowindex;
        	    var cellValue = event.args.value;
        	    var oldValue = event.args.oldvalue;         
        	    if(columnDataField=="description"){              
        	    	$('#jqxclientconfirmGrid').jqxGrid('setcellvalue', rowIndex, "description",cellValue);        
        	    }
        	});
			            $("#overlay, #PleaseWait").hide(); 

            $("#jqxclientconfirmGrid").jqxGrid('addrow', null, {});
            $('#jqxclientconfirmGrid').on('rowdoubleclick', function (event) {     

           	  var rowindex1=event.args.rowindex; 
           	  document.getElementById("hidcontrno").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "contrno");
           	  document.getElementById("hidcontdet").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "contdet");
           	  document.getElementById("hidcdate").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "cdate");
           	  document.getElementById("hidclient").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "refname");
           	  document.getElementById("hidtype").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "cctype");
           	  document.getElementById("hidwastetype").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "wastetype");
           	  document.getElementById("hidskipsize").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "skipsize");
           	  document.getElementById("hidnos").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "nos");
           	 document.getElementById("hidenddt").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "enddt");
          	  document.getElementById("hidstartdt").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "startdt");  

          	  document.getElementById("hiddate").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "date");  

           	  document.getElementById("hidpono").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "pono");
           	  document.getElementById("hidqty").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "qty");
           	  document.getElementById("hidamount").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "amount");
           	  document.getElementById("hidvalidupto").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "validupto");
           	  document.getElementById("hiddescription").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "description");
           //	  document.getElementById("hidpath").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "path");
           	  document.getElementById("hidrowno").value=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "rowno");
           	 $("#amcfollowupGrid").jqxGrid('clear');     
           	  $("#detailDiv").load("detailGrid.jsp?contrno="+$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "contrno"));  
           	  $('.textpanel p').text($('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "contrno")+' - '+$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowindex1, "refname"));
           	  $('.comments-container').html('');  

          });
        });
    
  
   
    </script>
    <div id="jqxclientconfirmGrid"></div>  
