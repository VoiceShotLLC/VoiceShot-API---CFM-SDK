
     <cfxml variable="XMLContent">
      <cfoutput>
       <campaign action="6" />
	  </cfoutput>
     </cfxml>
 
   
<cfset xmlstr = ToString(XMLContent)>
<cfif IsDefined("Form.Submit")>
  <cfset submitval = #Form.Submit#>
<cfelse>
  <cfset submitval = "">
</cfif>

<cfif submitval EQUAL "View">   
   <cfoutput>
      #HTMLEditFormat(xmlstr)#
   </cfoutput>
<cfelse>
   <cftry>
     <!--- Do not swap these two URLs. Always post to api.voiceshot.com first. --->
     <cfset posturl="http://api.voiceshot.com/ivrapi.asp">
     <cfhttp url=#posturl# method="post" throwOnError="yes">
       <cfhttpparam type="XML" value="#xmlstr#">
     </cfhttp>     
     <CFOUTPUT>
         #HTMLEditFormat(CFHTTP.FileContent)#
     </CFOUTPUT>	 
     <cfcatch type="Any">
	    <cftry>
		  <cfset posturl="http://apiproxy.voiceshot.com/ivrapi.asp">
          <cfhttp url=#posturl# method="post" throwOnError="yes">
            <cfhttpparam type="XML" value="#xmlstr#">
		  </cfhttp>	          
          <CFOUTPUT>
            #HTMLEditFormat(CFHTTP.FileContent)#
          </CFOUTPUT>				
          <cfcatch type="Any"> 
            <!--- Post is not successful --->
          </cfcatch>		  
		</cftry>
     </cfcatch>
   </cftry>
      
</cfif>

