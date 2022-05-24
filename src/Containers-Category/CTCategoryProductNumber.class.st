Class {
	#name : #CTCategoryProductNumber,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryProductNumber >> asCategory [

	^ CTProductNumberCategory on: self object
]
