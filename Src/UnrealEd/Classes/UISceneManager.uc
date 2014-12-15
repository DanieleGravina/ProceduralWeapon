/**
 * This class manages the UI editor windows.  It's responsible for initializing scenes when they are loaded/created and
 * managing the root scene client for all ui editors.
 * Created by the UIScene generic browser type and stored in the BrowserManager.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class UISceneManager extends Object
	native
	transient
	config(Editor)
	inherits(FGlobalDataStoreClientManager,FExec,FCallbackEventDevice);

struct native transient UIResourceInfo
{
	/** pointer to an archetype for a UI resource, such as a widget, style, or state */
	var Object UIResource;

	/** the text that will be displayed in all menus and dialogs for this resource */
	var string FriendlyName;

structcpptext
{
	/** Constructors */
	FUIResourceInfo( UObject* InResource )
	: UIResource(InResource)
	{
		checkSlow(UIResource);
		if ( !UIResource->HasAnyFlags(RF_ClassDefaultObject) )
		{
			FriendlyName = FString::Printf(TEXT("%s (%s)"), *UIResource->GetClass()->GetDescription(), *UIResource->GetName());
		}
		else
		{
			FriendlyName = UIResource->GetClass()->GetDescription();
		}
	}
	/** Copy Constructor */
	FUIResourceInfo( const FUIResourceInfo& Other )
	: UIResource(Other.UIResource), FriendlyName(Other.FriendlyName)
	{
	}

	/** Comparison operators */
	FORCEINLINE UBOOL operator==( const FUIResourceInfo& Other ) const
	{
		return UIResource == Other.UIResource;
	}
	FORCEINLINE UBOOL operator!=( const FUIResourceInfo& Other ) const
	{
		return UIResource != Other.UIResource;
	}
}
};

struct native transient UIObjectResourceInfo extends UIResourceInfo
{
structcpptext
{
	/** Constructors */
	FUIObjectResourceInfo( class UUIObject* InResource );
	/** Copy Constructor */
	FUIObjectResourceInfo( const FUIObjectResourceInfo& Other )
	: FUIResourceInfo(Other)
	{
	}

	/** Comparison operators */
	FORCEINLINE UBOOL operator==( const FUIObjectResourceInfo& Other ) const
	{
		return UIResource == Other.UIResource;
	}
	FORCEINLINE UBOOL operator!=( const FUIObjectResourceInfo& Other ) const
	{
		return UIResource != Other.UIResource;
	}
}
};

struct native transient UIStyleResourceInfo extends UIResourceInfo
{
structcpptext
{
	/** Constructors */
	FUIStyleResourceInfo( class UUIStyle_Data* InResource );
	/** Copy Constructor */
	FUIStyleResourceInfo( const FUIStyleResourceInfo& Other )
	: FUIResourceInfo(Other)
	{
	}

	/** Comparison operators */
	FORCEINLINE UBOOL operator==( const FUIStyleResourceInfo& Other ) const
	{
		return UIResource == Other.UIResource;
	}
	FORCEINLINE UBOOL operator!=( const FUIStyleResourceInfo& Other ) const
	{
		return UIResource != Other.UIResource;
	}
}
};

struct native transient UIStateResourceInfo extends UIResourceInfo
{
structcpptext
{
	/** Constructors */
	FUIStateResourceInfo( class UUIState* InResource );
	/** Copy Constructor */
	FUIStateResourceInfo( const FUIStateResourceInfo& Other )
	: FUIResourceInfo(Other)
	{
	}

	/** Comparison operators */
	FORCEINLINE UBOOL operator==( const FUIStateResourceInfo& Other ) const
	{
		return UIResource == Other.UIResource;
	}
	FORCEINLINE UBOOL operator!=( const FUIStateResourceInfo& Other ) const
	{
		return UIResource != Other.UIResource;
	}
}
};

struct native UIObjectToolbarMapping
{
	/** Name of the widget class to represent */
	var String WidgetClassName;

	/** Icon for the toolbar button */
	var String IconName;

	/** Tooltip for the toolbar button (Should be a localizable lookup) */
	var String Tooltip;

	/** Status bar text for the toolbar button (Should be a localizable lookup) */
	var String HelpText;
};

struct native UITitleRegions
{
	var float	RecommendedPercentage;
	var float	MaxPercentage;
};

/**
 * The UISkin currently providing styles to the scenes in the editor. Only one UISkin can be active at a time.
 */
var	transient 								UISkin								ActiveSkin;

/**
 * Manages all persistent global data stores.  Created when the UISceneManager is initialized.
 */
var	const transient							DataStoreClient						DataStoreManager;

