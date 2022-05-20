Class {
	#name : #CTCategoryNumberSum,
	#superclass : #CTCategoryNumber,
	#traits : 'CTCategoryTMonoid',
	#classTraits : 'CTCategoryTMonoid classTrait',
	#category : #'Containers-Category'
}

{ #category : #monoid }
CTCategoryNumberSum >> mappend: aMonoid [

	^ self class on: self argument + aMonoid argument
]

{ #category : #monoid }
CTCategoryNumberSum >> mempty [

	^ self class on: 0
]
