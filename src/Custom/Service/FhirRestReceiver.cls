Class Custom.Service.FhirRestReceiver Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/fhirToCcdaRequest/:fhirversion/:ccdaversion" Method="Post" Call="InvokeFhirToCCDA" />
<Route Url="/fhirToCcdaRequest" Method="Post" Call="InvokeFhirToCCDA" />
<Route Url="/ccdaToHtml/:ccdaversion" Method="Post" Call="ConvertCcdToHtml" />
<Route Url="/Test" Method="Get" Call="Test" />
</Routes>
}

ClassMethod InvokeFhirToCCDA(fhirversion As %String = "4.0.1", ccdaversion As %String = "CCDAv21") As %Status
{
    #Dim tRes As Custom.Response.CcdaResponse
    // Create request for business service
    Set tReq=##class(Custom.Request.FhirRestRequest).%New()
    Set tReq.FhirVersion = fhirversion
    Set tReq.CCDAVersion = ccdaversion
    Set tSC=tReq.FhirRequest.CopyFrom(%request.Content)

    // Create business service object and call process input
    Set tSC = ##class(Ens.Director).CreateBusinessService("FhirReceiver",.tService)
    Set tSC = tService.OnProcessInput(tReq,.tRes)

    set tCcdStream=##class(HS.SDA3.QuickStream).%OpenId(tRes.CcdaQuickStreamID)

    Write tCcdStream.Read(),!

    Quit tSC
}

ClassMethod ConvertCcdToHtml(ccdaversion As %String = "CCDAv21") As %Status
{
   #Dim tRes As Custom.Response.CcdaResponse
    // Create request for business service
    Set tReq=##class(Custom.Request.CcdaRequest).%New()
    Set tReq.CCDAVersion = ccdaversion

    Set tStream=##class(HS.SDA3.QuickStream).%New()
    Set tSC=tStream.CopyFrom(%request.Content)

    Set tReq.CcdaRequestId=tStream.%Id()

    // Create business service object and call process input
    Set tSC = ##class(Ens.Director).CreateBusinessService("CcdaReceiver",.tService)
    Set tSC = tService.OnProcessInput(tReq,.tRes)

    set tHtmlStream=##class(HS.SDA3.QuickStream).%OpenId(tRes.CcdaQuickStreamID)

    Write tHtmlStream.Read(),!
    Quit tSC
}

ClassMethod Test() As %Status
{
    Write "Test method called", !
    Quit $$$OK
}

}
