<%@ page import="com.dashboard.seal.documentexpiryv2.ClsDocumentExpiryDAO" %>
<% ClsDocumentExpiryDAO cld=new ClsDocumentExpiryDAO();%>

<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String check = request.getParameter("check")==null?"NA":request.getParameter("check").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim(); 
     String docid = request.getParameter("docid")==null?"0":request.getParameter("docid").trim(); 
     String active = request.getParameter("active")==null?"":request.getParameter("active").trim();%>            
<style>
 		 .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .orangeClass
        {
            background-color: #FFEBC2;
        }
        .violetClass
        {
            background-color: #ff99ac;
        }
        .blueClass
        {
           background-color: #bde0fe;
        }
        .pinkClass
        {
         background-color: #ffafcc;
        }
        .greenClass
        {
         background-color: #83c5be;
        }
        .lavClass
        {
        background-color: #e4c1f9;
        }
         .skyClass
        {
        background-color: #a9d6e5;
        }  
        .lightgreenClass
        {
        background-color: #c7f9cc;
        } 
        
        
      
        
        .whiteClass
        {
           background-color: #fff;
        }
        .folllowUpClass
	    {
	      background-color: #E0F8F1;
	    }
	    	    
</style>
        
<script type="text/javascript">
      var data,DocumentExpiryexcel;
      var temp='<%=branchval%>';
      var colorarray=['redClass','yellowClass','orangeClass','violetClass','blueClass','pinkClass','greenClass','lavClass','skyClass','lightgreenClass'];
	
     if(temp!='NA'){ 
	  		    data='<%=cld.documentExpiryGridLoading(branchval, upToDate,check, cldocno, active,docid)%>';   
	  	}
  	
        $(document).ready(function () {
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'refname', type: 'String'  },
					{name : 'name', type: 'String'  },
				    {name : 'per_mob' , type: 'String' },
				    {name : 'sal_name', type: 'String'  },
				    {name : 'document' , type: 'String' },
				    {name : 'expirydate', type: 'date'  },
				    {name : 'followupdate', type: 'date'  },
				    {name : 'cldocno', type: 'int' },
				    {name : 'sr_no', type: 'int'  },
				    {name : 'brhid', type: 'int'  },
				    {name : 'clientinfo', type: 'string'  },
				    {name : 'docid', type: 'string'  }
			         
	            ],
                localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		/*if (data.document == 'Licence Expired') {
                    return "redClass";
                } else if (data.document == 'Passport Expired') {
                    return "yellowClass";
                } else if (data.document == 'Trade Licence Expired') {
                    return "orangeClass";
                } else if (data.document == 'ID Expired') {
                    return "violetClass";
                } else{
                	return "whiteClass";
                };*/
                return colorarray[parseInt(data.docid)-1];
                
                
                
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#documentExpiry").jqxGrid(
            {
                width: '98%',
                height: 400,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
						{ text: 'Client', datafield: 'refname' },
						{ text: 'Cldocno', datafield: 'cldocno', width: '10%' ,hidden:true },
						{ text: 'Ref. Details', datafield: 'name', width: '15%' },
						{ text: 'Mobile No.', datafield: 'per_mob', width: '10%' },
						{ text: 'Salesman', datafield: 'sal_name', width: '10%' },
						{ text: 'Document', datafield: 'document', cellclassname: cellclassname,  width: '15%' },
						{ text: 'Expiry Date', datafield: 'expirydate', cellclassname: cellclassname,  cellsformat: 'dd.MM.yyyy' , width: '10%' },
						{ text: 'Follow-Up Date', datafield: 'followupdate', cellclassname: 'folllowUpClass',  cellsformat: 'dd.MM.yyyy' , width: '10%' },
						{ text: 'Driver SrNo.', datafield: 'sr_no', hidden: true, width: '10%' },
						{ text: 'Branch Id', datafield: 'brhid', hidden: true, width: '10%' },
						{ text: 'Client Info', datafield: 'clientinfo', hidden:true, width: '10%' },
						{ text: 'Doc Id', datafield: 'docid',hidden:true, width: '10%' },
						
						]
            });
            
            if(temp=='NA'){
                $("#documentExpiry").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
            $('#documentExpiry').on('rowdoubleclick', function (event) { 
        	  var rowindex1=event.args.rowindex;
        	  $('#cmbprocess').val('');$('#date').val(new Date());$('#txtbranch').val('');$('#txtcldocno').val('');$('#docid').val('');$('#expiryDate').val(new Date());$('#txtremarks').val('');
			  $('#txtdriver').val('');$('#txtdocument').val('');
        	  
              $('#cmbprocess').attr("disabled",false);$('#txtremarks').attr("readonly",false);
              $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
              document.getElementById("docid").value=$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, "docid"); 
         	  document.getElementById("txtcldocno").value=$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, "cldocno"); 
        	  document.getElementById("txtdriver").value=$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, "sr_no");
        	  document.getElementById("txtbranch").value=$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, "brhid");
        	  document.getElementById("txtdocument").value=$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, "document");
        	  $('#expiryDate').val($('#documentExpiry').jqxGrid('getcellvalue', rowindex1, "expirydate")) ; 
        	  
        	  var values= $('#documentExpiry').jqxGrid('getcellvalue',rowindex1, "clientinfo");
              
              var sum2 = values.toString().replace(/\*/g, '\n');
           
              document.getElementById("clientinfo").value=sum2;

              $('#documentDetailsGrid').jqxGrid('clear');
              
              var check = 1;
       		
              $("#detailDiv").load("detailGrid.jsp?cldocno="+$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, 'cldocno')
            		  +'&srno='+$('#documentExpiry').jqxGrid('getcellvalue', rowindex1, 'docid')+'&document='+encodeURIComponent($('#documentExpiry').jqxGrid('getcelltext', rowindex1, 'document'))+'&check='+check);
              }); 
            
  });
                       
</script>
<div id="documentExpiry"></div>
   