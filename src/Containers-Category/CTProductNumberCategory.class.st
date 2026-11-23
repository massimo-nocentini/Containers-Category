"
I am the monoid of numbers by product: `mappend:` multiplies the two numbers and `mempty` is 1. Make me with `asProductNumber asCategory`.
"
Class {
	#name : #CTProductNumberCategory,
	#superclass : #CTNumberCategory,
	#traits : 'TCTMonoidCategory',
	#classTraits : 'TCTMonoidCategory classTrait',
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
