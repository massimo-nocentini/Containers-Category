"
```haskell
instance Monad ((->) r) where
    return x = \_ -> x
    h >>= f = \w -> f (h w) w
```
"
Class {
	#name : #CTCategoryBlock,
	#superclass : #CTCategory,
	#traits : 'CTCategoryTMonad',
	#classTraits : 'CTCategoryTMonad classTrait',
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

{ #category : #monad }
CTCategoryBlock >> >>= aBlock [

	"(a -> m b) -> m a -> m b"

	"(a -> (c -> b)) -> (c -> a) -> (c -> b)"

	"h >>= f = \w -> f (h w) w"

	^ self class on: [ :w | 
		  | aBlockMonad |
		  aBlockMonad := aBlock cull: (self argument value: w) cull: self.
		  aBlockMonad argument value: w ]
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
		  aBlock cull: value cull: self ]
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
