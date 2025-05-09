Class Custom.Process.SdaToCcda Extends Ens.BusinessProcess
{

Method OnRequest(pRequest As Custom.Request.SdaToCcdaRequest, Output pResponse As Custom.Response.CcdaResponse) As %Status
{
    Try {
        //Open Quick Stream for transformation
        set tQuickStream=##class(HS.SDA3.QuickStream).%OpenId(pRequest.SDAQuickStreamID)
        // Transform to ccda using XSLT
        set tTransformer=##class(HS.Util.XSLTTransformer).%New()
        set tCcdQuickStream=##class(HS.SDA3.QuickStream).%New()
        set tSC=tTransformer.Transform(tQuickStream, pRequest.SDATransform,.tCcdQuickStream)

        // Create Response
        set pResponse=##class(Custom.Response.CcdaResponse).%New()
        set pResponse.CcdaQuickStreamID=tCcdQuickStream.%Id()

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
