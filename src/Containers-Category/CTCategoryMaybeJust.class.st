Class {
	#name : #CTCategoryMaybeJust,
	#superclass : #CTCategoryMaybe,
	#instVars : [
		'content'
	],
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCategoryMaybeJust >> <*> functorJust [

	^ self fmap: functorJust content
]

{ #category : #comparing }
CTCategoryMaybeJust >> = anObject [

	^ super = anObject and: [ self content = anObject content ]
]

{ #category : #accessing }
CTCategoryMaybeJust >> content [
	^ content
]

{ #category : #accessing }
CTCategoryMaybeJust >> content: anObject [
	content := anObject
]

{ #category : #'accessing - structure variables' }
CTCategoryMaybeJust >> fmap: aBlock [

	^ self class new
		  content: (aBlock value: self content);
		  yourself
]

{ #category : #comparing }
CTCategoryMaybeJust >> hash [

	^ super hash bitXor: self content hash
]

{ #category : #'as yet unclassified' }
CTCategoryMaybeJust >> ifNothing: nBlock ifJust: jBlock [
	^ jBlock value: self
]

{ #category : #'as yet unclassified' }
CTCategoryMaybeJust >> mappend: aMonoid [

	^ aMonoid ifNothing: [ self ] ifJust: [ :aJust | 
		  self class new
			  content: (self content mappend: aJust content);
			  yourself ]
]

{ #category : #printing }
CTCategoryMaybeJust >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	content printOn: aStream.
	aStream nextPut: $)
]
