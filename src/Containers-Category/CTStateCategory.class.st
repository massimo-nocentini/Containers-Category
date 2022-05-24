"
```
newtype State s a = State { runState :: s -> (a, s) }
```

instances:

```
instance Monad (State s) where
    return x = State $ \s -> (x, s)
    (State h) >>= f = State $ \s -> let (a, newState) = h s
                                        (State g) = f a
                                    in  g newState
```
"
Class {
	#name : #CTStateCategory,
	#superclass : #CTCategory,
	#traits : 'TCTMonadCategory + TCTMonadStateCategory',
	#classTraits : 'TCTMonadCategory classTrait + TCTMonadStateCategory classTrait',
	#instVars : [
		'log'
	],
	#category : #'Containers-Category'
}

{ #category : #applicative }
CTStateCategory >> <*> anApplicative [

	"(s -> ((a -> b), s)) -> (s -> (a, s)) -> (s -> (b, s))"

	^ [ :s | 
	  | anAssoc anotherAssoc aBlock b |
	  anAssoc := self argument ! s.

	  anotherAssoc := anApplicative argument ! anAssoc value.

	  aBlock := anotherAssoc key.

	  b := aBlock value: anAssoc key.

	  b -> anotherAssoc value ] asState asCategory
]

{ #category : #monad }
CTStateCategory >> >>= aBlock [

	"(a -> (s -> (a, s))) -> (s -> (a, s)) -> (s -> (b, s))"

	^ [ :s | 
	  | anAssoc aMonad |
	  anAssoc := self argument value: s.

	  aMonad := aBlock cull: anAssoc key cull: self.

	  aMonad argument value: anAssoc value ] asState asCategory
]

{ #category : #functor }
CTStateCategory >> fmap: aBlock [

	"(a -> b) -> (s -> (a, s)) -> (s -> (b, s))"

	^ [ :s | 
	  | anAssoc b |
	  anAssoc := self argument ! s.
	  b := aBlock value: anAssoc key.
	  b -> anAssoc value ] asState asCategory
]

{ #category : #'actions api' }
CTStateCategory >> get [

	^ [ :s | s -> s ] asState asCategory
]

{ #category : #applicative }
CTStateCategory >> pure: object [

	"a -> m a
	
	so in our case we have:
	
	a -> (s -> (a , s))
	
	"

	"return x = State $ \s -> (x, s)"

	^ [ :state | object -> state ] asState asCategory
]

{ #category : #'actions api' }
CTStateCategory >> put: aState [

	^ [ :s | nil -> aState ] asState asCategory
]
