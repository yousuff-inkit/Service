<%@page import="com.realestate.propertyowner.ClsPropertyOwnerDAO" %>
<%
ClsPropertyOwnerDAO cud=new ClsPropertyOwnerDAO();
%>
<%
 String powner = request.getParameter("powner")==null?"0":request.getParameter("powner");
 String ejarino = request.getParameter("ejarino")==null?"0":request.getParameter("ejarino");
 String vndmob = request.getParameter("vndmob")==null?"0":request.getParameter("vndmob");
 String vndtel = request.getParameter("vndtel")==null?"0":request.getParameter("vndtel");
%> 
<script type="text/javascript">
  		
  		var data1= '<%= cud.vndMainSearch(powner,ejarino,vndmob,vndtel) %>';
        
  		$(document).ready(function (){ 	
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'primary_owner' , type: 'String' },
     						{name : 'ejari_no', type: 'String'  },
     						{name : 'mobile', type: 'String'  },
     						{name : 'tele_phn', type: 'String'  },
     						{name : 'doc_no', type: 'int'  }
                 ],
               localdata: data1,
               
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
            $("#jqxPownerSearch").jqxGrid(
            {
            	width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                
                columns: [
					{ text: 'Name', datafield: 'primary_owner', width: '40%' },
					{ text: 'Ejari No.', datafield: 'ejari_no', width: '20%' },
					{ text: 'Mobile No.', datafield: 'mobile', width: '20%' },
					{ text: 'Telephone No.', datafield: 'tele_phn', width: '20%' },
					{ text: 'Doc No', hidden: true, datafield: 'doc_no', width: '5%' },
	              ]
            });
            
            $('#jqxPownerSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtprimeowner").value= $('#jqxPownerSearch').jqxGrid('getcellvalue', rowindex1, "primary_owner");
                document.getElementById("txtejarino").value= $('#jqxPownerSearch').jqxGrid('getcellvalue', rowindex1, "ejari_no");
                document.getElementById("txttelepho").value= $('#jqxPownerSearch').jqxGrid('getcellvalue', rowindex1, "tele_phn");
                document.getElementById("txtmobpho").value= $('#jqxPownerSearch').jqxGrid('getcellvalue', rowindex1, "mobile");
                document.getElementById("docno").value= $('#jqxPownerSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                $('#frmPropertyOwner select').attr('disabled', false);
                $('#jqxDate').jqxDateTimeInput({disabled: false});
                $('#jqxBirthDate').jqxDateTimeInput({disabled: false});
                $('#jqxexpiryDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmPropertyOwner").submit();
                $('#frmPropertyOwner select').attr('disabled', true);
                $('#jqxDate').jqxDateTimeInput({disabled: true});
                $('#jqxBirthDate').jqxDateTimeInput({disabled: true});
                $('#jqxexpiryDate').jqxDateTimeInput({disabled: true});
                $('#window').jqxWindow('close');
            }); 
        });
    </script>
    <div id="jqxPownerSearch"></div>
