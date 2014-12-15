/**
 * Resonsible for how the data associated with this list is presented.  Updates the list's operating parameters
 * (CellHeight, CellWidth, etc.) according to the presentation type for the data contained by this list.
 *
 * Routes render messages from the list to the individual elements, adding any additional data necessary for the
 * element to understand how to render itself.  For example, a listdata component might add that the element being
 * rendered is the currently selected element, so that the element can adjust the way it renders itself accordingly.
 * For a tree-type list, the listdata component might add whether the element being drawn is currently open, has
 * children, etc.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIComp_ListPresenter extends UIComp_ListComponentBase
	native(inherit)
	DependsOn(UIDataStorePublisher)
	implements(CustomPropertyItemHandler);

/**
 * Corresponds to a single cell in a UIList (intersection of a row and column).  Generally maps directly to a
 * single item in the list, but in the case of multiple columns or rows, a single list item may be associated with
 * multiple UIListElementCells (where each column for that row is represented by a UIListElementCell).
 *
 * The data for a UIListElementCell is accessed using a UIString. Contains one UIListCellRegion per UIStringNode
 * in the UIString, which can be configured to manually controls the extent for each UIStringNode.
 */
struct native UIListElementCell
{
	/** index of the UIListElement that contains this UIListElementCell */
	var	const	native	transient	int					ContainerElementIndex;

	/** pointer to the list that contains this element cell */
	var	const	transient	UIList						OwnerList;

	/** A UIString which contains data for this cell */
	var	transient			UIListString				ValueString;

	/**
	 * Allows the designer to specify a different style for each cell in a column/row
	 */
	var						UIStyleReference			CellStyle[EUIListElementState.ELEMENT_MAX];

	structcpptext
	{
		/** Script Constructors */
		FUIListElementCell()
		: ContainerElementIndex(INDEX_NONE), OwnerList(NULL), ValueString(NULL)
		{}
		FUIListElementCell(EEventParm);

		/**
		 * Called when this cell is created while populating the elements for the owning list. Creates the cell's UIListString.
		 */
		void OnCellCreated( INT ElementIndex, class UUIList* inOwnerList );

		/**
		 * Resolves the value of the specified tag from the DataProvider and assigns the result to this cell's ValueString.
		 *
		 * @param	DataSource		the data source to use for populating this cell's data
		 * @param	CellBindingTag	the tag (from the list supported by DataProvider) that should be associated with this
		 *							UIListElementCell.
		 *
		 * @note: even though this method is overridden in FUIListElementCellTemplate, it is intended to be non-virtual!
		 */
		void AssignBinding( struct FUIListItemDataBinding& DataSource, FName CellBindingTag );

		/**
		 * Resolves the CellStyle for the specified element state using the currently active skin.  This function is called
		 * anytime the cached cell style no longer is out of date, such as when the currently active skin has been changed.
		 *
		 * @param	ElementState	the list element state to update the element style for
		 */
		void ResolveCellStyles( EUIListElementState ElementState );

		/**
		 * Propagates the style data for the current menu state and element state to each cell .  This function is called anytime
		 * the style data that is applied to each cell is no longer valid, such as when the cell's CellState changes or when the
		 * owning list's menu state is changed.
		 *
		 * @param	ElementState	the list element state to update the element style for
		 */
		void ApplyCellStyleData( EUIListElementState ElementState );

		/**
		 * @return	the list element (UIListItem) that contains this cell
		 */
		struct FUIListItem* GetContainerElement() const;
	}

	structdefaultproperties
	{
		CellStyle(ELEMENT_Normal)=(RequiredStyleClass=class'Engine.UIStyle_Combo')
		CellStyle(ELEMENT_Active)=(RequiredStyleClass=class'Engine.UIStyle_Combo')
		CellStyle(ELEMENT_Selected)=(RequiredStyleClass=class'Engine.UIStyle_Combo')
		CellStyle(ELEMENT_UnderCursor)=(RequiredStyleClass=class'Engine.UIStyle_Combo')
	}
};


/**
 * Contains the data binding information for a single row or column in a list.  Also used for rendering the list's column
 * headers, if configured to do so.
 */
struct native UIListElementCellTemplate extends UIListElementCell
{
	/**
	 * Contains the data binding for each cell group in the list (row if columns are linked, columns if
	 * rows are linked, individual cells if neither are linked
	 */
	var()	editinline editconst	name				CellDataField;

	/**
	 * The string that should be rendered in the header for the column which displays the data for this cell.
	 */
	var()				editconst	string				ColumnHeaderText;

	/**
	 * The custom size for the linked cell (column/row).  A value of 0 indicates that the row/column's size should be
	 * controlled by the owning list according to its cell auto-size configuration.
	 */
	var()					UIScreenValue_Extent		CellSize;

