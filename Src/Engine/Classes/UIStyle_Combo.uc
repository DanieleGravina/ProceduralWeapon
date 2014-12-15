/**
 * Contains a reference to style data from either existing style, or custom defined UIStyle_Data.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UIStyle_Combo extends UIStyle_Data
	native(inherit);

struct native StyleDataReference
{
	/** Style which owns this reference */
	var private{private}				UIStyle			OwnerStyle;

	/** the style id for the style that this StyleDataReference is linked to */
	var	private{private}				STYLE_ID		SourceStyleID;

	/**
	 * the style that this refers to
	 */
	var	private{private}	transient	UIStyle			SourceStyle;

	/** the state corresponding to the style data that this refers to */
	var	private{private}				UIState			SourceState;

	/** the optional custom style data to be used instead of existing style reference */
	var private{private}				UIStyle_Data	CustomStyleData;

structcpptext
{
	friend class UUIStyle_Combo;

	/** Constructors */
	FStyleDataReference();
	FStyleDataReference( class UUIStyle* InSourceStyle, class UUIState* InSourceState );

	/** Comparison */
	UBOOL operator ==( const FStyleDataReference& Other ) const;
	UBOOL operator !=( const FStyleDataReference& Other ) const;

	/**
	 * Resolves SourceStyleID from the specified skin and assigns the result to SourceStyle.
	 *
	 * @param	ActiveSkin	the currently active skin.
	 */
	void ResolveSourceStyle( class UUISkin* ActiveSkin );

	/**
	 *	Returns the value of OnwerStyle
	 */
	class UUIStyle* GetOwnerStyle() const { return OwnerStyle; }

	/**
	 * Returns the style data object linked to this reference, if SourceStyle or SourceState are NULL then CustomStyleData will be returned instead
	 */
	class UUIStyle_Data* GetStyleData() const;

	/**
	 * Returns the value of SourceStyle
	 */
	class UUIStyle* GetSourceStyle() const { return SourceStyle; }

	/**
	 * Returns the value of SourceState
	 */
	class UUIState* GetSourceState() const { return SourceState; }

	/**
	 * Returns the value of CustomStyleData
	 */
	class UUIStyle_Data* GetCustomStyleData() const { return CustomStyleData; }

	/**
	 * Changes OwnerStyle to be the style specified
	 */
	void SetOwnerStyle( class UUIStyle* NewStyle ){ OwnerStyle = NewStyle; }

	/**
	 *	Sets The SourceStyle reference, makes sure that SourceState is valid for this style
	 */
	void SafeSetStyle(UUIStyle* Style);

	/**
	 * 	Sets The SourceState reference, makes sure that SourceStyle contains this state
	 */
	void SafeSetState(UUIState* State);

	/**
	 * Changes SourceStyle to the style specified, without checking whether it is valid.
	 */
	void SetSourceStyle( class UUIStyle* NewStyle );

	/**
	 * Changes SourceState to the state specified, without checking whether it is valid.
	 */
	void SetSourceState( class UUIState* NewState );

	/**
	 * Sets CustomStyleData reference
	 */
	void SetCustomStyleData( UUIStyle_Data* CustomData ){ CustomStyleData = CustomData; }

	/**
	 * Enables or disables the custom style data if the OwnerStyle is the outer of the custom data
	 */
	void EnableCustomStyleData( UBOOL BoolFlag );

	/**
	 *	Determines if referenced custom style data is valid.
	 */
	UBOOL IsCustomStyleDataValid() const;

	/**
	 *	Determines if the custom style data is valid and enabled
	 */
	UBOOL IsCustomStyleDataEnabled() const;

	/**
	 * Returns whether the styles referenced are marked as dirty
	 */
	UBOOL IsDirty() const;
}
};

var		StyleDataReference			ImageStyle;
var		StyleDataReference			TextStyle;

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

defaultproperties
{
   UIEditorControlClass="WxStyleComboPropertiesGroup"
   Name="Default__UIStyle_Combo"
   ObjectArchetype=UIStyle_Data'Engine.Default__UIStyle_Data'
}
