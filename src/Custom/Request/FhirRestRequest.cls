Class Custom.Request.FhirRestRequest Extends Ens.Request
{

Property FhirVersion As %String [ InitialExpression = "4.0.1" ];

Property CCDAVersion As %String [ InitialExpression = "CCDAv21" ];

Property FhirRequest As %Stream.GlobalCharacter;

Storage Default
{
<Data name="FhirRestRequestDefaultData">
<Subscript>"FhirRestRequest"</Subscript>
<Value name="1">
<Value>FhirVersion</Value>
</Value>
<Value name="2">
<Value>FhirRequest</Value>
</Value>
<Value name="3">
<Value>CCDAVersion</Value>
</Value>
</Data>
<DefaultData>FhirRestRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
