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
 function setValues() {
	 if(document.getElementById("hiddocno").value==""){
		 document.getElementById("hiddocno").value=docno;
	 }
	 //document.getElementById("hiddocno").value=docno;
	  document.getElementById("hidqtype").value=qtype;
	  document.getElementById("customer").value=customer;
	  document.getElementById("cusid").value=cusid;
 }
 function intro11check(){
	 if(document.getElementById("intro11").checked){
		 document.getElementById("hidintro11").value = 1;
	 }
	 else{
		 document.getElementById("hidintro11").value = 0;
	 }
 } 
  function intro22check(){
		 if(document.getElementById("intro22").checked){
			 document.getElementById("hidintro22").value = 1;
		 }
		 else{
			 document.getElementById("hidintro22").value = 0;
		 }
	 }
  function intro33check(){
		 if(document.getElementById("intro33").checked){
			 document.getElementById("hidintro33").value = 1;
		 }
		 else{
			 document.getElementById("hidintro33").value = 0;
		 }
	 } 
	  function intro44check(){
			 if(document.getElementById("intro44").checked){
				 document.getElementById("hidintro44").value = 1;
			 }
			 else{
				 document.getElementById("hidintro44").value = 0;
			 }
		 }
	  function shape11check(){
			 if(document.getElementById("shape11").checked){
				 document.getElementById("hidshape11").value = 1;
			 }
			 else{
				 document.getElementById("hidshape11").value = 0;
			 }
		 }
	  function shape22check(){
			 if(document.getElementById("shape22").checked){
				 document.getElementById("hidshape22").value = 1;
			 }
			 else{
				 document.getElementById("hidshape22").value = 0;
			 }
		 }
	  function shape33check(){
			 if(document.getElementById("shape33").checked){
				 document.getElementById("hidshape33").value = 1;
			 }
			 else{
				 document.getElementById("hidshape33").value = 0;
			 }
		 }
	  function shape44check(){
			 if(document.getElementById("shape44").checked){
				 document.getElementById("hidshape44").value = 1;
			 }
			 else{
				 document.getElementById("hidshape44").value = 0;
			 }
		 }
	  function ctype1check(){
			 if(document.getElementById("ctype1").checked){
				 document.getElementById("hidctype1").value = 1;
			 }
			 else{
				 document.getElementById("hidctype1").value = 0;
			 }
		 }
	  function ctype2check(){
			 if(document.getElementById("ctype2").checked){
				 document.getElementById("hidctype2").value = 1;
			 }
			 else{
				 document.getElementById("hidctype2").value = 0;
			 }
		 }
	  function ctype3check(){
			 if(document.getElementById("ctype3").checked){
				 document.getElementById("hidctype3").value = 1;
			 }
			 else{
				 document.getElementById("hidctype3").value = 0;
			 }
		 }
	  function material11check(){
			 if(document.getElementById("material11").checked){
				 document.getElementById("hidmaterial11").value = 1;
			 }
			 else{
				 document.getElementById("hidmaterial11").value = 0;
			 }
		 }
	  function material22check(){
			 if(document.getElementById("material22").checked){
				 document.getElementById("hidmaterial22").value = 1;
			 }
			 else{
				 document.getElementById("hidmaterial22").value = 0;
			 }
		 }
	  function drawer11check(){
			 if(document.getElementById("drawer11").checked){
				 document.getElementById("hiddrawer11").value = 1;
			 }
			 else{
				 document.getElementById("hiddrawer11").value = 0;
			 }
		 }
	  function drawer22check(){
			 if(document.getElementById("drawer22").checked){
				 document.getElementById("hiddrawer22").value = 1;
			 }
			 else{
				 document.getElementById("hiddrawer22").value = 0;
			 }
		 }
	  function drawer33check(){
			 if(document.getElementById("drawer33").checked){
				 document.getElementById("hiddrawer33").value = 1;
			 }
			 else{
				 document.getElementById("hiddrawer33").value = 0;
			 }
		 }
	  function kstyle1check(){
			 if(document.getElementById("kstyle1").checked){
				 document.getElementById("hidkstyle1").value = 1;
			 }
			 else{
				 document.getElementById("hidkstyle1").value = 0;
			 }
		 }
	  function kstyle2check(){
			 if(document.getElementById("kstyle2").checked){
				 document.getElementById("hidkstyle2").value = 1;
			 }
			 else{
				 document.getElementById("hidkstyle2").value = 0;
			 }
		 }
	  function interest1check(){
			 if(document.getElementById("interest1").checked){
				 document.getElementById("hidinterest1").value = 1;
			 }
			 else{
				 document.getElementById("hidinterest1").value = 0;
			 }
		 } 
		  function interest2check(){
				 if(document.getElementById("interest2").checked){
					 document.getElementById("hidinterest2").value = 1;
				 }
				 else{
					 document.getElementById("hidinterest2").value = 0;
				 }
			 }
		  function interest3check(){
				 if(document.getElementById("interest3").checked){
					 document.getElementById("hidinterest3").value = 1;
				 }
				 else{
					 document.getElementById("hidinterest3").value = 0;
				 }
			 } 
			  function interest4check(){
					 if(document.getElementById("interest4").checked){
						 document.getElementById("hidinterest4").value = 1;
					 }
					 else{
						 document.getElementById("hidinterest4").value = 0;
					 }
				 }
			  function appl1check(){
					 if(document.getElementById("appl1").checked){
						 document.getElementById("hidappl1").value = 1;
					 }
					 else{
						 document.getElementById("hidappl1").value = 0;
					 }
				 }
			  function appl2check(){
					 if(document.getElementById("appl2").checked){
						 document.getElementById("hidappl2").value = 1;
					 }
					 else{
						 document.getElementById("hidappl2").value = 0;
					 }
				 }
			  function appl3check(){
					 if(document.getElementById("appl3").checked){
						 document.getElementById("hidappl3").value = 1;
					 }
					 else{
						 document.getElementById("hidappl3").value = 0;
					 }
				 }
			  function appl4check(){
					 if(document.getElementById("appl4").checked){
						 document.getElementById("hidappl4").value = 1;
					 }
					 else{
						 document.getElementById("hidappl4").value = 0;
					 }
				 }
			  function appl5check(){
					 if(document.getElementById("appl5").checked){
						 document.getElementById("hidappl5").value = 1;
					 }
					 else{
						 document.getElementById("hidappl5").value = 0;
					 }
				 }
			  function appl6check(){
					 if(document.getElementById("appl6").checked){
						 document.getElementById("hidappl6").value = 1;
					 }
					 else{
						 document.getElementById("hidappl6").value = 0;
					 }
				 }
			  function appl7check(){
					 if(document.getElementById("appl7").checked){
						 document.getElementById("hidappl7").value = 1;
					 }
					 else{
						 document.getElementById("hidappl7").value = 0;
					 }
				 }
			  function appl8check(){
					 if(document.getElementById("appl8").checked){
						 document.getElementById("hidappl8").value = 1;
					 }
					 else{
						 document.getElementById("hidappl8").value = 0;
					 }
				 }
			  function appl9check(){
					 if(document.getElementById("appl9").checked){
						 document.getElementById("hidappl9").value = 1;
					 }
					 else{
						 document.getElementById("hidappl9").value = 0;
					 }
				 }
			  function appl10check(){
					 if(document.getElementById("appl10").checked){
						 document.getElementById("hidappl10").value = 1;
					 }
					 else{
						 document.getElementById("hidappl10").value = 0;
					 }
				 }
			  function counter1check(){
					 if(document.getElementById("counter1").checked){
						 document.getElementById("hidcounter1").value = 1;
					 }
					 else{
						 document.getElementById("hidcounter1").value = 0;
					 }
				 } 
				  function counter2check(){
						 if(document.getElementById("counter2").checked){
							 document.getElementById("hidcounter2").value = 1;
						 }
						 else{
							 document.getElementById("hidcounter2").value = 0;
						 }
					 }
				  function counter3check(){
						 if(document.getElementById("counter3").checked){
							 document.getElementById("hidcounter3").value = 1;
						 }
						 else{
							 document.getElementById("hidcounter3").value = 0;
						 }
					 }
				  function layout11check(){
						 if(document.getElementById("layout11").checked){
							 document.getElementById("hidlayout11").value = 1;
						 }
						 else{
							 document.getElementById("hidlayout11").value = 0;
						 }
						 if(document.getElementById("layout22").checked){
							 document.getElementById("hidlayout22").value = 1;
						 }
						 else{
							 document.getElementById("hidlayout22").value = 0;
						 }
					 }

				  function existcheck(){
						 if(document.getElementById("exist").checked){
							 document.getElementById("hidexist1").value = 1;
						 }
						 else{
							 document.getElementById("hidexist1").value = 0;
						 }
						 if(document.getElementById("notexist").checked){
							 document.getElementById("hidexist2").value = 1;
						 }
						 else{
							 document.getElementById("hidexist2").value = 0;
						 }
					 }  

				  function sp1check(){
						 if(document.getElementById("sp1").checked){
							 document.getElementById("hidsp1").value = 1;
						 }
						 else{
							 document.getElementById("hidsp1").value = 0;
						 }
						 if(document.getElementById("sp2").checked){
							 document.getElementById("hidsp2").value = 1;
						 }
						 else{
							 document.getElementById("hidsp2").value = 0;
						 }
					 }

				  function ls1check(){
						 if(document.getElementById("ls1").checked){
							 document.getElementById("hidls1").value = 1;
						 }
						 else{
							 document.getElementById("hidls1").value = 0;
						 }
						 if(document.getElementById("ls2").checked){
							 document.getElementById("hidls2").value = 1;
						 }
						 else{
							 document.getElementById("hidls2").value = 0;
						 }
					 }

				  function cor1check(){
						 if(document.getElementById("cor1").checked){
							 document.getElementById("hidcor1").value = 1;
						 }
						 else{
							 document.getElementById("hidcor1").value = 0;
						 }
						 if(document.getElementById("cor2").checked){
							 document.getElementById("hidcor2").value = 1;
						 }
						 else{
							 document.getElementById("hidcor2").value = 0;
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
								var exist1 = items[4];
								var exist2 = items[5];
								var numofitem = items[6];
								var shape1 = items[7];
								var shape2  = items[8];
								var shape3 = items[9];
								var shape4 = items[10];
								var ctype1 = items[11];
								var ctype2 = items[12];
								var ctype3 = items[13];
								var other = items[14];
								var material1 = items[15];
								var material2  = items[16];
								var drawer1 = items[17];
								var drawer2 = items[18];
								var drawer3 = items[19];
								var sp1 = items[20];
								var sp2 = items[21];
								var ls1 = items[22];
								var ls2 = items[23];
								var cor1  = items[24];
								var cor2 = items[25];
								var kstyle1 = items[26];
								var kstyle2 = items[27];
								var interest1 = items[28];
								var interest2 = items[29];
								var interest3 = items[30];
								var interest4 = items[31];
								var listitem  = items[32];
								var appl1 = items[33];
								var appl2 = items[34];
								var appl3 = items[35];
								var appl4 = items[36];
								var appl5 = items[37];
								var appl6 = items[38];
								var appl7 = items[39];
								var appl8  = items[40];
								var appl9 = items[41];
								var appl10 = items[42];
								var counter1 = items[43];
								var counter2 = items[44];
								var counter3 = items[45];
								var fwtw = items[46];
								var fwth = items[47];
								var fwtd = items[48];
								var dwash = items[49];
								var cooks  = items[50];
								var cookw = items[51];
								var mwaves = items[52];
								var mwavew = items[53];
								var mwaveh = items[54];
								var mwaveftr = items[55];
								var mwavedet = items[56];
								var sinks = items[57];
								var sinkw = items[58];
								var brand = items[59];
								var applncs = items[60];
								var applncss = items[61];
								var layout1 = items[62];
								var layout2 = items[63];
								var bank = items[64];
								var check = items[65];
								
									//alert("check======"+items[4]);
									
								if(check==1){
									document.getElementById("fwtw").value = fwtw;
									document.getElementById("fwth").value = fwth;
									document.getElementById("fwtd").value = fwtd;
									document.getElementById("dwash").value = dwash;
									document.getElementById("cooks").value = cooks;
									document.getElementById("cookw").value = cookw;
									document.getElementById("mwaves").value = mwaves;
									document.getElementById("mwavew").value = mwavew;
									document.getElementById("mwaveh").value = mwaveh;
									document.getElementById("mwaveftr").value = mwaveftr;
									document.getElementById("mwavedet").value = mwavedet;
									document.getElementById("sinks").value = sinks;
									document.getElementById("sinkw").value = sinkw;
									document.getElementById("brand").value = brand;
									document.getElementById("applncs").value = applncs;
									document.getElementById("applncss").value = applncss;
									document.getElementById("numofitem2").value = numofitem;
									document.getElementById("other").value = other;
									document.getElementById("listitem").value = listitem;
									document.getElementById("hidintro11").value = intro1;
									document.getElementById("hidintro22").value = intro2;
									document.getElementById("hidintro33").value = intro3;
									document.getElementById("hidintro44").value = intro4;
									document.getElementById("hidshape11").value = shape1;
									document.getElementById("hidshape22").value = shape2;
									document.getElementById("hidshape33").value = shape3;
									document.getElementById("hidshape44").value = shape4;
									document.getElementById("hidctype1").value = ctype1;
									document.getElementById("hidctype2").value = ctype2;
									document.getElementById("hidctype3").value = ctype3;
									document.getElementById("hidmaterial11").value = material1;
									document.getElementById("hidmaterial22").value = material2;
									document.getElementById("hiddrawer11").value = drawer1;
									document.getElementById("hiddrawer22").value = drawer2;
									document.getElementById("hiddrawer33").value = drawer3;
									document.getElementById("hidkstyle1").value = kstyle1;
									document.getElementById("hidkstyle2").value = kstyle2;
									document.getElementById("hidinterest1").value = interest1;
									document.getElementById("hidinterest2").value = interest2;
									document.getElementById("hidinterest3").value = interest3;
									document.getElementById("hidinterest4").value = interest4;
									document.getElementById("hidappl1").value = appl1;
									document.getElementById("hidappl2").value = appl2;
									document.getElementById("hidappl3").value = appl3;
									document.getElementById("hidappl4").value = appl4;
									document.getElementById("hidappl5").value = appl5;
									document.getElementById("hidappl6").value = appl6;
									document.getElementById("hidappl7").value = appl7;
									document.getElementById("hidappl8").value = appl8;
									document.getElementById("hidappl9").value = appl9;
									document.getElementById("hidappl10").value = appl10;
									document.getElementById("hidcounter1").value = counter1;
									document.getElementById("hidcounter2").value = counter2;
									document.getElementById("hidcounter3").value = counter3;
									document.getElementById("hidsp1").value = sp1;
									document.getElementById("hidsp2").value = sp2;
									document.getElementById("hidls1").value = ls1;
									document.getElementById("hidls2").value = ls2;
									document.getElementById("hidcor1").value = cor1;
									document.getElementById("hidcor2").value = cor2;
									document.getElementById("hidexist1").value = exist1;
									document.getElementById("hidexist2").value = exist2;
									document.getElementById("hidlayout11").value = layout1;
									document.getElementById("hidlayout22").value = layout2;
									document.getElementById("bank").value = bank;
									
									if(document.getElementById("hidintro11").value ==1){
									document.getElementById("intro11").checked=true;	
									}
									if(document.getElementById("hidintro22").value ==1){
										document.getElementById("intro22").checked=true;	
								    }
									if(document.getElementById("hidintro33").value ==1){
										document.getElementById("intro33").checked=true;	
									}
								    if(document.getElementById("hidintro44").value ==1){
											document.getElementById("intro44").checked=true;	
									}
									if(document.getElementById("hidshape11").value ==1){
											document.getElementById("shape11").checked=true;	
								    }
									if(document.getElementById("hidshape22").value ==1){
										document.getElementById("shape22").checked=true;	
							       }	
									if(document.getElementById("hidshape33").value ==1){
										document.getElementById("shape33").checked=true;	
							       }			
									if(document.getElementById("hidshape44").value ==1){
										document.getElementById("shape44").checked=true;	
							       }
									if(document.getElementById("hidctype1").value ==1){
										document.getElementById("ctype1").checked=true;	
							       }
									if(document.getElementById("hidctype2").value ==1){
										document.getElementById("ctype2").checked=true;	
							       }
									if(document.getElementById("hidctype3").value ==1){
										document.getElementById("ctype3").checked=true;	
							       }
									if(document.getElementById("hidmaterial11").value ==1){
										document.getElementById("material11").checked=true;	
							       }
									if(document.getElementById("hidmaterial22").value ==1){
										document.getElementById("material22").checked=true;	
							       }
									if(document.getElementById("hiddrawer11").value ==1){
										document.getElementById("drawer11").checked=true;	
							       }
									if(document.getElementById("hiddrawer22").value ==1){
										document.getElementById("drawer22").checked=true;	
							       }
									if(document.getElementById("hiddrawer33").value ==1){
										document.getElementById("drawer33").checked=true;	
							       }
									if(document.getElementById("hidkstyle1").value ==1){
										document.getElementById("kstyle1").checked=true;	
							       }
									if(document.getElementById("hidkstyle2").value ==1){
										document.getElementById("kstyle2").checked=true;	
							       }
									if(document.getElementById("hidinterest1").value ==1){
										document.getElementById("interest1").checked=true;	
							       }
									if(document.getElementById("hidinterest2").value ==1){
										document.getElementById("interest2").checked=true;	
							       }
									if(document.getElementById("hidinterest3").value ==1){
										document.getElementById("interest3").checked=true;	
							       }
									if(document.getElementById("hidinterest4").value ==1){
										document.getElementById("interest4").checked=true;	
							       }
									if(document.getElementById("hidappl1").value ==1){
										document.getElementById("appl1").checked=true;	
							       }
									if(document.getElementById("hidappl2").value ==1){
										document.getElementById("appl2").checked=true;	
							       }
									if(document.getElementById("hidappl3").value ==1){
										document.getElementById("appl3").checked=true;	
							       }
									if(document.getElementById("hidappl4").value ==1){
										document.getElementById("appl4").checked=true;	
							       }
									if(document.getElementById("hidappl5").value ==1){
										document.getElementById("appl5").checked=true;	
							       }
									if(document.getElementById("hidappl6").value ==1){
										document.getElementById("appl6").checked=true;	
							       }
									if(document.getElementById("hidappl7").value ==1){
										document.getElementById("appl7").checked=true;	
							       }
									if(document.getElementById("hidappl8").value ==1){
										document.getElementById("appl8").checked=true;	
							       }
									if(document.getElementById("hidappl9").value ==1){
										document.getElementById("appl9").checked=true;	
							       }
									if(document.getElementById("hidappl10").value ==1){
										document.getElementById("appl10").checked=true;	
							       }
									if(document.getElementById("hidcounter1").value ==1){
										document.getElementById("counter1").checked=true;	
							       }
									if(document.getElementById("hidcounter2").value ==1){
										document.getElementById("counter2").checked=true;	
							       }
									if(document.getElementById("hidcounter3").value ==1){
										document.getElementById("counter3").checked=true;	
							       }
									if(document.getElementById("hidsp1").value ==1){
										document.getElementById("sp1").checked=true;	
							       }
									if(document.getElementById("hidsp2").value ==1){
										document.getElementById("sp2").checked=true;	
							       }
									if(document.getElementById("hidls1").value ==1){
										document.getElementById("ls1").checked=true;	
							       }
									if(document.getElementById("hidls2").value ==1){
										document.getElementById("ls2").checked=true;	
							       }
									if(document.getElementById("hidcor1").value ==1){
										document.getElementById("cor1").checked=true;	
							       }
									if(document.getElementById("hidcor2").value ==1){
										document.getElementById("cor2").checked=true;	
							       }
									if(document.getElementById("hidexist1").value ==1){
										document.getElementById("exist").checked=true;	
							       }
									if(document.getElementById("hidexist2").value ==1){
										document.getElementById("notexist").checked=true;	
							       }
									if(document.getElementById("hidlayout11").value ==1){
										document.getElementById("layout11").checked=true;	
							       }
									if(document.getElementById("hidlayout22").value ==1){
										document.getElementById("layout22").checked=true;	
							       }
								}
							} else {}
						}
						x.open("GET","getdata.jsp?rdocno="+rdocno, true);
						x.send();
					}  
				    function checkdoc(){
						  var docno= document.getElementById("hiddocno").value;
					   
						  if(docno!=0){
							  funedit();   
						  }   
					   }
				    function funedit(){ 
						if(document.getElementById("btnsave").value=='Save'){
							funsave();     
						} 
						$('#frmkquesfrn input').prop('readonly', false );
					    $('#frmkquesfrn input').prop('disabled', false );
						$("#btnsave").attr('value', 'Save');           	   
					}
					function funsave(){    
						document.getElementById("frmkquesfrn").submit();     
					}
					function disable(){
						    $('#frmkquesfrn input').prop('readonly', true );
						    $('#frmkquesfrn input').prop('disabled', true );
						    $('#btnsave').attr('disabled', false );   
			  		}
  </script>
