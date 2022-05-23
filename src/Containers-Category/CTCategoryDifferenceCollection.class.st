Class {
	#name : #CTCategoryDifferenceCollection,
	#superclass : #CTCategory,
	#traits : 'CTCategoryTMonoid',
	#classTraits : 'CTCategoryTMonoid classTrait',
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryDifferenceCollection >> asOrderedCollection [

	^ self argument ! {  }
]

{ #category : #monoid }
CTCategoryDifferenceCollection >> mappend: aMonoid [

	^ self class on: [ :aSequenceable | 
		  aMonoid argument ! aSequenceable -! self argument ]
]

{ #category : #monoid }
CTCategoryDifferenceCollection >> mempty [

	^ self class on: [ :aSequenceable | aSequenceable ]
]
