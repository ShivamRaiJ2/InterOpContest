Class Custom.Request.SdaToCcdaRequest Extends Ens.Request
{

Property SDAQuickStreamID As %String;

Property SDATransform As %String [ InitialExpression = "SDA3/SDA-to-CCDAv21-CCD.xsl" ];

Storage Default
{
<Data name="SdaToCcdaRequestDefaultData">
<Subscript>"SdaToCcdaRequest"</Subscript>
<Value name="1">
<Value>SDAQuickStreamID</Value>
</Value>
<Value name="2">
<Value>SDATransform</Value>
</Value>
</Data>
<DefaultData>SdaToCcdaRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