/**
 * Holds an array of scene clients, which correspond to each scene that's been opened or created during this editing session.
 * Scene clients are not removed or deleted when their scene is closed
 */
var const transient 						array<EditorUISceneClient>			SceneClients;

/**
 * The list of placeable widgets types. Used to fill the various "add new widget" menus.  Built when the UISceneManager is initialized.
 */
var const transient							array<UIObjectResourceInfo>			UIWidgetResources;

/**
 * A list of mappings from widgets to information needed by the editor to display toolbar buttons corresponding to widgets. */
var const config							array<UIObjectToolbarMapping>		UIWidgetToolbarMaps;

/**
 * the list of useable UIStyle resources. Built when UISceneManager is initialized.
 */
var const transient							array<UIStyleResourceInfo>			UIStyleResources;

/**
 * the list of useable UIState resources.  Build when UISceneManager is initialized.
 */
var const transient	private{private}		array<UIStateResourceInfo>			UIStateResources;


/**
 * Quick lookup for friendly names for UIState resources.  Built when UISceneManager is initialized.
 */
var const transient							map{UClass*, FUIStateResourceInfo*}	UIStateResourceInfoMap;

/**
 * Variable that stores the max/recommended safe regions for the screen.
 */
var const config							UITitleRegions						TitleRegions;

/**
 * A pointer to the instance of WxDlgUIDataStoreBrowser
 */
var	transient	native	const private{private}	pointer							DlgUIDataStoreBrowser{class WxDlgUIDataStoreBrowser};

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

/**
 * Retrieves the list of UIStates which are supported by the specified widget.
 *
 * @param	out_SupportedStates		the list of UIStates supported by the specified widget class.
 * @param	WidgetClass				if specified, only those states supported by this class will be returned.  If not
 *									specified, all states will be returned.
 */
native final function GetSupportedUIStates( out array<UIStateResourceInfo> out_SupportedStates, optional class<UIScreenObject> WidgetClass ) const;

defaultproperties
{
   UIWidgetToolbarMaps(0)=(WidgetClassName="Engine.UIButton",IconName="UI_MODE_BUTTON",ToolTip="UIEditor_Widget_Button",HelpText="UIEditor_HelpText_Button")
   UIWidgetToolbarMaps(1)=(WidgetClassName="Engine.UIEditBox",IconName="UI_MODE_EDITBOX",ToolTip="UIEditor_Widget_Editbox",HelpText="UIEditor_HelpText_Editbox")
   UIWidgetToolbarMaps(2)=(WidgetClassName="Engine.UIImage",IconName="UI_MODE_IMAGE",ToolTip="UIEditor_Widget_Image",HelpText="UIEditor_HelpText_Image")
   UIWidgetToolbarMaps(3)=(WidgetClassName="Engine.UILabel",IconName="UI_MODE_LABEL",ToolTip="UIEditor_Widget_Label",HelpText="UIEditor_HelpText_Label")
   UIWidgetToolbarMaps(4)=(WidgetClassName="Engine.UILabelButton",IconName="UI_MODE_LABELBUTTON",ToolTip="UIEditor_Widget_LabelButton",HelpText="UIEditor_HelpText_LabelButton")
   UIWidgetToolbarMaps(5)=(WidgetClassName="Engine.UIToggleButton",IconName="UI_MODE_TOGGLEBUTTON",ToolTip="UIEditor_Widget_ToggleButton",HelpText="UIEditor_HelpText_ToggleButton")
   UIWidgetToolbarMaps(6)=(WidgetClassName="Engine.UICheckbox",IconName="UI_MODE_CHECKBOX",ToolTip="UIEditor_Widget_CheckBox",HelpText="UIEditor_HelpText_CheckBox")
   UIWidgetToolbarMaps(7)=(WidgetClassName="Engine.UIList",IconName="UI_MODE_LIST",ToolTip="UIEditor_Widget_List",HelpText="UIEditor_HelpText_List")
   UIWidgetToolbarMaps(8)=(WidgetClassName="Engine.UIPanel",IconName="UI_MODE_PANEL",ToolTip="UIEditor_Widget_Panel",HelpText="UIEditor_HelpText_Panel")
   UIWidgetToolbarMaps(9)=(WidgetClassName="Engine.UISlider",IconName="UI_MODE_SLIDER",ToolTip="UIEditor_Widget_Slider",HelpText="UIEditor_HelpText_Slider")
   TitleRegions=(RecommendedPercentage=0.850000,MaxPercentage=0.900000)
   Name="Default__UISceneManager"
   ObjectArchetype=Object'Core.Default__Object'
}
