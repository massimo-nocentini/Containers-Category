Class {
	#name : #CTCategoryJustMaybe,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryJustMaybe >> asCategory [

	^ CTJustMaybeCategory on: self object
]
