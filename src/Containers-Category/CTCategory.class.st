Class {
	#name : #CTCategory,
	#superclass : #Object,
	#category : #'Containers-Category'
}

{ #category : #factory }
CTCategory class >> block: aBlock [

	^ CTCategoryBlock new
		  block: aBlock currified;
		  yourself
]

{ #category : #factory }
CTCategory class >> collection: aCollection [

	^ CTCategoryCollection new
		  collection: aCollection;
		  yourself
]
