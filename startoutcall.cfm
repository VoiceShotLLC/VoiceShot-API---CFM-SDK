
  <cfif #Form.usedefault# EQ "1">
    <cfset menuid   = "0">
  <cfelse>
    <cfset menuid = #Form.menuid#>
  </cfif>
  
  <cfset promptinfo = "">
  <cfset numberinfo = "">
  
  <cfset Mode = "0">
  <cfset format = "xml">
  <cfif IsDefined("Form.callid")>
    <cfset callid    = #Form.callid#>
    <cfif callid NEQ "">         
      <cfset callid    = "callid="""& callid & """">
    </cfif>
  <cfelse>
    <cfset callid    = "">
  </cfif>
  <cfif IsDefined("Form.phonenumber")>
    <cfset number   = #Form.phonenumber#>
    <cfif number NEQ "">         
      <cfset number    = "number="""& number & """">
    </cfif>    
  <cfelse>
    <cfset number    = "">    
  </cfif>
  <cfif IsDefined("Form.tts")>
    <cfset tts      = #Form.tts#>
    <cfif tts NEQ "">         
      <cfset tts    = "<prompt promptid=""2""  tts="""& tts & """ />">
    </cfif>      
  <cfelse>
    <cfset tts    = "">    
  </cfif>
  <cfif IsDefined("Form.alttts")>
    <cfset alttts   = #Form.alttts#>
    <cfif alttts NEQ "">         
      <cfset alttts    = "alttts="""& alttts & """">
    </cfif>      
  <cfelse>
    <cfset alttts    = "">     
  </cfif>  
  <cfif IsDefined("Form.ext")>
    <cfset ext   = #Form.ext#>
    <cfif ext NEQ "">         
      <cfset ext    = "ext="""& ext & """">
    </cfif>      
  <cfelse>
    <cfset ext    = "">     
  </cfif>    
  <cfif IsDefined("Form.callerid")>
    <cfset callerid   = #Form.callerid#>
    <cfif callerid NEQ "">         
      <cfset callerid    = "callerid="""& callerid & """">
    </cfif>      
  <cfelse>
     <cfset callerid    = "">     
  </cfif>   
  <cfif IsDefined("Form.transferto")>
    <cfset transferto   = #Form.transferto#>
    <cfif transferto NEQ "">         
      <cfset transferto    = "transferto="""& transferto & """">
    </cfif>     
  <cfelse>
     <cfset transferto    = "">     
  </cfif>   
  <cfif alttts NEQ "" OR transferto NEQ "">
    <cfset promptinfo = "<prompt promptid=""1"" " & alttts & " " & transferto & " />" >
  </cfif>
  <cfif tts NEQ "">
    <cfset promptinfo = promptinfo & tts>
  </cfif>
  <cfif promptinfo NEQ "">
    <cfset promptinfo = "<prompts>" & promptinfo & "</prompts>">
  </cfif>  
  
   
     

     <cfxml variable="XMLContent">
      <cfoutput><campaign action="#Mode#" menuid="#menuid#" #callerid# >
	     #promptinfo# 
         <phonenumbers>
           <phonenumber #number# #ext# #callid# />                           
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

<cfif callerid EQ "">         
     <cfoutput>
        Data Validation Error: callerid attribute cannot be blank
     </cfoutput>     
<cfelse>	
  <cfif submitval EQUAL "View">     
<cfoutput>#HTMLEditFormat(xmlstr)#</cfoutput>
  <cfelse>
   <cftry>
     <!--- Do not swap these two URLs. Always post to api.voiceshot.com first. --->
     <cfset posturl="http://api.voiceshot.com/ivrapi.asp">
     <cfhttp url=#posturl# method="post" throwOnError="yes">
       <cfhttpparam type="XML" value="#xmlstr#">
     </cfhttp>     
     <CFOUTPUT>#HTMLEditFormat(CFHTTP.FileContent)#</CFOUTPUT>	 
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
</cfif>

