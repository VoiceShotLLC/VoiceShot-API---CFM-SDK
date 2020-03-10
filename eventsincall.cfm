<cfset x = GetHttpRequestData()>
<cfset BinData = x.content>
<cfset XMLContent = xmlparse(BinData) >
  
<cfset CRLF = Chr(13)&Chr(10)>
<cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "xmleventsincall.txt">
<cfset delimiter = "--- " & DateFormat(Now(), "mm/dd/yyyy") & " " & TimeFormat(Now(), "hh:mm:ss") & " ------------------------------------------------------" & CRLF>
<cfset delimiter = delimiter & ToString(XMLContent) & CRLF>

<cffile action="append" file="#filename#" output="#Replace(delimiter, "<?xml version=""1.0"" encoding=""UTF-8""?>", "")#" addnewline="Yes">

<cfset ParsedValues = "--- " & DateFormat(Now(), "mm/dd/yyyy") & " " & TimeFormat(Now(), "hh:mm:ss")  & " ------------------------------------------------------" & CRLF>
<!---cfset ParsedValues = ParsedValues & "XML : " & ToString(XMLContent) & CRLF & CRLF--->

<cfif isDefined("XMLContent.campaign.XmlAttributes.callid")>
   <cfset CallID = XMLContent.campaign.XmlAttributes.callid>
<cfelse>
   <cfset CallID = "">
</cfif>

<cfif isDefined("XMLContent.campaign.XmlAttributes.action")>
   <cfset Action = XMLContent.campaign.XmlAttributes.action>
<cfelse>
   <cfset Action = "">
</cfif>
<cfset KeyPress = "">

<cfif ((CallID EQ "" and Action Eq "4") OR (CallID NEQ ""))>
  <cfset ParsedValues = ParsedValues & "Call Start/Stop Event" & CRLF>
  <cfset ParsedValues = ParsedValues & "CallID : "  & CallID & CRLF>
  <cfset ParsedValues = ParsedValues & "MenuID : "  & XMLContent.campaign.XmlAttributes.menuid & CRLF>
  <cfif (Action EQ "4")>
     <cfset StrAction = "Answer">
  <cfelse>
     <cfset StrAction = "Hang Up">
  </cfif>
  <cfset ParsedValues = ParsedValues & "Action : "  & StrAction & CRLF>
  <cfif isdefined("XMLContent.campaign.XmlAttributes.callerid")>
     <cfset ParsedValues = ParsedValues & "CallerID : " & XMLContent.campaign.XmlAttributes.callerid & CRLF>
  </cfif>
  <cfif isdefined("XMLContent.campaign.XmlAttributes.duration")>
     <cfset ParsedValues = ParsedValues & "Duration : " & XMLContent.campaign.XmlAttributes.duration & CRLF>  
  </cfif>
<cfelse>
  <cfset ParsedValues = ParsedValues & "Prompt Event" & CRLF>
  <cfset ParsedValues = ParsedValues & "CallID : "   & XMLContent.prompt.XmlAttributes.callid & CRLF>
  <cfset ParsedValues = ParsedValues & "MenuID : "   & XMLContent.prompt.XmlAttributes.menuid & CRLF>
  <cfset ParsedValues = ParsedValues & "PromptID : " & XMLContent.prompt.XmlAttributes.promptid & CRLF>
  <cfset ParsedValues = ParsedValues & "KeyPress : " & XMLContent.prompt.XmlAttributes.keypress & CRLF>  
  <cfset KeyPress     = XMLContent.prompt.XmlAttributes.keypress>
</cfif>

<cfset ParsedValues = ParsedValues & CRLF>
<cfset filename=GetDirectoryFromPath(ExpandPath("*.*")) & "eventsincall.txt">
<cffile action="append" file="#filename#" output="#ParsedValues#" addnewline="Yes">

<cfset xmlResponse="">
<cfswitch expression="#KeyPress#">
   <cfcase value="1234">
      <cfset xmlResponse = "<prompt goto=""2"" />">
   </cfcase>
</cfswitch>

<cfcontent type="text/xml">
<cfoutput>
  #xmlResponse#
</cfoutput>