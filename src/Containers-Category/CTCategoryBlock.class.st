Class {
	#name : #CTCategoryBlock,
	#superclass : #Object,
	#traits : 'CTCategoryTApplicative',
	#classTraits : 'CTCategoryTApplicative classTrait',
	#instVars : [
		'block'
	],
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCategoryBlock >> <*> anApplicative [

	"

instance Applicative ((->) r) where
	pure x = (\_ -> x)
	f <*> g = \x -> f x (g x)
	
	"

	^ self class new
		  block: [ :x | anApplicative block ! x ! (block ! x) ];
		  yourself
]

{ #category : #accessing }
CTCategoryBlock >> block [

	^ block
]

{ #category : #accessing }
CTCategoryBlock >> block: anObject [

	block := anObject
]

{ #category : #'accessing - structure variables' }
CTCategoryBlock >> fmap: aBlock [

	"
	instance Functor ((->) r) where
		fmap f g = (\x -> f (g x))
	"

	^ self class new
		  block: [ :object | 
			  | value |
			  value := block value: object.
			  aBlock value: value ];
		  yourself
]

{ #category : #'as yet unclassified' }
CTCategoryBlock >> pure: object [

	"

instance Applicative ((->) r) where
	pure x = (\_ -> x)
	f <*> g = \x -> f x (g x)
	
	"

	block := [ :useless | object ]
]
