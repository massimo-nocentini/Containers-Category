"
I am what `asState` answers: my `asCategory` answers a `CTStateCategory` on my block.
"
Class {
	#name : #CTCategoryState,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryState >> asCategory [

	^ CTStateCategory on: self object
]
