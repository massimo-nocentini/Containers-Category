Class {
	#name : #CTCategory,
	#superclass : #Object,
	#category : #'Containers-Category'
}

{ #category : #factory }
CTCategory class >> collection: aCollection [

	^ CTCategoryCollection new
		  collection: aCollection;
		  yourself
]
