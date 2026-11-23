"
I am what `asProductNumber` answers: my `asCategory` answers a `CTProductNumberCategory` on my number.
"
Class {
	#name : #CTCategoryProductNumber,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryProductNumber >> asCategory [

	^ CTProductNumberCategory on: self object
]
