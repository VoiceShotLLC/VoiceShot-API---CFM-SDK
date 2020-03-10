
  <cfif #Form.UseDefault# EQ "1">
    <cfset MenuID   = "0">
  <cfelse>
    <cfset Menuid = #Form.Menuid#>
  </cfif>
  
  <cfset format = "xml">
  <cfif IsDefined("Form.CallID")>
    <cfset CallD    = #Form.CallID#>
  </cfif>

     <cfxml variable="XMLContent">
      <cfoutput>
       <campaign action="3" menuid="#MenuID#">
         <phonenumbers>
           <phonenumber callid="#CallID#" />
         </phonenumbers>
       </campaign>
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

