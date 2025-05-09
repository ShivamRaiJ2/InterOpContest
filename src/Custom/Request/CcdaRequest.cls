Class Custom.Request.CcdaRequest Extends Ens.Request
{

Property CCDAVersion As %String [ InitialExpression = "CCDAv21" ];

Property CcdaRequestId As %String;

Storage Default
{
<Data name="CcdaRequestDefaultData">
<Subscript>"CcdaRequest"</Subscript>
<Value name="1">
<Value>CCDAVersion</Value>
</Value>
<Value name="2">
<Value>CcdaRequestId</Value>
</Value>
</Data>
<DefaultData>CcdaRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
