<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% String contextPath=request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script>
<style type="text/css">
    .hidden-scrollbar {
  overflow: auto;
  height: 450px;      
}
.myButton {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
#customer{
font-weight:bold;
    border: none;
   /*  border-bottom: 2px solid black; */
}

#cusid{
font-weight:bold;
    border: none;
}
</style>
<%
String docno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String qtype =request.getParameter("qcheck")==null?"0":request.getParameter("qcheck").toString();
String customer =request.getParameter("customer")==null?"0":request.getParameter("customer").toString();
String cusid =request.getParameter("cusid")==null?"0":request.getParameter("cusid").toString();
%>
<script type="text/javascript"> 
var docno='<%= docno%>';
var qtype='<%= qtype%>';
var customer='<%= customer%>';
var cusid='<%= cusid%>';
$(document).ready(function () {
	getresetting();
});
 function setValues(){
	 if(document.getElementById("hiddocno").value==""){
		 document.getElementById("hiddocno").value=docno;
	 }
	 // document.getElementById("hiddocno").value=docno;
	  document.getElementById("hidqtype").value=qtype;
	  document.getElementById("customer").value=customer;
	  document.getElementById("cusid").value=cusid;
 }
  function intro1check(){
	 if(document.getElementById("intro1").checked){
		 document.getElementById("hidintro1").value = 1;
	 }
	 else{
		 document.getElementById("hidintro1").value = 0;
	 }
 } 
  function intro2check(){
		 if(document.getElementById("intro2").checked){
			 document.getElementById("hidintro2").value = 1;
		 }
		 else{
			 document.getElementById("hidintro2").value = 0;
		 }
	 }
  function intro3check(){
		 if(document.getElementById("intro3").checked){
			 document.getElementById("hidintro3").value = 1;
		 }
		 else{
			 document.getElementById("hidintro3").value = 0;
		 }
	 } 
	  function intro4check(){
			 if(document.getElementById("intro4").checked){
				 document.getElementById("hidintro4").value = 1;
			 }
			 else{
				 document.getElementById("hidintro4").value = 0;
			 }
		 }
	  function shape1check(){
			 if(document.getElementById("shape1").checked){
				 document.getElementById("hidshape1").value = 1;
			 }
			 else{
				 document.getElementById("hidshape1").value = 0;
			 }
		 }
	  function shape2check(){
			 if(document.getElementById("shape2").checked){
				 document.getElementById("hidshape2").value = 1;
			 }
			 else{
				 document.getElementById("hidshape2").value = 0;
			 }
		 }
	  function shape3check(){
			 if(document.getElementById("shape3").checked){
				 document.getElementById("hidshape3").value = 1;
			 }
			 else{
				 document.getElementById("hidshape3").value = 0;
			 }
		 }
	  function shape4check(){
			 if(document.getElementById("shape4").checked){
				 document.getElementById("hidshape4").value = 1;
			 }
			 else{
				 document.getElementById("hidshape4").value = 0;
			 }
		 }
	  function dtype1check(){
			 if(document.getElementById("dtype1").checked){
				 document.getElementById("hiddtype1").value = 1;
			 }
			 else{
				 document.getElementById("hiddtype1").value = 0;
			 }
		 }
	  function dtype2check(){
			 if(document.getElementById("dtype2").checked){
				 document.getElementById("hiddtype2").value = 1;
			 }
			 else{
				 document.getElementById("hiddtype2").value = 0;
			 }
		 }
	  function dtype3check(){
			 if(document.getElementById("dtype3").checked){
				 document.getElementById("hiddtype3").value = 1;
			 }
			 else{
				 document.getElementById("hiddtype3").value = 0;
			 }
		 }
	  function material1check(){
			 if(document.getElementById("material1").checked){
				 document.getElementById("hidmaterial1").value = 1;
			 }
			 else{
				 document.getElementById("hidmaterial1").value = 0;
			 }
		 }
	  function material2check(){
			 if(document.getElementById("material2").checked){
				 document.getElementById("hidmaterial2").value = 1;
			 }
			 else{
				 document.getElementById("hidmaterial2").value = 0;
			 }
		 }
	  function material3check(){
			 if(document.getElementById("material3").checked){
				 document.getElementById("hidmaterial3").value = 1;
			 }
			 else{
				 document.getElementById("hidmaterial3").value = 0;
			 }
		 }
	  function hardwr1check(){
			 if(document.getElementById("hardwr1").checked){
				 document.getElementById("hidhardwr1").value = 1;
			 }
			 else{
				 document.getElementById("hidhardwr1").value = 0;
			 }
		 }
	  function hardwr2check(){
			 if(document.getElementById("hardwr2").checked){
				 document.getElementById("hidhardwr2").value = 1;
			 }
			 else{
				 document.getElementById("hidhardwr2").value = 0;
			 }
		 }
	  function lightcheck(){
			 if(document.getElementById("light").checked){
				 document.getElementById("hidlight").value = 1;
			 }
			 else{
				 document.getElementById("hidlight").value = 0;
			 }
		 }
	  function drawer1check(){
			 if(document.getElementById("drawer1").checked){
				 document.getElementById("hiddrawer1").value = 1;
			 }
			 else{
				 document.getElementById("hiddrawer1").value = 0;
			 }
		 }
	  function drawer2check(){
			 if(document.getElementById("drawer2").checked){
				 document.getElementById("hiddrawer2").value = 1;
			 }
			 else{
				 document.getElementById("hiddrawer2").value = 0;
			 }
		 }
	  function repcheck(){
			 if(document.getElementById("rep").checked){
				 document.getElementById("hidrep").value = 1;
			 }
			 else{
				 document.getElementById("hidrep").value = 0;
			 }
			 if(document.getElementById("norep").checked){
				 document.getElementById("hidnorep").value = 1;
			 }
			 else{
				 document.getElementById("hidnorep").value = 0;
			 }
		 }
	  function bboard1check(){
			 if(document.getElementById("bboard1").checked){
				 document.getElementById("hidbboard1").value = 1;
			 }
			 else{
				 document.getElementById("hidbboard1").value = 0;
			 }
			 if(document.getElementById("bboard2").checked){
				 document.getElementById("hidbboard2").value = 1;
			 }
			 else{
				 document.getElementById("hidbboard2").value = 0;
			 }
		 }
	  function bsboard1check(){
			 if(document.getElementById("bsboard1").checked){
				 document.getElementById("hidbsboard1").value = 1;
			 }
			 else{
				 document.getElementById("hidbsboard1").value = 0;
			 }
			 if(document.getElementById("bsboard2").checked){
				 document.getElementById("hidbsboard2").value = 1;
			 }
			 else{
				 document.getElementById("hidbsboard2").value = 0;
			 }
		 }
	  function layout1check(){
			 if(document.getElementById("layout1").checked){
				 document.getElementById("hidlayout1").value = 1;
			 }
			 else{
				 document.getElementById("hidlayout1").value = 0;
			 }
			 if(document.getElementById("layout2").checked){
				 document.getElementById("hidlayout2").value = 1;
			 }
			 else{
				 document.getElementById("hidlayout2").value = 0;
			 }
		 }
	  
	   function getresetting(){
	    	var rdocno=document.getElementById("hiddocno").value;
	    	//alert("rdocno"+rdocno);
	    	var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var intro1  = items[0];
					var intro2 = items[1];
					var intro3 = items[2];
					var intro4 = items[3];
					var rep = items[4];
					var norep = items[5];
					var numofitem = items[6];
					var shape1 = items[7];
					var shape2  = items[8];
					var shape3 = items[9];
					var shape4 = items[10];
					var dtype1 = items[11];
					var dtype2 = items[12];
					var dtype3 = items[13];
					var material1 = items[14];
					var material2  = items[15];
					var material3 = items[16];
					var woodsel1 = items[17];
					var woodsel2 = items[18];
					var woodsel3 = items[19];
					var hardwr1 = items[20];
					var hardwr2 = items[21];
					var light = items[22];
					var ascode  = items[23];
					var drawer1 = items[24];
					var drawer2 = items[25];
					var bboard1 = items[26];
					var bboard2 = items[27];
					var bsboard1 = items[28];
					var bsboard2 = items[29];
					var layout1 = items[30];
					var layout2  = items[31];
					var cbank  = items[32];
					var check = items[33];
				   //alert("check======"+items[20]);
					if(check==1){
						document.getElementById("numofitem").value = numofitem;
						document.getElementById("ascode").value = ascode;
						document.getElementById("woodsel1").value = woodsel1;
						document.getElementById("woodsel2").value = woodsel2;
						document.getElementById("woodsel3").value = woodsel3;
						
						document.getElementById("hidintro1").value = intro1;
						document.getElementById("hidintro2").value = intro2;
						document.getElementById("hidintro3").value = intro3;
						document.getElementById("hidintro4").value = intro4;
						document.getElementById("hidshape1").value = shape1;
						document.getElementById("hidshape2").value = shape2;
						document.getElementById("hidshape3").value = shape3;
						document.getElementById("hidshape4").value = shape4;
						document.getElementById("hiddtype1").value = dtype1;
						document.getElementById("hiddtype2").value = dtype2;
						document.getElementById("hiddtype3").value = dtype3;
						document.getElementById("hidmaterial1").value = material1;
						document.getElementById("hidmaterial2").value = material2;
						document.getElementById("hidmaterial3").value = material3;
						document.getElementById("hiddrawer1").value = drawer1;
						document.getElementById("hiddrawer2").value = drawer2;
						document.getElementById("hidrep").value = rep;
						document.getElementById("hidnorep").value = norep;
						document.getElementById("hidhardwr1").value = hardwr1;
						document.getElementById("hidhardwr2").value = hardwr2;
						document.getElementById("hidlight").value = light;
						document.getElementById("hidbboard1").value = bboard1;
						document.getElementById("hidbboard2").value = bboard2;
						document.getElementById("hidbsboard1").value = bsboard1;
						document.getElementById("hidbsboard2").value = bsboard2;
						document.getElementById("hidlayout1").value = layout1;
						document.getElementById("hidlayout2").value = layout2;
						document.getElementById("cbank").value = cbank;
						
						if(document.getElementById("hidhardwr1").value ==1){
							document.getElementById("hardwr1").checked=true;	
							}
							if(document.getElementById("hidhardwr2").value ==1){
								document.getElementById("hardwr2").checked=true;	
						    }
						if(document.getElementById("hidintro1").value ==1){
						document.getElementById("intro1").checked=true;	
						}
						if(document.getElementById("hidintro2").value ==1){
							document.getElementById("intro2").checked=true;	
					    }
						if(document.getElementById("hidintro3").value ==1){
							document.getElementById("intro3").checked=true;	
						}
					    if(document.getElementById("hidintro4").value ==1){
								document.getElementById("intro4").checked=true;	
						}
						if(document.getElementById("hidshape1").value ==1){
								document.getElementById("shape1").checked=true;	
					    }
						if(document.getElementById("hidshape2").value ==1){
							document.getElementById("shape2").checked=true;	
				       }	
						if(document.getElementById("hidshape3").value ==1){
							document.getElementById("shape3").checked=true;	
				       }			
						if(document.getElementById("hidshape4").value ==1){
							document.getElementById("shape4").checked=true;	
				       }
						if(document.getElementById("hiddtype1").value ==1){
							document.getElementById("dtype1").checked=true;	
				       }
						if(document.getElementById("hiddtype2").value ==1){
							document.getElementById("dtype2").checked=true;	
				       }
						if(document.getElementById("hiddtype3").value ==1){
							document.getElementById("dtype3").checked=true;	
				       }
						if(document.getElementById("hidmaterial1").value ==1){
							document.getElementById("material1").checked=true;	
				       }
						if(document.getElementById("hidmaterial2").value ==1){
							document.getElementById("material2").checked=true;	
				       }
						if(document.getElementById("hidmaterial3").value ==1){
							document.getElementById("material3").checked=true;	
				       }
						if(document.getElementById("hiddrawer1").value ==1){
							document.getElementById("drawer1").checked=true;	
				       }
						if(document.getElementById("hiddrawer2").value ==1){
							document.getElementById("drawer2").checked=true;	
				       }
						if(document.getElementById("hidrep").value ==1){
							document.getElementById("rep").checked=true;	
				       }
						if(document.getElementById("hidnorep").value ==1){
							document.getElementById("norep").checked=true;	
				       }
						if(document.getElementById("hidlight").value ==1){
							document.getElementById("light").checked=true;	
				       }
						if(document.getElementById("hidbboard1").value ==1){
							document.getElementById("bboard1").checked=true;	
				       }
						if(document.getElementById("hidbboard2").value ==1){
							document.getElementById("bboard2").checked=true;	
				       }
						if(document.getElementById("hidbsboard1").value ==1){
							document.getElementById("bsboard1").checked=true;	
				       }
						if(document.getElementById("hidbsboard2").value ==1){
							document.getElementById("bsboard2").checked=true;	
				       }
						if(document.getElementById("hidlayout1").value ==1){
							document.getElementById("layout1").checked=true;	
				       }
						if(document.getElementById("hidlayout2").value ==1){
							document.getElementById("layout2").checked=true;	
				       }
					}
				} else {}
			}
			x.open("GET","getdatacq.jsp?rdocno="+rdocno, true);
			x.send();
		}
	   function checkdoc(){
		  var docno= document.getElementById("hiddocno").value;  
		  if(docno!=="0"){
			  funedit();   
		  }   
	   }
	   function funedit(){ 
			if(document.getElementById("btnsave").value=='Save'){
				funsave();     
			} 
			$('#frmcquesfrn input').prop('readonly', false );
		    $('#frmcquesfrn input').prop('disabled', false );
			$("#btnsave").attr('value', 'Save');           	   
		}
		function funsave(){    
			document.getElementById("frmcquesfrn").submit();     
		}
		function disable(){
			    $('#frmcquesfrn input').prop('readonly', true );
			    $('#frmcquesfrn input').prop('disabled', true );
			    $('#btnsave').attr('disabled', false );   
  		}
		
  </script>    
