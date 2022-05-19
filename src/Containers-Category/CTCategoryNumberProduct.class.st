Class {
	#name : #CTCategoryNumberProduct,
	#superclass : #CTCategoryNumber,
	#traits : 'CTCategoryTMonoid',
	#classTraits : 'CTCategoryTMonoid classTrait',
	#category : #'Containers-Category'
}

{ #category : #monoid }
CTCategoryNumberProduct class >> mempty [

	^ self new
		  number: 1;
		  yourself
]

{ #category : #monoid }
CTCategoryNumberProduct >> mappend: aMonoid [

	^ self class new
		  number: number * aMonoid number;
		  yourself
]
