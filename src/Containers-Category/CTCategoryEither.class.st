"
According to the Haskell type definition:

```haskell
data Either a b = Left a | Right b
```
"
Class {
	#name : #CTCategoryEither,
	#superclass : #Object,
	#traits : 'CTCategoryTFunctor',
	#classTraits : 'CTCategoryTFunctor classTrait',
	#instVars : [
		'content'
	],
	#category : #'Containers-Category'
}

{ #category : #accessing }
CTCategoryEither >> content [

	^ content
]

{ #category : #accessing }
CTCategoryEither >> content: anObject [

	content := anObject
]

{ #category : #'accessing - structure variables' }
CTCategoryEither >> fmap: aBlock [

	self subclassResponsibility
]
