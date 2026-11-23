"
I am what `asDifferenceCollection` answers: my `asCategory` answers a `CTDifferenceCollectionCategory` on a block that prepends my collection to its argument.
"
Class {
	#name : #CTCategoryDifferenceCollection,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryDifferenceCollection >> asCategory [

	^ CTDifferenceCollectionCategory on: [ :aSequenceable | 
		  self object , aSequenceable ]
]
