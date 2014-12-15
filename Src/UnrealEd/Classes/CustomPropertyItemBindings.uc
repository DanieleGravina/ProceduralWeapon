/**
 * This class is responsible for tracking custom property item draw and input proxies.  It allows specifying a custom
 * draw or input proxy for a particular property, or for a particular property type.  This class is a singleton; to access
 * the values stored in this class, use UCustomPropertyItemBindings::StaticClass()->GetDefaultObject<UCustomPropertyItemBinding>();
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class CustomPropertyItemBindings extends Object
	native(Private)
	config(Editor);


/**
 * This struct is used for specifying custom draw or input proxies for a specific property.
 */
struct native PropertyItemCustomProxy
{
	/**
	 * The complete pathname for the property that this custom proxy should be applied to.  When the property window
	 * encounters a property with this path name, it will use the PropertyItemClassName to represent that property instead
	 * of the default property item class.
	 */
	var()		config			string							PropertyPathName;

	/**
	 * The complete path name for the class to use in the property item window for the associated property.
	 */
	var()		config			string							PropertyItemClassName;

	/**
	 * Only relevant when the property associated with this custom property item proxy is an array property.  Indicates that this
	 * this custom property item proxy should be used when creating the item which corresponds to the array header item, rather than the
	 * normal array header item.
	 */
	var()		config			bool							bReplaceArrayHeaders;

	/**
	 * Only relevant when the property associated with this custom property item proxy control is an array property.  Indicates that this
	 * custom property item proxy should not be used for individual array elements.
	 */
	var()		config			bool							bIgnoreArrayElements;

	/**
	 * The custom property item class specified by PropertyItemClassName.  This value is filled in the first time this
	 * PropertyItemCustomProxy's custom property item class is requested.
	 */
	var	transient				class							PropertyItemClass;
};

/**
 * This struct is used for specifying custom draw or input proxies for a specific property type.
 */
struct native PropertyTypeCustomProxy
{
	/**
	 * The name of the property that this custom proxy applies to (e.g. ObjectProperty, ComponentProperty, etc.).
	 */
	var()		config			name							PropertyName;

	/**
	 * The complete path name for the object class that this custom proxy should be used for (e.g. Engine.UITexture)
	 */
	var()		config			string							PropertyObjectClassPathName;

	/**
	 * The complete path name for the class to use in the property item window for the associated property.
	 */
	var()		config			string							PropertyItemClassName;

	/**
	 * Only relevant when the property associated with this custom property item proxy is an array property.  Indicates that this
	 * this custom property item proxy should be used when creating the item which corresponds to the array header item, rather than the
	 * normal array header item.
	 */
	var()		config			bool							bReplaceArrayHeaders;

	/**
	 * Only relevant when the property associated with this custom property item proxy control is an array property.  Indicates that this
	 * custom property item proxy should not be used for individual array elements.
	 */
	var()		config			bool							bIgnoreArrayElements;

	/**
	 * The custom property item class specified by PropertyItemClassName.  This value is filled in the first time this
	 * PropertyTypeCustomProxy's custom property item class is requested.
	 */
	var	transient				class							PropertyItemClass;
};

/**
 * This struct is used for specifying custom property window item classes for a specific property or unrealscript struct.
 */
struct native PropertyItemCustomClass
{
	/**
	 * The complete pathname for the property/script-struct that this property binding should be applied to.  When the property window
	 * encounters a property that has this path name, it will use the PropertyItemClassName to represent that property instead
	 * of the default property item class.
	 *
	 * If PropertyPathName corresponds to a script struct, the custom property item class will be used for all struct properties for that struct.
	 */
	var()		config			string							PropertyPathName;

	/**
	 * The name of the WxPropertyWindow_Item subclass to use in the property item window for the associated property.
	 */
	var()		config			string							PropertyItemClassName;

	/**
	 * Only relevant when the property associated with this custom property editing control is an array property.  Indicates that this
	 * this custom property item control should be used when creating the item which corresponds to the array header item, rather than the
	 * normal array header item.
	 */
	var()		config			bool							bReplaceArrayHeaders;

	/**
	 * Only relevant when the property associated with this custom property editing control is an array property.  Indicates that this
	 * custom property item control should not be used for individual array elements.
	 */
	var()		config			bool							bIgnoreArrayElements;

