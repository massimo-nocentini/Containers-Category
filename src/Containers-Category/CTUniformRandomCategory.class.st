Class {
	#name : #CTUniformRandomCategory,
	#superclass : #CTCategory,
	#traits : 'TCTMonadCategory',
	#classTraits : 'TCTMonadCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #monad }
CTUniformRandomCategory >> >>= aBlock [

	"
flatten :: Prob (Prob a) -> Prob a
flatten (Prob xs) = Prob $ concat $ map multAll xs
    where multAll (Prob innerxs, p) = map (\(x, r) -> (x, p*r)) innerxs
	"

	| aMonadOfMonad flatten |
	aMonadOfMonad := self fmap: [ :each | 
		                 (aBlock cull: each cull: self) argument ].

	flatten := aMonadOfMonad argument flatCollect: [ :anAssoc | 
		           | aProbMonad p |
		           aProbMonad := anAssoc key.
		           p := anAssoc value.
		           aProbMonad argument collect: [ :each | 
			           each key -> (each value * p) ] ].

	^ self class on: flatten asCategory
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

{ #category : #monad }
CTUniformRandomCategory >> return: anObject [

	^ self class on: { (anObject -> 1) } asCategory
]
