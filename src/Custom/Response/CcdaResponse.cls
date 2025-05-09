Class Custom.Response.CcdaResponse Extends Ens.Response
{

Property CcdaQuickStreamID As %String;

Storage Default
{
<Data name="CcdaResponseDefaultData">
<Subscript>"CcdaResponse"</Subscript>
<Value name="1">
<Value>CcdaQuickStreamID</Value>
</Value>
</Data>
<DefaultData>CcdaResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
