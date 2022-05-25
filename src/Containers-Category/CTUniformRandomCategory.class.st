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

	"| aMonadOfMonad flatten |
	aMonadOfMonad := self argument
	                 >>= [ :each | 
	                 (aBlock cull: each cull: self) argument ].

	flatten := aMonadOfMonad argument flatCollect: [ :anAssoc | 
		           | aProbMonad p |
		           aProbMonad := anAssoc key.
		           p := anAssoc value.
		           aProbMonad argument collect: [ :each | 
			           each key -> (each value * p) ] ].

	^ self class on: flatten asCategory"

	^ (self argument >>= [ :each | aBlock cull: each cull: self ]) join
]

{ #category : #monad }
CTUniformRandomCategory >> fail: aString [

	^ self class on: {  } asCategory
]

{ #category : #monad }
CTUniformRandomCategory >> return: anObject [

	^ self class on: { (anObject -> 1) } asCategory
]
