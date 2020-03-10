<cfset ErrorMsg="">
<cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "xmleventsoutcall.txt">
<cfif Not(FileExists(filename))>
   <cftry> 
      <cffile action="append" file="#filename#" output="" addnewline="No">
	  
	  <cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "xmleventsincall.txt">
      <cffile action="append" file="#filename#" output="" addnewline="No">

	  <cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "xmlsummaryoutcall.txt">
      <cffile action="append" file="#filename#" output="" addnewline="No">
	  
	  <cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "xmlsummaryincall.txt">
      <cffile action="append" file="#filename#" output="" addnewline="No">
	  
	  <cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "eventsoutcall.txt">
      <cffile action="append" file="#filename#" output="" addnewline="No">
	  
 	  <cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "eventsincall.txt">
      <cffile action="append" file="#filename#" output="" addnewline="No">

	  <cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "summaryincall.txt">
      <cffile action="append" file="#filename#" output="" addnewline="No">

	  <cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "summaryoutcall.txt">
      <cffile action="append" file="#filename#" output="" addnewline="No">

	  <cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "summaryoutsms.txt">
      <cffile action="append" file="#filename#" output="" addnewline="No">

	  <cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "xmlsummaryoutsms.txt">
      <cffile action="append" file="#filename#" output="" addnewline="No">

	  <cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "summaryinsms.txt">
      <cffile action="append" file="#filename#" output="" addnewline="No">

	  <cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "xmlsummaryinsms.txt">
      <cffile action="append" file="#filename#" output="" addnewline="No">
   <cfcatch>
      <cfset ErrorMsg="Error: &nbsp;This example requires write permissions. &nbsp;Your Web server cannot write to this directory.">
   </cfcatch>
   </cftry>
</cfif>