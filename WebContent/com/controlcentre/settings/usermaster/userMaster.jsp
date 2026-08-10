<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui input[type="password"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui input[type="password"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
    margin: 0;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

form label.error { color:red; font-weight:bold; }
#errormsg { color:red; font-weight:bold; text-align:center; margin-bottom: 10px; }
</style>

<script type="text/javascript">
    $(document).ready(function () { 
        
        /* Modern 24px height setup for DateTimeInput */
        $("#jqxUserMasterDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
        setTimeout(function () {
            $("#jqxUserMasterDate").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $("#jqxUserMasterDate").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
          
        $('#roleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User Role Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
        $('#roleDetailsWindow').jqxWindow('close');
          
        $('#txtpasswordconfirm').on('keyup', function () {
            if ($(this).val() == $('#txtuserpassword').val()) {
                $('#message').html('Matching').css('color', 'green');
            } else $('#message').html('Not Matching').css('color', 'red');
        });
           
        $('#txtbrole').dblclick(function(){
            $('#roleDetailsWindow').jqxWindow('open');
            roleSearchContent('userRoleSearchGrid.jsp?', $('#roleDetailsWindow')); 
        });
    });
     
    function roleSearchContent(url) {
        $('#roleDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
            $('#roleDetailsWindow').jqxWindow('setContent', data);
            $('#roleDetailsWindow').jqxWindow('bringToFront');
        }); 
    }
     
    function funReadOnly(){
        $('#frmUserMaster input').attr('readonly', true );
        $('#frmUserMaster select').attr('disabled', true );
        $('#jqxUserMasterDate').jqxDateTimeInput({ disabled: true});
    }
    
    function funFocus(){
        $('#jqxUserMasterDate').jqxDateTimeInput('focus'); 
    }
    
    function funRemoveReadOnly(){
        $('#frmUserMaster input').attr('readonly', false );
        $('#frmUserMaster select').attr('disabled', false );
        $('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
        $('#docno').attr('readonly', true);
        $('#levels').val(0);
        $('#txtbrole').attr('readonly', true);
        
        if($('#mode').val()=="A") {
            $('#jqxUserMasterDate').val(new Date());
            $("#userMasterDiv").load("userMasterGrid.jsp");
        }
        
        if ($("#mode").val() == "E") {
            if(document.getElementById("permissionval").value==1) {
                $("#jqxUserMaster").jqxGrid({ disabled: false});   
            }
        }
        
        if ($("#mode").val() == "D") {
            $('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
        }
        getLang();
    }

    function getLang() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                items = items.split('####');
                var langItems = items[0].split(",");
                var optionslang = '';
                for (var i = 0; i < langItems.length; i++) {
                    optionslang += '<option value="' + langItems[i] + '">' + langItems[i] + '</option>';
                }
                $("select#cmblanguage").html(optionslang);
                if ($('#langval').val()!="") {
                    var aa=$('#langval').val().trim();
                    $('#cmblanguage').val(aa) ;
                }
            }
        }
        x.open("GET", "getLang.jsp", true);
        x.send();
    }
    
    function funSearchLoad() {
        changeContent('masterSearchuser.jsp'); 
    }
    
    function checkUserid() {
        var userid=document.getElementById("txtuser").value;
        var masterdoc=document.getElementById("docno").value;
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                if(parseInt(items)>0) {
                    document.getElementById("useridchk").value=1;                       
                    document.getElementById("errormsg").innerText="User ID Already Exists";
                    return  false;
                } else {
                    document.getElementById("useridchk").value="";      
                    document.getElementById("errormsg").innerText="";
                    return  true;
                }
             }
        }
        x.open("GET", "checkUserid.jsp?userid="+userid+"&masterdoc="+masterdoc, true);
        x.send();
    }
    
    function checkUsername() {
        var username=document.getElementById("txtusername").value;
        var masterdocs=document.getElementById("docno").value;
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                if(parseInt(items)>0) {
                    document.getElementById("usernamechk").value=1;     
                    document.getElementById("errormsg").innerText="User Name Already Exists";
                    return  false;
                } else {
                    document.getElementById("usernamechk").value="";        
                    document.getElementById("errormsg").innerText="";
                    return  true;
                }
             }
        }
        x.open("GET", "checkUsername.jsp?username="+username+"&masterdocs="+masterdocs, true);
        x.send();
    }
    
    function funNotify(){
        var useridchk= document.getElementById("useridchk").value;
        if(parseInt(useridchk)==1) {
            document.getElementById("errormsg").innerText="User ID Already Exists";
            document.getElementById("txtuser").focus();
            return  0;
        }
        
        var usernamechk= document.getElementById("usernamechk").value;
        if(parseInt(usernamechk)==1) {
            document.getElementById("errormsg").innerText="User Name Already Exists";
            document.getElementById("txtusername").focus();
            return  0; 
        }
        
        var levelss= document.getElementById("levels").value;
        if(levelss=="") {
            document.getElementById("errormsg").innerText="Select Discount Level";
            document.getElementById("levels").focus();
            return  0; 
        }
        
        var rolelevel= document.getElementById("txtbrole").value;
        if(rolelevel=="") {
            document.getElementById("errormsg").innerText="Select Role";
            document.getElementById("txtbrole").focus();
            return  0; 
        }
         
        if($('#txtuserpassword').val()!=$('#txtpasswordconfirm').val()) {
            document.getElementById("errormsg").innerText="Password Is Not Matching";
            return  0; 
        }

        if($('#cmpermission').val()==1) {               
            var z=0;
            var rows = $("#jqxUserMaster").jqxGrid('getrows');                    
            var selectedRecords = new Array();
            var selectedrows=$("#jqxUserMaster").jqxGrid('selectedrowindexes');
          
            if(selectedrows.length==0){
                $.messager.alert('Warning','Select Branch & Company.');
                return false;
            }
      
            $('#existusermaster').val(selectedrows.length);
            for (var i = 0; i < rows.length; i++) {
                for(var j=0;j<selectedrows.length;j++){
                    if(selectedrows[j]==i){
                        newTextBox = $(document.createElement("input"))
                           .attr("type", "dil")
                           .attr("id", "test"+z)
                           .attr("name", "test"+z)
                           .attr("hidden","true");
                        newTextBox.val(rows[i].brhid+"::"+rows[i].compid);
                        newTextBox.appendTo('form');
                        z++;
                    }
                }
            }
        }
        return 1;
    } 
      
    function getURole(event){
        var x= event.keyCode;
        if(x==114){
            roleSearchContent('userRoleSearchGrid.jsp');
        }
    }
    
    function fungriddis() {
        if($('#cmpermission').val()==1) {
            $("#jqxUserMaster").jqxGrid({ disabled: false});   
            $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
        } else {
            $("#jqxUserMaster").jqxGrid({ disabled: true}); 
            $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
        }
    }
     
    function checkvals() {
        if($('#permissionval').val()!="") {
            $('#cmpermission').val($('#permissionval').val());
        }
        if($('#hidelevels').val()!="") {
            $('#levels').val($('#hidelevels').val());
        }
    }

    function setValues() {
        if($('#hidjqxUserMasterDate').val()){
            $("#jqxUserMasterDate").jqxDateTimeInput('val', $('#hidjqxUserMasterDate').val());
        }
        var docnumber=document.getElementById("docno").value;
        
        if(parseInt(docnumber)>0) { 
             $("#userMasterDiv").load("userMasterGrid.jsp?docno="+docnumber);
        }  
        
        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }
        
        getLang();
        checkvals();
        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        funSetlabel();
    }
