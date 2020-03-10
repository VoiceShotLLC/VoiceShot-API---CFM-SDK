
  <cfif #Form.usedefault# EQ "1">
    <cfset menuid   = "1">
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
  <cfif IsDefined("Form.txt")>
    <cfset txt      = #Form.txt#>
    <cfif txt NEQ "">         
      <cfset txt    = "<prompt promptid=""1""  txt="""& txt & """ />">
    </cfif>      
  <cfelse>
    <cfset txt    = "">    
  </cfif>
  <cfif IsDefined("Form.callerid")>
    <cfset callerid   = #Form.callerid#>
    <cfif callerid NEQ "">         
      <cfset callerid    = "callerid="""& callerid & """">
    </cfif>      
  <cfelse>
     <cfset callerid    = "">     
  </cfif>   
  <cfif txt NEQ "">
    <cfset promptinfo = promptinfo & txt>
  </cfif>
  <cfif promptinfo NEQ "">
    <cfset promptinfo = "<prompts>" & promptinfo & "</prompts>">
  </cfif>  
  
   
     

     <cfxml variable="XMLContent">
      <cfoutput>
       <campaign action="#Mode#" menuid="#menuid#" #callerid# >
         #promptinfo#  
         <phonenumbers>
           <phonenumber #number# #callid# />             
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

