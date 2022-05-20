Class {
	#name : #CTCategoryBlock,
	#superclass : #CTCategory,
	#traits : 'CTCategoryTApplicative',
	#classTraits : 'CTCategoryTApplicative classTrait',
	#category : #'Containers-Category'
}

{ #category : #'instance creation' }
CTCategoryBlock class >> on: aBlock [

	^ super on: aBlock currified
]

{ #category : #applicative }
CTCategoryBlock >> <*> anApplicative [

	"

instance Applicative ((->) r) where
	pure x = (\_ -> x)
	f <*> g = \x -> f x (g x)
	
	"

	^ self class on: [ :x | 
		  anApplicative argument ! x ! (self argument ! x) ]
]

{ #category : #functor }
CTCategoryBlock >> fmap: aBlock [

	"
	instance Functor ((->) r) where
		fmap f g = (\x -> f (g x))
	"

	^ self class on: [ :object | 
		  | value |
		  value := self argument value: object.
		  aBlock value: value ]
]

{ #category : #applicative }
CTCategoryBlock >> pure: object [

	"

instance Applicative ((->) r) where
	pure x = (\_ -> x)
	f <*> g = \x -> f x (g x)
	
	"

	^ self class on: [ :useless | object ]
]