</script>
</head>
<body onload="setValues();getLang();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmUserMaster" action="saveUserMaster" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui hidden-scrollbar">
    <div id="errormsg"></div>

    <!-- User Master Settings Panel -->
    <div class="middle-panel">
        <span class="middle-panel-title">User Master Info</span>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Date</label>
            <div style="width: 125px;">
                <div id='jqxUserMasterDate' name='jqxUserMasterDate' value='<s:property value="jqxUserMasterDate"/>'></div>
            </div>
            <input type="hidden" id="hidjqxUserMasterDate" name="hidjqxUserMasterDate" value='<s:property value="hidjqxUserMasterDate"/>'/>
            
            <label class="lbl-right" style="width:100px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="docno" value='<s:property value="docno"/>' tabindex="-1" style="width:125px;" readonly>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">User ID</label>
            <input type="text" id="txtuser" name="txtuser" placeholder="Enter User ID" value='<s:property value="txtuser"/>' onblur="checkUserid()" style="width:125px;">

            <label class="lbl-right" style="width:100px; margin-left:auto;">User Name</label>
            <input type="text" id="txtusername" name="txtusername" placeholder="Enter User Name" value='<s:property value="txtusername"/>' onblur="checkUsername()" style="flex:1;">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Role</label>
            <div class="input-search-container" style="width:125px;">
                <input type="text" id="txtbrole" name="txtbrole" placeholder="Press F3" value='<s:property value="txtbrole"/>' onkeydown="getURole(event);">
                <svg class="magnifier-icon" onclick="$('#txtbrole').dblclick();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            <input type="hidden" id="txtroleid" name="txtroleid" value='<s:property value="txtroleid"/>'/>

            <label class="lbl-right" style="width:100px; margin-left:auto;">Language</label>
            <select id="cmblanguage" name="cmblanguage" style="width:180px;"></select>
            <input type="hidden" id="hidcmblanguage" name="hidcmblanguage" value='<s:property value="hidcmblanguage"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Email</label>
            <input type="email" id="txtusermail" name="txtusermail" placeholder="Enter Email" value='<s:property value="txtusermail"/>' style="width:250px;">

            <label class="lbl-right" style="width:100px; margin-left:auto;">Permission</label>
            <select id="cmpermission" name="cmpermission" onchange="fungriddis()" style="width:180px;">
                <option value="0">All Branch</option>
                <option value="1">Selected Branch</option>
            </select>
            <input type="hidden" id="hidcmpermission" name="hidcmpermission" value='<s:property value="hidcmpermission"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">E-mail Password</label>
            <input type="password" id="txtmailpswd" name="txtmailpswd" placeholder="Email Password" value='<s:property value="txtmailpswd"/>' style="width:250px;">

            <label class="lbl-right" style="width:100px; margin-left:auto;">Signature</label>
            <input type="text" id="txtmailsign" name="txtmailsign" placeholder="Email Signature" value='<s:property value="txtmailsign"/>' style="width:180px;">
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">E-mail Host</label>
            <input type="text" id="txtmailhost" name="txtmailhost" placeholder="Email Host" value='<s:property value="txtmailhost"/>' style="width:250px;">

            <label class="lbl-right" style="width:100px; margin-left:auto;">E-mail Port</label>
            <input type="text" id="txtmailport" name="txtmailport" placeholder="Email Port" value='<s:property value="txtmailport"/>' style="width:180px;">
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Password</label>
            <input type="password" id="txtuserpassword" name="txtuserpassword" placeholder="Enter Password" value='<s:property value="txtuserpassword"/>' style="width:250px;">

            <label class="lbl-right" style="width:100px; margin-left:auto;">Confirm Password</label>
            <div style="display:flex; align-items:center; gap:8px;">
                <input type="password" id="txtpasswordconfirm" name="txtpasswordconfirm" placeholder="Confirm Password" value='<s:property value="txtpasswordconfirm"/>' style="width:180px;">
                <span id="message" style="font-weight:bold; font-size:12px;"></span>
            </div>
        </div>
    </div>

    <!-- Grid Data Panel -->
    <div class="middle-panel" style="padding-bottom:10px;">
        <span class="middle-panel-title">Details</span>
        <div id="userMasterDiv" class="grid-container" style="border:none; margin:0;">
            <jsp:include page="userMasterGrid.jsp"></jsp:include>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="useridchk" name="useridchk" value='<s:property value="useridchk"/>'/>
        <input type="hidden" id="usernamechk" name="usernamechk" value='<s:property value="usernamechk"/>'/>
        <input type="hidden" id="langval" name="langval" value='<s:property value="langval"/>'/>
        <input type="hidden" id="levels" name="levels" value='<s:property value="levels"/>'/>
        <input type="hidden" id="permissionval" name="permissionval" value='<s:property value="permissionval"/>'/>
        <input type="hidden" id="existusermaster" name="existusermaster" value='<s:property value="existusermaster"/>'/>
        <input type="hidden" id="hidelevels" name="hidelevels" value='<s:property value="hidelevels"/>'/>
    </div>

</div>
</form>

<div id="roleDetailsWindow"><div></div></div>

</div>
</body>
</html>