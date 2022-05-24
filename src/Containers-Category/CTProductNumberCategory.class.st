Class {
	#name : #CTProductNumberCategory,
	#superclass : #CTNumberCategory,
	#traits : 'CTCategoryTMonoid',
	#classTraits : 'CTCategoryTMonoid classTrait',
	#category : #'Containers-Category'
}

{ #category : #monoid }
CTProductNumberCategory >> mappend: aMonoid [

	^ self class on: self argument * aMonoid argument
]

{ #category : #monoid }
CTProductNumberCategory >> mempty [

	^ self class on: 1
]
