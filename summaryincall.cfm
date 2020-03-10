<cfset x = GetHttpRequestData()>
<cfset BinData = x.content>
<cfset XMLContent = xmlparse(BinData) >
<cfset CRLF = Chr(13)&Chr(10)>

<!--- Write Raw XML to file --->
<cfset filename =GetDirectoryFromPath(ExpandPath("*.*")) & "xmlsummaryincall.txt">
<cfset delimiter = "--- " & DateFormat(Now(), "mm/dd/yyyy") & " " & TimeFormat(Now(), "hh:mm:ss") & " ------------------------------------------------------" & CRLF>
<cfset delimiter = delimiter & ToString(XMLContent) & CRLF>
<cffile action="append" file="#filename#" output="#Replace(delimiter, "<?xml version=""1.0"" encoding=""UTF-8""?>", "")#" addnewline="Yes">

<!--- Parse XML --->
<cfset ParsedValues = "--- " & DateFormat(Now(), "mm/dd/yyyy") & " " & TimeFormat(Now(), "hh:mm:ss") & " ------------------------------------------------------" & CRLF>
<cfset ParsedValues = ParsedValues & "MenuID : "  & XMLContent.campaign.XmlAttributes.menuid & CRLF>
<cfset ParsedValues = ParsedValues & "Duration : " & XMLContent.campaign.XmlAttributes.duration & CRLF>
<cfset ParsedValues = ParsedValues & "CallerID : " & XMLContent.campaign.XmlAttributes.callerid & CRLF>

<cfset NodeCount = arrayLen(XMLContent.Campaign.prompts.xmlChildren)>
<cfset Counter = 1>
<cfloop condition="Counter LT NodeCount + 1">
   <cfset ParsedValues = ParsedValues & "Prompt ID: " & XMLContent.campaign.prompts.prompt[Counter].XmlAttributes.promptid & "  Key Press : " & XMLContent.campaign.prompts.prompt[Counter].XmlAttributes.keypress & CRLF>
   <!--- Save WAV file if sent with Prompt and Keypress data --->
   <CFTRY>
      <cfset filename = GetDirectoryFromPath(ExpandPath("*.*")) & XMLContent.campaign.prompts.prompt[counter].file.XMLAttributes.filename>
      <cfset file1 = toBinary(XMLContent.campaign.prompts.prompt[counter].file.xmltext)>
      <cffile action="write"  file="#filename#" output="#File1#" addnewline="No">
	  <cfset ParsedValues = ParsedValues & "Filename : " & XMLContent.campaign.prompts.prompt[counter].file.XMLAttributes.filename & CRLF>
   <CFCATCH>
   </CFCATCH>
   </CFTRY>
   <cfset Counter = Counter + 1>
</cfloop>

<!--- Write parsed XML to file --->
<cfset filename = GetDirectoryFromPath(ExpandPath("*.*")) & "summaryincall.txt">
<cffile action="append" file="#filename#" output="#ParsedValues#" addnewline="Yes">

