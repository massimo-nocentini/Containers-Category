Class {
	#name : #CTUniformRandomCategory,
	#superclass : #CTCategory,
	#traits : 'TCTMonadCategory',
	#classTraits : 'TCTMonadCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #monad }
CTUniformRandomCategory >> >>= aBlock [

	^ (self fmap: [ :each | aBlock cull: each cull: self ]) join
]

{ #category : #monad }
CTUniformRandomCategory >> fail: aString [

	^ self class on: {  } asCategory
]

{ #category : #functor }
CTUniformRandomCategory >> fmap: aBlock [

	"
instance Functor Prob where
    fmap f (Prob xs) = Prob $ map (\(x, p) -> (f x, p)) xs
	"

	^ self class on: (self argument fmap: [ :anAssoc | 
			   aBlock ! anAssoc key -> anAssoc value ])
]

{ #category : #splitjoin }
CTUniformRandomCategory >> join [

	| flatten |
	flatten := self argument fmap: [ :anAssoc | 
		           | aProbMonad p |
		           aProbMonad := anAssoc key.
		           p := anAssoc value.
		           aProbMonad argument fmap: [ :each | 
			           each key -> (each value * p) ] ].

	^ self class on: flatten join
]

{ #category : #monad }
CTUniformRandomCategory >> return: anObject [

	^ self class on: { (anObject -> 1) } asCategory
]
