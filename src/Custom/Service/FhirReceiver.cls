Class Custom.Service.FhirReceiver Extends Ens.BusinessService
{

Property Target As %String [ InitialExpression = "FhirToSDA" ];

Parameter SETTINGS = "Target";

Method OnProcessInput(pInput As Custom.Request.FhirRestRequest, Output pOutput As %RegisteredObject) As %Status
{
    Try {
        // Validate fhir before processing
        If (..ValidateFhir(pInput)) {
            // Forward request to process for conversions
            Set tSC=..SendRequestSync(..Target,pInput,.pOutput)
        } Else {
            Throw ##class(%Exception.General).%New("Invalid FHIR request")
        }
         
    }Catch ex {
        Set tSC = ex.AsStatus()
        // Log error
        $$$LOGERROR("Error processing FHIR request: "_tSC)
    }
	Quit tSC
}

Method ValidateFhir(pInput As Custom.Request.FhirRestRequest) As %Integer
{
    Set tValidationPassed=0
    // Ensure its a bundle
    Set tJSONObject=##class(%Library.DynamicAbstractObject).%FromJSON(pInput.FhirRequest)
    Set tResourceType=tJSONObject.resourceType
    If (tResourceType="Bundle") {
        Set tValidationPassed=1
    }
    Quit tValidationPassed
}

}
