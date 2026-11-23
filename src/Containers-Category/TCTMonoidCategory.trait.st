"
I am the trait of monoids. My users implement `mappend:`, the operation, and `mempty`, its neutral element. I add `mconcat:`, which folds a collection of monoids from the right.

```smalltalk
(CTSumNumberCategory new mconcat:
	(#( 1 2 3 ) collect: [ :each | each asSumNumber asCategory ]))
	argument ""6""
```
"
Trait {
	#name : #TCTMonoidCategory,
	#category : #'Containers-Category'
}

{ #category : #monoid }
TCTMonoidCategory >> mappend: aMonoid [

	self explicitRequirement
]

{ #category : #monoid }
TCTMonoidCategory >> mconcat: aCollectionOfMonoids [

	^ aCollectionOfMonoids
		  foldr: [ :each :acc | each mappend: acc ]
		  init: self mempty
]

{ #category : #monoid }
TCTMonoidCategory >> mempty [

	self explicitRequirement
]
