Class Custom.Process.FhirToSda Extends Ens.BusinessProcess
{

Property Target As %String [ InitialExpression = "SDAToCCDA" ];

Parameter SETTINGS = "Target";

Method OnRequest(pRequest As Custom.Request.FhirRestRequest, Output pResponse As %Library.Persistent) As %Status
{
    Try {
        Do pRequest.FhirRequest.Rewind()

        // Use Fhir Transformer to convert FHIR to SDA
        set tTransformer=##class(HS.FHIR.DTL.Util.API.Transform.FHIRToSDA3).TransformStream(pRequest.FhirRequest,pRequest.FhirVersion,"JSON")
        Set tSDA3Object=tTransformer.object

        // Create a new stream to hold the SDA
        set tQuickStream=##class(HS.SDA3.QuickStream).%New()
        $$$ThrowOnError(tSDA3Object.XMLExportToStream(tQuickStream))
        $$$LOGINFO(tQuickStream.Read())  
        Do tQuickStream.Rewind()

        // Make request for CCDA transformation
        set tSDARequest=##class(Custom.Request.SdaToCcdaRequest).%New()
        set tSDARequest.SDAQuickStreamID=tQuickStream.%Id()
        set tSDARequest.SDATransform=$CASE(pRequest.CCDAVersion,"CCDA":"SDA3/SDA-to-CCDA-ClinicalSummary.xsl", :"SDA3/SDA-to-CCDAv21-ClinicalSummary.xsl")

        // Forward  SDA to CCDA process for conversion to CCDA
        set tSC=..SendRequestSync(..Target,tSDARequest,.pResponse)

    } Catch ex {
        Set tSC=ex.AsStatus()
    } 
	Quit tSC
}

Storage Default
{
<Data name="FhirToSdaDefaultData">
<Subscript>"FhirToSda"</Subscript>
<Value name="1">
<Value>Target</Value>
</Value>
</Data>
<DefaultData>FhirToSdaDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