	/**
	 * The starting position of this cell, in absolute pixels.
	 */
	var								float				CellPosition;

	structcpptext
	{
		/** Script Constructor */
		FUIListElementCellTemplate() {}
		FUIListElementCellTemplate(EEventParm);

		/**
		 * Called when this cell is created while populating the elements for the owning list. Creates the cell's UIListString.
		 */
		void OnCellCreated( class UUIList* inOwnerList );

		/**
		 * Initializes the specified cell based on this cell template.
		 *
		 * @param	DataSource		the information about the data source for this element
		 * @param	TargetCell		the cell to initialize.
		 */
		void InitializeCell( struct FUIListItemDataBinding& DataSource, struct FUIListElementCell& TargetCell );

		/**
		 * Resolves the value of the specified tag from the DataProvider and assigns the result to this cell's ValueString.
		 *
		 * @param	DataProvider	the object which contains the data for this element cell.
		 * @param	CellBindingTag	the tag (from the list supported by DataProvider) that should be associated with this
		 *							UIListElementCell.
		 * @param	ColumnHeader	the string that should be displayed in the column header for this cell.
		 */
		void AssignBinding( TScriptInterface<class IUIListElementCellProvider> DataProvider, FName CellBindingTag, const FString& ColumnHeader );

		/**
		 * Applies the resolved style data for the column header style to the schema cells' strings.  This function is called anytime
		 * the header style data that is applied to the schema cells is no longer valid, such as when the owning list's menu state is changed.
		 *
		 * @param	ResolvedStyle			the style resolved by the style reference
		 */
		void ApplyHeaderStyleData( UUIStyle* ResolvedStyle );
	}
};

struct native UIListItemDataBinding
{
	/**
	 * The data provider that contains the data for this list element
	 */
	var	UIListElementCellProvider	DataSourceProvider;

	/**
	 * The name of the field from DataSourceProvider that contains the array of data corresponding to this list element
	 */
	var	name						DataSourceTag;

	/**
	 * The index into the array [DataSourceTag] in DataSourceProvider that this list element represents.
	 */
	var	int							DataSourceIndex;

	structcpptext
	{
		/** Constructors */
		FUIListItemDataBinding() {}
		FUIListItemDataBinding(EEventParm)
		{
			appMemzero(this, sizeof(FUIListItemDataBinding));
		}

		FUIListItemDataBinding( TScriptInterface<class IUIListElementCellProvider> InDataSource, FName DataTag, INT InIndex )
		: DataSourceProvider(InDataSource)
		, DataSourceTag(DataTag)
		, DataSourceIndex(InIndex)
		{}
	}

};

/**
 * Corresponds to a single item in a UIList, which may be any type of data structure.
 *
 * Contains a list of UIListElementCells, which correspond to one or more data fields of the underlying data
 * structure associated with the list item represented by this object.  For linked-column lists, each
 * UIListElementCell is typically associated with a different field from the underlying data structure.
 */
struct native UIListItem
{
	/** The list element associated with the cells contained by this UIElementCellList. */
	var	const						UIListItemDataBinding					DataSource;

	/** the cells associated with this list element */
	var()	editinline editconst editfixedsize	array<UIListElementCell>	Cells;

	/** The current state of this cell (selected, active, etc.) */
	var()	editconst	transient 	noimport EUIListElementState			ElementState;

	structcpptext
	{
		/** Script Constructors */
		FUIListItem() {}
		FUIListItem(EEventParm)
		{
			appMemzero(this, sizeof(FUIListItem));
		}

		/** Standard ctor */
		FUIListItem( const struct FUIListItemDataBinding& InDataSource );

		/**
		 * Changes the ElementState for this element and refreshes its cell's cached style references based on the new cell state
		 *
		 * @param	NewElementState	the new element state to use.
		 *
		 * @return	TRUE if the element state actually changed.
		 */
		UBOOL SetElementState( EUIListElementState NewElementState );
	}
};

/**
 * Contains the data store bindings for the individual cells of a single element in this list.  This struct is used
 * for looking up the data required to fill the cells of a list element when a new element is added.
 */
struct native UIElementCellSchema
{
	/** contains the data store bindings used for creating new elements in this list */
	var() editinline	array<UIListElementCellTemplate>	Cells;

	structcpptext
	{
		/** Script Constructors */
		FUIElementCellSchema() {}
		FUIElementCellSchema(EEventParm)
		{
			appMemzero(this, sizeof(FUIElementCellSchema));
		}
	}
};


/**
 * Contains the formatting information configured for each individual cell in the UI editor.
 * Private/const because changing the value of this property invalidates all data in this, requiring that all data be refreshed.
 */
var()		const private									UIElementCellSchema	ElementSchema;

