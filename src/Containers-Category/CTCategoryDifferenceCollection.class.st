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
