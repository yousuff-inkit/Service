<%@page import="com.dashboard.inkit.amsrenewalfollowup.amsRenewalFollowupDAO"%>
<%
amsRenewalFollowupDAO DAO=new amsRenewalFollowupDAO();     
%>          

<% String doc =request.getParameter("doc")==null?"0":request.getParameter("doc").toString();%>
 <% String cldoc =request.getParameter("cldoc")==null?"0":request.getParameter("cldoc").toString();%>

<script type="text/javascript">
  
		var amcdata='<%=DAO.amcdetails(doc,cldoc) %>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'voc_no', type: 'string'  },
                            {name : 'docno', type: 'string'  },
                            {name : 'refno', type: 'string'  },
                            {name : 'sdate', type: 'date'  },
                            {name : 'edate', type: 'date'  }
                        ],
                 	localdata: amcdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#amssearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'AMS No', datafield: 'voc_no', width: '25%'},
                              { text: 'Ref No', datafield: 'refno', width: '25%'},
                              { text: 'Start Date', datafield: 'sdate', width: '25%',cellsformat:'dd.MM.yyyy'},
                              { text: 'End Date', datafield: 'edate', width: '25%',cellsformat:'dd.MM.yyyy'},
                              { text: 'AMS No', datafield: 'docno', width: '25%',hidden:true},
                             
						]
            });
            
          $('#amssearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("amcno").value=$('#amssearch').jqxGrid('getcellvalue', rowindex2, "docno");
           //     document.getElementById("cldocno").value=$('#amssearch').jqxGrid('getcellvalue', rowindex2, "cldocno");
               
                
                $('#amswindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="amssearch"></div>