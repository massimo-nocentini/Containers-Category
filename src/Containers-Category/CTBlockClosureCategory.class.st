"
```haskell
instance Monad ((->) r) where
    return x = \_ -> x
    h >>= f = \w -> f (h w) w
```
"
Class {
	#name : #CTBlockClosureCategory,
	#superclass : #CTCategory,
	#traits : 'TCTMonadCategory',
	#classTraits : 'TCTMonadCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #applicative }
CTBlockClosureCategory >> <*> anApplicative [

	"

instance Applicative ((->) r) where
	pure x = (\_ -> x)
	f <*> g = \x -> f x (g x)
	
	"

	^ [ :x | anApplicative argument ! x ! (self argument ! x) ]
		  asCategory
]

{ #category : #monad }
CTBlockClosureCategory >> >>= aBlock [

	"(a -> m b) -> m a -> m b"

	"(a -> (c -> b)) -> (c -> a) -> (c -> b)"

	"h >>= f = \w -> f (h w) w"

	^ [ :c | 
	  | aBlockMonad a b |
	  a := self argument value: c.
	  aBlockMonad := aBlock cull: a cull: self.
	  b := aBlockMonad argument value: c.
	  b ] asCategory
]

{ #category : #functor }
CTBlockClosureCategory >> fmap: aBlock [

	"
	instance Functor ((->) r) where
		fmap f g = (\x -> f (g x))
	"

	^ [ :object | 
	  | value |
	  value := self argument value: object.
	  aBlock ! value ] asCategory
]

{ #category : #applicative }
CTBlockClosureCategory >> pure: object [

	"

instance Applicative ((->) r) where
	pure x = (\_ -> x)
	f <*> g = \x -> f x (g x)
	
	"

	^ [ :useless | object ] asCategory
]
