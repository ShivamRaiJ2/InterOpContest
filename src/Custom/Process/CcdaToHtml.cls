Class Custom.Process.CcdaToHtml Extends Ens.BusinessProcess
{

Method OnRequest(pRequest As Custom.Request.CcdaRequest, Output pResponse As Custom.Response.CcdaResponse) As %Status
{
    Try {
        //Open Quick Stream for transformation
        set tQuickStream=##class(HS.SDA3.QuickStream).%OpenId(pRequest.CcdaRequestId)
        
        // Transform to ccda using XSLT
        Set tTransform=##class(HS.Util.XSLTTransformer).%New()
        Set tHTMLStream=##class(HS.SDA3.QuickStream).%New()
        Set tSC=tTransform.Transform(tQuickStream, "SDA3/CDA-Support-Files/Reports/"_pRequest.CCDAVersion_"-to-HTML.xsl", .tHTMLStream)
        
        Set pResponse=##class(Custom.Response.CcdaResponse).%New()
        Set pResponse.CcdaQuickStreamID=tHTMLStream.%Id()

        Do pRequest.NewResponse(pResponse)
        // $$$LOGINFO(tResponse.Read())

        

    } Catch ex {
        Set tSC=ex.AsStatus()
    } 
	Quit tSC
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