	/**
	 * A pointer to the WxPropertyWindow_Item class corresponding to PropertyItemClassName.  This value is filled the first
	 * time this PropertyItemCustomClass's custom property item class is requested.
	 */
	var	transient	native		pointer							WxPropertyItemClass{class wxClassInfo};
};

/**
 * This struct is used for specifying custom property window item classes for a specific property type.
 */
struct native PropertyTypeCustomClass
{
	/**
	 * The name of the property that this custom item class applies to (e.g. ObjectProperty, ComponentProperty, etc.).
	 */
	var()		config			name							PropertyName;

	/**
	 * The complete path name for the object class that this custom item class should be used for (e.g. Engine.UITexture)
	 */
	var()		config			string							PropertyObjectClassPathName;

	/**
	 * The name of the WxPropertyWindow_Item subclass to use in the property item window for the associated property.
	 */
	var()		config			string							PropertyItemClassName;

	/**
	 * Only relevant when the property associated with this custom property editing control is an array property.  Indicates that this
	 * this custom property item control should be used when creating the item which corresponds to the array header item, rather than the
	 * normal array header item.
	 */
	var()		config			bool							bReplaceArrayHeaders;

	/**
	 * Only relevant when the property associated with this custom property editing control is an array property.  Indicates that this
	 * custom property item control should not be used for individual array elements.
	 */
	var()		config			bool							bIgnoreArrayElements;

	/**
	 * A pointer to the WxPropertyWindow_Item class corresponding to PropertyItemClassName.  This value is filled the first
	 * time this PropertyTypeCustomClass's custom property item class is requested.
	 */
	var	transient	native		pointer							WxPropertyItemClass{class wxClassInfo};
};

/** custom property item classes, for specific properties */
var()			config			array<PropertyItemCustomClass>			CustomPropertyClasses;
/** custom property item classes, per property type */
var()			config			array<PropertyTypeCustomClass>			CustomPropertyTypeClasses;

/** custom draw proxy classes, for specific properties */
var()			config			array<PropertyItemCustomProxy>			CustomPropertyDrawProxies;
/** custom draw proxy classes, per property type */
var()			config			array<PropertyItemCustomProxy>			CustomPropertyInputProxies;

