<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<style>
form label.error {
color:red;

  font-weight:bold;

}
.hidden-scrollbar {
    overflow: auto;
    
    height: 550px;
}
</style>
 
 
<jsp:include page="../../../includes.jsp"></jsp:include>

<script type="text/javascript">


      
$(document).ready(function () {
    	  /* Date */
    	  $("#txtdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  $('#accinfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '75%' ,maxWidth: '80%' ,title: ' Account Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	  $('#accinfowindow').jqxWindow('close');
    	  getBillingmethod();
    	 
    	 $('#txtacc').dblclick(function(){
    		  $('#accinfowindow').jqxWindow('open');
			  accsearchcontent('accountsearch.jsp?getarea=0');
			  });
    	  })
function setValues() {
    document.getElementById("formdetail").value = "Service";
    document.getElementById("formdetailcode").value = "SER";

    if ($("#hiddate").val() != "") {
        $("#txtdate").jqxDateTimeInput('val', $('#hiddate').val());
    }
    if ($("#hidtxtbillmethod").val() != "") {
        $("#txtbillmethod").val($('#hidtxtbillmethod').val());
    }
    if ($('#msg').val() != "") {
        $.messager.alert('Message', $('#msg').val());
    }
}

function funNotify() {
    var service = document.getElementById("txtservice").value;
    if (service == "" || service == null) {
        document.getElementById("errormsg").innerText = " Please enter service";
        document.getElementById("txtservice").focus();
        return 0;
    }

    var billmethod = document.getElementById("txtbillmethod").value;
    if (billmethod == "" || billmethod == null) {  
        document.getElementById("errormsg").innerText = " Please select a bill method";
        document.getElementById("txtbillmethod").focus();
        return 0;
    }

    var account = document.getElementById("txtacc").value;    
    if (account == "" || account == null) {
        document.getElementById("errormsg").innerText = " Please select an account";  
        document.getElementById("txtacc").focus();
        return 0;
    }
    return 1;
}



function funReadOnly() {
    $('#frmservicemaster input').attr('disabled', true);
    $('#frmservicemaster textarea').attr('disabled', true);
    $('#frmservicemaster select').attr('disabled', true);
}

function funFocus() {
    document.getElementById("txtdate").focus();
}

function funRemoveReadOnly() {
    $('#frmservicemaster input').attr('disabled', false);
    $('#frmservicemaster textarea').attr('disabled', false);
    $('#frmservicemaster select').attr('disabled', false);
}

function accsearchcontent(url) {
    $.get(url).done(function(data) {
        $('#accinfowindow').jqxWindow('setContent', data);
    });
}

function funSearchLoad() {
    changeContent('ServiceMainSearch.jsp');
}

function getAccount(event) {
    var x = event.keyCode;
    if (x == 114) {
        $('#accinfowindow').jqxWindow('open');
        accsearchcontent('accountsearch.jsp?getarea=0');

    } else {}
}

function funChkButton() {}

function getBillingmethod() {
    var x = new XMLHttpRequest();
    var items, currIdItems, mcloseItems, currCodeItems;
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            currIdItems = items[0].split(",");
            currCodeItems = items[1].split(",");

            var optionscurr = '<option value="">-- Select --</option>';  
            for (var i = 0; i < currCodeItems.length; i++) {
                optionscurr += '<option value="' + currIdItems[i] + '">' + currCodeItems[i] + '</option>';
            }
            $("select#txtbillmethod").html(optionscurr);
        } else {}

        if ($('#hidtxtbillmethod').val()) {
            $("#txtbillmethod").val($('#hidtxtbillmethod').val());
        }
    }
    x.open("GET", "getBillingmethod.jsp");
    x.send();
}       	 
</script>
</head>
<body onload="setValues();">
   <div id="mainBG" class="homeContent" data-type="background">
      <form id="frmservicemaster" action="saveservicemasterSeal" method="post" autocomplete="off">
         <jsp:include page="../../../header.jsp" />
         <br/>
         <div class='hidden-scrollbar'>
            <fieldset>
               <table width="100%">
                  <tr>
                     <td width="4%" align="right">Date</td>
                     <td width="6%">
                        <div id="txtdate" name="txtdate" ></div>
                     </td>
                     <td width="10%" align="right">Service</td>
                     <td width="10%"><input type="text" name="txtservice" id="txtservice" style="width:90%;" value='<s:property value="txtservice" />'></td>
                     <td width="5%" align="right">Doc No</td>
                     <td width="8%"><input type="text" name="docno" id="docno" style="width:49%;" value='<s:property value="docno" />'></td>
                  </tr>
                  <tr>
                     <td width="4%" align="right">Bill Method</td>
                     <td width="10%">
                        <select id="txtbillmethod" name="txtbillmethod" style="width:46%">
                        </select>
                        <input type="hidden" id="hidtxtbillmethod" name="hidtxtbillmethod" value='<s:property value="hidtxtbillmethod"/>'/>
                     </td>
                     <td width="10%" align="right">Account</td>
                     <td width="10%"><input type="text" name="txtacc" id="txtacc" style="width:90%;" placeholder="press F3 to search" onKeyDown="getAccount(event)"  value='<s:property value="txtacc"/>'></td>
                  </tr>
                  <tr>
                     <td width="4%" align="right">Description</td>
                     <td width="6%" colspan="3"><input type="text" name="txtdescription" id="txtdescription" style="width:96.8%;" value='<s:property value="txtdescription" />'></td>
                  </tr>
                  <tr>
                     <td>
                        <input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
                        <input type="hidden" id="hiddate" name="hiddate"  value='<s:property value="hiddate"/>'/>
                        <input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>
                        <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
                        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
                        <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
                     </td>
                  </tr>
               </table>
            </fieldset>
         </div>
      </form>
      <div id="accinfowindow">
         <div ></div>
      </div>
      <div id="serviceinfowindow">
         <div ></div>
      </div>
   </div>
</body>
</html>