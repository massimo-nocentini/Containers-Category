"
I am the monoid of numbers by sum: `mappend:` adds the two numbers and `mempty` is 0. Make me with `asSumNumber asCategory`.
"
Class {
	#name : #CTSumNumberCategory,
	#superclass : #CTNumberCategory,
	#traits : 'TCTMonoidCategory',
	#classTraits : 'TCTMonoidCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #monoid }
CTSumNumberCategory >> mappend: aMonoid [

	^ self class on: self argument + aMonoid argument
]

{ #category : #monoid }
CTSumNumberCategory >> mempty [

	^ self class on: 0
]
