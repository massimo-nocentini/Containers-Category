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

{ #category : #monad }
CTBlockClosureCategory >> return: anObject [

	^ [ :useless | anObject ] asCategory
]
