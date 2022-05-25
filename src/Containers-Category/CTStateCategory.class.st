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

{ #category : #monad }
CTStateCategory >> >>= aBlock [

	"(a -> (s -> (a, s))) -> (s -> (a, s)) -> (s -> (b, s))"

	^ [ :s | 
	  | anAssoc aMonad |
	  anAssoc := self argument value: s.

	  aMonad := aBlock cull: anAssoc key cull: self.

	  aMonad argument value: anAssoc value ] asState asCategory
]

{ #category : #'actions api' }
CTStateCategory >> get [

	^ [ :s | s -> s ] asState asCategory
]

{ #category : #'actions api' }
CTStateCategory >> put: aState [

	^ [ :s | nil -> aState ] asState asCategory
]

{ #category : #monad }
CTStateCategory >> return: anObject [

	^ [ :state | anObject -> state ] asState asCategory
]
