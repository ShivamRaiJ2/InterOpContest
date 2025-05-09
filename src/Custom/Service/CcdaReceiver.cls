Class Custom.Service.CcdaReceiver Extends Ens.BusinessService
{

Property Target As %String [ InitialExpression = "CCDAToHtml" ];

Parameter SETTINGS = "Target";

Method OnProcessInput(pInput As Custom.Request.FhirRestRequest, Output pOutput As %RegisteredObject) As %Status
{
    // Forward request to process for conversions
    Set tSC=..SendRequestSync(..Target,pInput,.pOutput)
	Quit tSC
}

}
