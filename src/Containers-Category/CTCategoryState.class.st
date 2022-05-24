Class {
	#name : #CTCategoryState,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryState >> asCategory [

	^ CTStateCategory on: self object
]
