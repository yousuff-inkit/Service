<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.settings.subdivision.ClsSubDivisionDAO"%>
<%ClsSubDivisionDAO DAO= new ClsSubDivisionDAO();%>     
<script type="text/javascript">
				
		$(document).ready(function() {
			$("#date").jqxDateTimeInput({ width: '105px', height: '20px', formatString:"dd.MM.yyyy"});
		
			var datas='<%=DAO.descLoad(session) %>';
              
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'date', type: 'date'  },
                          	{name : 'name', type: 'String'  },
                 ],
                localdata: datas,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#subDivisionGridID").jqxGrid(
                    {
                    	width: "100%",
                    	height:375,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        enabletooltips:true,     
                        selectionmode: 'singlerow',
                        
                        columns: [
        					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Name', datafield: 'name'},             
        	              ]
                    });
            
         $('#subDivisionGridID').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#subDivisionGridID').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#date").jqxDateTimeInput('val', $("#subDivisionGridID").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("txtname").value = $("#subDivisionGridID").jqxGrid('getcellvalue', rowindex1, "name");
            });
		
		});
		
		function funReadOnly(){
			$('#frmSubDivision input').attr('readonly', true );
			$('#date').jqxDateTimeInput({disabled: true});
		}
		
		function funRemoveReadOnly(){
			$('#frmSubDivision input').attr('readonly', false );
			$('#date').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#date').val(new Date());
			}
		}
		
		function funSearchLoad(){
			  /*changeContent('cpsMainSearch.jsp');*/   
		 }
			
		function funChkButton() {
				/* funReset(); */
		}
		 
		function funFocus(){
			$('#date').jqxDateTimeInput('focus'); 	    		
		}
		
		function funNotify(){	
  			 return 1;
			} 
		  
		  function setValues(){
			  
			  if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			  
			  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			  funSetlabel();
			  
			}
		
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSubDivision" action="saveSubDivision" method="post" autocomplete="off">        
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<table width="100%">

</table><br/>

<fieldset style="background-color: #EBDEF0;">       
<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="66%"><div id='date' name='date' value='<s:property value="date"/>'></div>
                   <input type="hidden" id="hidendate" name="hidendate" value='<s:property value="hidendate"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="24%"><input type="text" id="docno" name="docno" style="width:40%" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td width="4%" align="right">Name</td>
    <td width="25%" colspan="3"><input type="text" id="txtname" name="txtname" style="width:85%;" value='<s:property value="txtname"/>'/></td>
  </tr>
</table>
</fieldset>

<table width="100%">
  <tr><td><div id="subDivisionGridID"></div></td></tr>     
</table>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>

</div>
</body>
</html>