</head>   
<body onload="setValues();getresetting();disable();">  
<form id="frmcquesfrn" action="saveCQfrn" >  
<div  class='hidden-scrollbar'> 
<h2 style="text-align:center;"><U><b>CLOSET DESIGN QUESTIONNAIRE</b></U></h2>   
<table width="100%">

<tr>
<td><b><label>Customer:</label></b><input id="customer"  name="customer"  value='<s:property value="customer"/>'/></td>
<td colspan="1"><b><label>Customer bank info:</label></b><input type="text"   name="cbank" id="cbank"    value='<s:property value="cbank"/>'/></td>
<td colspan="1"><b><label>Enquiry No :</label></b><input type="text" id="cusid" name="cusid" style="height: 16px; width:30%" value='<s:property value="cusid"/>'/></td>
<td>&nbsp;</td>
<td><input type="button" id="btnsave"  class="myButton" value="Edit" onclick="checkdoc();"/></td>
</tr>   
<tr><td><label>How did you know about QAF  ?</label></td></tr>
<tr>
<td><label>Walk in</label><input type="checkbox" name="intro1" id="intro1" onchange="intro1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
 <input type="hidden" id="hidintro1" name="hidintro1" value='<s:property value="hidintro1"/>'/></td>
<td><label>Through Friends</label><input type="checkbox" name="intro2" id="intro2" onchange="intro2check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidintro2" name="hidintro2" value='<s:property value="hidintro2"/>'/></td>
<td><label>Through Social Media</label><input type="checkbox" name="intro3" id="intro3" onchange="intro3check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidintro3" name="hidintro3" value='<s:property value="hidintro3"/>'/></td>
<td><label>Through Website</label><input type="checkbox" name="intro4" id="intro4" onchange="intro4check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidintro4" name="hidintro4" value='<s:property value="hidintro4"/>'/></td>
</tr>
</table>
<h3><B>CLOSET</B></h3>
<table width="100%">
<tr><td><label>Do you have existing closets you want to replace:</label></td>
<td><label>Yes</label><input type="radio" name="rep" id="rep" onchange="repcheck();" value='<s:property value="rep"/>'/>
<input type="hidden" id="hidrep" name="hidrep" value='<s:property value="hidrep"/>'/></td>
<td><label>No</label><input type="radio" name="rep" id="norep" onchange="repcheck();" value='<s:property value="rep"/>'/>
<input type="hidden" id="hidnorep" name="hidnorep" value='<s:property value="hidnorep"/>'/></td>
</tr>
<tr>
<td><label>How many closets do you want:</label></td>
<td><input type="text" name="numofitem" id="numofitem" value='<s:property value="numofitem"/>'></td>
</tr>
<tr>
<td><label>Closet Shape:</label></td> 
</tr>
<tr>
<td><input type="checkbox" name="shape1" id="shape1" onchange="shape1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/><label>Straight</label>
<input type="hidden" id="hidshape1" name="hidshape1" value='<s:property value="hidshape1"/>'/></td>
<td><input type="checkbox" name="shape2" id="shape2" onchange="shape2check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/><label>L-shape</label>
<input type="hidden" id="hidshape2" name="hidshape2" value='<s:property value="hidshape2"/>'/></td>
<td><input type="checkbox" name="shape3" id="shape3" onchange="shape3check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/><label>U-shape</label>
<input type="hidden" id="hidshape3" name="hidshape3" value='<s:property value="hidshape3"/>'/></td>
<td><input type="checkbox" name="shape4" id="shape4" onchange="shape4check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/><label>Parallel</label>
<input type="hidden" id="hidshape4" name="hidshape4" value='<s:property value="hidshape4"/>'/></td>
</tr>
<tr>
<td>Door Type of Closet:</td>
<td><input type="checkbox" name="dtype1" id="dtype1" onchange="dtype1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/><label>Hinged Door</label>
<input type="hidden" id="hiddtype1" name="hiddtype1" value='<s:property value="hiddtype1"/>'/></td>
<td><input type="checkbox" name="dtype2" id="dtype2" onchange="dtype2check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/><label>Sliding Door</label>
<input type="hidden" id="hiddtype2" name="hiddtype2" value='<s:property value="hiddtype2"/>'/></td>
<td><input type="checkbox" name="dtype3" id="dtype3" onchange="dtype3check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/><label>Walk In</label>
<input type="hidden" id="hiddtype3" name="hiddtype3" value='<s:property value="hiddtype3"/>'/></td>
</tr>

