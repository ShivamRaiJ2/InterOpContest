Class Custom.Service.FhirReceiver Extends Ens.BusinessService
{

Property Target As %String [ InitialExpression = "FhirToSDA" ];

Parameter SETTINGS = "Target";

Method OnProcessInput(pInput As Custom.Request.FhirRestRequest, Output pOutput As %RegisteredObject) As %Status
{
    // Forward request to process for conversions
    Set tSC=..SendRequestSync(..Target,pInput,.pOutput)
	Quit tSC
}

}
