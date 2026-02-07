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
<%@page import="com.controlcentre.settings.subservicetype.ClsSubServicetypeDAO"%>
<%ClsSubServicetypeDAO DAO= new ClsSubServicetypeDAO();   
   
%>
<script type="text/javascript">      
				
		$(document).ready(function() {
			
			  $('#sertypefowindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Service Type' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			  $('#sertypefowindow').jqxWindow('close');
			
			$("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
			
			$('#txtservice').dblclick(function(){
				   
		    	 $('#sertypefowindow').jqxWindow('open');
		    	 serTypeSearchContent('servicetypesearch.jsp?', $('#sertypefowindow')); 
				   		
				 }); 
		
			 var datas='<%=DAO.descLoad(session) %>';
              
            var source =
            {
                datatype: "json",
                datafields: [
                	        {name : 'servicetype', type: 'String'  },
                	        {name : 'name', type: 'String'  },
                         	{name : 'doc_no' , type: 'number' },
                          	{name : 'date', type: 'date'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'brhid', type: 'String'  },
                         	{name : 'srvid', type: 'String'  },
                         	{name : 'description', type: 'String'  }
                          	
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
    
            $("#enquiryServiceGridID").jqxGrid(
                    {
                    	width: "100%",
                    	height:375,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
                        	{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '5%' },
							{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name' },
							{ text: 'Service Type',columntype: 'textbox', filtertype: 'input', datafield: 'servicetype', width: '20%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Description',columntype: 'textbox', filtertype: 'input', datafield: 'description' },
        					{ text: 'Brhid',columntype: 'textbox', filtertype: 'input', datafield: 'brhid', width: '10%',hidden:true },
        					{ text: 'srvid',columntype: 'textbox', filtertype: 'input', datafield: 'srvid', width: '5%',hidden:true }
							
        	              ]
                    });
            
         $('#enquiryServiceGridID').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#enquiryServiceGridID').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#date").jqxDateTimeInput('val', $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("txtname").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("txtdescription").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("txtservice").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "servicetype");
                document.getElementById("sertype").value = $("#enquiryServiceGridID").jqxGrid('getcellvalue', rowindex1, "srvid");
               
            }); 
		
		});
		function getserType(rowBoundIndex){
			 
			  $('#sertypefowindow').jqxWindow('open');

		//$('#accountWindow').jqxWindow('focus');
		  serTypeSearchContent('servicetypesearch.jsp?rowBoundIndex='+rowBoundIndex);
			 }
			 
		function serTypeSearchContent(url) {
		//alert(url);
			 $.get(url).done(function (data) {
				 //alert(data);
		$('#sertypefowindow').jqxWindow('setContent', data);

		      	}); 
			}
		     
		function funReadOnly(){
			$('#frmSubservice input').attr('readonly', true );
			$('#date').jqxDateTimeInput({disabled: true});
			
		}
		
		function funRemoveReadOnly(){
			$('#frmSubservice input').attr('readonly', false );
			$('#date').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#date').val(new Date());
			}
		}
		
		function funSearchLoad(){
			  changeContent('cpsMainSearch.jsp');  
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
<form id="frmSubservice" action="saveSubservice" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<fieldset>
<table width="100%">
  <tr>
    <td width="8%" align="right">Date</td>
    <td width="66%"><div id='date' name='date' value='<s:property value="date"/>'></div>
                   <input type="hidden" id="hidendate" name="hidendate" value='<s:property value="hidendate"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="24%"><input type="text" id="docno" name="docno" style="width:40%" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table><br/>
<table width="100%">
  <tr>
  <td width="8%" align="right">Service Type</td>   
    <td width="25%"><input style="width:345px" type="text" name="txtservice" id="txtservice" value='<s:property value="txtservice"/>' onKeyDown="getserType(event);" readonly placeholder="Press F3 to Search"></td>
    <td width="5%" align="right">Name</td>
    <td  width="67%"><input type="text" id="txtname" name="txtname" style="width:47.5%;" value='<s:property value="txtname"/>'/></td>
  <tr>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:66%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
</fieldset>

<table width="100%">
  <tr><td><div id="enquiryServiceGridID"></div></td></tr>
</table>

<input type="hidden" id="sertype" name="sertype" value='<s:property value="sertype"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
<div id="sertypefowindow">
   <div ></div>
</div>
</div> 
</body>
</html>