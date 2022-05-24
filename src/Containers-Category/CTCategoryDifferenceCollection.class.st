Class {
	#name : #CTCategoryDifferenceCollection,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryDifferenceCollection >> asCategory [

	^ CTDifferenceCollectionCategory on: [ :aSequenceable | 
		  self collection , aSequenceable ]
]

{ #category : #accessing }
CTCategoryDifferenceCollection >> collection [

	^ collection
]

{ #category : #accessing }
CTCategoryDifferenceCollection >> collection: anObject [

	collection := anObject
]
