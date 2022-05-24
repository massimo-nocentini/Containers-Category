Class {
	#name : #CTDifferenceCollectionCategory,
	#superclass : #CTCategory,
	#traits : 'TCTMonoidCategory',
	#classTraits : 'TCTMonoidCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #converting }
CTDifferenceCollectionCategory >> asOrderedCollection [

	^ self argument ! {  }
]

{ #category : #monoid }
CTDifferenceCollectionCategory >> mappend: aMonoid [

	^ self class on: [ :aSequenceable | 
		  aMonoid argument ! aSequenceable -! self argument ]
]

{ #category : #monoid }
CTDifferenceCollectionCategory >> mempty [

	^ self class on: [ :aSequenceable | aSequenceable ]
]