/**
 * Contains the element cells for each list item.  Each item in the ElementCells array is the list of
 * UIListElementCells for the corresponding element in the list.
 */
var()	editconst	editinline	transient noimport	init	array<UIListItem>	ListItems;

/**
 * Optional background image for the column headers; only applicable if bDisplayColumnHeaders is TRUE.
 */
var(Image)	instanced	editinlineuse						UITexture			ColumnHeaderBackground[EColumnHeaderState.COLUMNHEADER_MAX]<EditCondition=bDisplayColumnHeaders>;

/**
 * The image to render over each element.
 */
var(Image)	instanced	editinlineuse						UITexture			ListItemOverlay[EUIListElementState.ELEMENT_MAX];

/**
 * Texture atlas coordinates for the column header background textures; only applicable if bDisplayColumnHeaders is TRUE.
 * Values of 0 indicate that the texture is not part of an atlas.
 */
var(Image)													TextureCoordinates	ColumnHeaderBackgroundCoordinates[EColumnHeaderState.COLUMNHEADER_MAX]<EditCondition=bDisplayColumnHeaders>;

/**
 * the texture atlas coordinates for the SelectionOverlay. Values of 0 indicate that the texture is not part of an atlas.
 */
var(Image)													TextureCoordinates	ListItemOverlayCoordinates[EUIListElementState.ELEMENT_MAX];

/** Controls whether column headers are rendered for this list */
var()		private{private}								bool				bDisplayColumnHeaders;

/** set to indicate that the cells in this list needs to recalculate their extents */
var			transient										bool				bReapplyFormatting;

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
 * Changes whether this list renders colum headers or not.  Only applicable if the owning list's CellLinkType is LINKED_Columns
 */
native final function EnableColumnHeaderRendering( bool bShouldRenderColHeaders=true );

/**
 * Returns whether this list should render column headers
 */
native final function bool ShouldRenderColumnHeaders() const;

/**
 * Returns whether the list's bounds will be adjusted for the specified orientation considering the list's configured
 * autosize and cell link type values.
 *
 * @param	Orientation		the orientation to check auto-sizing for
 */
native final function bool ShouldAdjustListBounds( EUIOrientation Orientation ) const;

/**
 * Returns the object that provides the cell schema for this component's owner list (usually the class default object for
 * the class of the owning list's list element provider)
 */
native final function UIListElementCellProvider GetCellSchemaProvider() const;

/**
 * Find the index of the list item which corresponds to the data element specified.
 *
 * @param	DataSourceIndex		the index into the list element provider's data source collection for the element to find.
 *
 * @return	the index [into the ListItems array] for the element which corresponds to the data element specified, or INDEX_NONE
 * if none where found or DataSourceIndex is invalid.
 */
native final function int FindElementIndex( int DataSourceIndex ) const;

defaultproperties
{
   Begin Object Class=UITexture Name=NormalOverlayTemplate ObjName=NormalOverlayTemplate Archetype=UITexture'Engine.Default__UITexture'
      Name="NormalOverlayTemplate"
      ObjectArchetype=UITexture'Engine.Default__UITexture'
   End Object
   ListItemOverlay(0)=UITexture'Engine.Default__UIComp_ListPresenter:NormalOverlayTemplate'
   Begin Object Class=UITexture Name=ActiveOverlayTemplate ObjName=ActiveOverlayTemplate Archetype=UITexture'Engine.Default__UITexture'
      Name="ActiveOverlayTemplate"
      ObjectArchetype=UITexture'Engine.Default__UITexture'
   End Object
   ListItemOverlay(1)=UITexture'Engine.Default__UIComp_ListPresenter:ActiveOverlayTemplate'
   Begin Object Class=UITexture Name=SelectionOverlayTemplate ObjName=SelectionOverlayTemplate Archetype=UITexture'Engine.Default__UITexture'
      Name="SelectionOverlayTemplate"
      ObjectArchetype=UITexture'Engine.Default__UITexture'
   End Object
   ListItemOverlay(2)=UITexture'Engine.Default__UIComp_ListPresenter:SelectionOverlayTemplate'
   Begin Object Class=UITexture Name=HoverOverlayTemplate ObjName=HoverOverlayTemplate Archetype=UITexture'Engine.Default__UITexture'
      Name="HoverOverlayTemplate"
      ObjectArchetype=UITexture'Engine.Default__UITexture'
   End Object
   ListItemOverlay(3)=UITexture'Engine.Default__UIComp_ListPresenter:HoverOverlayTemplate'
   bDisplayColumnHeaders=True
   Name="Default__UIComp_ListPresenter"
   ObjectArchetype=UIComp_ListComponentBase'Engine.Default__UIComp_ListComponentBase'
}