<tr>
<td><label>What material do you want in sliding/hinged door:</label></td>
</tr>
<tr>
<td><label>Wood</label><input type="checkbox" name="material1" id="material1" onchange="material1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidmaterial1" name="hidmaterial1" value='<s:property value="hidmaterial1"/>'/></td>
<td><label>Mirror</label><input type="checkbox" name="material2" id="material2" onchange="material2check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidmaterial2" name="hidmaterial2" value='<s:property value="hidmaterial2"/>'/></td>
<td><label>Glass</label><input type="checkbox" name="material3" id="material3" onchange="material3check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidmaterial3" name="hidmaterial3" value='<s:property value="hidmaterial3"/>'/></td>
</tr>
<tr>
<td><label>Wood Selection: Reference</label></td>
<td><input type="text" name="woodsel1" id="woodsel1" value='<s:property value="woodsel1"/>'></td>
<td><input type="text" name="woodsel2" id="woodsel2" value='<s:property value="woodsel2"/>'></td>
<td><input type="text" name="woodsel3" id="woodsel3" value='<s:property value="woodsel3"/>'></td>
</tr>
<tr>
<td><label>Hardware:</label></td>
<td><input type="checkbox" name="hardwr1" id="hardwr1" onchange="hardwr1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/><label>Handle</label>
<input type="hidden" id="hidhardwr1" name="hidhardwr1" value='<s:property value="hidhardwr1"/>'/></td>
<td><input type="checkbox" name="hardwr2" id="hardwr2" onchange="hardwr2check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/><label>Knobs</label>
<input type="hidden" id="hidhardwr2" name="hidhardwr2" value='<s:property value="hidhardwr2"/>'/></td>
</tr>
<tr>
<td><label>Light:</label></td>
<td><input type="checkbox" name="light" id="light" onchange="lightcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/><label>Spot Light</label>
<input type="hidden" id="hidlight" name="hidlight" value='<s:property value="hidlight"/>'/></td>
</tr>
<tr>
<td><label>Accessories Code:</label></td>
<td><input type="text" name="ascode" id="ascode" value='<s:property value="ascode"/>'></td>
</tr>
<tr>
<td><label>What type of drawer you prefer:</label></td>
<td><label>Soft Closing</label><input type="checkbox" name="drawer1" id="drawer1" onchange="drawer1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hiddrawer1" name="hiddrawer1" value='<s:property value="hiddrawer1"/>'/></td>
<td><label>Push to Open</label><input type="checkbox" name="drawer2" id="drawer2" onchange="drawer2check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hiddrawer2" name="hiddrawer2" value='<s:property value="hiddrawer2"/>'/></td>
</tr>
<tr>
<td><label>Back board required:</label></td>
<td><label>Yes</label><input type="radio" name="bboard1" id="bboard1" onchange="bboard1check();" value='<s:property value="bboard1"/>'/>
<input type="hidden" id="hidbboard1" name="hidbboard1" value='<s:property value="hidbboard1"/>'/></td>
<td><label>No</label><input type="radio" name="bboard1" id="bboard2" onchange="bboard1check();" value='<s:property value="bboard2"/>'/>
<input type="hidden" id="hidbboard2" name="hidbboard2" value='<s:property value="hidbboard2"/>'/></td>
</tr>
<tr>
<td><label>Base board required:</label></td>
<td><label>Yes</label><input type="radio" name="bsboard1" id="bsboard1" onchange="bsboard1check();" value='<s:property value="bsboard1"/>'/>
<input type="hidden" id="hidbsboard1" name="hidbsboard1" value='<s:property value="hidbsboard1"/>'/></td>
<td><label>No</label><input type="radio" name="bsboard1" id="bsboard2" onchange="bsboard1check();" value='<s:property value="bsboard2"/>'/>
<input type="hidden" id="hidbsboard2" name="hidbsboard2" value='<s:property value="hidbsboard2"/>'/></td>
</tr>
<tr>
<td><label>Layout plan attached:</label></td>
<td><label>Yes</label><input type="radio" name="layout1" id="layout1" onchange="layout1check();" value='<s:property value="layout1"/>'>
<input type="hidden" id="hidlayout1" name="hidlayout1" value='<s:property value="hidlayout1"/>'/></td>
<td><label>No</label><input type="radio" name="layout1" id="layout2" onchange="layout1check();" value='<s:property value="layout2"/>'/>
<input type="hidden" id="hidlayout2" name="hidlayout2" value='<s:property value="hidlayout2"/>'/></td>
</tr>
	<tr><td colspan="2">&nbsp;</td></tr>
<tr>
<td><label><b>Signature:</b>Sales Person</label></td>
<td><input type="text" name="spsign" id="spsign" ></td>
<td><label>Date:</label></td> 
<td><input type="text" name="sdate" id="sdate" ><td>
</tr>
<tr>
<td><label>Assigned to Designer:Signature</label></td>
<td><input type="text" name="dsign" id="dsign" ></td>
<td><label>Date:</label></td>
<td><input type="text" name="sdate" id="sdate" ><td>
</tr>
<tr>
<td><label>Expected Completion Date:</label></td>
<td><input type="text" name="cdate" id="cdate" ><td>
</tr>	
</table>
<input type="hidden" name="hiddocno" id="hiddocno" value='<s:property value="hiddocno"/>'/>
<input type="hidden" name="hidqtype" id="hidqtype" value='<s:property value="hidqtype"/>'/>
</div>
</form>
</body>
</html>