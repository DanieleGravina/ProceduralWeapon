/**
 * Handles information about a collection of list elements are sorted.  Responsible for invoking the
 * UISortableItem on each element to allow the element to perform the comparison.
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIComp_ListElementSorter extends UIComp_ListComponentBase
	native(inherit)
	editinlinenew;

/**
 * Contains parameters for a list sorting operation.
 */
struct native transient UIListSortingParameters
{
	/** the index of the column/row that should be used for first-pass sorting */
	var		int		PrimaryIndex;
	/** the index of the column/row that should be used when first pass sorting encounters two identical elements */
	var		int		SecondaryIndex;

	/** indicates that the elements should be sorted in reverse for first-pass */
	var		bool	bReversePrimarySorting;
	/** indicates that the elements should be sorted in reverse for second-pass */
	var		bool	bReverseSecondarySorting;
	/** indicates that sorting should be case sensitive */
	var		bool	bCaseSensitive;

	/** indicates that the strings should be converted into integers for sorting purposes */
	var		bool	bIntSortPrimary;
	var		bool	bIntSortSecondary;

	/** indicates that the strings should be converted into floats for sorting purposes */
	var		bool	bFloatSortPrimary;
	var		bool	bFloatSortSecondary;

structcpptext
{
	/** Constructor */
	FUIListSortingParameters( INT InPrimaryIndex, INT InSecondaryIndex, UBOOL bReversePrimary, UBOOL bReverseSecondary, UBOOL bInCaseSensitive, UBOOL bIntSort[2], UBOOL bFloatSort[2] )
	: PrimaryIndex(InPrimaryIndex), SecondaryIndex(InSecondaryIndex)
	, bReversePrimarySorting(bReversePrimary), bReverseSecondarySorting(bReverseSecondary), bCaseSensitive(bInCaseSensitive)
	, bIntSortPrimary(bIntSort[0]), bIntSortSecondary(bIntSort[1]), bFloatSortPrimary(bFloatSort[0]), bFloatSortSecondary(bFloatSort[1])
	{}
}
};

/** Indicates whether sorting by multiple columns is allowed in this list */
var()										bool	bAllowCompoundSorting<Tooltip=Enables sorting by multiple columns>;

/** the index of the column (or row) to use for sorting the list's elements when SortColumn is INDEX_NONE */
var()										int		InitialSortColumn;

/** the index of the column (or row) to use for performing the initial secondary sorting of the list's elements when SecondarySortColumn is INDEX_NONE */
var()										int		InitialSecondarySortColumn;

/** the index of the column (or row) being used for sorting the list's items */
var()		editconst	transient	const	int		PrimarySortColumn;

/** the index of the column (or row) of the previous SortColumn */
var()		editconst	transient	const	int		SecondarySortColumn;

/** indicates that the primary sort column should be sorted in reverse order */
var()										bool	bReversePrimarySorting;

/** indicates that the secondary sort column should be sorted in reverse order */
var()										bool	bReverseSecondarySorting;


// (cpptext)
// (cpptext)
// (cpptext)
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
 * Resets the PrimarySortColumn and SecondarySortColumn to the Initial* values.
 *
 * @param	bResort	specify TRUE to re-sort the list's elements after resetting the sort columns.
 */
native final function ResetSortColumns( optional bool bResort=true );

/**
 * Sorts the owning list's items using the parameters specified.
 *
 * @param	ColumnIndex		the column (when CellLinkType is LINKED_Columns) or row (when CellLinkType is LINKED_Rows) to
 *							use for sorting.  Specify INDEX_NONE to clear sorting.
 * @param	bSecondarySort	specify TRUE to set ColumnIndex as the SecondarySortColumn.  If FALSE, resets the value of SecondarySortColumn
 * @param	bCaseSensitive	specify TRUE to perform case-sensitive comparison
 *
 * @return	TRUE if the items were sorted successfully.
 */
native final function bool SortItems( int ColumnIndex, optional bool bSecondarySort, optional bool bCaseSensitive );

/**
 * Sorts the owning list's items without modifying any sorting parameters.
 *
 * @param	bCaseSensitive	specify TRUE to perform case-sensitive comparison
 *
 * @return	TRUE if the items were sorted successfully.
 */
native final function bool ResortItems( optional bool bCaseSensitive );

defaultproperties
{
   bAllowCompoundSorting=True
   InitialSortColumn=-1
   InitialSecondarySortColumn=-1
   PrimarySortColumn=-1
   SecondarySortColumn=-1
   Name="Default__UIComp_ListElementSorter"
   ObjectArchetype=UIComp_ListComponentBase'Engine.Default__UIComp_ListComponentBase'
}
