Class {
	#name : #CTCategoryNumberProduct,
	#superclass : #CTCategoryNumber,
	#traits : 'CTCategoryTMonoid',
	#classTraits : 'CTCategoryTMonoid classTrait',
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCategoryNumberProduct class >> mempty [

	^ self new
		  number: 1;
		  yourself
]

{ #category : #'as yet unclassified' }
CTCategoryNumberProduct >> mappend: aMonoid [

	^ self class new
		  number: number * aMonoid number;
		  yourself
]