</head>
<body onload="setValues();getresetting();disable();">  
<form id="frmkquesfrn" action="saveKQit">
<div  class='hidden-scrollbar'>
<h2 style="text-align:center;"><U><b>KITCHEN DESIGN QUESTIONNAIRE</b></U></h2>
<table width="100%">

<tr>  
<td><b><label>Customer:</label></b><input id="customer"  name="customer"  value='<s:property value="customer"/>'/></td>
<td ><b><label>Customer Bank info:</label></b><input type="text" id="bank"  name="bank" style="height: 14px;width: 50%" value='<s:property value="bank"/>'/></td>
<td colspan="1"><b><label>Enquiry No :</label></b><input type="text" id="cusid" name="cusid" style="height: 16px;" value='<s:property value="cusid"/>'/></td>
<td colspan="1"><input type="button" id="btnsave"  class="myButton" value="Edit" onclick="checkdoc();"/></td>
</tr>
<td>&nbsp;</td>
<tr><td><label>How did you know about QAF ?</label></td></tr>   
<tr>  
 
<td><label>Walk in</label><input type="checkbox" name="intro11" id="intro11" onchange="intro11check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
 <input type="hidden" id="hidintro11" name="hidintro11" value='<s:property value="hidintro11"/>'/></td>
<td><label>Through Friends</label><input type="checkbox" name="intro22" id="intro22" onchange="intro22check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidintro22" name="hidintro22" value='<s:property value="hidintro22"/>'/></td>
<td><label>Through Social Media</label><input type="checkbox" name="intro33" id="intro33" onchange="intro33check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidintro33" name="hidintro33" value='<s:property value="hidintro33"/>'/></td>
<td><label>Through Website</label><input type="checkbox" name="intro44" id="intro44" onchange="intro44check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidintro44" name="hidintro44" value='<s:property value="hidintro44"/>'/></td>
</tr>
</table>  
<h3><B>KITCHEN</B></h3>
<table width="100%">
<tr><td><label>Do you have existing kitchen:</label></td>
<td><label>Yes</label><input type="radio" name="exist" id="exist" onchange="existcheck();" value='<s:property value="rep"/>'/>
<input type="hidden" id="hidexist1" name="hidexist1" value='<s:property value="hidexist1"/>'/></td>
<td><label>No</label><input type="radio" name="exist" id="notexist" onchange="existcheck();" value='<s:property value="rep"/>'/>
<input type="hidden" id="hidexist2" name="hidexist2" value='<s:property value="hidexist2"/>'/></td>
</tr>
<tr>      
<td><label>How many kitchens do you want:</label></td>    
<td><input type="text" name="numofitem2" id="numofitem2" value='<s:property value="numofitem2"/>'></td>
</tr>
<tr>
<td><label>Kitchen Shape:</label></td>
<td><label>Straight</label><input type="checkbox" name="shape11" id="shape11" onchange="shape11check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidshape11" name="hidshape11" value='<s:property value="hidshape11"/>'/></td>
<td><label>L-shape</label><input type="checkbox" name="shape22" id="shape22" onchange="shape22check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidshape22" name="hidshape22" value='<s:property value="hidshape22"/>'/></td>
<td><label>U-shape</label><input type="checkbox" name="shape33" id="shape33" onchange="shape33check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidshape33" name="hidshape33" value='<s:property value="hidshape33"/>'/></td>
<td><label>Parallel</label><input type="checkbox" name="shape44" id="shape44" onchange="shape44check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidshape44" name="hidshape44" value='<s:property value="hidshape44"/>'/></td>
</tr>
<tr>
<td><label>Type of cabinets you need in base:</label></td>
<td><label>More Drawers</label><input type="checkbox" name="ctype1" id="ctype1" onchange="ctype1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidctype1" name="hidctype1" value='<s:property value="hidctype1"/>'/></td>
<td><label>More Shutters</label><input type="checkbox" name="ctype2" id="ctype2" onchange="ctype2check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidctype2" name="hidctype2" value='<s:property value="hidctype2"/>'/></td>
<td><label>More Shelf</label><input type="checkbox" name="ctype3" id="ctype3" onchange="ctype3check();"onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidctype3" name="hidctype3" value='<s:property value="hidctype3"/>'/></td>
</tr>
<tr>
<td><label>Others:</label></td>
<td><input type="text" name="other" id="other" value='<s:property value="other"/>'></td>
</tr>
<tr>
<td><label>What material you want in carcass:</label></td>
<td><label>Glass</label><input type="checkbox" name="material11" id="material11" onchange="material11check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidmaterial11" name="hidmaterial11" value='<s:property value="hidmaterial11"/>'/></td>
<td><label>Wood</label><input type="checkbox" name="material22" id="material22" onchange="material22check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidmaterial22" name="hidmaterial22" value='<s:property value="hidmaterial22"/>'/></td>
</tr>
<tr>
<td><label>What type of drawer you prefer:</label></td>
<td><label>Soft Closing</label><input type="checkbox" name="drawer11" id="drawer11" onchange="drawer11check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hiddrawer11" name="hiddrawer11" value='<s:property value="hiddrawer11"/>'/></td>
<td><label>Push to Open</label><input type="checkbox" name="drawer22" id="drawer22" onchange="drawer22check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hiddrawer22" name="hiddrawer22" value='<s:property value="hiddrawer22"/>'/></td>
<td><label>Normal</label><input type="checkbox" name="drawer33" id="drawer33" onchange="drawer33check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hiddrawer33" name="hiddrawer33" value='<s:property value="hiddrawer33"/>'/></td>
</tr>
<tr>
<td><label>Skirting/Plinth required:</label></td>
<td><label>Yes</label><input type="radio" name="sp" id="sp1" onchange="sp1check();" value='<s:property value="sp"/>'/>
<input type="hidden" id="hidsp1" name="hidsp1" value='<s:property value="hidsp1"/>'/></td>
<td><label>No</label><input type="radio" name="sp" id="sp2" onchange="sp1check();" value='<s:property value="sp"/>'/>
<input type="hidden" id="hidsp2" name="hidsp2" value='<s:property value="hidsp2"/>'/></td>
</tr> 
<tr>
<td><label>Light strip required:</label></td>
<td><label>Yes</label><input type="radio" name="ls" id="ls1" onchange="ls1check();" value='<s:property value="ls"/>'/>
<input type="hidden" id="hidls1" name="hidls1" value='<s:property value="hidls1"/>'/></td>
<td><label>No</label><input type="radio" name="ls" id="ls2" onchange="ls1check();" value='<s:property value="ls"/>'/>
<input type="hidden" id="hidls2" name="hidls2" value='<s:property value="hidls2"/>'/></td>
</tr>
<tr>
<td><label>Cornice required:</label></td>
<td><label>Yes</label><input type="radio" name="cor" id="cor1" onchange="cor1check();" value='<s:property value="ls"/>'/>
<input type="hidden" id="hidcor1" name="hidcor1" value='<s:property value="hidcor1"/>'/></td>
<td><label>No</label><input type="radio" name="cor" id="cor2" onchange="cor1check();" value='<s:property value="ls"/>'/>
<input type="hidden" id="hidcor2" name="hidcor2" value='<s:property value="hidcor2"/>'/></td>
</tr>
<tr>
<td><label>What style or feel would you like your new kitchen to have:</label></td>
</tr>
<tr>
<td><label>Modern</label><input type="checkbox" name="kstyle1" id="kstyle1" onchange="kstyle1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidkstyle1" name="hidkstyle1" value='<s:property value="hidkstyle1"/>'/></td>
<td><label>Classic</label><input type="checkbox" name="kstyle2" id="kstyle2" onchange="kstyle2check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidkstyle2" name="hidkstyle2" value='<s:property value="hidkstyle2"/>'/></td>
</tr>
<tr><td><label>What cabinetry options interest you? Check all that apply</label></td></tr>
<tr>
<td><label>Glass Cabinet Fronts</label><input type="checkbox" name="interest1" id="interest1" onchange="interest1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidinterest1" name="hidinterest1" value='<s:property value="hidinterest1"/>'/></td>
<td><label>Open Shelves</label><input type="checkbox" name="interest2" id="interest2" onchange="interest2check();"onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidinterest2" name="hidinterest2" value='<s:property value="hidinterest2"/>'/></td>
<td><label>Island</label><input type="checkbox" name="interest3" id="interest3" onchange="interest3check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidinterest3" name="hidinterest3" value='<s:property value="hidinterest3"/>'/></td>
<td><label>Other</label><input type="checkbox" name="interest4" id="interest4" onchange="interest4check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidinterest4" name="hidinterest4" value='<s:property value="hidinterest4"/>'/></td>
</tr>  
<tr>
<td><label>List some details of the new kitchen that are important to you:</label></td>
<td><input type="text" name="listitem" id="listitem" value='<s:property value="listitem"/>'></td>
</tr>
<tr><td><label>What electric appliances do you use in your kitchen</label></td></tr>
<tr>
<td><label>Blender</label>
<input type="checkbox" name="appl1" id="appl1" onchange="appl1check();"  onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidappl1" name="hidappl1" value='<s:property value="hidappl1"/>'/></td>
<td><label>Wok</label>
<input type="checkbox" name="appl2" id="appl2" onchange="appl2check();"  onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidappl2" name="hidappl2" value='<s:property value="hidappl2"/>'/></td>
<td><label>Toaster</label>
<input type="checkbox" name="appl3" id="appl3" onchange="appl3check();"  onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidappl3" name="hidappl3" value='<s:property value="hidappl3"/>'/></td>
<td><label>Coffee Pot</label>
<input type="checkbox" name="appl4" id="appl4" onchange="appl4check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidappl4" name="hidappl4" value='<s:property value="hidappl4"/>'/></td>
<td><label>Can Opener</label>
<input type="checkbox" name="appl5" id="appl5" onchange="appl5check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidappl5" name="hidappl5" value='<s:property value="hidappl5"/>'/></td>
</tr>
<tr>
<td><label>Electric Fry Pan</label>
<input type="checkbox" name="appl6" id="appl6" onchange="appl6check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidappl6" name="hidappl6" value='<s:property value="hidappl6"/>'/></td>
<td><label>Griddle</label>
<input type="checkbox" name="appl7" id="appl7" onchange="appl7check();"onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidappl7" name="hidappl7" value='<s:property value="hidappl7"/>'/></td>
<td><label>Crock Pot</label>
<input type="checkbox" name="appl8" id="appl8" onchange="appl8check();"onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidappl8" name="hidappl8" value='<s:property value="hidappl8"/>'/></td>
<td><label>Food Processor</label>
<input type="checkbox" name="appl9" id="appl9" onchange="appl9check();"onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidappl9" name="hidappl9" value='<s:property value="hidappl9"/>'/></td>
<td><label>Other</label>
<input type="checkbox" name="appl10" id="appl10" onchange="appl10check();"onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidappl10" name="hidappl10" value='<s:property value="hidappl10"/>'/></td>
</tr>
<tr><td><label>What type of counter top do you want?</label></td></tr>
<tr>
<td><label>Corian</label><input type="checkbox" name="counter1" id="counter1" onchange="counter1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidcounter1" name="hidcounter1" value='<s:property value="hidcounter1"/>'/></td>
<td><label>Marble</label><input type="checkbox" name="counter2" id="counter2" onchange="counter2check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidcounter2" name="hidcounter2" value='<s:property value="hidcounter2"/>'/></td>
<td><label>Other</label><input type="checkbox" name="counter3" id="counter3" onchange="counter3check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
<input type="hidden" id="hidcounter3" name="hidcounter3" value='<s:property value="hidcounter3"/>'/></td>
</tr>
<tr>
<td><label><u>Appliances</u></label></td> 
</tr>
<tr>
<td><label>Fridge size:(Roughly)</label></td>
<td><input type="text" name="fwtw" id="fwtw" value='<s:property value="fwtw"/>'>W</td>
<td><input type="text" name="fwth" id="fwth" value='<s:property value="fwth"/>'>H</td>
<td><input type="text" name="fwtd" id="fwtd" value='<s:property value="fwtd"/>'>D(Width,Height & Depth)</td>
</tr>
<tr>
<td><label>Dish washer?</label></td>
<td><input type="text" name="dwash" id="dwash" value='<s:property value="dwash"/>'></td>
</tr>
<tr>
<td><label>Cook top?</label></td>
<td><input type="text" name="cooks" id="cooks" value='<s:property value="cooks"/>'>Size</td>
<td><input type="text" name="cookw" id="cookw" value='<s:property value="cookw"/>'>W</td>
</tr>
<tr>
<td><label>Microwave</label></td>
<td><input type="text" name="mwaves" id="mwaves" value='<s:property value="mwaves"/>'>Size</td>
<td><input type="text" name="mwavew" id="mwavew" value='<s:property value="mwavew"/>'>W</td>
<td><input type="text" name="mwaveh" id="mwaveh" value='<s:property value="mwaveh"/>'>H</td>
</tr>
<tr>
<td><label>(How convenient do you want your microwave to be?)</label></td>
<td><input type="text" name="mwaveftr" id="mwaveftr" value='<s:property value="mwaveftr"/>'></td>
</tr>
<tr>
<td><label>Microwave built-in the tall cabinet?</label></td>
<td><input type="text" name="mwavedet" id="mwavedet" value='<s:property value="mwavedet"/>'></td>
</tr>
<tr>
<td><label>Sink & Tap?</label></td>
<td><input type="text" name="sinks" id="sinks" value='<s:property value="sinks"/>'>Sizes</td>
<td><input type="text" name="sinkw" id="sinkw" value='<s:property value="sinkw"/>'>W(Brand</td>
<td><input type="text" name="brand" id="brand" value='<s:property value="brand"/>'>)</td>
</tr>
<tr>
<td><label>Other appliances?</label></td>
<td><input type="text" name="applncs" id="applncs" value='<s:property value="applncs"/>'>Sizes</td>
<td><input type="text" name="applncss" id="applncss" value='<s:property value="applncss"/>'></td>
</tr>
<tr>
<td><label>Layout plan attached:</label></td>
<td><label>Yes</label><input type="radio" name="layout" id="layout11" onchange="layout11check();"value='<s:property value="layout"/>'/>
<input type="hidden" id="hidlayout11" name="hidlayout11" value='<s:property value="hidlayout11"/>'/></td>
<td><label>No</label><input type="radio" name="layout" id="layout22" onchange="layout11check();"value='<s:property value="layout"/>'/>
<input type="hidden" id="hidlayout22" name="hidlayout22" value='<s:property value="hidlayout22"/>'/></td>
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