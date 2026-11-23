"
I am the category of an object that may not be there, a `CTJustMaybeCategory` when it is and a `CTNothingMaybeCategory` when it is not. I am a monad, where `fail:` answers a nothing, and a monoid, whose `mempty` is a nothing.

```smalltalk
9 asJustMaybe asCategory >>= [ :x :category | category return: x * 10 ].
	""a CTJustMaybeCategory(90)""
nil asNothingMaybe asCategory >>= [ :x :category | category return: x * 10 ].
	""a CTNothingMaybeCategory""
```

`just:` and `nothing`, on my class side, make the two. `ifNothing:ifJust:` tells them apart.
"
Class {
	#name : #CTMaybeCategory,
	#superclass : #CTCategory,
	#traits : 'TCTMonadCategory + TCTMonoidCategory',
	#classTraits : 'TCTMonadCategory classTrait + TCTMonoidCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #factory }
CTMaybeCategory class >> just: anObject [

	^ CTJustMaybeCategory on: anObject
]

{ #category : #factory }
CTMaybeCategory class >> nothing [

	^ CTNothingMaybeCategory on: nil
]

{ #category : #monad }
CTMaybeCategory >> fail: aString [

	^ self class nothing
]

{ #category : #controlling }
CTMaybeCategory >> ifNothing: nBlock ifJust: jBlock [

	self subclassResponsibility
]

{ #category : #monoid }
CTMaybeCategory >> mempty [

	^ self class nothing
]

{ #category : #monad }
CTMaybeCategory >> return: anObject [

	^ anObject asJustMaybe asCategory
]
