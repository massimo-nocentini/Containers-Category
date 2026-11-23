"
I am the category of a number, my `argument`. My class-side messages `sum` and `product` answer my two subclasses, the monoids of numbers.
"
Class {
	#name : #CTNumberCategory,
	#superclass : #CTCategory,
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTNumberCategory class >> product [

	^ CTProductNumberCategory
]

{ #category : #'as yet unclassified' }
CTNumberCategory class >> sum [

	^ CTSumNumberCategory
]
