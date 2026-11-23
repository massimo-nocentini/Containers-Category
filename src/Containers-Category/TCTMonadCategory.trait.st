"
I am the trait of monads, which are applicatives too: I implement `<*>` and `pure:`. My users implement:

- `>>=`, which binds what the receiver wraps to the argument of a block that answers a monad;
- `return:`, which wraps an object;
- `fail:`, the failure. Not all of them do.

The block of `>>=` can have a second argument, a monad to send `return:` and the other messages to.

```smalltalk
9 asJustMaybe asCategory
	>>= [ :x :category | category return: x * 10 ]
	""a CTJustMaybeCategory(90)""
```

I add `>>`, the bind that ignores what the receiver wraps, `join`, which flattens a monad of monads, and `guard:`, which answers a `return:` or a `fail:` according to a boolean.
"
Trait {
	#name : #TCTMonadCategory,
	#traits : 'TCTApplicativeCategory',
	#classTraits : 'TCTApplicativeCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #applicative }
TCTMonadCategory >> <*> aMonad [

	"(Monad m) => m (a -> b) -> m a -> m b"

	^ aMonad >>= [ :aBlock | 
	  self >>= [ :a :cat | 
	  | b |
	  b := aBlock value: a.
	  cat return: b ] ]
]

{ #category : #monad }
TCTMonadCategory >> >> aMonad [

	^ self >>= [ :useless | aMonad ]
]

{ #category : #monad }
TCTMonadCategory >> >>= aBlock [

	self explicitRequirement
]

{ #category : #monad }
TCTMonadCategory >> fail: aString [

	self explicitRequirement
]

{ #category : #monad }
TCTMonadCategory >> guard: aBoolean [

	^ aBoolean
		  ifTrue: [ self return: nil ]
		  ifFalse: [ self fail: nil ]
]

{ #category : #splitjoin }
TCTMonadCategory >> join [

	^ self >>= [ :aMonad | aMonad ]
]

{ #category : #applicative }
TCTMonadCategory >> pure: object [

	^ self return: object
]

{ #category : #monad }
TCTMonadCategory >> return: anObject [

	self explicitRequirement
]
