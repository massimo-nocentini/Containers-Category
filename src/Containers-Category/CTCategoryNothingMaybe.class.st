Class {
	#name : #CTCategoryNothingMaybe,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryNothingMaybe >> asCategory [

	^ CTNothingMaybeCategory on: nil
]