/** custom input proxy classes, for specific properties */
var()			config			array<PropertyTypeCustomProxy>			CustomPropertyTypeDrawProxies;
/** custom input proxy classes, per property type */
var()			config			array<PropertyTypeCustomProxy>			CustomPropertyTypeInputProxies;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   CustomPropertyClasses(0)=(PropertyPathName="Engine.UIRoot:UIStyleOverride.DrawColor",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem")
   CustomPropertyClasses(1)=(PropertyPathName="Engine.UIRoot:UIStyleOverride.Opacity",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem")
   CustomPropertyClasses(2)=(PropertyPathName="Engine.UIRoot:UIStyleOverride.Padding",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem",bReplaceArrayHeaders=True,bIgnoreArrayElements=True)
   CustomPropertyClasses(3)=(PropertyPathName="Engine.UIRoot:UITextStyleOverride.DrawFont",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem")
   CustomPropertyClasses(4)=(PropertyPathName="Engine.UIRoot:UITextStyleOverride.TextAttributes",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem")
   CustomPropertyClasses(5)=(PropertyPathName="Engine.UIRoot:UITextStyleOverride.TextAlignment",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem",bReplaceArrayHeaders=True,bIgnoreArrayElements=True)
   CustomPropertyClasses(6)=(PropertyPathName="Engine.UIRoot:UITextStyleOverride.ClipMode",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem")
   CustomPropertyClasses(7)=(PropertyPathName="Engine.UIRoot:UITextStyleOverride.ClipAlignment",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem")
   CustomPropertyClasses(8)=(PropertyPathName="Engine.UIRoot:UITextStyleOverride.AutoScaling",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem")
   CustomPropertyClasses(9)=(PropertyPathName="Engine.UIRoot:UITextStyleOverride.DrawScale",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem",bReplaceArrayHeaders=True,bIgnoreArrayElements=True)
   CustomPropertyClasses(10)=(PropertyPathName="Engine.UIRoot:UITextStyleOverride.SpacingAdjust",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem",bReplaceArrayHeaders=True,bIgnoreArrayElements=True)
   CustomPropertyClasses(11)=(PropertyPathName="Engine.UIRoot:UIImageStyleOverride.Coordinates",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem")
   CustomPropertyClasses(12)=(PropertyPathName="Engine.UIRoot:UIImageStyleOverride.Formatting",PropertyItemClassName="WxCustomPropertyItem_ConditionalItem",bReplaceArrayHeaders=True,bIgnoreArrayElements=True)
   CustomPropertyClasses(13)=(PropertyPathName="UnrealEd.MaterialEditorInstanceConstant:VectorParameterValues",PropertyItemClassName="WxPropertyWindow_MaterialInstanceConstantParameters",bReplaceArrayHeaders=True)
   CustomPropertyClasses(14)=(PropertyPathName="UnrealEd.MaterialEditorInstanceConstant:StaticSwitchParameterValues",PropertyItemClassName="WxPropertyWindow_MaterialInstanceConstantParameters",bReplaceArrayHeaders=True)
   CustomPropertyClasses(15)=(PropertyPathName="UnrealEd.MaterialEditorInstanceConstant:StaticComponentMaskParameterValues",PropertyItemClassName="WxPropertyWindow_MaterialInstanceConstantParameters",bReplaceArrayHeaders=True)
   CustomPropertyClasses(16)=(PropertyPathName="UnrealEd.MaterialEditorInstanceConstant:ScalarParameterValues",PropertyItemClassName="WxPropertyWindow_MaterialInstanceConstantParameters",bReplaceArrayHeaders=True)
   CustomPropertyClasses(17)=(PropertyPathName="UnrealEd.MaterialEditorInstanceConstant:TextureParameterValues",PropertyItemClassName="WxPropertyWindow_MaterialInstanceConstantParameters",bReplaceArrayHeaders=True)
   CustomPropertyClasses(18)=(PropertyPathName="UnrealEd.MaterialEditorInstanceConstant:EditorVectorParameterValue.ParameterValue",PropertyItemClassName="WxCustomPropertyItem_MaterialInstanceConstantParameter")
   CustomPropertyClasses(19)=(PropertyPathName="UnrealEd.MaterialEditorInstanceConstant:EditorStaticSwitchParameterValue.ParameterValue",PropertyItemClassName="WxCustomPropertyItem_MaterialInstanceConstantParameter")
   CustomPropertyClasses(20)=(PropertyPathName="UnrealEd.MaterialEditorInstanceConstant:EditorStaticComponentMaskParameterValue.ParameterValue",PropertyItemClassName="WxCustomPropertyItem_MaterialInstanceConstantParameter")
   CustomPropertyClasses(21)=(PropertyPathName="UnrealEd.MaterialEditorInstanceConstant:EditorScalarParameterValue.ParameterValue",PropertyItemClassName="WxCustomPropertyItem_MaterialInstanceConstantParameter")
   CustomPropertyClasses(22)=(PropertyPathName="UnrealEd.MaterialEditorInstanceConstant:EditorTextureParameterValue.ParameterValue",PropertyItemClassName="WxCustomPropertyItem_MaterialInstanceConstantParameter")
   CustomPropertyDrawProxies(0)=(PropertyPathName="Engine.UIScreenObject:PlayerInputMask",PropertyItemClassName="UnrealEd.PlayerInputMask_CustomDrawProxy")
   CustomPropertyInputProxies(0)=(PropertyPathName="Engine.UIScreenObject:PlayerInputMask",PropertyItemClassName="UnrealEd.PlayerInputMask_CustomInputProxy")
   CustomPropertyInputProxies(1)=(PropertyPathName="Engine.UIScreenObject:InactiveStates.InactiveStates",PropertyItemClassName="UnrealEd.UIState_CustomInputProxy")
   CustomPropertyInputProxies(2)=(PropertyPathName="Engine.UIScreenObject:InitialState",PropertyItemClassName="UnrealEd.UIStateClass_CustomInputProxy")
   CustomPropertyTypeDrawProxies(0)=(PropertyName="ObjectProperty",PropertyObjectClassPathName="Engine.UITexture",PropertyItemClassName="UnrealEd.UITexture_CustomDrawProxy")
   CustomPropertyTypeInputProxies(0)=(PropertyName="ObjectProperty",PropertyObjectClassPathName="Engine.UITexture",PropertyItemClassName="UnrealEd.UITexture_CustomInputProxy")
   Name="Default__CustomPropertyItemBindings"
   ObjectArchetype=Object'Core.Default__Object'
}
