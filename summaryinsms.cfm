<cfset x = GetHttpRequestData()>
<cfset BinData = x.content>
<cfset XMLContent = xmlparse(BinData) >
<cfset CRLF = Chr(13)&Chr(10)>

<!--- Write Raw XML to file --->
<cfset filename =GetDirectoryFromPath(ExpandPath("*.*")) & "xmlsummaryinsms.txt">
<cfset delimiter = "--- " & DateFormat(Now(), "mm/dd/yyyy") & " " & TimeFormat(Now(), "hh:mm:ss") & " ------------------------------------------------------" & CRLF>
<cfset delimiter = delimiter & ToString(XMLContent) & CRLF>
<cffile action="append" file="#filename#" output="#Replace(delimiter, "<?xml version=""1.0"" encoding=""UTF-8""?>", "")#" addnewline="Yes">

<!--- Parse XML --->
<cfset ParsedValues = "--- " & DateFormat(Now(), "mm/dd/yyyy") & " " & TimeFormat(Now(), "hh:mm:ss") & " ------------------------------------------------------" & CRLF>

<cfset ParsedValues = ParsedValues & "MenuID : "   & XMLContent.campaign.XmlAttributes.menuid & CRLF>
<cfset ParsedValues = ParsedValues & "CallID : "   & XMLContent.campaign.XmlAttributes.callid & CRLF>
<cfset ParsedValues = ParsedValues & "CallerID : " & XMLContent.campaign.XmlAttributes.callerid & CRLF>
<cfset ParsedValues = ParsedValues & "Text : "     & XMLContent.campaign.prompts.prompt[1].XmlAttributes.txt & CRLF>
 
<!--- Write parsed XML to file --->
<cfset filename = GetDirectoryFromPath(ExpandPath("*.*")) & "summaryinsms.txt"> 
<cffile action="append" file="#filename#" output="#ParsedValues#" addnewline="Yes">

