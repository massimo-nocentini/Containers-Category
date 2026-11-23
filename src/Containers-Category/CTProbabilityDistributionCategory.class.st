"
I am the monad of probability distributions. My `argument` is a `CTCollectionCategory` of associations, from an object to its probability.

```smalltalk
| coin |
coin := { (#head -> (1 / 2)). (#tail -> (1 / 2)) } asProbabilityDistribution asCategory.
(coin >>= [ :a | coin >>= [ :b :cat | cat return: a = b ] ]) argument argument
	""{true->(1/4). false->(1/4). false->(1/4). true->(1/4)}""
```

- `fmap:` evaluates its block with the objects and keeps the probabilities.
- `join` flattens a distribution of distributions, by multiplying the probabilities. Equal objects are not collected together, as the example shows.
- `return:` gives its object the probability 1.
- `fail:` answers the empty distribution.
"
Class {
	#name : #CTProbabilityDistributionCategory,
	#superclass : #CTCategory,
	#traits : 'TCTMonadCategory',
	#classTraits : 'TCTMonadCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #monad }
CTProbabilityDistributionCategory >> >>= aBlock [

	^ (self fmap: [ :each | aBlock cull: each cull: self ]) join
]

{ #category : #monad }
CTProbabilityDistributionCategory >> fail: aString [

	^ {  } asProbabilityDistribution asCategory
]

{ #category : #functor }
CTProbabilityDistributionCategory >> fmap: aBlock [

	"
instance Functor Prob where
    fmap f (Prob xs) = Prob $ map (\(x, p) -> (f x, p)) xs
	"

	^ self class on: (self argument fmap: [ :anAssoc | 
			   aBlock ! anAssoc key -> anAssoc value ])
]

{ #category : #splitjoin }
CTProbabilityDistributionCategory >> join [

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
CTProbabilityDistributionCategory >> return: anObject [

	^ self class on: { (anObject -> 1) } asCategory
]
