<cfset x = GetHttpRequestData()>
<cfset BinData = x.content>
<cfset XMLContent = xmlparse(BinData) >
<cfset CRLF = Chr(13)&Chr(10)>

<!--- Write Raw XML to file --->
<cfset filename =GetDirectoryFromPath(ExpandPath("*.*")) & "xmlsummaryoutsms.txt">
<cfset delimiter = "--- " & DateFormat(Now(), "mm/dd/yyyy") & " " & TimeFormat(Now(), "hh:mm:ss") & " ------------------------------------------------------" & CRLF>
<cfset delimiter = delimiter & ToString(XMLContent) & CRLF>
<cffile action="append" file="#filename#" output="#Replace(delimiter, "<?xml version=""1.0"" encoding=""UTF-8""?>", "")#" addnewline="Yes">

<!--- Parse XML --->
<cfset ParsedValues = "--- " & DateFormat(Now(), "mm/dd/yyyy") & " " & TimeFormat(Now(), "hh:mm:ss") & " ------------------------------------------------------" & CRLF>

<cfset ParsedValues = ParsedValues & "MenuID : "           & XMLContent.campaign.XmlAttributes.menuid & CRLF>
<cfset ParsedValues = ParsedValues & "CallID : "           & XMLContent.campaign.XmlAttributes.callid & CRLF>
<cfset ParsedValues = ParsedValues & "Phone Number : "     & XMLContent.campaign.XmlAttributes.phonenumber & CRLF>
<cfset ParsedValues = ParsedValues & "Status : "           & XMLContent.campaign.XmlAttributes.status & CRLF>
<cfset ParsedValues = ParsedValues & "Call Information : " & XMLContent.campaign.XmlAttributes.comment & CRLF>
<cfset ParsedValues = ParsedValues & "Date And Time : "    & XMLContent.campaign.XmlAttributes.dateandtime & CRLF>


<!--- Write parsed XML to file --->
<cfset filename = GetDirectoryFromPath(ExpandPath("*.*")) & "summaryoutsms.txt">
<cffile action="append" file="#filename#" output="#ParsedValues#" addnewline="Yes">

